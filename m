Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVJXPnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVJXPnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVJXPnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:43:55 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:37270 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751114AbVJXPny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:43:54 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: what happened to page_mkwrite? - was: Re: page_mkwrite seems
	broken
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: David Howells <dhowells@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <7872.1130167591@warthog.cambridge.redhat.com>
References: <1130167005.19518.35.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com>
	 <7872.1130167591@warthog.cambridge.redhat.com>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 24 Oct 2005 16:43:39 +0100
Message-Id: <1130168619.19518.43.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 16:26 +0100, David Howells wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> 
> > What happened with page_mkwrite?  It seems to have disappeared both from
> > -mm and generally from the face of the earth...
> 
> It got taken out because no one was using it (CacheFS has been removed
> temorarily).
> 
> I'm still attempting to maintain it. If you want I can post it to Andrew again
> to see if he'll take it back. If you want a direct copy, I'll have to extract
> it from CacheFS.

I don't really mind either way.  I am stuck with ntfs at the moment at
the point where I am either going to use my own ->nopage handler to
allocate on-disk clusters or have a ->page_mkwrite handler do it.  The
former is not nice as it means we allocate space even when only reading
whilst the later is very nice as it only triggers when someone actually
does an mmapped write.

So whatever works best for you.  I am happy with it appearing in -mm and
I am also happy with having my own copy in my ntfs development tree for
now.  Given we both want it and High said he wanted it, too, it may be
the more sensible approach to have it in -mm so we have one common code
base to work with/apply fixes to/whatever...  Otherwise we may get
headaches down the line if we end up with diverging implementations of
the same thing and all try to merge ours into the kernel...

Btw. have you addressed the problems Hugh pointed out with it?  If not,
-mm would perhaps be a good place for us to get it sorted?

Andrew, would you be happy to take the ->page_mkwrite patches again into
-mm?  I promise you a user of it to appear in -mm as soon as I can knock
up the ntfs code for it once I have seen the exact interface I am coding
for...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

