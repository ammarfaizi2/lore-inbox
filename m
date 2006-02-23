Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWBWShB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWBWShB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWBWSg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:36:57 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:1478 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751143AbWBWSg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:36:56 -0500
Subject: Re: slab: Remove SLAB_NO_REAP option
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Alok Kataria <alok.kataria@calsoftinc.com>,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602230917540.1796@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.63.0602231502380.7798@localhost.localdomain>
	 <20060223020957.478d4cc1.akpm@osdl.org>
	 <Pine.LNX.4.58.0602231331530.15716@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.64.0602230917540.1796@schroedinger.engr.sgi.com>
Date: Thu, 23 Feb 2006 20:36:52 +0200
Message-Id: <1140719812.11455.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 09:20 -0800, Christoph Lameter wrote:
> On Thu, 23 Feb 2006, Pekka J Enberg wrote:
> 
> > We need _something_ to avoid excessive scanning of cache_cache. It takes a 
> > hell of a lot insmod/rmmod to actually free a full page. Maybe something 
> > like this (totally untested) patch?
> 
> What excessive scanning of cache_cache? If the per cpu cache of 
> cache_cache has been drained then there will be no scanning just an 
> inspection if there are zero elements.

Look at the loop, it is redundant work (like acquiring/releasing a
spinlock). The cache_cache is practically static, which is why it makes
sense to leave it alone.

				Pekka

