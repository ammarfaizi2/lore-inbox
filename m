Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbVJaVok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbVJaVok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVJaVok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:44:40 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:31685 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932530AbVJaVoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:44:39 -0500
Date: Mon, 31 Oct 2005 22:44:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, tytso@us.ibm.com, sripathi@in.ibm.com,
       dipankar@in.ibm.com, oleg@tv-sign.ru
Subject: Re: [RFC,PATCH] RCUify single-thread case of clock_gettime()
Message-ID: <20051031214449.GB17489@elte.hu>
References: <20051031174416.GA2762@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031174416.GA2762@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Hello!
> 
> The attached patch uses RCU to avoid the need to acquire tasklist_lock 
> in the single-thread case of clock_gettime().  Still acquires 
> tasklist_lock when asking for the time of a (potentially 
> multithreaded) process.
> 
> Experimental, has been touch-tested on x86 and POWER.  Requires RCU on 
> task_struct.  Further more focused testing in progress.
> 
> Thoughts?  (Why?  Some off-list users want to be able to monitor CPU 
> consumption of specific threads.  They need to do so quite frequently, 
> so acquiring tasklist_lock is inappropriate.)

looks good to me - i have added this to the -rt tree, it should show up 
in 2.6.14-rt3.

	Ingo
