Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVC2JLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVC2JLB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVC2JLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 04:11:01 -0500
Received: from mail.dif.dk ([193.138.115.101]:16549 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262229AbVC2JKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 04:10:47 -0500
Date: Tue, 29 Mar 2005 11:10:37 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Chris Friesen <cfriesen@nortel.com>
Cc: krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to measure time accurately.
In-Reply-To: <4248E282.1000105@nortel.com>
Message-ID: <Pine.LNX.4.62.0503291107000.3229@jjulnx.backbone.dif.dk>
References: <424779F3.5000306@globaledgesoft.com> <4248E282.1000105@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005, Chris Friesen wrote:

> Date: Mon, 28 Mar 2005 23:07:14 -0600
> From: Chris Friesen <cfriesen@nortel.com>
> To: krishna <krishna.c@globaledgesoft.com>
> Cc: Linux Kernel <linux-kernel@vger.kernel.org>
> Subject: Re: How to measure time accurately.
> 
> krishna wrote:
> > Hi All,
> > 
> > Can any one tell me how to measure time accurately for a block of C code in
> > device drivers.
> > For example, If I want to measure the time duration of firmware download.
> 
> Most cpus have some way of getting at a counter or decrementer of various
> frequencies.  Usually it requires low-level hardware knowledge and often it
> needs assembly code.
> 
> 
> On ppc you'd use the mftbu/mftbl instructions, as suggested by Lee on x86
> you'd use the rdtsc instruction.
> 

In some cases you can simply count jiffies - depending on how accurate you 
need to time things I'd say that often something like this is adequate :


unsigned long start, time_spent;

start = jiffies;
/* do stuff */
time_spent = jiffies - start;
printk("stuff took %d jiffies (%d seconds)\n", time_spent, time_spent/HZ);


-- 
Jesper Juhl

