Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbUK3C0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUK3C0G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUK3CZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:25:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:33173 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261944AbUK3CWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 21:22:04 -0500
Date: Mon, 29 Nov 2004 18:22:00 -0800
From: Chris Wright <chrisw@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.29-pre1] proc_tty.c warning fix
Message-ID: <20041129182159.H14339@build.pdx.osdl.net>
References: <200411281426.iASEQjDt001350@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200411281426.iASEQjDt001350@harpo.it.uu.se>; from mikpe@csd.uu.se on Sun, Nov 28, 2004 at 03:26:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mikael Pettersson (mikpe@csd.uu.se) wrote:
> The /proc/tty/driver/serial vulnerability fix in 2.4.29-pre1
> calls a function without a prototype in scope, resulting in:
> 
> proc_tty.c: In function `proc_tty_init':
> proc_tty.c:183: warning: implicit declaration of function `proc_mkdir_mode'
> proc_tty.c:183: warning: assignment makes pointer from integer without a cast
> 
> Fixed by the trivial patch below.
> 
> Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

Yes, oversight, please apply.  Well, here's an insignificant variation
which comes straight from 2.6 to minimize divergence.

===== include/linux/proc_fs.h 1.10 vs edited =====
--- 1.10/include/linux/proc_fs.h	2004-10-05 11:22:37 -07:00
+++ edited/include/linux/proc_fs.h	2004-11-29 18:17:37 -08:00
@@ -144,6 +144,8 @@ extern struct proc_dir_entry *proc_symli
 extern struct proc_dir_entry *proc_mknod(const char *,mode_t,
 		struct proc_dir_entry *,kdev_t);
 extern struct proc_dir_entry *proc_mkdir(const char *,struct proc_dir_entry *);
+extern struct proc_dir_entry *proc_mkdir_mode(const char *name, mode_t mode,
+			struct proc_dir_entry *parent);
 
 static inline struct proc_dir_entry *create_proc_read_entry(const char *name,
 	mode_t mode, struct proc_dir_entry *base, 
