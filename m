Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWAKXD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWAKXD3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWAKXD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:03:29 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:473 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932510AbWAKXD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:03:28 -0500
Subject: Re: [PATCH 2/2] hugetlb: synchronize alloc with page cache insert
From: Adam Litke <agl@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20060111225202.GE9091@holomorphy.com>
References: <1136920951.23288.5.camel@localhost.localdomain>
	 <1137016960.9672.5.camel@localhost.localdomain>
	 <1137018263.9672.10.camel@localhost.localdomain>
	 <20060111225202.GE9091@holomorphy.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 11 Jan 2006 17:03:25 -0600
Message-Id: <1137020606.9672.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 14:52 -0800, William Lee Irwin III wrote:
> On Wed, Jan 11, 2006 at 04:24:23PM -0600, Adam Litke wrote:
> > My only concern is if I am using the correct lock for the job here.
> 
> ->i_lock looks rather fishy. It may have been necessary when ->i_blocks
> was used for nefarious purposes, but without ->i_blocks fiddling, it's
> not needed unless I somehow missed the addition of some custom fields
> to hugetlbfs inodes and their modifications by any of these functions.

Nope, all the i_blocks stuff is gone.  I was just looking for a
spin_lock for serializing all allocations for a particular hugeltbfs
file and i_lock seemed to fit that bill.  It could be said, however,
that the locking strategy used in the patch protects a section of code,
not a data structure (which can be a bad idea).  Any thoughts on a less
"fishy" locking strategy for this case?

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

