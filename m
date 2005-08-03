Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVHCQLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVHCQLL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 12:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVHCQLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 12:11:11 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5826 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262320AbVHCQLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 12:11:10 -0400
Date: Wed, 3 Aug 2005 09:10:55 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Alex Williamson <alex.williamson@hp.com>
cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] optimize writer path in time_interpolator_get_counter()
In-Reply-To: <1123080155.5193.15.camel@tdi>
Message-ID: <Pine.LNX.4.62.0508030907370.24104@schroedinger.engr.sgi.com>
References: <1122911571.5243.23.camel@tdi>  <200508021837.j72Ib7T9020681@agluck-lia64.sc.intel.com>
 <1123080155.5193.15.camel@tdi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2005, Alex Williamson wrote:

> be a reasonable performance vs absolute accuracy trade-off.  What
> happens to your worst case time if you (just for a test) hard code a
> min_delta of something around 20-50?  There could be some kind of

Think about a threaded process that gets time on multiple processors 
and then compares the times. This means that the time value obtained later 
on one thread may indicate a time earlier than that obtained on another 
thread. An essential requirement for time values is that they are 
monotonically increasing. You are changing that basic nature.

> boot/run time tunable to set this min_delta if there's no good way to
> calculate it.  It should be trivial to add something like this to the
> fsys path as well and shouldn't disrupt the nojitter path at all.

I assure you it is not going to be trivial. IA64 asm instructions bundling 
and cycle optimization will have to be changed.
