Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbWFIEuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWFIEuk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 00:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWFIEuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 00:50:40 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:12441 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965116AbWFIEuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 00:50:39 -0400
Message-ID: <4488FE41.9010901@sbcglobal.net>
Date: Thu, 08 Jun 2006 23:51:13 -0500
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-ide@vger.kernel.org, "zhao, forrest" <forrest.zhao@intel.com>,
       htejun@gmail.com, randy_dunlap <rdunlap@xenotime.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ATA host-protected area (HPA) device mapper?
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>	 <44883BAE.7070406@pobox.com> <1149820043.5721.7.camel@forrest26.sh.intel.com> <4488E6F6.10306@pobox.com> <4488EE68.9000605@garzik.org>
In-Reply-To: <4488EE68.9000605@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> As I just mentioned on linux-ide in another email:
> libata should -- like drivers/ide -- call the ATA "set max" command to 
> fully address the hard drive, including the special "host-protected 
> area" (HPA).  We should do this because the Linux standard is to export 
> the raw hardware directly, making 100% of the hardware capability 
> available to the user (and, in this case, Linux-based BIOS and recovery 
> tools).
> 

Yay for exposing absolute potential functionality; yay for recognizing 
the havok possible, and proposing strategies for channeling that 
possibility.

> However, there are rare bug reports and general paranoia related to 
> presenting 100% of the ATA hard drive "native" space, rather than the 
> possibly-smaller space that the BIOS chose to present to the user.
> 

I've grepped through several old discussions of HPA handling, and it 
doesn't seem like everyone has the same idea of exactly what this will 
do, possibly because of the delta in BIOS behavior over original design 
restrictions.

> My thinking is that [someone] should create an optional, ATA-specific 
> device mapper module.  This module would layer on top of an ATA block 
> device, and present two block devices:  the BIOS-presented space, and 
> the HPA.
> 
> Such a module would make it trivial for users to ensure that partition 
> tables and RAID metadata formats know what the BIOS (rather than 
> underlying hard drive) considers to be end-of-disk.
> 
> Comments?  Questions?  Am I completely insane?  ;-)
> 

Tools with which to lay waste to systems, or save them.

What I like about your proposal is that it doesn't go back to "Do we 
blow away the HPA or reserve it?"; you suggest conserving both options. 
  Make the kernel aware of the existence of the HPA, and thereby the 
whole capacity of the disk, and simultaneously of what it should see and 
expose for usage 'safely'.  Doesn't sound insane to me; it sounds like 
you're planning on [having someone] teach the kernel to respect the 
actual disk limitations.

Whether the implementation will be sane ... 'nother story.  :)  Thence 
the question of teaching userspace to sanely use what is exposed, though 
if the 'old' (non-HPA) space is presented, it shouldn't be a hard 
reorientation.  Would we be talking about a new sysfs entry parallel to 
the existing information?  If I understand it right -- and I might not 
-- the HPA doesn't get included in the partitioning schemes, because it 
is protected.  Even nuking the disk will/should bypass it.  So the 
system will tend to ignore it under normal conditions, until you decide 
to get fancy and trip over its shadow.  So making the kernel aware that 
this disk has this spot that must be respected should be a no-brainer. 
What better way to make the kernel aware of it, than by acknowledging it 
as a block device among other block devices?  It just needs a good 
molly-guard to cover the respect portion of the problem.

Of course, I don't hack ATA, so my opinions may have limited validity 
after a certain level of specificity.  I can always be enlightened as to 
why you really are insane.  ;)

>     Jeff
> 

Matt
