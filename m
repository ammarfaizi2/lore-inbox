Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTEDHaX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 03:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263548AbTEDHaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 03:30:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3137 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S263547AbTEDHaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 03:30:21 -0400
To: Valdis.Kletnieks@vt.edu
Cc: thunder7@xs4all.nl, Gabe Foobar <foobar.gabe@freemail.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: will be able to load new kernel without restarting?
References: <freemail.20030403212422.18231@fm9.freemail.hu>
	<20030503205656.GA19352@middle.of.nowhere>
	<200305032252.h43Mq7X9006633@turing-police.cc.vt.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 May 2003 01:39:51 -0600
In-Reply-To: <200305032252.h43Mq7X9006633@turing-police.cc.vt.edu>
Message-ID: <m11xzfcg8o.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> On Sat, 03 May 2003 22:56:56 +0200, Jurriaan said:
> 
> > > Just a simple question. When I will be able to load new
> > > kernel without restarting the system? Working anybody on
> > > this problem?
> 
> > Check the archives for 'kexec'. Some success messages were posted even
> > today.
> > 
> 
> As I understand it, that's still restarting, just skipping the usual detour
> through the BIOS and lilo/grub/whatever.
> 
> What he wants is the sort of on-the-fly upgrading that bellheads have grown to
> know and love, and which is NOT likely to be implemented for the entire Linux
> kernel anytime soon.  Large sections can do it now with the "module" stuff, so
> you can rmmod the old one and insmod the new one.. but I don't see any easy way
> to implement rmmmod/insmod semantics for things like kernel/schedule.c (how
> would you get your next timeslice?).  There's also issues with changing the
> API for something - it's hard to drop a 2.5.71 kernel/signals.c into a 2.5.70
> kernel if the API is different.  Googling around will probably cough up
> lots of references to how the telcos do software upgrades - it basically
> involves LOTS of up-front design work to make sure all the details are
> addressed in the basic design of the system.
> 
> Bottom line - you can do it now for things that can be built as modules,
> *if* it's something you can effectively rmmod and insmod.  If it's not a module,
> 
> or if it's the driver for something you can't rmmod (a disk or network driver,
> etc), you can't do it on-the-fly.

If you can checkpoint user space you can use kexec to load the new kernel.
So at this point we are approaching half way there.   I don't know
where all of the work is for checkpointing but I do know there is a lot of interest
in it, and several partial implementations.

When replacing the entire kernel at least you have a stable ABI which
makes a number of things at least theoretically easier.

Eric



