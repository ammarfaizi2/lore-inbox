Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293035AbSCaIcR>; Sun, 31 Mar 2002 03:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312412AbSCaIcG>; Sun, 31 Mar 2002 03:32:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58641 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293035AbSCaIb4>;
	Sun, 31 Mar 2002 03:31:56 -0500
Message-ID: <3CA6C91D.67186FAB@zip.com.au>
Date: Sun, 31 Mar 2002 00:30:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: "David S. Miller" <davem@redhat.com>, tim@birdsnest.maths.tcd.ie,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.7
In-Reply-To: <20020330.182243.88963096.davem@redhat.com> <Pine.GSO.4.21.0203310253360.4431-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> ...
> +/*
> + * "Conditional" syscalls
> + *
> + * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
> + * but it doesn't work on sparc64, so we just do it by hand
> + */
> +#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
> +
> +cond_syscall(sys_nfsservctl)
> +cond_syscall(sys_quotactl)
> +cond_syscall(sys_acct)
> +

Could you remind us what problem this is solving?  The
#ifdef approach seemed reasonable and there's no indication
here why weak linkage is needed.

Weak linkage could perhaps be useful elsewhere.  Maybe this
should be implemented as

	weak_symbol(sym, default_sym)

in some generic header somewhere...

-
