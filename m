Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUDNXhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUDNXhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 19:37:37 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:20160 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262059AbUDNXgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 19:36:10 -0400
Subject: Re: [PATCH 0/4] ext3 block reservation patch set
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tytso@mit.edu, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <20040414160714.30e34753.akpm@osdl.org>
References: <200403190846.56955.pbadari@us.ibm.com>
	<20040321015746.14b3c0dc.akpm@osdl.org>
	<1080636930.3548.4549.camel@localhost.localdomain>
	<20040330014523.6a368a69.akpm@osdl.org>
	<1080956712.15980.6505.camel@localhost.localdomain>
	<20040402175049.20b10864.akpm@osdl.org>
	<1080959870.3548.6555.camel@localhost.localdomain>
	<20040402185007.7d41e1a2.akpm@osdl.org>
	<1081903949.3548.6837.camel@localhost.localdomain>
	<20040413194734.3a08c80f.akpm@osdl.org>
	<1081963850.4714.6888.camel@localhost.localdomain> 
	<20040414160714.30e34753.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Apr 2004 16:42:45 -0700
Message-Id: <1081986169.3548.6980.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-14 at 16:07, Andrew Morton wrote:

> > The current implementation is more than O(n): every time it does not
> > have a reservation window, it search from the head of per filesystem
> > reservation window list head. If it failed within the group, it will
> > move to the next group and start the search from the head of the list
> > again.
> 
> Same problem exists in arch_get_unmapped_area().  We have a funny little
> heuristic (free_area_cache) in there to speed up the common case.
Actually, we only hit this more than O(n) case when the file is just
opened for write(without reservation window).  In the normal case, if we
have a old reservation window, we will start the from the old
reservation, instead of the head of whole filesystem list, to search for
next new reservable hole.

> 
> > This could be fixed by forget about the block group boundary at
> > all,(remove the for loop in ext3_new_block), make it searchs for a block
> > in a filesystem wide:)
> 
> I do think we should do this.  Does it have any disadvantages?
> 
I re-looked at the code today, my concern is, we may end of a big
changes to the existing code. Need to think it more....



