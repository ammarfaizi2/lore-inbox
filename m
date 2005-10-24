Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVJXPQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVJXPQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVJXPQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:16:55 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:54438 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751086AbVJXPQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:16:54 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: what happened to page_mkwrite? - was: Re: page_mkwrite seems broken
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 24 Oct 2005 16:16:45 +0100
Message-Id: <1130167005.19518.35.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-02-09 at 14:28 +0000, Hugh Dickins wrote:
> On Fri, 4 Feb 2005, Hugh Dickins wrote in another thread:
> > Isn't this exactly what David Howells' page_mkwrite stuff in -mm's
> > add-page-becoming-writable-notification.patch is designed for?
> > 
> > Though it looks a little broken to me as it stands (beyond the two
> > fixup patches already there).  I've not found time to double-check
> > or test, apologies in advance if I'm libelling, but...
> > 
> > (a) I thought the prot bits do_nopage gives a pte in a shared writable
> >     mapping include write permission, even when it's a read fault:
> >     that can't be allowed if there's a page_mkwrite.
> > 
> > (b) I don't understand how do_wp_page's "reuse" logic for whether it
> >     can just go ahead and use the existing anonymous page, would have
> >     any relevance to calling page_mkwrite on a shared writable page,
> >     which must be used and not COWed however many references there are.
> 
> I have now looked further, and both points still seem valid to me:
> the page_mkwrite calling code looks doubly broken.  (Tested?)
> 
> Nor has there been any movement on the points raised by Christoph,
> that aops->page_mkwrite is redundant, and do_wp_page_mk_pte_writable
> separation unhelpful.
> 
> I could probably put page_mkwrite to use in tmpfs (to eliminate its
> unsatisfactory but never over-troubling shmem_recalc_inode), but not
> as it currently stands.
> 
> Are you planning any movement on this, David?
> Or should I have a go sometime?

What happened with page_mkwrite?  It seems to have disappeared both from
-mm and generally from the face of the earth...

I am very interested in having such ability for ntfs...

Is anyone still working on this?  If not why not?  Did it prove
impractical or ...?

If no-one is working on this anymore, where do I find the last "current"
patch?

Thanks a lot in advance!

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

