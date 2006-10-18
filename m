Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422893AbWJRUVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbWJRUVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWJRUVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:21:43 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:45450 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422901AbWJRUVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:21:41 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.19-rc2-mm1
Date: Wed, 18 Oct 2006 22:20:49 +0200
User-Agent: KMail/1.9.1
Cc: Cedric Le Goater <clg@fr.ibm.com>, Gabriel C <nix.or.die@googlemail.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20061016230645.fed53c5b.akpm@osdl.org> <4536818E.3060505@fr.ibm.com> <453683A6.9090106@yahoo.com.au>
In-Reply-To: <453683A6.9090106@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610182220.50487.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 18 October 2006 21:42, Nick Piggin wrote:
> Cedric Le Goater wrote:
> > Rafael J. Wysocki wrote:
> > 
> >>On Wednesday, 18 October 2006 20:27, Gabriel C wrote:
> >>
> >>>Andrew Morton wrote:
> >>>
> >>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm1/
> >>>>  
> >>>
> >>>Hello,
> >>>
> >>>I got this build error with 2.6.19-rc2-mm1:
> >>>
> >>>CHK include/linux/compile.h
> >>>UPD include/linux/compile.h
> >>>CC init/version.o
> >>>LD init/built-in.o
> >>>LD .tmp_vmlinux1
> >>>mm/built-in.o: In function `xip_file_write':
> >>>(.text+0x19a47): undefined reference to `filemap_copy_from_user'
> >>>make: *** [.tmp_vmlinux1] Error 1
> >>
> >>\metoo
> > 
> > 
> > Here's a fix i sent to andrew.
> > 
> > C.
> > 
> > 
> > Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> > ---
> >  mm/filemap_xip.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: 2.6.19-rc2-mm1/mm/filemap_xip.c
> > ===================================================================
> > --- 2.6.19-rc2-mm1.orig/mm/filemap_xip.c
> > +++ 2.6.19-rc2-mm1/mm/filemap_xip.c
> > @@ -317,7 +317,7 @@ __xip_file_write(struct file *filp, cons
> >  			break;
> >  		}
> >  
> > -		copied = filemap_copy_from_user(page, offset, buf, bytes);
> > +		copied = filemap_copy_from_user_atomic(page, offset, buf, bytes);
> >  		flush_dcache_page(page);
> >  		if (likely(copied > 0)) {
> >  			status = copied;
> 
> This fix will work. You should really call the non atomic version though, just
> so it is clear (and maybe some architectures care).
> 
> Because we must service a fault if it happens here. The fault_in_pages_readable
> and comments are wrong AFAIKS.

So I guess there should be

copied = filemap_copy_from_user_nonatomic(page, offset, buf, bytes); 

