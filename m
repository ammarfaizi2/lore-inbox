Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946223AbWJTE5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946223AbWJTE5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 00:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946228AbWJTE5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 00:57:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:42096 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946223AbWJTE5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 00:57:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mol9P1MDxnWs+7cTlqa34Vk8i7eaSGm9EBskhdg7SNN3p8lp1fpdSUWEXAuGmodKd/6u06kq0zLQ2hepY0ir4VcnPOEaMARCfDAoTQiLBknKmffQGsW0nokzyuBfRFNJdiXzJl63znQXmexn6oYpjR9h0AczyO3egqswPDuoGDI=
Message-ID: <76bd70e30610192157q3c2252b4s62e7bf985b4b487d@mail.gmail.com>
Date: Fri, 20 Oct 2006 00:57:49 -0400
From: "Chuck Lever" <chucklever@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [NFS] [PATCH 07/11] NFS: fix minor bug in new NFS symlink code
Cc: "Trond Myklebust" <Trond.Myklebust@netapp.com>,
       "Linus Torvalds" <torvalds@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061019212541.b2adc4b2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
	 <20061019170432.8171.49033.stgit@lade.trondhjem.org>
	 <20061019212541.b2adc4b2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 19 Oct 2006 13:04:32 -0400
> Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
>
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index 58d4405..c86a1ea 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -1519,8 +1519,8 @@ static int nfs_symlink(struct inode *dir
> >       pagevec_init(&lru_pvec, 0);
> >       if (!add_to_page_cache(page, dentry->d_inode->i_mapping, 0,
> >                                                       GFP_KERNEL)) {
> > -             if (!pagevec_add(&lru_pvec, page))
> > -                     __pagevec_lru_add(&lru_pvec);
> > +             pagevec_add(&lru_pvec, page);
> > +             pagevec_lru_add(&lru_pvec);
> >               SetPageUptodate(page);
> >               unlock_page(page);
> >       } else
>
> One could export add_to_page_cache_lru() to modules..

I assumed there was probably a good reason that this had not already been done.

-- 
"We who cut mere stones must always be envisioning cathedrals"
   -- Quarry worker's creed
