Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264545AbRFTSfx>; Wed, 20 Jun 2001 14:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264548AbRFTSfo>; Wed, 20 Jun 2001 14:35:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10907 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264545AbRFTSf2>;
	Wed, 20 Jun 2001 14:35:28 -0400
Date: Wed, 20 Jun 2001 14:35:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: george anzinger <george@mvista.com>
cc: Jes Sorensen <jes@sunsite.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        bert hubert <ahu@ds9a.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <3B30D1AC.325A4CCB@mvista.com>
Message-ID: <Pine.GSO.4.21.0106201429150.26389-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Jun 2001, george anzinger wrote:

> > around we _will_ get problems. Kernel UP programming is not different
> > from SMP one. It is multithreaded. And amount of genuine SMP bugs is
> > very small compared to ones that had been there on UP since way back.
> > And yes, programming threads is the same thing. No arguments here.
> > 
> Correct, IF the UP kernel is preemptable.  As long as it is not (and SMP
> is ignored) threads are harder BECAUSE they are preemptable.

In practice it's a BS. There is a lot of ways minor modifications of code
could add a preemption point, so if you rely on the lack of such - expect
major PITA.

Yes, in theory SMP adds some extra fun. Practically, almost every "SMP"
race found so far did not require SMP.

Clean code is trivial to make SMP-safe - critical areas that rely on
lack of preemption are couple of instructions wide and are easy to
protect. Anything trickier and I bet that you have a race on (normal)
UP kernel. Been there, found probably several hundreds of them.

