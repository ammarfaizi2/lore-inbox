Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVC3Vm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVC3Vm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVC3Vm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:42:57 -0500
Received: from 71-33-33-84.albq.qwest.net ([71.33.33.84]:23959 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262282AbVC3Vmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:42:47 -0500
Date: Wed, 30 Mar 2005 14:44:28 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org, seife@suse.de,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: smp/swsusp done right
In-Reply-To: <20050330212253.GB1347@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0503301437550.12965@montezuma.fsmlabs.com>
References: <20050323204019.GA11616@elf.ucw.cz>
 <Pine.LNX.4.61.0503301413050.12965@montezuma.fsmlabs.com>
 <20050330212253.GB1347@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Pavel Machek wrote:

> Hi!
> 
> > > This is against -mm kernel; it is smp swsusp done right, and it
> > > actually works for me. Unlike previous hacks, it uses cpu hotplug
> > > infrastructure. Disable CONFIG_MTRR before you try this...
> > > 
> > > Test this if you can, and report any problems. If not enough people
> > > scream, this is going to -mm.
> > 
> > Yay! Thanks for getting that done Pavel =)
> 
> Well, I guess it is thank you -- I got rid of ugly FIXME that would
> involve arch-dependend assembly to be solved properly.
> 
> ... hmm, can play_dead handle all the memory being overwritten? Also
> it should probably save and restore registers including MTRRs.

play_dead currently can't handle memory being overwritten, i guess you'd 
probably want to put the hook to kill the processor for real there. We 
probably only have to make sure that MTRRs are restored on resume, which 
should be taken care of by the current code since ACPI hotplug probably 
requires it too.

> ...so I more moved ugly FIXME to better place. Oh well, at least it
> uses common infrastructure now. People at Intel doing suspend-to-RAM
> on smp systems will need to solve it properly, anyway, because they
> need to go to real mode and back.

Sounds like a perfect candidate =)

Thanks,
	Zwane

