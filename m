Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVBXUK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVBXUK7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 15:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVBXUK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 15:10:58 -0500
Received: from one.firstfloor.org ([213.235.205.2]:60567 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262465AbVBXUKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 15:10:51 -0500
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CKRM [2/8] More accurate account for CPU & IO
 scheduling
References: <E1D4FNo-0006vw-00@w-gerrit.beaverton.ibm.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 24 Feb 2005 21:10:49 +0100
In-Reply-To: <E1D4FNo-0006vw-00@w-gerrit.beaverton.ibm.com> (Gerrit
 Huizenga's message of "Thu, 24 Feb 2005 01:34:08 -0800")
Message-ID: <m1is4hhg6u.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga <gh@us.ibm.com> writes:

> --- linux-2.6.11-rc5.orig/kernel/sched.c	2005-02-23 20:03:10.000000000 -0800
> +++ linux-2.6.11-rc5/kernel/sched.c	2005-02-24 00:54:56.572070756 -0800
> @@ -288,6 +288,8 @@
> @@ -2806,6 +2809,8 @@
>  
>  	sched_info_switch(prev, next);
>  	if (likely(prev != next)) {
> +		add_delay_ts(next, waitcpu_total, next->timestamp, now);
> +		inc_delay(next, runs);

This is an extremly hot path. I think it needs far more justification
why you really need this. In general we try to keep the context
switch as fast as possible; I don't think it's a good idea to add 
accounting like this.

How about you investigate ways to do this using samples 
from the regular statistics timers?  If it's good enough for all
other CPU accounting, it should be good enough for this relatively
obscure metric too.
  
-Andi
