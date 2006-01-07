Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbWAGJTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbWAGJTK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 04:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWAGJTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 04:19:10 -0500
Received: from drugphish.ch ([69.55.226.176]:61608 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S932703AbWAGJTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 04:19:08 -0500
Message-ID: <43BF8785.2010703@drugphish.ch>
Date: Sat, 07 Jan 2006 10:19:01 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu> <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu> <1136030901.28365.51.camel@localhost.localdomain> <20051231130151.GA15993@alpha.home.local> <Pine.LNX.4.64.0601041402340.28134@potato.cts.ucla.edu> <20060105054348.GA28125@w.ods.org> <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu> <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu>
In-Reply-To: <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> After a little more than one day up with 2.4.32 SMP+ACP+aic7xxx, I got 
>> another bad pmd and an oops this morning at 4:23am.  I'm going to boot 
>> vanilla 2.4.32 with nosmp and acpi=off.

Your oops does not make much sense, could you enable following, please:

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_FRAME_POINTER=y

> booting with "nosmp acpi=off" did not help.  The box hung as before, at

Could you boot with pci=noacpi and report again? The difference is that 
ACPI will still be used but not for IRQ routing. I have a few boxes out 
with 2.4.x kernels and Adaptec HBAs that need this to work reliably.

> hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: attached ide-cdrom driver.
> hda: ATAPI 24X CD-ROM drive, 128kB Cache
> Uniform CD-ROM driver Revision: 3.12
> SCSI subsystem driver Revision: 1.00
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36

What's the SCSI BIOS version?

>        <Adaptec 3960D Ultra160 SCSI adapter>
>        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> 
> scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>        <Adaptec 3960D Ultra160 SCSI adapter>
>        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
> 
> scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>        <Adaptec aic7899 Ultra160 SCSI adapter>
>        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
> 
> blk: queue f7e46018, I/O limit 4095Mb (mask 0xffffffff)
>  
> I waited about 10 minutes to see if it would continue, then booted back 
> into 2.6.14.4.

What's the diff between /proc/interrupt and lspci -v on those kernels, 
when they've finished the booting sequence?

If you find time, send me your BIOS settings and your .config in private 
email. I didn't track this thread from the beginning, so I don't know if 
you've already done this.

It might also help to carry this problem over to the linux-scsi mailing 
list, since, I believe, most SCSI guys don't ready lkml too frequently.

Of course, if 2.6.x works for you and you need to go productive, then 
I'd switch to it if I was you.

Just my 2 cents,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
