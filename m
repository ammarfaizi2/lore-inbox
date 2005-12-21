Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVLUWuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVLUWuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVLUWuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:50:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:40387 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964909AbVLUWuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:50:21 -0500
Date: Wed, 21 Dec 2005 23:50:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nikita Danilov <nikita@clusterfs.com>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: About 4k kernel stack size....
In-Reply-To: <17321.29301.978623.281668@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.61.0512212345560.605@yvahk01.tjqt.qr>
References: <20051218231401.6ded8de2@werewolf.auna.net> <43A77205.2040306@rtr.ca>
 <20051220133729.GC6789@stusta.de> <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com>
 <46578.10.10.10.28.1135094132.squirrel@linux1> <Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com>
 <17320.35736.89250.390950@gargle.gargle.HOWL> <Pine.LNX.4.61.0512210901340.11568@chaos.analogic.com>
 <17321.25650.271585.790597@gargle.gargle.HOWL> <Pine.LNX.4.61.0512210923580.11743@chaos.analogic.com>
 <17321.29301.978623.281668@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > > See, isn't rule-making fun? This whole 4k stack-
> > > > > > thing is really dumb. Other operating systems
> > > > > > use paged virtual memory for stacks, except
> > > > > > for the interrupt stack. If Linux used paged
> > > > > > virtual memory for stacks,
> > > > >
> > > > > ... then spin-locks couldn't be held across function calls.
> > > >
> > > > Sure they can! In ix86 machines the local 'cli' within the
> > >
> > > Sure they cannot: one cannot schedule with spin-lock held, and major
> > > page fault will block for IO.
> > > [...]
> > [...]
> [...]

Without me knowing every single detail of this matter, just try to hold a 
mutex over function calls in the BSD kernel. While you can acquire a mutex 
(=spinlock) (local to the module implementing the chardev) in e.g. the 
open() routine of a chardev in Linux, and release it upon close(), you'll 
get a segfault on BSD. Ok, Linux got nothing to do with BSD, but that's 
what I remember from porting some code, and it resembles what is discussed 
above.
(http://unix.derkeiler.com/Mailing-Lists/FreeBSD/hackers/2004-12/0337.html)



Jan Engelhardt
-- 
