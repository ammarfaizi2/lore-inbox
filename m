Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWEERNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWEERNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWEERNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:13:32 -0400
Received: from smtpout.mac.com ([17.250.248.185]:28875 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751178AbWEERNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:13:32 -0400
In-Reply-To: <8.420169009@selenic.com>
References: <8.420169009@selenic.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Date: Fri, 5 May 2006 13:13:23 -0400
To: Matt Mackall <mpm@selenic.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 5, 2006, at 12:42:35, Matt Mackall wrote:
> Remove SA_SAMPLE_RANDOM from network drivers
>
> /dev/random wants entropy sources to be both unpredictable and  
> unobservable. Network devices are neither as they may be directly  
> observed and controlled by an attacker. Thus SA_SAMPLE_RANDOM is  
> not appropriate.

I thought I saw an analysis somewhere of why it was actually OK to  
include randomness from network devices (or even basically any  
interrupt source that isn't periodic on a fundamental hardware  
level).  It had something to do with investigating interrupt arrival  
time from real-time network traffic; they hooked a logic analyzer of  
sorts up to the physical ethernet cable itself and to the system bus  
of the destination computer (and wrote software that recorded a TSC  
timestamp of every interrupt).  Essentially the interaction between  
the occasional ethernet retransmission, variable internal network  
card latencies and queues, variable CPU-dependent interrupt  
latencies, critical sections in the OS, etc, plus the high-resolution  
nature of the TSC used for a seed value made it a chaotic system and  
basically cryptographically impossible to predict the interrupt  
data.  It's possible that the analysis I saw was later proven  
incorrect; but I'd be interested if you've seen some paper or  
research on the topic that I haven't, I'd be interested in references.

Cheers,
Kyle Moffett


