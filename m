Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbUBVKMV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 05:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUBVKMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 05:12:20 -0500
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:37380
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S261218AbUBVKMS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 05:12:18 -0500
Subject: Re: Fw: Client looses NFS handle (kernel 2.6.3)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>, Willy Weisz <weisz@vcpc.univie.ac.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040221214345.6533eb68.akpm@osdl.org>
References: <20040221214345.6533eb68.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1077444724.2944.10.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 22 Feb 2004 02:12:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "Can't bind to reserved port" error message looks like the known
problem when you set CONFIG_SECURITY. It has been discussed several
times already on l-k.

Please either disable CONFIG_SECURITY (it's not as if *that* is going to
be a showstopper when migrating to 2.6.x from 2.4.x) or go to my website
and apply the advertised fix:

http://www.fys.uio.no/~trondmy/src/Linux-2.6.x/2.6.3/linux-2.6.3-08-reconnect.dif

Cheers,
  Trond


På lau , 21/02/2004 klokka 21:43, skreiv Andrew Morton:
> fyi..
> 
> Begin forwarded message:
> 
> Date: Sun, 22 Feb 2004 00:36:13 +0100
> From: Willy Weisz <weisz@vcpc.univie.ac.at>
> To: linux-kernel@vger.kernel.org
> Subject: Client looses NFS handle (kernel 2.6.3)
> 
> 
> The client looses the handle to a statically mounted NFS file system. A 
> user sees
> a stale handle in "df" and can't access files and directories.
> 
> When root issues a "df" or accesses a file or directory on the NFS file 
> system,
> it gets a correct result.
> 
> Thereafter a normal user also can access files and directories on the 
> NFS file system.
> After a short time the NFS handle becomes stale again.
> /var/log/messages contains the lines:
> Feb 21 23:33:50 gsr108 kernel: RPC: Can't bind to reserved port (13).
> Feb 21 23:33:50 gsr108 kernel: RPC: can't bind to reserved port.
> after a user tries to access a file on the NFS file system.
> The NFS server runs kernel version 2.4.23 SMP. Client NFS 2.4.23 works.
> 
> The filesystem is mounted with the following options in /etc/fstab:
> rw,bg,hard,intr,rsize=8192,wsize=8192
> 
> We are stuck and can't upgrade to 2.6.x with this bug.
> 
> Regards
> 
> Willy Weisz
> -----------------------------------------------------------
> Willy Weisz
> 
> European Centre for Parallel Computing at Vienna (VCPC)
>                  Liechtensteinstrasse 22
>                  A-1090 Wien
> Tel: (+43 1) 4277 - 38824          Fax: (+43 1) 4277 - 9388
>                 e-mail: weisz@vcpc.univie.ac.at
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
