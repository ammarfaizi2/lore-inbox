Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272060AbTHRPUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272063AbTHRPUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:20:55 -0400
Received: from waste.org ([209.173.204.2]:52940 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272060AbTHRPUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:20:53 -0400
Date: Mon, 18 Aug 2003 10:20:34 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, tytso@mit.edu, jmorris@intercode.com.au,
       jamie@shareable.org, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030818152034.GA16387@waste.org>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030815221211.GA4306@think> <20030815235501.GB325@waste.org> <20030815170532.06e14e89.akpm@osdl.org> <20030816043816.GC325@waste.org> <20030818004313.T3708@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818004313.T3708@schatzie.adilger.int>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 12:43:13AM -0600, Andreas Dilger wrote:
> On Aug 15, 2003  23:38 -0500, Matt Mackall wrote:
> > a) extract_entropy (pool->lock)
> > 
> >  For nitpickers, there remains a vanishingly small possibility that
> >  two readers could get identical results from the pool by hitting a
> >  window immediately after reseeding, after accounting, _and_ after
> >  feedback mixing.
> 
> It wasn't even vanishingly small...  We had a problem in our code where
> two readers got the same 64-bit value calling get_random_bytes(), and
> we were depending on this 64-bit value being unique.  This problem was
> fixed by putting a spinlock around the call to get_random_bytes().

Was this before or after the locking was added in test2-mm3 or so?

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
