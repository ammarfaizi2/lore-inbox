Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUDNX33 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUDNX06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 19:26:58 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:17545 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262062AbUDNXYv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 19:24:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/4] ext3 block reservation patch set
Date: Wed, 14 Apr 2004 16:12:22 -0700
User-Agent: KMail/1.4.1
Cc: cmm@us.ibm.com, tytso@mit.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
References: <200403190846.56955.pbadari@us.ibm.com> <200404140911.57772.pbadari@us.ibm.com> <20040414160222.4a227073.akpm@osdl.org>
In-Reply-To: <20040414160222.4a227073.akpm@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200404141612.22605.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 April 2004 04:02 pm, Andrew Morton wrote:


> > In our TODO list. But our original thought was, we have to search only
> > the current block group reservations to get a window. So, if we have lots
> > & lots of reservations in a single block group - search gets complicated.
> > We were thinking of adding (dummy) anchors in the list to represent
> > begining of each block group, so that we can get to the start of a block
> > group quickly. But so far, we haven't done anything.
>
> hm, I need to look at the new code more closely.  I was hoping that we
> could divorce the reservation windows from any knowledge of blockgroups.
> Is that not the case?

The reservation window code kind of knows the group boundaries. The
reason why we did this was, we want to fit it into existing 
ext3_get_newblock() code easily. ext3_get_newblock() operates on each
group and passes a bitmap for each group to work on. The current code
looks for a reservation window in the given group (since we need bitmap to
verify that there is something allocatable in that group).  
To make the reservation window ignore groups, we may need to do some major 
surgery to ext3_get_newblock().

	
> > We are also looking at RB tree and see how we can make use of it. Our
> > problem is,  we are interested in finding out a big enough hole in the
> > tree to put our reservation. We need to look closely.

> This sounds awfully like get_unmapped_area().

That was the first place I looked, i need to look at it one more time to see
if we can reuse the logic.

Thanks,
Badari
