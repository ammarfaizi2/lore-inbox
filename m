Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293440AbSCAAik>; Thu, 28 Feb 2002 19:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310291AbSCAAg7>; Thu, 28 Feb 2002 19:36:59 -0500
Received: from saladd2.ist.utl.pt ([193.136.132.33]:12931 "EHLO
	saladd2.ist.utl.pt") by vger.kernel.org with ESMTP
	id <S310284AbSCAAfa>; Thu, 28 Feb 2002 19:35:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15486.52695.972327.496962@saladd2.ist.utl.pt>
Date: Fri, 1 Mar 2002 00:39:51 +0000
From: "Jose' Manuel Pereira" <jmp@ist.utl.pt>
To: Pavel Machek <pavel@suse.cz>
Cc: swsusp@lister.fornax.hu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18/swsusp bugs
In-Reply-To: Pavel Machek's message of <20020228101705.GE4760@atrey.karlin.mff.cuni.cz> [Subj: Re: 2.2.18/swsusp bugs]
In-Reply-To: <20020219194154.GA2054@elf.ucw.cz>
	<200202201702.g1KH2YR05704@fuji.home.perso>
	<15477.26769.969651.333984@saladd2.ist.utl.pt>
	<20020222020202.GC30638@atrey.karlin.mff.cuni.cz>
	<15478.33963.155227.154314@saladd2.ist.utl.pt>
	<20020222185606.GC1351@atrey.karlin.mff.cuni.cz>
	<15478.49275.3087.824024@saladd2.ist.utl.pt>
	<20020223212820.GA943@elf.ucw.cz>
	<15485.22755.869916.466453@saladd2.ist.utl.pt>
	<20020228101705.GE4760@atrey.karlin.mff.cuni.cz>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: "Jose' Manuel Pereira" <jmp@ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"PM" == Pavel Machek <pavel@suse.cz> writes:

  PM> Well, global entries are for things common to all processes, like
  PM> vmalloced area. But you are just booting different kernel, which has
  PM> different vmalloced areas.

You're right, of course. We're replacing all page tables by then.

  PM> So what happens is * kernel works, prepares some work into the journal *
  PM> suspend/resume cycle, work in journal is actually done * kernel might be
  PM> pretty confused here, as its disk state changed below it...
  >> The kernel isn't confused, is just unaware that it just writes again the
  >> state that's in fact (well, supposedly) already on disk.

  PM> I'm not sure this is safe.

I didn't say I was sure either, but it is supposed to, I believe.

  >> That can probably be done by going over all disk drivers and
  >> understanding how they guarantee all (DMA) transactions are over.

  PM> Yep. That's what I'm going to do.

I was hoping there was something higher-level that had that info available...

  >> Alright, but provided that trying to resume from a non-suspend swap
  >> doesn't crash anything...

  PM> Do you stop all user processes before doing resume, for example?

(Different subject, hey?-). No, I don't. At the point I do (and recommend to)
swapon is during early init processing. There are no user processes at that
point. If they are, they disappear in thin air at that point...

But I already gave up, I agree w/your method. But remember that people will
boot resume=/bla even when they have no swap to resume from. Just a lilo thing,
unavoidable.

  PM> But that might be problem at resume. Imagine uhci has buffers at
  PM> 0x12345678, but in image being resumed, /bin/bash is at 0x12345678. Then
  PM> you have a problem.

Nope, that can't happen. uhci and bash had their pages neatly restored...
Wait! Are you saying you start uhci/netdrivers/enable interrupts BEFORE
resuming?? Nonono! Forbidden! Disk corruption, or your computer may explode!

(Apart from the explosions, all that seems to routinely happen in swsusp-2.4 ;-)

  >> How about disabling interrupts except for the swap disk driver? Just a
  >> thought...

  PM> You don't easily know which one is it.

Why? You have the major/minor! (Remember you got the user to tell you).
Looks easy from here (I'm not looking at the code right now :-)

  PM> [swsusp list no longer works, doing cc to l-k.]

So it seems. It didn't bounce yesterday, but didn't get a response. OTOH, l-k
isn't too busy a place to discuss swsusp? How about the ACPI list?

(BTW, I'm not subscribed to l-k. But I can read the archives...)

-- 
 Jose' Pereira		(CIIST sysadm)			Tel. +351.21.841 7526
 Centro de Informatica
 Instituto Superior Tecnico - Technical University of Lisboa
 Av. Rovisco Pais - 1049-001 Lisboa - Portugal
