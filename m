Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264869AbTE1UzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 16:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264810AbTE1UzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 16:55:00 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:25605 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264869AbTE1Uy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 16:54:58 -0400
Date: Wed, 28 May 2003 18:08:21 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Riley Williams <Riley@Williams.Name>
Cc: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: CODA breaks boot
Message-ID: <20030528210821.GM12434@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Riley Williams <Riley@Williams.Name>, Andrew Morton <akpm@digeo.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <20030528043600.650a2f82.akpm@digeo.com> <BKEGKPICNAKILKJKMHCACEPLEBAA.Riley@Williams.Name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BKEGKPICNAKILKJKMHCACEPLEBAA.Riley@Williams.Name>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 28, 2003 at 10:00:06PM +0100, Riley Williams escreveu:
> Hi Andrew.
> 
>  >> ...it oopses in kmem_cache_create, called from release_console_sem and
>  >>  coda_init_inodecache.
> 
>  > You'll be needing this one.
>  > 
>  >  fs/coda/inode.c |    6 +++---
>  >  1 files changed, 3 insertions(+), 3 deletions(-)
>  > 
>  > diff -puN fs/coda/inode.c~coda-typo-fix fs/coda/inode.c
>  > --- 25/fs/coda/inode.c~coda-typo-fix	2003-05-27 22:27:11.000000000 -0700
>  > +++ 25-akpm/fs/coda/inode.c	2003-05-27 22:27:27.000000000 -0700
>  > @@ -69,9 +69,9 @@ static void init_once(void * foo, kmem_c
>  >  int coda_init_inodecache(void)
>  >  {
>  >  	coda_inode_cachep = kmem_cache_create("coda_inode_cache",
>  > -					     sizeof(struct coda_inode_info),
>  > +				sizeof(struct coda_inode_info),
>  > -					     0, SLAB_HWCACHE_ALIGN||SLAB_RECLAIM_ACCOUNT,
                                                                  ^^
                                                             logical OR
>  > +				0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
                                                     ^
                                                 bit or
>  > -					     init_once, NULL);
>  > +				init_once, NULL);
>  >  	if (coda_inode_cachep == NULL)
>  >  		return -ENOMEM;
>  >  	return 0;
> 
> That patch has me puzzled. Other than changing the white space, what actual
> change to the code does it make? I can't see any.

gotcha? 8)

- Arnaldo
