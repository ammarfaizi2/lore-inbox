Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbTE2QRb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTE2QRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:17:31 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:46714 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S262320AbTE2QRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:17:30 -0400
Date: Thu, 29 May 2003 17:33:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: phillips@arcor.de, <akpm@digeo.com>, <hch@infradead.org>,
       <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Avoid vmtruncate/mmap-page-fault race
In-Reply-To: <20030529151424.GA1397@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0305291723310.1800-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003, Paul E. McKenney wrote:
> On Fri, May 23, 2003 at 11:42:02AM -0700, Paul E. McKenney wrote:
> > 
> > Exactly -- allows a ->nopage() to drop some lock to avoid races
> > between pagefault and either vmtruncate() or invalidate_mmap_range().
> > This race (from the cross-host mmap viewpoint) is described in:
> > 
> >     http://marc.theaimsgroup.com/?l=linux-kernel&m=105286345316249&w=2
> 
> Rediffed for 2.5.70-mm1.

Me?  I much preferred your original, much sparer, nopagedone patch
(labelled "uglyh as hell" by hch).  I dislike passing lots of args
down a level so they can be passed up again to the library function.

In particular, I feel queasy (fear loss of control) about passing a
pmd_t* down to a filesystem, which I'd prefer to have no access to
such.  But I may be in a minority, and the decision won't be mine.

Hugh

