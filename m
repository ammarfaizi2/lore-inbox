Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268315AbUI2Lmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268315AbUI2Lmq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 07:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268313AbUI2Lmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 07:42:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22179 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268315AbUI2Lmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 07:42:43 -0400
Subject: Re: [PATCH] gdth update
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Achim_Leubner@adaptec.com
In-Reply-To: <200409281401.i8SE1dXL006887@hera.kernel.org>
References: <200409281401.i8SE1dXL006887@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ng2ky2JaJaflW6VM+QnK"
Organization: Red Hat UK
Message-Id: <1096458159.2786.28.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 13:42:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ng2ky2JaJaflW6VM+QnK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-28 at 13:12, Linux Kernel Mailing List wrote:
>   * IO-mapping with virt_to_bus(), gdth_readb(), gdth_writeb(), ...
> - * register_reboot_notifier() to get a notify on shutdown used
> + * register_reboot_notifier() to get a notify on shutown used

why this change ?

> +#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0)
> +static irqreturn_t gdth_interrupt(int irq, void *dev_id, struct pt_regs =
*regs);
>  #else
> -static void gdth_interrupt(int irq,struct pt_regs *regs);
> +static void gdth_interrupt(int irq, void *dev_id, struct pt_regs *regs);
>  #endif

this really is the wrong way to do such irq prototype compatibility in
drivers. *really*


> +static struct file_operations gdth_fops =3D {
> +#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,0)
> +    .ioctl   =3D gdth_ioctl,
> +    .open    =3D gdth_open,
> +    .release =3D gdth_close,
> +#else
> +    ioctl:gdth_ioctl,
> +    open:gdth_open,
> +    release:gdth_close,
> +#endif

C99 initializers work in all kernel versions since it's a property of
the C compiler not of the kernel. I wonder why you are putting this
ifdef here....

the rest of your ifdefs are generally quite fishy too unfortionately...=20

--=-ng2ky2JaJaflW6VM+QnK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBWp+vxULwo51rQBIRAnkXAKCj24toytvsVLUeOSU9T42u8GBQWwCbBTa/
+6Md9NFHeNeEoOjkhEgm8Qw=
=h8sC
-----END PGP SIGNATURE-----

--=-ng2ky2JaJaflW6VM+QnK--

