Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbTAZANx>; Sat, 25 Jan 2003 19:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbTAZANx>; Sat, 25 Jan 2003 19:13:53 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:10896 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265385AbTAZANw>; Sat, 25 Jan 2003 19:13:52 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 25 Jan 2003 16:28:40 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "J.A. Magallon" <jamagallon@able.es>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] epoll for 2.4.20 updated ...
In-Reply-To: <20030126001511.GE1507@werewolf.able.es>
Message-ID: <Pine.LNX.4.50.0301251627180.1855-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0301242004010.2858-100000@blue1.dev.mcafeelabs.com>
 <20030126001511.GE1507@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2003, J.A. Magallon wrote:

>
> On 2003.01.25 Davide Libenzi wrote:
> >
> > I updated the 2.4.20 patch with the changes posted today and I fixed a
> > little error about the wait queue function prototype :
> >
> > http://www.xmailserver.org/linux-patches/sys_epoll-2.4.20-0.61.diff
> >
>
> I needed this to build smbfs:
>
> --- linux-2.4.21-pre3-jam3/fs/smbfs/sock.c.orig	2003-01-26 01:02:32.000000000 +0100
> +++ linux-2.4.21-pre3-jam3/fs/smbfs/sock.c	2003-01-26 01:03:11.000000000 +0100
> @@ -314,7 +314,7 @@
>  smb_receive_poll(struct smb_sb_info *server)
>  {
>  	struct file *file = server->sock_file;
> -	poll_table wait_table;
> +	struct poll_wqueues wait_table;
>  	int result = 0;
>  	int timeout = server->mnt->timeo * HZ;
>  	int mask;
> @@ -323,7 +323,7 @@
>  		poll_initwait(&wait_table);
>                  set_current_state(TASK_INTERRUPTIBLE);
>
> -		mask = file->f_op->poll(file, &wait_table);
> +		mask = file->f_op->poll(file, &wait_table.pt);
>  		if (mask & POLLIN) {
>  			poll_freewait(&wait_table);
>  			current->state = TASK_RUNNING;
>
> Is it correct ?

I thought this was already been reported and fixed. Your fix is fine, I'll
make 0.62 ...



- Davide

