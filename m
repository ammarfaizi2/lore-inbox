Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVFBS2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVFBS2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 14:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVFBS2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 14:28:33 -0400
Received: from one.firstfloor.org ([213.235.205.2]:3991 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261208AbVFBS2a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 14:28:30 -0400
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: jschopp@austin.ibm.com, Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
References: <20050531112048.D2511E57A@skynet.csn.ul.ie>
	<429E20B6.2000907@austin.ibm.com> <429E4023.2010308@yahoo.com.au>
	<423970000.1117668514@flay> <429E483D.8010106@yahoo.com.au>
	<434510000.1117670555@flay>
From: Andi Kleen <ak@muc.de>
Date: Thu, 02 Jun 2005 20:28:26 +0200
In-Reply-To: <434510000.1117670555@flay> (Martin J. Bligh's message of "Wed,
 01 Jun 2005 17:02:35 -0700")
Message-ID: <m14qcgwr3p.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> writes:

> It gets very messy when CIFS requires a large buffer to write back
> to disk in order to free memory ...

How about just fixing CIFS to submit memory page by page? The network
stack below it supports that just fine and the VFS above it does anyways, 
so it doesnt make much sense that CIFS sitting below them uses
larger buffers.

> There's one example ... we can probably work around it if we try hard
> enough. However, the fundamental question becomes "do we support higher
> order allocs, or not?". If not fine ... but we ought to quit pretending
> we do. If so, then we need to make them more reliable.

My understanding was that the deal was that order 1 is supposed
to work but somewhat slower, and bigger orders are supposed to work
at boot up time.

-Andi
