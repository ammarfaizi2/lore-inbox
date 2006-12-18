Return-Path: <linux-kernel-owner+w=401wt.eu-S1753634AbWLRKMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbWLRKMn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbWLRKMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:12:43 -0500
Received: from amsfep19-int.chello.nl ([62.179.120.14]:54677 "EHLO
	amsfep19-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbWLRKMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:12:42 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: andrei.popa@i-neo.ro
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <1166436005.7072.15.camel@localhost>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org>
	 <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org>
	 <45861E68.3060403@yahoo.com.au>
	 <Pine.LNX.4.64.0612172145250.3479@woody.osdl.org>
	 <1166433544.6911.5.camel@localhost> <20061218013806.2cf67614.akpm@osdl.org>
	 <1166436005.7072.15.camel@localhost>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 11:11:57 +0100
Message-Id: <1166436717.10372.58.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 12:00 +0200, Andrei Popa wrote:
> On Mon, 2006-12-18 at 01:38 -0800, Andrew Morton wrote: 
> > On Mon, 18 Dec 2006 11:19:04 +0200
> > Andrei Popa <andrei.popa@i-neo.ro> wrote:
> > 
> > > 
> > > I tried latest git with the patch from this email and it still get file
> > > content corruption. If I can help you further debug the problem tell me
> > > what to do.
> > 
> > Can you please tell us all the steps which we need to take to reproduce this?
> 
> I'm using rtorrent-0.7.0 and libtorrent-0.11.0, just download a torrent
> with multiple files(I downloaded 84 rar files) and when it will finish
> it will do a hash check and at the end of the check will say "Hash check
> on download completion found bad chunks, consider using "safe_sync"."
> and stop and most of the downloaded files are broken. With Peter
> Zijlstra patch this error doesn't show but there is file
> corruption(although less files are corrupted); afther the hash check,
> rtorrent will download the bad chunks and do another hash check and all
> files are ok.

OK, I'll try this on a ext3 box. BTW, what data mode are you using ext3
in?


Also, for testings sake, could you give this a go:
It's a total hack but I guess worth testing.

---
 mm/rmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-git/mm/rmap.c
===================================================================
--- linux-2.6-git.orig/mm/rmap.c	2006-12-18 11:06:29.000000000 +0100
+++ linux-2.6-git/mm/rmap.c	2006-12-18 11:07:16.000000000 +0100
@@ -448,7 +448,7 @@ static int page_mkclean_one(struct page 
 		goto unlock;
 
 	entry = ptep_get_and_clear(mm, address, pte);
-	entry = pte_mkclean(entry);
+	/* entry = pte_mkclean(entry); */
 	entry = pte_wrprotect(entry);
 	ptep_establish(vma, address, pte, entry);
 	lazy_mmu_prot_update(entry);


