Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161158AbVIPKdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbVIPKdI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 06:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbVIPKdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 06:33:08 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:54918 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1161158AbVIPKdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 06:33:07 -0400
Date: Fri, 16 Sep 2005 12:33:03 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: early printk timings way off
In-Reply-To: <Pine.LNX.4.53.0509161202450.19735@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.53.0509161226440.19898@gockel.physik3.uni-rostock.de>
References: <200509152342.24922.jesper.juhl@gmail.com> 
 <Pine.LNX.4.58.0509151458330.1800@shark.he.net> <9a87484905091515072c7dd4a8@mail.gmail.com>
 <Pine.LNX.4.53.0509161202450.19735@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2005, Tim Schmielau wrote:

> On Fri, 16 Sep 2005, Jesper Juhl wrote:
> > It also doesn't
> > explain why two lines, the first with timing value 0.000, and the next
> > with 27.121 don't seem to match reality - the *actual* delta between
> > printing those two lines is far lower than 27 seconds.
>
> Yes, this seems to be different, possibly unrelated problem.
> It's interesting that the value jumps _exactly_to_zero_, though.
> Will need to dig into the code...

Did that.
The problem is that printk uses sched_clock() to determine the time, which
just isn't supposed to be a reliable long-time clock. We need to base the
output on a different clock.

Btw, the rate-limiting logic in printk.c looks 'interesting'. Will look
into that, too.

Tim
