Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263781AbUEXBZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbUEXBZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 21:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263799AbUEXBZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 21:25:57 -0400
Received: from unthought.net ([212.97.129.88]:22420 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S263781AbUEXBZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 21:25:54 -0400
Date: Mon, 24 May 2004 03:25:53 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: William Lee Irwin III <wli@holomorphy.com>,
       Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-ID: <20040524012553.GG30687@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
References: <20040524003200.14639.qmail@web90007.mail.scd.yahoo.com> <20040524005751.62303.qmail@web90006.mail.scd.yahoo.com> <20040524010455.GJ1833@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524010455.GJ1833@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 06:04:55PM -0700, William Lee Irwin III wrote:
> On Sun, May 23, 2004 at 05:57:51PM -0700, Phy Prabab wrote:
> > Just for more clarification, here is a perfect
> > example:
> > 2.6.7-p1:
> > 24.86user 51.77system 2:58.87elapsed 42%CPU
> > (0avgtext+0avgdata 0maxresident)k
> > 0inputs+0outputs (13major+7591686minor)pagefaults
> > 0swaps
> > 2.4.21:
> > 28.68user 34.98system 1:12.34elapsed 87%CPU
> > (0avgtext+0avgdata 0maxresident)k
> > 0inputs+0outputs (5691267major+1130523minor)pagefaults
> > 0swaps
> 
> Thanks. This reveals that the performance regression is system time.

Eh, not if I read the numbers right:

2.6.7-p1: 24.86user 51.77system 2:58.87elapsed 42%CPU

24.86 + 51.77 = 76.63 seconds on CPU, 102.24 seconds of waiting

2.4.21: 28.68user 34.98system 1:12.34elapsed 87%CPU

28.68 + 34.98 = 63.66 seconds on CPU, 8.68 seconds of waiting

So, 2.6.7-p1 spends 16.79 seconds more in the kernel as you observed,
but it spends 93.56 seconds more waiting for I/O (or whatever).

Unless I'm totally missing something, the wait seems to be the
regression.

 / jakob

