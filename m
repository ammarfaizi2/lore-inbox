Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314074AbSDQHHV>; Wed, 17 Apr 2002 03:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSDQHHU>; Wed, 17 Apr 2002 03:07:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37965 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314074AbSDQHHU>; Wed, 17 Apr 2002 03:07:20 -0400
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 arch subdivision into machine types for 2.5.8
In-Reply-To: <200204162327.g3GNRO606562@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Apr 2002 01:00:10 -0600
Message-ID: <m1it6qizd1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> ebiederm@xmission.com said:
> > Yes.  I'm totally for the ability to select from config.in.  But at
> > the same time having being able to build a kernel that works in all
> > kinds of configurations comes in quite handy.  I know the alpha does
> > this I'm not quite certain about ARM. 
> 
> The alpha uses a machine type function table switch to achieve this.  It's 
> certainly possible, just slightly more than I bargained for.
> 
> The issue will become more interesting with Patrick's cpu/bus/mtrr switch, 
> where self configuration does become more of an issue.  Can I just wait to see 
> what he comes up with and then copy it?

Sounds reasonable.  What I care about is that we have the goals straight at least.
 
> > Do you have boot problems on the NCR voyagers?  If so I'd be
> > interested in hearing what the issues are.
> 
> The 8 byte GDT alignment requirement in boot/setup.S was the biggest problem 
> (until I found it empirically), if that's not done, they crash when jumping to 
> protected mode.

It sounds like we may have been getting lucky on that one.  I guess an explicit
align directive fixes that.

> Not all boot managers work on voyager: grub and syslinux don't, lilo does (for 
> now) but complains that EBDA is too big.

Interesting, so reading this and skimming your patch the voyager BIOS is a
descendant of the XT & AT BIOS.  But it is a very weird one.

What was the gate a20 issue, you fixed in setup.S?
 
> I think it's because they actually have a larger than 384k hole (low memory 
> seems to end at 588k instead of 640k), but I was just so relieved to get them 
> to boot finally that I've never explored the problems in detail.

That could be it.  But there have been enough systems with that
problem I would have thought the various bootloaders would have
already handled it.  syslinux especially.

> This is the actual memory map:
> 
> BIOS-provided physical RAM map:
>  Voyager-SUS: 0000000000000000 - 0000000000093000 (usable)
>                                             ^^^^^ usually around 9fffff
>  Voyager-SUS: 0000000000100000 - 000000003ffff000 (usable)

Certainly a different one.  I find it interesting how none of these
maps reserve the bios interrupt table, or the BIOS data area.  Basically
the first 1280 bytes of memory...  And they just assume everyone will
know better and not touch them :)

Eric
