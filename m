Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVCVXR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVCVXR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVCVXR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:17:29 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:14465 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262356AbVCVXQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:16:25 -0500
Message-ID: <4240A744.1000306@yahoo.com.au>
Date: Wed, 23 Mar 2005 10:16:20 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arun Srinivas <getarunsri@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: help needed pls. scheduler(kernel 2.6) + hyperthreaded related
 questions?
References: <BAY10-F42C3843D362DEB897FCABBD94E0@phx.gbl>
In-Reply-To: <BAY10-F42C3843D362DEB897FCABBD94E0@phx.gbl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arun Srinivas wrote:
> Pls. help me.  I went through the sched.c for kernel 2.6 and saw that it 
> supports
> hyperthreading.I would be glad if someone could answer this question....(if
> am not wrong a HT processor has 2 architectural states and one execution
> unit...i.e., two pipeline streams)
> 
> 1)when there are 2 processes a parent and child(created by fork()) do they
> get scheduled @ the same time...ie., when the parent process is put into 
> one
> pipeline, do the child also gets scheduled the same time?
> 

No.

> 2) what abt in the case of threads(I read tht as opposed to kernel2.4,where
> threads are treated as processes) ..kernel 2.6 treats threads as threads.
> So, when two paired threads get into execution are they always scheduled at
> the same time?
> 

No.

> Also, it would be helpful if someone could suggest which part of sched.c
> shud i look into to find out how threads are scheduled for a normal
> processor and for a hyperthreaded processor
> 

It is pretty tricky. Basically processes on different CPUs are
scheduled completely independently of one another. The only time
when they may get moved from one CPU to another is with
load_balance, load_balance_newidle, active_load_balance,
try_to_wake_up, sched_exec, wake_up_new_task.

