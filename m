Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWH3DKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWH3DKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 23:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWH3DKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 23:10:47 -0400
Received: from imladris.surriel.com ([66.92.77.98]:21182 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S1751394AbWH3DKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 23:10:46 -0400
Message-ID: <44F501B3.9070200@surriel.com>
Date: Tue, 29 Aug 2006 23:10:43 -0400
From: Rik van Riel <riel@surriel.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Rick Brown <rick.brown.3@gmail.com>
CC: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Spinlock query
References: <7783925d0608291912i3f04d460kc9edebf9d358dbc3@mail.gmail.com>
In-Reply-To: <7783925d0608291912i3f04d460kc9edebf9d358dbc3@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Brown wrote:
> Hi,
> 
> In my driver (Process context), I have written the following code:
> 
> --------------------------------------------
> spin_lock(lock)
> ...
> //Critical section to manipulate driver data

... interrupt hits here
     interrupt handler tries to grab the spinlock, which is already taken
     *BOOM*

> spin_u lock(lock)
> ---------------------------------------------
> 
> I have written similar code in my interrupt handler (Interrupt
> context). The driver data is not accessed from anywhere else. Is my
> code safe from any potential concurrency issues? Is there a need to
> use spin_lock_irqsave()? In both the places?

You need to use spin_lock_irqsave() from process context.
 From the interrupt handler itself it doesn't hurt, but it
shouldn't matter much since interrupt handlers should not
get preempted.

-- 
What is important?  What you want to be true, or what is true?
