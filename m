Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWGRMQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWGRMQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 08:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWGRMQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 08:16:44 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:18605 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751331AbWGRMQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 08:16:44 -0400
Subject: Re: [PATCH] mm: inactive-clean list
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-mm <linux-mm@kvack.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0607172035140.28956@schroedinger.engr.sgi.com>
References: <1153167857.31891.78.camel@lappy>
	 <Pine.LNX.4.64.0607172035140.28956@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Tue, 18 Jul 2006 14:16:35 +0200
Message-Id: <1153224998.2041.15.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-17 at 20:37 -0700, Christoph Lameter wrote:
> On Mon, 17 Jul 2006, Peter Zijlstra wrote:
> 
> > This patch implements the inactive_clean list spoken of during the VM summit.
> > The LRU tail pages will be unmapped and ready to free, but not freeed.
> > This gives reclaim an extra chance.
> 
> I thought we wanted to just track the number of unmapped clean pages and 
> insure that they do not go under a certain limit? That would not require
> any locking changes but just a new zoned counter and a check in the dirty
> handling path.

The problem I see with that is that we cannot create new unmapped clean
pages. Where will we get new pages to satisfy our demand when there is
nothing mmap'ed.

This approach will generate them by forceing some pages into swap space.

