Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbVHPFUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbVHPFUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbVHPFUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:20:05 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:41918
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S965107AbVHPFUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:20:04 -0400
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base
	Driver (dcdbas) with sysfs support
From: Michael E Brown <Michael_E_Brown@dell.com>
To: Kyle Moffett <mrmacman_g4@mac.com>, Chris Wedgwood <cw@f00f.org>,
       linux-kernel@vger.kernel.org, Doug Warzecha <Douglas_Warzecha@dell.com>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 00:19:49 -0500
Message-Id: <1124169589.10755.194.camel@soltek.michaels-house.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again, please cc Doug and I on replies...

Kyle Moffett wrote:
>On Aug 16, 2005, at 00:34:51, Chris Wedgwood wrote:
>> On Mon, Aug 15, 2005 at 04:23:37PM -0400, Kyle Moffett wrote:
>>> Why can't you just implement the system management actions in the
>>> kernel driver?
>>
>> Why put things in the kernel unless it's really needed?

Thank you. Our sentiments exactly.

>>
>> I'm not thrillied about the lack of userspace support for this driver
>> but that still doesn't mean we need to shovel wads of crap into the
>> kernel.

Hmm... did I mention libsmbios? :-)
http://linux.dell.com/libsmbios/main.

SMI support is not yet implemented inside libsmbios, but I am working
feverishly on it (in-between emails to linux-kernel, of course.) :-) We
have a development mailing list, and I will make the announcement there
when it has been complete. I will also be submitting patches to the RBU
documentation and dcdbas documentation pointing to libsmbios for folks
that want a 100% open-source method of using these drivers.

I cannot (at this point, I'm working on it, though), provide our
internal documentation of our SMI implementation directly. But, I am
authorized to add all of this to libsmbios, and I intend to very
clearly document all of the SMI calls in libsmbios. 

>
> I'm worried that it might be more of a mess in userspace than it  
> could be
> if done properly in the kernel.  Hardware drivers, especially for  
> something
> as critical as the BIOS, should probably be done in-kernel.  Look at the
> mess that X has become, it mmaps /dev/mem and pokes at the PCI busses
> directly.  I just don't want an MSI-driver to become another /dev/mem.

Again, this is a whole different thing from a video card driver. The
SMI driver consists of one instruction: "outb magic_port#,
magic_value;", with the simple addition that EBX contain the
physical address of buffer that holds the requested command code and the
return values.

There isn't really a whole lot more than that. For the Dell SMI, you
have to look up the magic port # and magic value in smbios,
specifically, there is a vendor structure 0xDA with a specific layout
(which will be documented in libsmbios) that specifies the magic port
and value.

Aside from that, for the most part, the only thing SMI ever does is
pass buffers back and forth. 

-- 
Michael



