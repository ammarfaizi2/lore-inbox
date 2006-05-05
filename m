Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbWEER3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWEER3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWEER3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:29:04 -0400
Received: from waste.org ([64.81.244.121]:55274 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751649AbWEER3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:29:02 -0400
Date: Fri, 5 May 2006 12:24:26 -0500
From: Matt Mackall <mpm@selenic.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060505172424.GV15445@waste.org>
References: <8.420169009@selenic.com> <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 01:13:23PM -0400, Kyle Moffett wrote:
> On May 5, 2006, at 12:42:35, Matt Mackall wrote:
> >Remove SA_SAMPLE_RANDOM from network drivers
> >
> >/dev/random wants entropy sources to be both unpredictable and  
> >unobservable. Network devices are neither as they may be directly  
> >observed and controlled by an attacker. Thus SA_SAMPLE_RANDOM is  
> >not appropriate.
> 
> I thought I saw an analysis somewhere of why it was actually OK to  
> include randomness from network devices (or even basically any  
> interrupt source that isn't periodic on a fundamental hardware  
> level).  It had something to do with investigating interrupt arrival  
> time from real-time network traffic; they hooked a logic analyzer of  
> sorts up to the physical ethernet cable itself and to the system bus  
> of the destination computer (and wrote software that recorded a TSC  
> timestamp of every interrupt).  Essentially the interaction between  
> the occasional ethernet retransmission, variable internal network  
> card latencies and queues, variable CPU-dependent interrupt  
> latencies, critical sections in the OS, etc, plus the high-resolution  
> nature of the TSC used for a seed value made it a chaotic system and  
> basically cryptographically impossible to predict the interrupt  
> data.  It's possible that the analysis I saw was later proven  
> incorrect; but I'd be interested if you've seen some paper or  
> research on the topic that I haven't, I'd be interested in references.

I haven't seen such an analysis, scholarly or otherwise and my bias
here is to lean towards the paranoid.

Assuming a machine with no TSC and an otherwise quiescent ethernet
(hackers burning the midnight oil), I think most of the
hard-to-analyze bits above get pretty transparent.

-- 
Mathematics is the supreme nostalgia of our time.
