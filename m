Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVAIEHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVAIEHz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 23:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVAIEHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 23:07:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:36074 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262245AbVAIEHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 23:07:50 -0500
Date: Sat, 8 Jan 2005 20:07:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <Pine.LNX.4.58.0501081345440.2386@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501082004450.2339@ppc970.osdl.org>
References: <41DE9D10.B33ED5E4@tv-sign.ru>  <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
  <1105113998.24187.361.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org> 
 <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org> <41DEF81B.60905@sun.com>
  <41DF1F3D.3030006@nortelnetworks.com> <1105220326.24592.98.camel@krustophenia.net>
 <Pine.LNX.4.58.0501081345440.2386@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jan 2005, Linus Torvalds wrote:
> 
> Short and sweet: the latency changes are in the noise for SMP, but can be
> seen on UP. I'll look at it a bit more:  since I had to add the coalescing
> code anyway, I might also decide to re-use a buffer page rather than free
> it immediately, since that may help latency for small writes.

Side note: the SMP numbers seem to fluctuate wildly making any
benchmarking a bit suspect. They probably depend very much on just how
things get scheduled, and on inter-CPU cache behaviour.

In contrast, the UP numbers are a lot more reliable, so I'll try to make
sure that everything looks good on UP - which definitely means that I'll
work to make sure that latency looks good too.

		Linus
