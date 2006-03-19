Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWCSFch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWCSFch (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 00:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWCSFch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 00:32:37 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:39305 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751439AbWCSFcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 00:32:36 -0500
Date: Sun, 19 Mar 2006 13:32:50 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH 07/23] readahead: insert cond_resched() calls
Message-ID: <20060319053250.GB4313@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
References: <20060319023413.305977000@localhost.localdomain> <20060319023451.808130000@localhost.localdomain> <1142740242.4532.1.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142740242.4532.1.camel@mindpipe>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 10:50:42PM -0500, Lee Revell wrote:
> On Sun, 2006-03-19 at 10:34 +0800, Wu Fengguang wrote:
> > plain text document attachment
> > (readahead-insert-cond_resched-calls.patch)
> > Since the VM_MAX_READAHEAD is greatly enlarged and the algorithm become more
> > complex, it becomes necessary to insert some cond_resched() calls in the
> > read-ahead path.
> > 
> > If desktop users still feel audio jitters with the new read-ahead code,
> > please try one of the following ways to get rid of it:
> > 
> > 1) compile kernel with CONFIG_PREEMPT_VOLUNTARY/CONFIG_PREEMPT
> > 2) reduce the read-ahead request size by running
> > 	blockdev --setra 256 /dev/hda # or whatever device you are using
> 
> Do you have any numbers on this (say, from Ingo's latency tracer)?  Have
> you confirmed it's not a latency regression with the default settings?

Sorry, I did the testing simply by playing mp3s while doing heavy I/O.
The 128KB window size do not need these cond_resched()s, yet the
1024KB window size do.  With this patch, I do not feel any latency
issues with CONFIG_PREEMPT_NONE. 

But I'm not sure it is the case for others, for there has been user
reports of audio jitters(without further informations, hence still an
open problem).

Anyway, numbers will be collected soon ...

Cheers,
Wu
