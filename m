Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWIKTcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWIKTcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWIKTcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:32:10 -0400
Received: from mail.tmr.com ([64.65.253.246]:54736 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S965003AbWIKTcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:32:09 -0400
Message-ID: <4505BAA6.20002@tmr.com>
Date: Mon, 11 Sep 2006 15:36:06 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Arjan van de Ven <arjan@infradead.org>
CC: Dave Jones <davej@redhat.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
References: <20060908031422.GA4549@lists.us.dell.com>	 <20060908155639.GJ28592@redhat.com>	 <20060908161817.GA12642@lists.us.dell.com> <1157734517.30730.103.camel@laptopd505.fenrus.org>
In-Reply-To: <1157734517.30730.103.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Fri, 2006-09-08 at 11:18 -0500, Matt Domsch wrote:
>> On Fri, Sep 08, 2006 at 11:56:39AM -0400, Dave Jones wrote:
>>> On Thu, Sep 07, 2006 at 10:14:22PM -0500, Matt Domsch wrote:
>>>  > Problem:
>>>  > New Dell PowerEdge servers have 2 embedded ethernet ports, which are
>>>  > labeled NIC1 and NIC2 on the chassis, in the BIOS setup screens, and
>>>  > in the printed documentation.  Assuming no other add-in ethernet ports
>>>  > in the system, Linux 2.4 kernels name these eth0 and eth1
>>>  > respectively.  Many people have come to expect this naming.  Linux 2.6
>>>  > kernels name these eth1 and eth0 respectively (backwards from
>>>  > expectations).  I also have reports that various Sun and HP servers
>>>  > have similar behavior.
>>>  
>>> This came up years back when 2.6 was something new, and the answer
>>> then was 'bind the interface to the MAC address'.
>> Both Red Hat-based distros and openSuSE-based distros do something
>> like this with configuration files automatically.  Red Hat's
>> anaconda/kudzu puts the HWADDR lines in the generated
>> /etc/sysconfig/network-scripts/ifcfg-* files.  openSuSE's udev rules
>> puts lines in /etc/udev/rules.d/30-net_persistent_names.rules the
>> first time it discovers a new interface.  Both methods are intended to
>> maintain a persistent name for each NIC, after being set up the first
>> time.  Neither deals well with replacing one NIC with another - you
>> must edit the config files.
>>
>> This works pretty well post-install.  It doesn't work well at install
>> time, all the installers use the kernel's original names, and then
>> those names become the persistent names in the config files.
>>
>>
>>> Whilst your patch will fix the case that's currently broken (2.4->2.6),
>>> doesn't it offer equal possibility to break existing setups when people move
>>> from <=2.6.18 -> 2.6.19 ?
>> If they're using config files / udev rules as suggested, it shouldn't
>> break them.
>>
>> If they're not, then yes, this could.  Debian's
>> /etc/network/interfaces file allows use of hwaddr fields, though by
>> default it doesn't appear anything sets it up.
>>
>> I'm open to suggestions on how *not* to break setups that don't use
>> the MAC addresses.
> 
> to be honest I really don't like the PCI ordering change thing for this.
> It's just too fragile altogether to cause a fixed ordering as you want.
> 
> Maybe the kernel's initial ordering should do a numeric sort by mac
> address or something.. (or userspace should)
> 
> 
That wouldn't match any existing setup, and would be subject to mid-list 
insertions if a NIC were added/replaced. And that is fragile.

I was looking for an easy way to do PCI slot to MAC, and from there MAC 
to IP, so any NIC plugged into a given slot could be called eth0 (for 
instance) and given the "right" IP address, but that's not easy. Can be 
done with some searching in /sys, but it's non-trivial.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
