Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVJaTNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVJaTNE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVJaTNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:13:04 -0500
Received: from main.gmane.org ([80.91.229.2]:8904 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964790AbVJaTNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:13:02 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: any fairness in NTPL pthread mutexes?
Date: Mon, 31 Oct 2005 14:09:03 -0500
Message-ID: <dk5q3m$tmq$1@sea.gmane.org>
References: <43665B08.6040005@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <43665B08.6040005@nortel.com>
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

SCHED_OTHER.

If there are any waiting tasks when the mutex is unlocked, one of the waiting
tasks is woken up but not given lock ownership.  It has to acquire the mutex
on its own.  If it fails because another thread got the mutex first, then it
goes back to waiting.   It's sometimes called an adaptive mutex.  It's a little
faster than a FIFO mutex.  It recovers from intermittent contention better.
With heavier contention, some threads in theory could starve, something that
wouldn't happen with a FIFO mutex.

--
Joe Seigh

