Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265125AbSKJTvq>; Sun, 10 Nov 2002 14:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265127AbSKJTvq>; Sun, 10 Nov 2002 14:51:46 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:24581 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265125AbSKJTvp>; Sun, 10 Nov 2002 14:51:45 -0500
Message-Id: <200211101953.gAAJr8p32469@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Morton <akpm@digeo.com>, Ed Tomlinson <tomlins@cam.org>
Subject: Re: 2.5.46-mm2 - oops
Date: Sun, 10 Nov 2002 22:44:40 -0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Chris Mason <mason@suse.com>
References: <3DCDD9AC.C3FB30D9@digeo.com> <200211101309.21447.tomlins@cam.org> <3DCEAAE3.C6EE63EF@digeo.com>
In-Reply-To: <3DCEAAE3.C6EE63EF@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 November 2002 16:52, Andrew Morton wrote:
> Ed Tomlinson wrote:
> > On November 9, 2002 10:59 pm, Andrew Morton wrote:
> > > Of note in -mm2 is a patch from Chris Mason which teaches
> > > reiserfs to use the mpage code for reads - it should show a nice
> > > reduction in CPU load under reiserfs reads.
> >
> > Booting into mm2 I get:
> >
> > ...
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000004
> >
> > ...
> > EIP is at mpage_readpages+0x47/0x140
>
> whoops.  The ->readpages API was changed...
>
> --- 25/fs/reiserfs/inode.c~reiserfs-readpages-fix	Sun Nov 10 10:44:28
> 2002 +++ 25-akpm/fs/reiserfs/inode.c	Sun Nov 10 10:44:39 2002
> @@ -2081,7 +2081,7 @@ static int reiserfs_readpage (struct fil
>  }
>
>  static int
> -reiserfs_readpages(struct address_space *mapping,
> +reiserfs_readpages(struct file *file, struct address_space *mapping,
>                 struct list_head *pages, unsigned nr_pages)

Why it wasn't catched by compiler? Does C allow assignments with
incompatible pointers without cast?
--
vda
