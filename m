Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030989AbWKOUjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030989AbWKOUjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030988AbWKOUjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:39:51 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:37882 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030654AbWKOUju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:39:50 -0500
Date: Wed, 15 Nov 2006 15:39:52 -0500
From: Chris Mason <chris.mason@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-mm <linux-mm@kvack.org>,
       ext4 <linux-ext4@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
       npiggin@suse.de
Subject: Re: pagefault in generic_file_buffered_write() causing deadlock
Message-ID: <20061115203929.GE2392@think.oraclecorp.com>
References: <1163606265.7662.8.camel@dyn9047017100.beaverton.ibm.com> <20061115090005.c9ec6db5.akpm@osdl.org> <455B5A7B.6010807@us.ibm.com> <20061115112957.e38539e9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115112957.e38539e9.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 11:29:57AM -0800, Andrew Morton wrote:
> Oh well.  If it's a deadlock (this is not clear from your description) then
> please gather backtraces of all affected tasks.
> 
> There is an ab/ba deadlock with journal_start() and lock_page(), iirc. 
> Chris and I had a look at that a while back and collapsed in exhaustion -
> it isn't pretty.  

This should be the page fault/journal lock inversion stuff Nick was
working on.  His patchset had a pretty good description of the problems,
Badari can also dig through the novell/ltc bugzillas for vmmstress.
Should be LTC9358.

Hopefully Nick's patches will address all of this.  sles9 had a partial
solution for the mmap deadlock, I think it was to dirty the inode at a
later time.  For some reason, I thought this workload was passing in
later kernels...

-chris
