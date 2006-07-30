Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWG3OkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWG3OkP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 10:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWG3OkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 10:40:15 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:18955 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932320AbWG3OkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 10:40:13 -0400
Message-ID: <44CCC4CA.6000208@argo.co.il>
Date: Sun, 30 Jul 2006 17:40:10 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FP in kernelspace
References: <44CC97A4.8050207@gmail.com>
In-Reply-To: <44CC97A4.8050207@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jul 2006 14:40:11.0609 (UTC) FILETIME=[0FD4C490:01C6B3E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
>
> Hello,
>
> I have a driver written for 2.4 + RT patches with FP support. I want 
> it to work
> in 2.6. How to implement FP? Has anybody developped some "protocol" 
> between KS
> and US yet? If not, could somebody point me, how to do it the best -- 
> with low
> latency.
> The device doesn't generate irqs *), I need to quickly respond to 
> timer call,
> because interval between two posts of data to the device has to be 
> equal as much
> as possible (BTW is there any way how to gain up to 5000Hz).
> I've one idea: have a thread with RT priority and wake the app in US 
> waiting in
> read of character device when timer ticks, post a struct with 2 floats 
> and
> operation and wait in write for the result. App computes, writes the 
> result, we
> are woken and can post it to the device. But I'm afraid it would be 
> tooo slow.
>
> *) I don't know how to persuade it (standard PLX chip with unknown 
> piece of
> logic behind) to generate, because official driver is closed and _very_
> expensive. Old (2.4) driver was implemented with RT thread and timer, 
> where FP
> is implemented within RT and computed directly in KS.
>
> So 2 questions are:
> 1) howto FP in kernel
>
kernel_fpu_begin();
c = d * 3.14;
kernel_fpu_end();

-- 
error compiling committee.c: too many arguments to function

