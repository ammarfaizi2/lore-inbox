Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751856AbWCILrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbWCILrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWCILrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:47:00 -0500
Received: from ns2.suse.de ([195.135.220.15]:59022 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751856AbWCILq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:46:59 -0500
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Ocfs2-devel] Ocfs2 performance bugs of doom
Date: Thu, 9 Mar 2006 05:19:36 +0100
User-Agent: KMail/1.9.1
Cc: Daniel Phillips <phillips@google.com>,
       Mark Fasheh <mark.fasheh@oracle.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <4408C2E8.4010600@google.com> <440FCA81.7090608@google.com> <440FDC8E.9060907@yahoo.com.au>
In-Reply-To: <440FDC8E.9060907@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603090519.37801.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 March 2006 08:43, Nick Piggin wrote:
 
> Just interested: do the locks have any sort of locality of lookup?
> If so, then have you tried moving hot (ie. the one you've just found,
> or newly inserted) hash entries to the head of the hash list?
> 
> In applications with really good locality you can sometimes get away
> with small hash tables (10s even 100s of collisions on average) without
> taking too big a hit this way, because your entries basically get sorted
> LRU for you.

LRU hashes have really bad cache behaviour though if that is not the case
because you possibily need to bounce around the hash heads as DIRTY 
cache lines instead of keeping them in SHARED state.
My feeling would be that scalability is more important for this, which would
discourage this.

-Andi
