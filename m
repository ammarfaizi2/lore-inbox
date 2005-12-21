Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVLUPTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVLUPTC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 10:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVLUPTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 10:19:02 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:30376 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932450AbVLUPTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 10:19:00 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17321.29301.978623.281668@gargle.gargle.HOWL>
Date: Wed, 21 Dec 2005 18:19:17 +0300
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: About 4k kernel stack size....
In-Reply-To: <Pine.LNX.4.61.0512210923580.11743@chaos.analogic.com>
References: <20051218231401.6ded8de2@werewolf.auna.net>
	<43A77205.2040306@rtr.ca>
	<20051220133729.GC6789@stusta.de>
	<170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com>
	<46578.10.10.10.28.1135094132.squirrel@linux1>
	<Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com>
	<17320.35736.89250.390950@gargle.gargle.HOWL>
	<Pine.LNX.4.61.0512210901340.11568@chaos.analogic.com>
	<17321.25650.271585.790597@gargle.gargle.HOWL>
	<Pine.LNX.4.61.0512210923580.11743@chaos.analogic.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) writes:
 > 
 > On Wed, 21 Dec 2005, Nikita Danilov wrote:
 > 
 > > linux-os (Dick Johnson) writes:
 > > >
 > > > On Tue, 20 Dec 2005, Nikita Danilov wrote:
 > > >
 > > > > linux-os \(Dick Johnson\) writes:
 > > > > >
 > > > >
 > > > > [...]
 > > > >
 > > > > > See, isn't rule-making fun? This whole 4k stack-
 > > > > > thing is really dumb. Other operating systems
 > > > > > use paged virtual memory for stacks, except
 > > > > > for the interrupt stack. If Linux used paged
 > > > > > virtual memory for stacks,
 > > > >
 > > > > ... then spin-locks couldn't be held across function calls.
 > > > >
 > > >
 > > > Sure they can! In ix86 machines the local 'cli' within the
 > >
 > > Sure they cannot: one cannot schedule with spin-lock held, and major
 > > page fault will block for IO.
 > >
 > > [...]
 > >
 > 
 > Read the text you deleted and you will learn how.

I am afraid, I'd better not:

 - spin-locks do not imply disabled interrupts;

 - how can "swapper" guarantee that there is enough pages in the free
 list to satisfy stack page faults atomically? The only way is to keep
 free page for each thread. But then it's so much easier to just use
 this reserved page for the stack from the very beginning. 

 Note, that RSX/RT didn't have "kernel threads" at all: it was
 implemented as a non-blocking state machine serving user requests on
 per-cpu stacks (at least pdp-15 versions).

 > 
 > Cheers,
 > Dick Johnson
 > Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
 > Warning : 98.36% of all statistics are fiction.
 > .

Nikita.
