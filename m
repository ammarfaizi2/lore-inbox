Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbTDCQUK>; Thu, 3 Apr 2003 11:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbTDCQUK>; Thu, 3 Apr 2003 11:20:10 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:62578 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261341AbTDCQUG>; Thu, 3 Apr 2003 11:20:06 -0500
Date: Thu, 3 Apr 2003 17:33:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Dave McCracken <dmccr@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.66-mm2] Fix page_convert_anon locking issues
In-Reply-To: <8750000.1049385619@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0304031727420.2014-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, Dave McCracken wrote:
> 
> No, try_to_unmap will claim success when in fact there are still mappings.
> It'd be all right if it failed, but there's no way to tell it to fail.  The
> page will be freed by kswapd based on try_to_unmap's claim of success.

No: see the various checks on page_count(page) in vmscan.c:
though page_convert_anon temporarily leaves a page with neither
mapcount nor the right number of pte pointers, page_count is unaffected.

Hugh

