Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313016AbSDPX1f>; Tue, 16 Apr 2002 19:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313962AbSDPX1e>; Tue, 16 Apr 2002 19:27:34 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:21841
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S313016AbSDPX1d>; Tue, 16 Apr 2002 19:27:33 -0400
Message-Id: <200204162327.g3GNRO606562@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: ebiederm@xmission.com (Eric W. Biederman)
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 arch subdivision into machine types for 2.5.8 
In-Reply-To: Message from ebiederm@xmission.com (Eric W. Biederman) 
   of "16 Apr 2002 15:44:37 MDT." <m1n0w3iaii.fsf@frodo.biederman.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Apr 2002 18:27:23 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com said:
> Yes.  I'm totally for the ability to select from config.in.  But at
> the same time having being able to build a kernel that works in all
> kinds of configurations comes in quite handy.  I know the alpha does
> this I'm not quite certain about ARM. 

The alpha uses a machine type function table switch to achieve this.  It's 
certainly possible, just slightly more than I bargained for.

The issue will become more interesting with Patrick's cpu/bus/mtrr switch, 
where self configuration does become more of an issue.  Can I just wait to see 
what he comes up with and then copy it?

> Do you have boot problems on the NCR voyagers?  If so I'd be
> interested in hearing what the issues are.

The 8 byte GDT alignment requirement in boot/setup.S was the biggest problem 
(until I found it empirically), if that's not done, they crash when jumping to 
protected mode.

Not all boot managers work on voyager: grub and syslinux don't, lilo does (for 
now) but complains that EBDA is too big.

I think it's because they actually have a larger than 384k hole (low memory 
seems to end at 588k instead of 640k), but I was just so relieved to get them 
to boot finally that I've never explored the problems in detail.

This is the actual memory map:

BIOS-provided physical RAM map:
 Voyager-SUS: 0000000000000000 - 0000000000093000 (usable)
                                            ^^^^^ usually around 9fffff
 Voyager-SUS: 0000000000100000 - 000000003ffff000 (usable)

James


