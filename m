Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWCFHtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWCFHtM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbWCFHtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:49:12 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:63001 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751165AbWCFHtK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:49:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lwQhg4ILAejhgA6767WojsI3/PN307urRHS3XVyHnMg7sswQRea9gnS1+8j+r4AIRqCQvPc2YBxGq0ut2oXTAlR030aFWoin2hYBXj4MQcWPnMuXmtLZailgnaFCr4KZ1MRb0cndqc2wRe95X+U9GTsjsyaiuvu5mgfK1G6WgXQ=
Message-ID: <84144f020603052349p4e95381ar92c3f80027557c12@mail.gmail.com>
Date: Mon, 6 Mar 2006 09:49:09 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Christoph Lameter" <clameter@engr.sgi.com>
Subject: Re: cache_reap(): Further reduction in interrupt holdoff
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, kiran@scalex86.org,
       alokk@calsoftinc.com
In-Reply-To: <Pine.LNX.4.64.0603031530380.15581@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0603031530380.15581@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(Christoph, please use penberg@cs.helsinki.fi instead.)

On 3/4/06, Christoph Lameter <clameter@engr.sgi.com> wrote:
> cache_reap takes the l3->list_lock (disabling interrupts) unconditionally and
> then does a few checks and maybe does some cleanup. This patch makes
> cache_reap() only take the lock if there is work to do and then the lock
> is taken and released for each cleaning action.
>
> The checking of when to do the next reaping is done without any locking
> and becomes racy. Should not matter since reaping can also be skipped
> if the slab mutex cannot be acquired.

The cache chain mutex is mostly used by /proc/slabinfo and not taken
that often, I think. But yeah, I don't think next reaping is an issue
either.

On 3/4/06, Christoph Lameter <clameter@engr.sgi.com> wrote:
> The same is true for the touched processing. If we get this wrong once
> in awhile then we will mistakenly clean or not clean the shared cache.
> This will impact performance slightly.

Touched processing worries me little because it's used when there's
high allocation pressure. Do you have any numbers where this patch
helps?

                                         Pekka
