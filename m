Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267295AbUGNCTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267295AbUGNCTr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 22:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267296AbUGNCTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 22:19:47 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:5783 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S267295AbUGNCTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 22:19:43 -0400
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Vincent Hanquez <tab@snarc.org>
Date: Wed, 14 Jul 2004 12:19:34 +1000
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.8-rc1 fix AFS struct_cpy use which break !X86
Message-ID: <20040714021934.GB31683@cse.unsw.EDU.AU>
References: <20040714010706.GA31683@cse.unsw.EDU.AU> <20040714012110.GA5400@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714012110.GA5400@snarc.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep, that fixed it, we'll wait for the original patch to be merged.

see
http://lkml.org/lkml/2004/7/12/176
for the original thread and patch.

Thanks
Darren

> Ok, what about the following patch ?
> 
> Index: fs/afs/mntpt.c
> ===================================================================
> --- fs/afs/mntpt.c	(revision 1)
> +++ fs/afs/mntpt.c	(working copy)
> @@ -257,7 +257,7 @@
>  	if (IS_ERR(newmnt))
>  		return PTR_ERR(newmnt);
>  
> -	struct_cpy(&newnd, nd);
> +	newnd = *nd;
>  	newnd.dentry = dentry;
>  	err = do_add_mount(newmnt, &newnd, 0, &afs_vfsmounts);
>  
> Index: fs/afs/vlocation.c
> ===================================================================
> --- fs/afs/vlocation.c	(revision 1)
> +++ fs/afs/vlocation.c	(working copy)
> @@ -906,7 +906,7 @@
>  		if (!vlocation->valid ||
>  		    vlocation->vldb.rtime == vldb->rtime
>  		    ) {
> -			struct_cpy(&vlocation->vldb, vldb);
> +			vlocation->vldb = *vldb;
>  			vlocation->valid = 1;
>  			_leave(" = SUCCESS [c->m]");
>  			return CACHEFS_MATCH_SUCCESS;
> @@ -947,7 +947,7 @@
>  
>  	_enter("");
>  
> -	struct_cpy(vldb,&vlocation->vldb);
> +	*vldb = vlocation->vldb;
>  
>  } /* end afs_vlocation_cache_update() */
>  #endif


--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
