Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbTL3V5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 16:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265335AbTL3V5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 16:57:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:40876 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265319AbTL3V5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 16:57:42 -0500
Date: Tue, 30 Dec 2003 13:57:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Daniel Tram Lux <daniel@starbattle.com>, steve@drifthost.com,
       James Bourne <jbourne@hardrock.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Gergely Tamas <dice@mfa.kfki.hu>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: no DRQ after issuing WRITE was Re: 2.4.23-uv3 patch set released
In-Reply-To: <Pine.LNX.4.58L.0312301849400.23875@logos.cnet>
Message-ID: <Pine.LNX.4.58.0312301352570.2065@home.osdl.org>
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org>
 <Pine.LNX.4.58L.0312300935040.22101@logos.cnet> <Pine.LNX.4.58.0312301130430.2065@home.osdl.org>
 <Pine.LNX.4.58L.0312301849400.23875@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Marcelo Tosatti wrote:
> 
> Small correction: people are not hitting the WAIT_READY (they are hitting
> the problem from ide-disk.c, which uses WAIT_DRQ). But still...

Ok. Do you have the full trace? In particular, if there is no locking in 
that path, and interrupts are enabled, you could possibly get not just an 
interrupt, but a preemption event. Now _that_ could blow up the timeout to 
any amount of time, and then even 100ms might not be enough.

Is CONFIG_PREEMPT on in the cases, and is there really no locking 
anywhere? Preempting in the middle of the data transfer phase sounds like 
a fundamentally bad idea, and maybe the code needs a few preempt 
disable/enable pairs somewhere?

			Linus
