Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUCKLGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 06:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUCKLGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 06:06:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:9391 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261179AbUCKLGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 06:06:10 -0500
Date: Thu, 11 Mar 2004 03:06:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mickael Marchand <marchand@kde.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-Id: <20040311030607.22706063.akpm@osdl.org>
In-Reply-To: <200403111017.33363.marchand@kde.org>
References: <20040310233140.3ce99610.akpm@osdl.org>
	<200403111017.33363.marchand@kde.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mickael Marchand <marchand@kde.org> wrote:
>
> Hi,
> 
> on my config (opteron box) I need this patch to get it compiled :
> 
> --- fs/compat_ioctl.c.orig      2004-03-11 08:57:49.472074584 +0000
> +++ fs/compat_ioctl.c   2004-03-11 08:57:01.770326352 +0000
> @@ -1604,7 +1604,7 @@
>          * To have permissions to do most of the vt ioctls, we either have
>          * to be the owner of the tty, or super-user.
>          */
> -       if (current->tty == tty || capable(CAP_SYS_ADMIN))
> +       if (current->signal->tty == tty || capable(CAP_SYS_ADMIN))
>                 return 1;
>         return 0;
>  }

yup, thanks.

> 
> while I am at it, I am running a 64 bits kernel with 32 bits debian testing and
> it seems some ioctl conversion fails
> that happened with all 2.6 I tried.
> here is the relevant kernel messages part :
> ioctl32(dmsetup:26199): Unknown cmd fd(3) cmd(c134fd00){01} arg(0804c0b0) on /dev/mapper/control

The device mapper version 1 ioctl interface was removed.  Perhaps you need
to update your dm tools?

> ioctl32(fsck.reiserfs:201): Unknown cmd fd(4) cmd(80081272){00} arg(ffffdab8) on /dev/ide/host0/bus0/target0/lun0/part4

Is this something which 2.6 has always done, or is it new behaviour?

reiserfs ioctl translation appears to be incomplete...
