Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTFGTz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 15:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTFGTz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 15:55:56 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:12829 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263452AbTFGTzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 15:55:54 -0400
Date: Sat, 7 Jun 2003 13:09:38 -0700
From: Andrew Morton <akpm@digeo.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: bunk@fs.tum.de, jt@bougret.hpl.hp.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [patch] fix vlsi_ir.c compile if !CONFIG_PROC_FS
Message-Id: <20030607130938.01caef92.akpm@digeo.com>
In-Reply-To: <Pine.SOL.4.30.0306071815120.6449-100000@mion.elka.pw.edu.pl>
References: <20030607152434.GQ15311@fs.tum.de>
	<Pine.SOL.4.30.0306071815120.6449-100000@mion.elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2003 20:09:29.0742 (UTC) FILETIME=[B3F5DAE0:01C32D30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>
> -static inline void remove_proc_entry(const char *name, struct proc_dir_entry *parent) {};
>  +#define remove_proc_entry(name, parent)	/* nothing */

oh, OK.

--- 25/include/linux/proc_fs.h~remove_proc_entry-fix	2003-06-07 13:07:46.000000000 -0700
+++ 25-akpm/include/linux/proc_fs.h	2003-06-07 13:08:51.000000000 -0700
@@ -205,7 +205,8 @@ static inline void proc_pid_flush(struct
 static inline struct proc_dir_entry *create_proc_entry(const char *name,
 	mode_t mode, struct proc_dir_entry *parent) { return NULL; }
 
-static inline void remove_proc_entry(const char *name, struct proc_dir_entry *parent) {};
+#define remove_proc_entry(name, parent) do {} while (0)
+
 static inline struct proc_dir_entry *proc_symlink(const char *name,
 		struct proc_dir_entry *parent,char *dest) {return NULL;}
 static inline struct proc_dir_entry *proc_mknod(const char *name,mode_t mode,

_

