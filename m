Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTFGTwn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 15:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTFGTwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 15:52:43 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:2589 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263451AbTFGTwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 15:52:41 -0400
Date: Sat, 7 Jun 2003 13:06:25 -0700
From: Andrew Morton <akpm@digeo.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [patch] 2.5.70-mm5: fix ieee1394_core.c compile if
 !CONFIG_PROC_FS
Message-Id: <20030607130625.37f077da.akpm@digeo.com>
In-Reply-To: <20030607144558.GO15311@fs.tum.de>
References: <20030607144558.GO15311@fs.tum.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2003 20:06:17.0213 (UTC) FILETIME=[413442D0:01C32D30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> I got the following compile error with !CONFIG_PROC_FS:
> 
> The following patch fixes it:
> --- linux-2.5.70-mm5/drivers/ieee1394/ieee1394_core.c.old	2003-06-07 16:42:35.000000000 +0200
> +++ linux-2.5.70-mm5/drivers/ieee1394/ieee1394_core.c	2003-06-07 16:42:47.000000000 +0200
> @@ -1228,7 +1228,9 @@
>  
>  	unregister_chrdev(IEEE1394_MAJOR, "ieee1394");
>  	devfs_remove("ieee1394");
> +#ifdef CONFIG_PROC_FS
>  	remove_proc_entry("ieee1394", proc_bus);
> +#endif
>  }
>  

proc_fs.h has:

static inline void remove_proc_entry(const char *name, struct proc_dir_entry *parent) {};

for the !CONFIG_PROC_FS case, so that _should_ have prevented this problem.
 What went wrong?

