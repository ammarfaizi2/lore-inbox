Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbULNEBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbULNEBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbULND6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 22:58:45 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:59229 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261392AbULND44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 22:56:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ctitQX4OaQqHt7Dq/J3Q8igAwXbrNIDb4fFhb1CdFIsDPYS34ZHJf0CQEPUFgIxJuvxKLPH6zjJ127ToKo5u1yRpnuLhdbxioTz2G09E7F7CV1bXtkda5Lxiy3xgYZnJH3l0MkEy/t5ciSQp5G+jHSnXW2wn2iZh8C0o0reWLio=
Message-ID: <29495f1d0412131956526c94d7@mail.gmail.com>
Date: Mon, 13 Dec 2004 19:56:55 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
Cc: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org, pavel@suse.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041213114737.GV16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random>
	 <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org>
	 <20041213111741.GR16322@dualathlon.random>
	 <20041213032521.702efe2f.akpm@osdl.org>
	 <20041213114737.GV16322@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004 12:47:37 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> On Mon, Dec 13, 2004 at 03:25:21AM -0800, Andrew Morton wrote:
> > We still have 1000-odd places which do things like
> >
> >       schedule_timeout(HZ/10);
> >
> > which will now involve a runtime divide.  The propagation of msleep() and
> > ssleep() will reduce that a bit, but not much.
> 
> The above is by far the least cpu-hungry piece, it's going to sleep for
> 100msec, so any order-of-nanoseconds computation in such path will be by
> defininition not measurable.
> 
> msleep and ssleep as well will obviously be non measurable for the same
> reason (their only point is to wait and "waste" cpu). I mean,
> msleep/ssleep are the only places in the kernel that we don't really
> need to optimize ;).

I don't exactly understand what you mean by ""waste" cpu"? They both
give up the CPU by calling schedule_timeout() which calls schedule().
So any "waste" of the CPU is due to no tasks being available to run,
not to msleep()/ssleep(). I think :)

-Nish
