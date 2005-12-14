Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVLNCzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVLNCzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVLNCzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:55:16 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:41881 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932175AbVLNCzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:55:14 -0500
Date: Tue, 13 Dec 2005 18:55:03 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] atomic_long_t & include/asm-generic/atomic.h V2
In-Reply-To: <20051213154916.6667b6d8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0512131849550.24909@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0512131417390.24002@schroedinger.engr.sgi.com>
 <20051213154916.6667b6d8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005, Andrew Morton wrote:

> I dunno, this still looks kludgy.  It looks like we couldn't be assed
> implementing atomic_long_t in each architecture ;)

What do you mean by "assed"?

> How about requiring that all 64-bit archs implement atomic64_t and do:

It may be reasonable to have 64 bit arches that are not 
capable of 64 bit atomic ops. As far as I can remember sparc was initially
a 32 bit platform without 32 bit atomic ops.

> static inline void atomic_long_set(atomic_long_t *vl, long i)
> {
> 	/*
> 	 * Do the cast separately to avoid possible cast-as-lval errors
> 	 */
> 	atomic64_t *v = (atomic64_t *)vl;
> 	atomic64_set(v, i);
> }

The lval casts only become necessary if you truly define a separate 
type. Are the #define statements that bad?
