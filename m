Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbULVPbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbULVPbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 10:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbULVPba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 10:31:30 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:33467 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261988AbULVPb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 10:31:28 -0500
Subject: Re: Negative "ios_in_flight" in the 2.4 kernel
From: "M. Edward Borasky" <znmeb@cesmail.net>
Reply-To: znmeb@cesmail.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041222111642.GD12463@suse.de>
References: <1103691937.23157.14.camel@DreamGate>
	 <20041222111642.GD12463@suse.de>
Content-Type: text/plain
Date: Wed, 22 Dec 2004 07:19:42 -0800
Message-Id: <1103728782.26340.34.camel@DreamGate>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-22 at 12:16 +0100, Jens Axboe wrote:
>  
> > Question: wouldn't a simple refusal to decrement ios_in_flight in
> > "down_ios" if it's zero fix this, or am I missing something?
> 
> That would paper over the real bug, but it will work for you.
What is the "real bug", then? What will "work for me" is accurate disk
usage tick counts. The intent of these statistics is something known as
Operational Analysis of Queueing Networks. 

The "requirement" is that the operations on each device be accurately
counted, and the "wall clock" time spent *waiting* for requests and the
time spent *servicing* requests be accurately accumulated for each
device. The sector count is a bonus. 

>From these raw counters, one can, and iostat does, compute throughput,
utilization, average service time, average wait time and average queue
length. An excellent and highly readable reference for the math involved
can be found at

http://www.cs.washington.edu/homes/lazowska/qsp/Images/Chap_03.pdf

That is the intent behind these counters, and what will "work for me" is
a kernel that captures the raw counters correctly. If forcing
ios_in_flight to be non-negative is done at the expense of losing or
gaining ticks in the wait or service time accumulators, then it will not
work for me.

Ed Borasky
http://www.borasky-research.net


