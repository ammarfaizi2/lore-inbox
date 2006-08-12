Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWHLHae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWHLHae (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 03:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWHLHae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 03:30:34 -0400
Received: from main.gmane.org ([80.91.229.2]:26595 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751374AbWHLHad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 03:30:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: Status of driver core struct device changes?
Date: Sat, 12 Aug 2006 07:30:32 +0200
Organization: Palacky University in Olomouc
Message-ID: <44DD6778.8060003@flower.upol.cz>
References: <1155332969.2652.8.camel@soncomputer> <20060812005959.GA25689@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: linux-kernel@vger.kernel.org
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <20060812005959.GA25689@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH:
> On Fri, Aug 11, 2006 at 05:49:29PM -0400, Louis Garcia II wrote:
...
> I'm working on fixing up the udev issues so that the kernel work is not
> held up.  That's a bit slower going as it requires me to install a lot
> of different distros...
> 

(IMHO any new _documented_ sysfs layout is not so bad for fresh kernels)

Will Andrew complain, if someone will change some  userspace<->kernel interface 
to something *really* usable ?

[ Story ]

IMHO here's good example of this (with some comments).

A firmware (and binary modules)
in the linux world:
-- ethically bad;
-- causing flames in lkml every year (someone's quote);
-- binary/[GPLv2 incompatible source] modules can't be non derived from Linux,
    if some interfaces are used;
-- 1074 FIRMWARE LOADER (request_firmware)
    1075 L: linux-kernel@vger.kernel.org
    1076 S: Orphan
-- GNU paranoia ;D of original author of request_firmware():
	...
	2 * firmware_sample_driver.c -
	3 *
	4 * Copyright (c) 2003 Manuel Estrada Sainz <ranty@debian.org>
	5 *
	...
	115 MODULE_LICENSE("GPL");

in the wild world:
-- (while it's in every modern PC) Linus said

    "The fact that ACPI was designed by a group of monkeys high on LSD"
    <http://permalink.gmane.org/gmane.linux.kernel/322911>

-- broken ACPI DSDT needs hand-hacked updates;
-- devices with (re)loadable firmware;
-- whatever on-demand text/binary (re)configuration of devices (PCI/USB ids);
-- (wait for more LSD tabs under bonnet ;).


Let me put all together.

Binary/text uploading for devices is on *demand* as for open-source linux-only 
drivers, as for ported drivers with or without sources (GPLed or not). But 
interface is orphan (for 3 years), uses brand Linux SYSFS(tm). Huge firmware 
files are out there:
  __
/
|deen:ddk/linux-2.6.16.18/drivers/scsi/qla2xxx# du -hcs *fw.c
|306K    ql2100_fw.c
|337K    ql2200_fw.c
|485K    ql2300_fw.c
|523K    ql2322_fw.c
|591K    ql2400_fw.c
|448K    ql6312_fw.c
|2.7M    total
|deen:ddk/linux-2.6.16.18/drivers/scsi/qla2xxx# du -hcs
|3.3M    .
|3.3M    total
|deen:ddk/linux-2.6.16.18/drivers/scsi/qla2xxx# echo print 2.7/3.3*100 | python
|81.8181818182
|deen:ddk/linux-2.6.16.18/drivers/scsi/qla2xxx#
\__

I've read some lkml posts, where Linus Torvalds argued good design by the
"UNIX way". I never used any real UNIX or derived OS, but heard many rumors 
(also i'm not graduated in CS). One such rumor was:

"in /dev/ a real UNIX has access even for processor's registers !".

But lets see documents, like <http://en.wikipedia.org/wiki/Device_file>:

"The Unix systems are characterized by various concepts: plain text files, 
command line interpreter, hierarchical file system, treating devices and 
certain types of inter-process communication as files, etc."

"A device file or special file is an interface for a device driver that appears 
in a file system as if it were an ordinary file. This allows software to 
interact with the device driver using standard input/output system calls, which 
simplifies many tasks.

Device files often provide simple interfaces to peripheral devices, ..."

... plain text files, ... simple interface to peripherial devices ...

Nothing about programming, but user point is important here.
(If you're still reading me) using linux-gnu i came to inevitable conclusion, 
that good modern programmer (kernel or userspace) must be excellent user of OS.

So, what's wrong ? Yes, in UNIX time there were no cheap RAM, no FLASH, system 
programmers used to burn (E)EPROMs once and forever ;D. But i think UNIX way 
maybe smoothly adopted.
  __
/
|olecom@deen:~$ dd </usr/share/lsd/ver7.tab>/dev/intelshacker
|7+0 records in
|7+0 records out
|3584 bytes (3.6 kB) copied, 5.1e-05 seconds, 70.3 MB/s
|olecom@deen:~$ echo $?
\_

File with one ASCII line of description and whatever after that, feed with a 
little bit of XML to device file. Device maybe some kind of relay or real.
UNIX way, isn't it (with xml ;) ? Clear, simply and nobody will complain about 
"new ways to piss-off developers with use of proc/sysfs/configfs/whateverfs".

Yes, driver developers tend to place firmware into driver, because "everything 
will work out of the box" (well, until bugs are in safe place ;). But this is 
only first step toward full configured device (ifconfig, hdparm, setserial, 
whatever). So let system administrators deal with that, system programmers are 
just programmers, not users. One line to startup/hotplug/udev/whatever script, 
that's all.

Intel microcode update driver uses character device file. But (as usual) it 
requires additional utility.

I'm pretty sure, that there's a possible combination of [ASCII line token] / 
open() / write() / close() to communicate to the driver. Such way was found for 
mandatory locking using old permissions.

I suppose, that (embedded) ARM kernel developers doing such things to devices 
on every step. And i can't understand why there's such ugly interface for 
firmware upload, are they very busy or 2.6 isn't for embedded world (nosysfs 
patches) ?

> thanks,
> 
> greg k-h

Yes, thanks for everything!

-- 
-o--=O`C
  #oo'L O
<___=E M

