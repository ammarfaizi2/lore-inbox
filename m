Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268701AbUJUMAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268701AbUJUMAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268766AbUJTRVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:21:03 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:52918 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S268752AbUJTRNj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:13:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Add key management syscalls to non-i386 archs
Date: Wed, 20 Oct 2004 19:08:17 +0200
User-Agent: KMail/1.6.2
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, sparclinux@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-m68k@vger.kernel.org,
       linux-sh@m17n.org, linux-arm-kernel@lists.arm.linux.org.uk,
       parisc-linux@parisc-linux.org, linux-ia64@vger.kernel.org,
       linux-390@vm.marist.edu, linux-mips@linux-mips.org
References: <3506.1098283455@redhat.com>
In-Reply-To: <3506.1098283455@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_CupdB4JbrQs2xt2";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410201908.18273.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_CupdB4JbrQs2xt2
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Middeweken 20 Oktober 2004 16:44, David Howells wrote:

> diff -uNrp linux-2.6.9-bk4/arch/s390/kernel/compat_wrapper.S linux-2.6.9-bk4-keys/arch/s390/kernel/compat_wrapper.S
> --- linux-2.6.9-bk4/arch/s390/kernel/compat_wrapper.S	2004-06-18 13:43:49.000000000 +0100
> +++ linux-2.6.9-bk4-keys/arch/s390/kernel/compat_wrapper.S	2004-10-20 15:08:00.071403677 +0100
> @@ -1406,3 +1406,29 @@ compat_sys_mq_getsetattr_wrapper:
>  	llgtr	%r3,%r3			# struct compat_mq_attr *
>  	llgtr	%r4,%r4			# struct compat_mq_attr *
>  	jg	compat_sys_mq_getsetattr
> +
> +	.globl  sys32_add_key_wrapper
> +sys32_add_key_wrapper:
> +	lgfr	%r2,%r2			# const char *
> +	llgfr	%r3,%r3			# const char *
> +	llgfr	%r4,%r4			# const void *
> +	llgfr	%r5,%r5			# size_t
> +	llgfr	%r6,%r6			# key_serial_t
> +	jg	sys_add_key		# branch to system call
> +
> +	.globl  sys32_request_key_wrapper
> +sys32_request_key_wrapper:
> +	lgfr	%r2,%r2			# const char *
> +	llgfr	%r3,%r3			# const char *
> +	llgfr	%r4,%r4			# const char *
> +	llgfr	%r5,%r5			# key_serial_t
> +	jg	sys_request_key		# branch to system call
> +
> +	.globl  sys32_keyctl_wrapper
> +sys32_keyctl_wrapper:
> +	lgfr	%r2,%r2			# int
> +	llgfr	%r3,%r3			# unsigned long
> +	llgfr	%r4,%r4			# unsigned long
> +	llgfr	%r5,%r5			# unsigned long
> +	llgfr	%r6,%r6			# unsigned long
> +	jg	sys_keyctl		# branch to system call

The comments don't match with the code. Please use the correct
lgfr/llgfr/llgtr opcodes for signed/unsigned/pointer extension.
Note that for keyctl_wrapper, the actual conversion is not static
but depends on the value of %r2. You probably want to code that
conversion in C.

	Arnd <><

--Boundary-02=_CupdB4JbrQs2xt2
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBdpuC5t5GS2LDRf4RAoT5AKCYRkFi9fbfnxz10RYNM754yKii4QCeNrKb
FUrUowG0HK9A0oCEiOZIaMA=
=9I0C
-----END PGP SIGNATURE-----

--Boundary-02=_CupdB4JbrQs2xt2--
