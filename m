Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131193AbRAYXxk>; Thu, 25 Jan 2001 18:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132363AbRAYXx3>; Thu, 25 Jan 2001 18:53:29 -0500
Received: from diver.doc.ic.ac.uk ([146.169.1.47]:47634 "EHLO
	diver.doc.ic.ac.uk") by vger.kernel.org with ESMTP
	id <S131193AbRAYXxV>; Thu, 25 Jan 2001 18:53:21 -0500
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: limit on number of kmapped pages
In-Reply-To: <y7rsnmav0cv.fsf@sytry.doc.ic.ac.uk>
	<m1r91udt59.fsf@frodo.biederman.org>
	<y7rofwxeqin.fsf@sytry.doc.ic.ac.uk>
	<20010125181621.W11607@redhat.com>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 25 Jan 2001 23:53:16 +0000
In-Reply-To: "Stephen C. Tweedie"'s message of "Thu, 25 Jan 2001 18:16:21 +0000"
Message-ID: <y7rwvbjmbo3.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> writes:
> On Wed, Jan 24, 2001 at 12:35:12AM +0000, David Wragg wrote:
> > 
> > > And why do the pages need to be kmapped? 
> > 
> > They only need to be kmapped while data is being copied into them.
> 
> But you only need to kmap one page at a time during the copy.  There
> is absolutely no need to copy the whole chunk at once.

The chunks I'm copying are always smaller than a page.  Usually they
are a few hundred bytes.

Though because I'm copying into the pages in a bottom half, I'll have
to use kmap_atomic.  After a page is filled, it is put into the page
cache.  So they have to be allocated with page_cache_alloc(), hence
__GFP_HIGHMEM and the reason I'm bothering with kmap at all.


David Wragg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
