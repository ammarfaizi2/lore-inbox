Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSLGOrH>; Sat, 7 Dec 2002 09:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSLGOrH>; Sat, 7 Dec 2002 09:47:07 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:40967 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S262708AbSLGOrF>; Sat, 7 Dec 2002 09:47:05 -0500
Date: Sat, 7 Dec 2002 15:54:40 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix the ext3 data=journal unmount bug
Message-ID: <20021207145440.GA31143@merlin.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <3DF03B35.AA5858DC@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF03B35.AA5858DC@digeo.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Dec 2002, Andrew Morton wrote:

>  fs/buffer.c        |    6 ++++--
>  fs/ext3/super.c    |   25 +++++++++++++------------
>  fs/super.c         |    6 +++++-
>  include/linux/fs.h |    3 ++-
>  4 files changed, 24 insertions(+), 16 deletions(-)
> 
> --- linux-akpm/fs/buffer.c~sync_fs	Thu Dec  5 21:33:56 2002
> +++ linux-akpm-akpm/fs/buffer.c	Thu Dec  5 21:33:56 2002
> @@ -327,6 +327,8 @@ int fsync_super(struct super_block *sb)
>  	lock_super(sb);
>  	if (sb->s_dirt && sb->s_op && sb->s_op->write_super)
>  		sb->s_op->write_super(sb);
> +	if (sb->s_op && sb->s_op->sync_fs)
> +		sb->s_op->sync_fs(sb);
>  	unlock_super(sb);
>  	unlock_kernel();

Against what kernel version is this?
