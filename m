Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbVKADww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVKADww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVKADww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:52:52 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:17734 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932561AbVKADwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:52:51 -0500
Date: Mon, 31 Oct 2005 21:52:47 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: any fairness in NTPL pthread mutexes?
In-reply-to: <53M7O-7Se-33@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4366E68F.3040109@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <53M7O-7Se-33@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen wrote:
> 
> I'm using NPTL.
> 
> If I have a pthread mutex currently owned by a task, and two other tasks 
> try to lock it, when the mutex is unlocked, are there any rules about 
> the order in which the waiting tasks get the mutex (ie priority, FIFO, 
> etc.)?
> 

Not in the pthread spec (at least not for normal SCHED_OTHER tasks), and 
Linux/glibc don't really provide any either. In particular, if one 
thread unlocks a mutex and immediately tries to relock, there is no 
guarantee that any other thread waiting on the mutex will be able to get 
in and lock it before the first thread can relock.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

