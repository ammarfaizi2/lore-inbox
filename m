Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264040AbUECVwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbUECVwP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbUECVwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:52:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:17595 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264040AbUECVwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:52:12 -0400
Subject: Re: Random file I/O regressions in 2.6
From: Ram Pai <linuxram@us.ibm.com>
To: Peter Zaitsev <peter@mysql.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, alexeyk@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <1083620245.23042.107.camel@abyss.local>
References: <200405022357.59415.alexeyk@mysql.com>
	 <409629A5.8070201@yahoo.com.au> <20040503110854.5abcdc7e.akpm@osdl.org>
	 <1083615727.7949.40.camel@localhost.localdomain>
	 <20040503135719.423ded06.akpm@osdl.org>
	 <1083620245.23042.107.camel@abyss.local>
Content-Type: text/plain
Organization: 
Message-Id: <1083621052.7949.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2004 14:50:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 14:37, Peter Zaitsev wrote:
> On Mon, 2004-05-03 at 13:57, Andrew Morton wrote:
> > Ram Pai <linuxram@us.ibm.com> wrote:
> > >
> > > > The place which needs attention is handle_ra_miss().  But first I'd like to
> > > > reacquaint myself with the intent behind the lazy-readahead patch.  Was
> > > > never happy with the complexity and special-cases which that introduced.
> > > 
> > > lazy-readahead has no role to play here.
> > 
> 
> Andrew,
> 
> Could you please clarify how this things become to be dependent on
> read-ahead at all.
> 
> At my understanding read-ahead it to catch sequential (or other) access
> pattern and do some advance reading, so instead of 16K request we do
> 128K request, or something similar.
> 
> But how could read-ahead disabled end up in 16K request converted to
> several sequential synchronous 4K requests ? 

When the readahead window gets closed,the code goes into slow-read mode.
In this mode, all requests are broken to page-size. Hence a 16k request
gets broken into 4  4K-requests. This continues to the point where
enough number of sequential i/os are requested(i.e around ra->ra_pages
number of pages), at which point the readahead window gets
re-activated.  

Looking at it the other way, without readahead code, all requests
satisfied through 4k i/os.  Readahead helps in generating larger size
i/os.

RP


