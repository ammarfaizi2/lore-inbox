Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVAHRef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVAHRef (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 12:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVAHRee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 12:34:34 -0500
Received: from mail-ext.curl.com ([66.228.88.132]:1034 "HELO mail-ext.curl.com")
	by vger.kernel.org with SMTP id S261220AbVAHReb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 12:34:31 -0500
To: "linux-os" <linux-os@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/random vs. /dev/urandom
References: <20050107190536.GA14205@mtholyoke.edu> <20050107213943.GA6052@pclin040.win.tue.nl> <Pine.LNX.4.61.0501071729330.22391@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501071729330.22391@chaos.analogic.com>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 08 Jan 2005 12:34:30 -0500
Message-ID: <s5gzmzjbza1.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os <linux-os@chaos.analogic.com> writes:

> In this case I AND with 1, which should produce as many '1's as
> '0's, ... and clearly does not.

Actually, a fair coin flipped N times is unlikely to come up heads
exactly N/2 times, and the probability of this drops quickly as N
grows.

What is true is that it will usually come up heads N/2 times, give or
take sqrt(N).  Mathematicians call this the "Central Limit Theorem".

For example, take N=32.  The square root of 32 is a little less than
6.  So we expect to see between 16-6 (i.e., 10) and 16+6 (i.e., 22)
heads in a typical trial.  (Of course, in one trial out of 4 billion
it will come up all heads.  The Central Limit Theorem is about "usual"
outcomes, not every outcome.)

So we expect between 10 and 22 odds/evens in your trial.

> Trying /dev/random
> 0100000101010000010001000101000000000000000101000100010000000101
>   odds = 14 evens = 18
> Trying /dev/urandom
> 0001010001000100000101000100010001000000000000000000010000000000
>   odds = 10 evens = 22
> LINUX> ./xxx
> Trying /dev/random
> 0100000100010101000101010101010101000100010000010001010000000101
>   odds = 20 evens = 12
> Trying /dev/urandom
> 0100000100000101010001000101010001010001000000010101010100010000
>   odds = 18 evens = 14

Well how about that.  Try it with larger N, and you will find it gets
even harder to hit a case where the total is outside the sqrt(N) error
margin.  And of course, as a percentage of N, sqrt(N) only shrinks as
N grows.

If you doubt any of this, try it with a real coin.  Or read a book on
probability.

 - Pat
