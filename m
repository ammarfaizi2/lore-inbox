Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbVFVIvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbVFVIvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbVFVIs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:48:29 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:52616 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S262933AbVFVIpC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:45:02 -0400
Message-ID: <42B92791.9060800@ru.mvista.com>
Date: Wed, 22 Jun 2005 12:55:45 +0400
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Lewis <andrew-lewis@netspace.net.au>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Dwalker@Mvista. Com" <dwalker@mvista.com>
Subject: Re: ARM Linux Suitability for Real-time Application
References: <42B8F6FB.2090203@netspace.net.au>
In-Reply-To: <42B8F6FB.2090203@netspace.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lewis wrote:
> I have recently been using Linux on the AT91RM9200 as a data 
> concentrator for a small (as yet unreleased) communications application.
> 
[snip]
> In order to run the radio successfully I need to be able to handle 
> interrupts within around 50us, and have interrupts run constantly for 
> between 20us and 200us (mostly at the low end).  I would expect there to 
> be three or four of these interrupts every 1000us, probably using about 
> 25% of the CPU power just to manage the radio deck.
> 
> This would makeup the real-time control element of the application.  If 
> I was writing this on bare metal, I would lock the high level interrupts 
> out to perform communications between the mainline and the interrupt 
> control paths for no more than 10us.
> 
[snip]

> The question is, would I be able to meet these time contraints if I 
> wrote a device driver running under Linux?  Especially important is 
> keeping the latency of handling the interrupts below 50us, and not 
> breaking anything by running 200us long interrupts.
> 
> I just wanted a general indication that such a driver is possible or 
> impossible before embarking on a more detailed investigation.
The rough answer is that it's impossible with vanilla kernel and 
possible   (as a rough approximation) with Ingo Molnar's real-time patch 
  http://redhat.com/~mingo/realtime-preempt/ which includes arm 
real-time port and hardirq-disable removal feature by Daniel Walker.

All linux real-time related discussions are going on LKML so first of 
all you might want to use LKML instead arm linux list for all real-time 
questions (thus I changed list in the header of the message).

As to concrete numbers you are interested in please take a look at 
"PREEMPT_RT vs I-PIPE: the numbers, part 2" thread on LKML which I 
believe presents most recent numbers.

The bottom line is that interrupt and preemption latencies for a kernel 
with RT patch are inbetween 15-150us. But of course even with real-time 
patch you have to perform _real_ fine tuning of your system to achieve 
such hard constraints you identified.

	Eugeny
> Best Regards,
> Andrew Lewis
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
> 
> 
> 


