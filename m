Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317886AbSGPQeb>; Tue, 16 Jul 2002 12:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317885AbSGPQea>; Tue, 16 Jul 2002 12:34:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43417 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317884AbSGPQe3>;
	Tue, 16 Jul 2002 12:34:29 -0400
Date: Tue, 16 Jul 2002 18:36:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
Message-ID: <20020716163636.GW811@suse.de>
References: <3D33DED8.C5C92C06@zip.com.au> <Pine.LNX.4.44L.0207160948160.3009-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0207160948160.3009-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16 2002, Rik van Riel wrote:
> On Tue, 16 Jul 2002, Andrew Morton wrote:
> 
> > That's maybe wrong - if there are a decent number of pages
> > under writeback then we should be able to just wait it out.
> > But it gets tricky with the loop driver...
> 
> I wonder if it is possible to exhaust the mempool with
> the loop driver requests before getting around to the
> requests to the underlying block device(s)...

Given the finite size of the pool and the possibly infinite stacking
level, yes that is possible. You may just run out of loop minors before
this happens [1]. Also note that you need more than a simple remapping,
crypto setup for instance. 

[1] 256 minors, standard bio pool is 256.

-- 
Jens Axboe

