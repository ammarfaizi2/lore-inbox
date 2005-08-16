Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbVHPBok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbVHPBok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 21:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbVHPBok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 21:44:40 -0400
Received: from smtpout.mac.com ([17.250.248.89]:27353 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965072AbVHPBok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 21:44:40 -0400
In-Reply-To: <20050815233849.GA3758@sysman-doug.us.dell.com>
References: <20050815200522.GA3667@sysman-doug.us.dell.com> <AC1976B5-FAFC-4809-B1B2-579D5F14FDFE@mac.com> <20050815233849.GA3758@sysman-doug.us.dell.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A9EE6A23-FE2C-4CDE-8236-23F1E48F25F0@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Date: Mon, 15 Aug 2005 21:44:34 -0400
To: Doug Warzecha <Douglas_Warzecha@dell.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2005, at 19:38:49, Doug Warzecha wrote:
> On Mon, Aug 15, 2005 at 04:23:37PM -0400, Kyle Moffett wrote:
>> Why can't you just implement the system management actions in the  
>> kernel
>> driver?
>
> We want to minimize the amount of code in the kernel and avoid  
> having to
> update the driver each time a new system management command is added.

One of the recent trends in kernel driver development is to make as much
as possible accessible through standard tools (like with echo and cat  
via
sysfs).

> The libsmbios project is being updated to use this code.  http:// 
> linux.dell.com/libsmbios/main/.  Using the libsmbios code, you
> will be able to set all of the options in BIOS F2 screen from Linux
> userspace.  Also, libsmbios is looking at implementing a few other  
> things
> like fan status.  Libsmbios is 100% open-source (OSL/GPL dual  
> license).

 From my point of view, this driver could use sysfs almost entirely  
and put
all of the hardware-manipulation code completely in kernel space, along
with the hardware detection code.  You could have plain-text files in
/sys/bus/platform/dellbios/ that have all of the BIOS F2 options  
accessible
to the admin from the command line, without special tools.  (You could
always add an extra program that presents a BIOS-like interface)

> The power cycle feature of the system powers off the system for a few
> seconds and then powers the system back on without user intervention.
> shutdown() and reboot() don't provide that feature.

Please ensure that the code is only run on reboot (and maybe halt), but
definitely not in the poweroff code.

>> What exactly is smi_type used for?  Please provide better  
>> documentation
>> on how to use this and what it does.
>
> The method of generating a host control SMI is not exactly the same  
> for
> each PowerEdge system listed in dcdbas.txt.  host_control_smi_type  
> tells
> the driver how to generate the host control SMI for the system in use.
> I'll update dcdbas.txt with the SMI type value associated with the  
> systems
> listed in that file.

This is an _excellent_ reason why more of this should be in the kernel.
What happens if the wrong SMI is used?  Shouldn't it be relatively easy
for the kernel to determine the correct SMI itself?

Thanks for your hard work!

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that
would also stop them from doing clever things.
   -- Doug Gwyn


