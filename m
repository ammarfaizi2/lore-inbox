Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbSKQR7l>; Sun, 17 Nov 2002 12:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbSKQR7k>; Sun, 17 Nov 2002 12:59:40 -0500
Received: from mx2.elte.hu ([157.181.151.9]:50130 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267540AbSKQR7j>;
	Sun, 17 Nov 2002 12:59:39 -0500
Date: Sun, 17 Nov 2002 20:23:08 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Run timers as softirqs, not tasklets
In-Reply-To: <20021117171625.C7530@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0211172020470.11308-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Matthew Wilcox wrote:

> Seems to me that the timer code is attempting to replicate the softirq
> characteristics at the tasklet level, which is a little pointless.  
> This patch converts timers to be a first-class softirq citizen.

i agree with your patch.

> Ingo, was there a reason you didn't do it this way to begin with?

because there was an interim state of the timer code in where we still had
a global timer context (ie. a timer tasklet). Only later did it get
converted to completely unsynchronized per-CPU tasklets. Which indeed is
what softirqs are :-)

	Ingo

