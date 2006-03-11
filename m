Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752359AbWCKIPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbWCKIPq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 03:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbWCKIPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 03:15:46 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:37029 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751665AbWCKIPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 03:15:46 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
Date: Sat, 11 Mar 2006 19:15:32 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
References: <200603102054.20077.kernel@kolivas.org> <200603111824.06274.kernel@kolivas.org> <1142063500.7605.13.camel@homer>
In-Reply-To: <1142063500.7605.13.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603111915.32748.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 March 2006 18:51, Mike Galbraith wrote:
> On Sat, 2006-03-11 at 18:24 +1100, Con Kolivas wrote:
> > On Saturday 11 March 2006 17:00, Mike Galbraith wrote:
> > > If you're creating a lot of traffic, I can see it causing problems.  I
> > > was under the impression that you were doing minimal IO and absolutely
> > > trivial CPU.  That's what didn't make sense to me to be clear.
> >
> > A lot of cpu would be easier to handle; it's using absolutely miniscule
> > amounts of cpu. The IO is massive though (and seeky in nature), and
> > reading from a swap partition seems particularly expensive in this
> > regard.
>
> There used to be a pages in flight 'restrictor plate' in there that
> would have probably helped this situation at least a little.  But in any
> case, it sounds like you'll have to find a way to submit the IO in itty
> bitty synchronous pieces.

Well the original code used to have an heuristic to decide how much to 
prefetch at a time. It was considered opaque so I removed it. It made the 
amount to prefetch proportional to amount of ram which is wrong of course 
because it should depend more on swap partition read speed vs bus bandwidth 
or something. 

This way of deciding based on cpu load works anyway but yet again seems 
unpopular.

Cheers,
Con
