Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWEQQsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWEQQsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 12:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWEQQsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 12:48:05 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:25300 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S1750711AbWEQQsD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 12:48:03 -0400
Date: Wed, 17 May 2006 09:47:59 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 35 of 53] ipath - some interrelated stability and
 cleanliness fixes
In-Reply-To: <fa.yXZlqXBzNi9Gq/4Q6Wc9H6bw+lU@ifi.uio.no>
Message-ID: <Pine.LNX.4.61.0605170944570.22323@osa.unixfolk.com>
References: <fa.2ho1QSA8Kf7L8EFqp3rLsB7NE9s@ifi.uio.no>
 <fa.yXZlqXBzNi9Gq/4Q6Wc9H6bw+lU@ifi.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006, Roland Dreier wrote:

| This looks like a pastiche of several patches.  Why can't it be split
| up into logical pieces?
| 
|  > Call dma_free_coherent without ipath_mutex held.
| 
| Why?  Doesn't freeing work with the mutex held?

Sure, that's the way the previous code worked.

We are seeing a bug (with both our driver native MPI processes and mthca mvapic),
where when 8 processes using "simultaneously exit", we get watchdogs and/or hangs
in the close routines.   Moving the freeing outside the mutex was an attempt
to see if we were running into some VM issues by doing lots of page unlocking
and freeing with the mutex held.   It seemed to help somewhat, but not to solve
the problem.

It also allows other processes to open and close in a somewhat more timely
fashion.

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
