Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbSIWNIr>; Mon, 23 Sep 2002 09:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbSIWNIr>; Mon, 23 Sep 2002 09:08:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:48002 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261246AbSIWNIq>; Mon, 23 Sep 2002 09:08:46 -0400
Date: Mon, 23 Sep 2002 09:15:41 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Erik Andersen <andersen@codepoet.org>
cc: Con Kolivas <conman@kolivas.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
In-Reply-To: <20020923124730.GA7556@codepoet.org>
Message-ID: <Pine.LNX.3.95.1020923091213.2963C-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Erik Andersen wrote:

> On Mon Sep 23, 2002 at 08:30:21PM +1000, Con Kolivas wrote:
> > Yes you make a very valid point and something I've been stewing over privately
> > for some time. contest runs benchmarks in a fixed order with a "priming" compile
> > to try and get pagecaches etc back to some sort of baseline (I've been trying
> > hard to make the results accurate and repeatable). 
> 
> It would sure be nice for this sortof test if there were
> some sort of a "flush-all-caches" syscall...
> 
>  -Erik

I think all you need to do is reload the code-segment register
and you end up flushing caches in ix86.


#
#   This forces a cache-line refill by reloading the code-segment
#   segment register. This would normally slow things down. However,
#   if I put this at the start of a procedure that suffers a cache-line
#   refill within the procedure, it is possible to speed things up.
#
.section	.text
.global		cflush	
.type		cflush,@function

cflush: pushl	%cs		# Put code segment on the stack
	pushl	$goto		# Put offset on the stack
	lret			# Do a 'long' return (reloads cs)
goto:	ret
.end




Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

