Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267681AbRGZImu>; Thu, 26 Jul 2001 04:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267684AbRGZIml>; Thu, 26 Jul 2001 04:42:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47408 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S267681AbRGZIma>; Thu, 26 Jul 2001 04:42:30 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <Pine.LNX.4.33L.0107251340550.20326-100000@duckman.distro.conectiva>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Jul 2001 02:36:18 -0600
In-Reply-To: <Pine.LNX.4.33L.0107251340550.20326-100000@duckman.distro.conectiva>
Message-ID: <m1ae1sf5od.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rik van Riel <riel@conectiva.com.br> writes:

> On Wed, 25 Jul 2001, Daniel Phillips wrote:
> > On Wednesday 25 July 2001 08:33, Marcelo Tosatti wrote:
> > > Now I'm not sure why directly adding swapcache pages to the inactive
> > > dirty lits with 0 zero age improves things.
> >
> > Because it moves the page rapidly down the inactive queue towards the
> > ->writepage instead of leaving it floating around on the active ring
> > waiting to be noticed.  We already know we want to evict that page,
> 
> We don't.

Agreed.  The kinds of ``aging'' don't match up so we can't tell if
it meets our usual criteria for aging.
 
> The page gets unmapped and added to the swap cache the first
> time it wasn't referenced by the process.
> 
> This is before any page aging is done.

Actually there has been aging done.  Unless you completely disable
testing for pte_young.  It is a different kind of aging but it is
aging.

Eric
