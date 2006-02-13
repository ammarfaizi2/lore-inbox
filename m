Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWBMPth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWBMPth (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWBMPth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:49:37 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:62176 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750704AbWBMPth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:49:37 -0500
Date: Mon, 13 Feb 2006 16:49:20 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 01/13] hrtimer: round up relative start time
In-Reply-To: <20060213144403.GA21317@elte.hu>
Message-ID: <Pine.LNX.4.61.0602131643290.30994@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
 <1139827927.4932.17.camel@localhost.localdomain> <Pine.LNX.4.61.0602131208050.30994@scrub.home>
 <20060213130143.GA10771@elte.hu> <Pine.LNX.4.61.0602131441110.9696@scrub.home>
 <20060213144403.GA21317@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Ingo Molnar wrote:

> In other words: your patch re-introduces half of the bug on low-res 
> platforms. Users doing a series of one-shot itimer calls would be 
> exposed to the same kind of (incorrect and unnecessary) summing-up 
> errors. What's the point?

I don't fully agree with the interval behaviour either, but here one could 
at least say it's correct on average. Since hrtimer is also used for 
nanosleep(), which I consider more important (as e.g. posix timer), this 
one should at least be correct and consistent with previous 2.6 releases. 
I don't mind fixing it properly, but just omitting the rounding here is 
simply not correct.

bye, Roman
