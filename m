Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUCVE3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 23:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbUCVE3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 23:29:52 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:34498 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261684AbUCVE3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 23:29:51 -0500
Subject: Re: [PATCH] Drop O_LARGEFILE from F_GETFL for POSIX compliance
From: Nicholas Miell <nmiell@attbi.com>
To: Andi Kleen <ak@suse.de>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040322051318.597ad1f9.ak@suse.de>
References: <20040322051318.597ad1f9.ak@suse.de>
Content-Type: text/plain
Message-Id: <1079929789.1832.2.camel@entropy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 21 Mar 2004 20:29:49 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-21 at 20:13, Andi Kleen wrote:
> diff -burpN -X ../KDIFX linux-2.4.26-pre5/fs/fcntl.c linux-merge/fs/fcntl.c
> --- linux-2.4.26-pre5/fs/fcntl.c	2004-01-13 10:29:17.000000000 +0100
> +++ linux-merge/fs/fcntl.c	2003-10-23 15:40:52.000000000 +0200
> @@ -271,7 +271,7 @@ static long do_fcntl(unsigned int fd, un
>  			set_close_on_exec(fd, arg&1);
>  			break;
>  		case F_GETFL:
> -			err = filp->f_flags;
> +			err = filp->f_flags & ~O_LARGEFILE;
>  			break;
>  		case F_SETFL:
>  			lock_kernel();

Shouldn't this be guarded by #if BITS_PER_LONG != 32, like sys_open?


