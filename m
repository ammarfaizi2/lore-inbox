Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030522AbWBHFRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030522AbWBHFRR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbWBHFRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:17:17 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:50706 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030522AbWBHFRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:17:16 -0500
Date: Wed, 8 Feb 2006 06:17:09 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Grant Coady <gcoady@gmail.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
Message-ID: <20060208051709.GE11380@w.ods.org>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com> <200602081335.18256.kernel@kolivas.org> <24niu1hrom6udfa2km18b8bagad62kjamc@4ax.com> <200602081400.59931.kernel@kolivas.org> <nutiu1dkoldca31ddusfbd2rv41q7q0k3m@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nutiu1dkoldca31ddusfbd2rv41q7q0k3m@4ax.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

On Wed, Feb 08, 2006 at 03:51:24PM +1100, Grant Coady wrote:
> On Wed, 8 Feb 2006 14:00:59 +1100, Con Kolivas <kernel@kolivas.org> wrote:
> 
> >This is the terminal's fault. xterm et al use an algorithm to determine how 
> >fast your machine is and decide whether to jump scroll or smooth scroll. This 
> >algorithm is basically broken with the 2.6 scheduler and it decides to mostly 
> >smooth scroll.
> 
> Strange it does that over localnet to a PuTTY terminal on windoze.
> 
> Seems a strange thing to do in the kernel though, presentation 
> buffering / management surely can be done in userspace?

I suspect the sshd on the firewall gets woken up for each line and it
behaves exactly like an xterm. After having done a lot of "ls -l|cat"
on 2.6, I'm not surprized at all :-/

A good test would be to strace sshd under 2.4 and 2.6. You could even
use strace -tt. Probably that you will see something like 1 ms between
two reads on 2.6 and nearly nothing between them in 2.4.

> Grant.

Cheers,
Willy

