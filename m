Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSIHUnh>; Sun, 8 Sep 2002 16:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSIHUnh>; Sun, 8 Sep 2002 16:43:37 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:44398 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S315200AbSIHUng>; Sun, 8 Sep 2002 16:43:36 -0400
Date: Sun, 8 Sep 2002 21:48:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: LMbench2.0 results
In-Reply-To: <3D7B9988.6B8CD04F@digeo.com>
Message-ID: <Pine.LNX.4.44.0209082139190.1950-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2002, Andrew Morton wrote:
> 
> We need to find some way of making vm_enough_memory not call get_page_state
> so often.  One way of doing that might be to make get_page_state dump
> its latest result into a global copy, and make vm_enough_memory()
> only get_page_state once per N invokations.  A speed/accuracy tradeoff there.

Accuracy is not very important in that sysctl_overcommit_memory 0 case
e.g. the swapper_space.nr_pages addition was brought in at a time when
it was very necessary, but usually overestimates now (or last time I
thought about it).  The main thing to look out for is running the same
memory grabber twice in quick succession: not nice if it succeeds the
first time, but not the second, just because of some transient effect
that its old pages are temporarily uncounted.

Hugh

