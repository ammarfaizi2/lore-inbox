Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWAZBEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWAZBEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 20:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWAZBEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 20:04:16 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41107 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932240AbWAZBEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 20:04:16 -0500
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP
	slow)
From: Lee Revell <rlrevell@joe-job.com>
To: Howard Chu <hyc@symas.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43D81C8D.5000106@symas.com>
References: <20060124225919.GC12566@suse.de>
	 <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>
	 <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>
	 <43D7BA0F.5010907@nortel.com> <43D7C2F0.5020108@symas.com>
	 <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com>
	 <43D814E1.7030600@shaw.ca>  <43D81C8D.5000106@symas.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 20:04:15 -0500
Message-Id: <1138237456.3087.93.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 16:49 -0800, Howard Chu wrote:
> Basic "fairness" isn't the issue. Fairness is concerned with which of 
> *multiple waiting threads* gets the mutex, and that is certainly 
> irrelevant here. The issue is that the releasing thread should not be
> a candidate.
> 

You seem to be making 2 controversial assertions:

1. pthread_mutex_unlock must cause an immediate reschedule if other
threads are blocked on the mutex, and 
2. if the unlocking thread immediately tries to relock the mutex,
another thread must get it first

I disagree with #1, which makes #2 irrelevant.  It would lead to
obviously incorrect behavior, pthread_mutex_unlock would no longer be an
RT safe operation for example.

Also consider a SCHED_FIFO policy - static priorities and the scheduler
always runs the highest priority runnable thread - under your
interpretation of POSIX a high priority thread unlocking a mutex would
require the scheduler to run a lower priority thread which violates
SCHED_FIFO semantics.

Lee



