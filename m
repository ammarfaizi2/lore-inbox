Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSBSI7Y>; Tue, 19 Feb 2002 03:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288040AbSBSI7O>; Tue, 19 Feb 2002 03:59:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23052 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287817AbSBSI6z>; Tue, 19 Feb 2002 03:58:55 -0500
Subject: Re: Moving fasync_struct into struct file?
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 19 Feb 2002 09:11:48 +0000 (GMT)
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16d4XU-0003VI-00@wagner.rustcorp.com.au> from "Rusty Russell" at Feb 19, 2002 06:18:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16d6JQ-0008LI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the SIGIO.  IMVHO the best way to clean this up is to check the
> fasync_list in sys_close, and if pid == filp->f_owner.pid and fd ==
> fasync_list->fa_fd, unregister the SIGIO.

We already clean up fasync structures on close, its the drivers 
responsibility to do so.  If you wanted to be more strict you could do
a similar helper call in the other closing callback for each fd close.

> 	This means we need a move the "struct fasync_struct
> fasync_list" into struct file (up from all the subsystems which use
> it, eg. struct socket).

Any reason for not just caching the 32bit task ident field ? Using the
slightly confusingly p->parent_exec_id, which is basically a 32bit process
ident for example
