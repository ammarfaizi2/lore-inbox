Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264095AbUECWJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUECWJI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 18:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264096AbUECWJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 18:09:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:65000 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264095AbUECWJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 18:09:02 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Zaitsev <peter@mysql.com>, nickpiggin@yahoo.com.au,
       alexeyk@mysql.com, linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20040503145922.5a7dee73.akpm@osdl.org>
References: <200405022357.59415.alexeyk@mysql.com>
	 <409629A5.8070201@yahoo.com.au> <20040503110854.5abcdc7e.akpm@osdl.org>
	 <1083615727.7949.40.camel@localhost.localdomain>
	 <20040503135719.423ded06.akpm@osdl.org>
	 <1083620245.23042.107.camel@abyss.local>
	 <20040503145922.5a7dee73.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1083622065.7949.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2004 15:07:45 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 14:59, Andrew Morton wrote:
 
> 
> > But how could read-ahead disabled end up in 16K request converted to
> > several sequential synchronous 4K requests ? 
> 
> Readahead got itself turned off because of pagecache hits and didn't turn
> itself on again.

Andrew,
	In the slow read path, every contiguous access increases 
	ra->size by 1 and  non-contiguous access decreases the
	ra->size by 1. Now in the case of 16k random request,
        we have 1 non-contiguous request and 3 contiguous request.
	As a result the ra->size should have been incremented by
	-1+1+1+1=2 . So at the end of 16 4K request we should have had
        ra->size at 32. At this point onwards the readahead should get
	turned on. Right?

	I strongly feel the readahead got closed because of misses and
	not because of hits. Moreover if we are closing readahead window
	 because of hits, then that implies we have pretty good caching
	 going on.Which implies i/o should rarely hit the disk and hence
	 performance should not degrade.

Agree?
RP
	
> 
> 

