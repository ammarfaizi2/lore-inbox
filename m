Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267645AbTB1H71>; Fri, 28 Feb 2003 02:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbTB1H71>; Fri, 28 Feb 2003 02:59:27 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:51154 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267645AbTB1H7Z>; Fri, 28 Feb 2003 02:59:25 -0500
Date: Fri, 28 Feb 2003 09:08:47 +0100
From: Andi Kleen <ak@muc.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus <torvalds@transmeta.com>,
       anton@samba.org, "David S. Miller" <davem@redhat.com>, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org, matthew@wil.cx
Subject: Re: [PATCH][COMPAT] compat_sys_fcntl{,64} 1/9 Generic part
Message-ID: <20030228080847.GA29108@averell>
References: <20030228153349.600b73f7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228153349.600b73f7.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 05:33:49AM +0100, Stephen Rothwell wrote:
> +static int get_compat_flock(struct flock *kfl, struct compat_flock *ufl)
> +{
> +	if (!access_ok(VERIFY_READ, ufl, sizeof(*ufl)) ||
> +	    __get_user(kfl->l_type, &ufl->l_type) ||
> +	    __get_user(kfl->l_whence, &ufl->l_whence) ||
> +	    __get_user(kfl->l_start, &ufl->l_start) ||
> +	    __get_user(kfl->l_len, &ufl->l_len) ||
> +	    __get_user(kfl->l_pid, &ufl->l_pid))

Perhaps there should be really a big fat comment on top of compat.c
that it depends on a hole on __PAGE_OFFSET if the arch allows passing
64bit pointers to the compat functions.

> +
> +asmlinkage long compat_sys_fcntl(unsigned int fd, unsigned int cmd,
> +		unsigned long arg)
> +{
> +	if ((cmd == F_GETLK64) || (cmd == F_SETLK64) || (cmd == F_SETLKW64))
> +		return -EINVAL;

That won't work for IA32 emulation. There are programs that call
old style fcntl() with F_*LK64. Just drop the if here.

> +	return compat_sys_fcntl64(fd, cmd, arg);

-Andi















