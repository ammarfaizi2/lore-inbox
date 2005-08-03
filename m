Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVHCQca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVHCQca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 12:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVHCQc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 12:32:29 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:387 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262325AbVHCQcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 12:32:22 -0400
Subject: Re: [PATCH] optimize writer path in time_interpolator_get_counter()
From: Alex Williamson <alex.williamson@hp.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.62.0508030907370.24104@schroedinger.engr.sgi.com>
References: <1122911571.5243.23.camel@tdi>
	 <200508021837.j72Ib7T9020681@agluck-lia64.sc.intel.com>
	 <1123080155.5193.15.camel@tdi>
	 <Pine.LNX.4.62.0508030907370.24104@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: LOSL
Date: Wed, 03 Aug 2005 10:32:13 -0600
Message-Id: <1123086733.5193.69.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 09:10 -0700, Christoph Lameter wrote:
> On Wed, 3 Aug 2005, Alex Williamson wrote:
> 
> > be a reasonable performance vs absolute accuracy trade-off.  What
> > happens to your worst case time if you (just for a test) hard code a
> > min_delta of something around 20-50?  There could be some kind of
> 
> Think about a threaded process that gets time on multiple processors 
> and then compares the times. This means that the time value obtained later 
> on one thread may indicate a time earlier than that obtained on another 
> thread. An essential requirement for time values is that they are 
> monotonically increasing. You are changing that basic nature.

   Ok, I can see the scenario where that could produce jitter.  However,
that implies than any exit through that path could produce jitter as it
is.  For instance:

CPU0				CPU1
read lcycle
read itc
				read lcycle
				read itc
cmpxchg
				oops, lcycle is stale

So the window already exists for this...

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

