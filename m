Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWAZALj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWAZALj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWAZALj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:11:39 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:11136 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751260AbWAZALi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:11:38 -0500
Date: Wed, 25 Jan 2006 18:08:16 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
In-reply-to: <43D7C2F0.5020108@symas.com>
To: Howard Chu <hyc@symas.com>
Cc: Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <43D812F0.1070003@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <20060124225919.GC12566@suse.de>
 <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>
 <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>
 <43D7BA0F.5010907@nortel.com> <43D7C2F0.5020108@symas.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> The SUSv3 text seems pretty clear. It says "WHEN pthread_mutex_unlock() 
> is called, ... the scheduling policy SHALL decide ..." It doesn't say 
> MAY, and it doesn't say "some undefined time after the call." There is 
> nothing optional or implementation-defined here. The only thing that is 
> not explicitly stated is what happens when there are no waiting threads; 
> in that case obviously the running thread can continue running.

It says the scheduling policy will decide who gets the mutex. It does 
not say that such a decision must be made immediately. That seems rather 
implementation defined to me.

> 
> re: forcing the mutex to ping-pong between different threads - if that 
> is inefficient, then the thread scheduler needs to be tuned differently. 
> Threads and thread context switches are supposed to be cheap, otherwise 
> you might as well just program with fork() instead. (And of course, back 
> when Unix was first developed, *processes* were lightweight, compared to 
> other extant OSs.)

This is nothing to do with the thread scheduler being inefficient. It is 
inherently inefficient to context-switch repeatedly no matter how good 
the kernel is. It trashes the CPU pipeline, at the very least, can cause 
thrashing of the CPU caches, and can cause cache lines to be pushed back 
and forth across the bus on SMP machines which really kills performance.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
