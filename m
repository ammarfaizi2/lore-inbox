Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbTBEBlX>; Tue, 4 Feb 2003 20:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267656AbTBEBlX>; Tue, 4 Feb 2003 20:41:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:23285 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267544AbTBEBlW>;
	Tue, 4 Feb 2003 20:41:22 -0500
Date: Tue, 4 Feb 2003 17:51:09 -0800
From: Andrew Morton <akpm@digeo.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, tytso@thunk.org,
       rddunlap@osdl.org
Subject: Re: [PATCH][RESEND 3] disassociate_ctty SMP fix
Message-Id: <20030204175109.57bbfc51.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50L.0302042306230.32328-100000@imladris.surriel.com>
References: <Pine.LNX.4.50L.0302042235180.32328-100000@imladris.surriel.com>
	<Pine.LNX.4.50L.0302042306230.32328-100000@imladris.surriel.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2003 01:50:49.0483 (UTC) FILETIME=[020715B0:01C2CCB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> wrote:
>
> ===== drivers/char/tty_io.c 1.55 vs edited =====
> --- 1.55/drivers/char/tty_io.c	Tue Jan 14 23:37:20 2003
> +++ edited/drivers/char/tty_io.c	Tue Feb  4 23:02:52 2003
> @@ -425,19 +425,21 @@
>   */
>  void do_tty_hangup(void *data)
>  {
> -	struct tty_struct *tty = (struct tty_struct *) data;
> +	struct tty_struct *tty;
>  	struct file * cons_filp = NULL;
>  	struct task_struct *p;
>  	struct list_head *l;
>  	struct pid *pid;
>  	int    closecount = 0, n;
> 
> -	if (!tty)
> -		return;
> -
>  	/* inuse_filps is protected by the single kernel lock */
>  	lock_kernel();
> -
> +	tty = (struct tty_struct *) data;
> +	if (!tty) {
> +		unlock_kernel();
> +		return;
> +	}
> +
>  	check_tty_count(tty, "do_tty_hangup");
>  	file_list_lock();
>  	for (l = tty->tty_files.next; l != &tty->tty_files; l = l->next) {

This part is a no-op...

