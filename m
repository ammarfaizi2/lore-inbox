Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUGZX6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUGZX6A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 19:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUGZX6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 19:58:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:10225 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266186AbUGZX55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 19:57:57 -0400
Subject: Re: [PATCH] fix readahead breakage for sequential after random
	reads
From: Ram Pai <linuxram@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20040726162950.7f4a3cf4.akpm@osdl.org>
References: <E1BmKAd-0001hz-00@dorka.pomaz.szeredi.hu>
	 <20040726162950.7f4a3cf4.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1090886218.8416.3.camel@dyn319181.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Jul 2004 16:56:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
	Yes the patch fixes a valid bug.

	
RP

On Mon, 2004-07-26 at 16:29, Andrew Morton wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > Current readahead logic is broken when a random read pattern is
> >  followed by a long sequential read.  The cause is that on a window
> >  miss ra->next_size is set to ra->average, but ra->average is only
> >  updated at the end of a sequence, so window size will remain 1 until
> >  the end of the sequential read.
> > 
> >  This patch fixes this by taking the current sequence length into
> >  account (code taken from towards end of page_cache_readahead()), and
> >  also setting ra->average to a decent value in handle_ra_miss() when
> >  sequential access is detected.
> 
> Thanks.   Do you have any performance testing results from this patch?
> 

