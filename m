Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbULHMJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbULHMJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 07:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbULHMJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 07:09:39 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:33453 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261195AbULHMJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 07:09:22 -0500
Date: Wed, 8 Dec 2004 23:09:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, tony.luck@intel.com,
       ak@suse.de, ralf@linux-mips.org, paulus@au.ibm.com,
       schwidefsky@de.ibm.com, Davem@davemloft.net
Subject: Re: [Compatibilty patch] sigtimedwait
Message-Id: <20041208230919.7a3a37fc.sfr@canb.auug.org.au>
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427013C9FB@pdsmsx402.ccr.corp.intel.com>
References: <894E37DECA393E4D9374E0ACBBE7427013C9FB@pdsmsx402.ccr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__8_Dec_2004_23_09_19_+1100_9lw2yOKUls+47B5t"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__8_Dec_2004_23_09_19_+1100_9lw2yOKUls+47B5t
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

> diff -Nraup a/include/linux/compat.h b/include/linux/compat.h
> --- a/include/linux/compat.h	2004-12-06 13:04:33.000000000 +0800
> +++ b/include/linux/compat.h	2004-12-07 07:03:42.000000000 +0800
> @@ -143,6 +143,8 @@ long compat_get_bitmap(unsigned long *ma
>  		       unsigned long bitmap_size);
>  long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
>  		       unsigned long bitmap_size);
> -
> +struct siginfo32;
> +int copy_siginfo_from_user32(siginfo_t *to, struct siginfo32 __user *from);
> +int copy_siginfo_to_user32(struct siginfo32 __user *to, siginfo_t *from);

for (some) consistency with the rest of the compat code, these should
probably be

struct compat_siginfo;

int copy_compat_siginfo_from_user(siginfo_t *to,
		struct compat_siginfo __user *from);
int copy_compat_siginfo_to_user(struct compat_siginfo __user *to,
		siginfo_t *from);

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__8_Dec_2004_23_09_19_+1100_9lw2yOKUls+47B5t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBtu7v4CJfqux9a+8RArqFAKCWCRdcNZV3Zopxwi0v21YZTn1I1QCePAP9
rZbVfGgYDWmNAUijl8bbZfs=
=t42o
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Dec_2004_23_09_19_+1100_9lw2yOKUls+47B5t--
