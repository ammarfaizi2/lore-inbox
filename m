Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbWCGBPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWCGBPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWCGBPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:15:46 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:48483 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932589AbWCGBPp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:15:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mROcdhmVga4RuT9pDbehWozzSrHZJE2rRjUz5llbTJCgr1k4tTa4C8scF0SJMZ2N9YYBYzaTaXNBikybBbszRgs0libp6bZEXtWzyXZXEwuQjV5Ht7R1Q7G1z0mK9YihBq475y9Why/ziJ0UgvvS4SsHQTSSCia/G29B61oloow=
Message-ID: <8766c4ce0603061715t7a0c2aacg@mail.gmail.com>
Date: Tue, 7 Mar 2006 02:15:43 +0100
From: "Miguel Blanco" <mblancom@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: problem mounting a jffs2 filesystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1141652131.4110.47.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <8766c4ce0603050504h24b445c5t@mail.gmail.com>
	 <1141652131.4110.47.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, It works now with the patch !!!

Thank you.

Miguel.

2006/3/6, David Woodhouse <dwmw2@infradead.org>:
> On Sun, 2006-03-05 at 14:04 +0100, Miguel Blanco wrote:
> >  divide error: 0000 [#1]
> >  EIP is at jffs2_scan_medium+0xdf/0x55e [jffs2]
>
> Can you try it with the attached patch? Or turn off
> CONFIG_JFFS2_FS_WRITEBUFFER
>
> --
> dwmw2
>
>
>
> ---------- Mensaje reenviado ----------
> From: David Woodhouse <dwmw2@infradead.org>
> To: linux-mtd-cvs@lists.infradead.org
> Date: Thu, 09 Feb 2006 16:13:01 +0000
> Subject: mtd/fs/jffs2 scan.c,1.134,1.135
> Update of /home/cvs/mtd/fs/jffs2
> In directory phoenix.infradead.org:/tmp/cvs-serv28853
>
> Modified Files:
>         scan.c
> Log Message:
> Avoid divide-by-zero
>
> Index: scan.c
> ===================================================================
> RCS file: /home/cvs/mtd/fs/jffs2/scan.c,v
> retrieving revision 1.134
> retrieving revision 1.135
> diff -u -r1.134 -r1.135
> --- scan.c      13 Jan 2006 10:25:29 -0000      1.134
> +++ scan.c      9 Feb 2006 16:12:59 -0000       1.135
> @@ -239,7 +239,7 @@
>                 c->nextblock->dirty_size = 0;
>         }
>  #ifdef CONFIG_JFFS2_FS_WRITEBUFFER
> -       if (!jffs2_can_mark_obsolete(c) && c->nextblock && (c->nextblock->free_size % c->wbuf_pagesize)) {
> +       if (!jffs2_can_mark_obsolete(c) && c->wbuf_pagesize && c->nextblock && (c->nextblock->free_size % c->wbuf_pagesize)) {
>                 /* If we're going to start writing into a block which already
>                    contains data, and the end of the data isn't page-aligned,
>                    skip a little and align it. */
>
>
> __________________________________________________________
> Linux-MTD CVS commit list
> http://lists.infradead.org/mailman/listinfo/linux-mtd-cvs/
>
>
>
