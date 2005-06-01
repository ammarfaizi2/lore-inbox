Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVFAJeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVFAJeU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVFAJeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:34:13 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:54749 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S261339AbVFAJdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:33:16 -0400
Message-ID: <429D80AD.1000601@stud.feec.vutbr.cz>
Date: Wed, 01 Jun 2005 11:32:29 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
References: <20050523082637.GA15696@elte.hu> <4294E24E.8000003@stud.feec.vutbr.cz> <20050601091908.GA13041@elte.hu>
In-Reply-To: <20050601091908.GA13041@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
>>I'm attaching a patch which changes a semaphore in cpufreq into a 
>>completion. With this patch, my system runs OK even with cpufreqd.
> 
> 
> btw., could you please submit this upstream too, so that it doesnt get 
> lost? Semaphore->completion conversions are desirable upstream for cases 
> where the semaphore was in reality not used for mutual exclusion but for 
> completion purposes. (in which case real completions are both more 
> readable and slightly faster)

Yes, I'm going to contact upstream about this.
However, after closer look on cpufreq code I came to a conclusion that 
the lock there doesn't really play the role of a completion. There's 
always: down(), then do something with the data structure, then up() in 
the same function.
I'm going to fix it differently after consulting with upstream author (I 
now think that it should not be necessary to take the lock in 
cpufreq_add_dev at all).

Michal
