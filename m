Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTFGQqY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 12:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTFGQqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 12:46:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60882 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263271AbTFGQqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 12:46:22 -0400
Date: Sat, 7 Jun 2003 18:59:51 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       bcollins@debian.org, linux1394-devel@lists.sourceforge.net
Cc: Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [patch] fix vlsi_ir.c compile if !CONFIG_PROC_FS
Message-ID: <20030607165951.GA13377@fs.tum.de>
References: <20030607152434.GQ15311@fs.tum.de> <Pine.SOL.4.30.0306071815120.6449-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0306071815120.6449-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 06:22:39PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Apply something like this:
> 
> --- linux-2.5.70-bk11/include/proc_fs.h	Fri Jun  6 18:43:49 2003
> +++ linux/include/proc_fs.h	Sat Jun  7 18:11:22 2003
> @@ -205,7 +205,7 @@
>  static inline struct proc_dir_entry *create_proc_entry(const char *name,
>  	mode_t mode, struct proc_dir_entry *parent) { return NULL; }
> 
> -static inline void remove_proc_entry(const char *name, struct proc_dir_entry *parent) {};
> +#define remove_proc_entry(name, parent)	/* nothing */
>  static inline struct proc_dir_entry *proc_symlink(const char *name,
>  		struct proc_dir_entry *parent,char *dest) {return NULL;}
>  static inline struct proc_dir_entry *proc_mknod(const char *name,mode_t mode,
> 
> And you wil not have to readd #ifdef/#endif pair.
> 
> I've seen Sam's mail but this is generic solution to quiet compiler
> and will work for any remove_proc_entry() user.

Yup, for this specific error Sam's solution is the best one, but your 
patch e.g. solves the ieee1394_core.c compile error I reported, too.

> Thanks,
> --
> Bartlomiej

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

