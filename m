Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161206AbWALTYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161206AbWALTYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161203AbWALTYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:24:23 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:7110 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161202AbWALTYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:24:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: spereira@tusc.com.au
Subject: Re: [PATCH 2/4 - 2.6.15]net: 32 bit (socket layer) ioctl emulation for 64 bit kernels
Date: Thu, 12 Jan 2006 19:24:02 +0000
User-Agent: KMail/1.9.1
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Andi Kleen <ak@muc.de>,
       linux-kenel <linux-kernel@vger.kernel.org>,
       x25 maintainer <eis@baty.hanse.de>,
       "David S. Miller" <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>, SP <pereira.shaun@gmail.com>
References: <1137045732.5221.21.camel@spereira05.tusc.com.au>
In-Reply-To: <1137045732.5221.21.camel@spereira05.tusc.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200601121924.02747.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 06:02, Shaun Pereira wrote:
> +int compat_sock_get_timestamp(struct sock *sk, struct timeval __user
> *userstamp)
> +{
> +       struct compat_timeval __user *ctv;
> +       ctv = (struct compat_timeval __user*) userstamp;
> +       if(!sock_flag(sk, SOCK_TIMESTAMP))
> +               sock_enable_timestamp(sk);
> +       if(sk->sk_stamp.tv_sec == -1)
> +               return -ENOENT;
> +       if(sk->sk_stamp.tv_sec == 0)
> +               do_gettimeofday(&sk->sk_stamp);
> +       return copy_to_user(ctv, &sk->sk_stamp, sizeof(struct
> compat_timeval)) ?
> +                       -EFAULT : 0;
> +}

This looks wrong, you're not doing any conversion here.
You cannot just copy sk_stamp to ctv, they are not compatible.
See compat_sys_gettimeofday on how to copy a struct timeval
correctly.

The other patches look good.

	Arnd <><
