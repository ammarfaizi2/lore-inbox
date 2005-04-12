Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVDLROM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVDLROM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVDLRNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 13:13:06 -0400
Received: from smtp3.actcom.co.il ([192.114.47.65]:13484 "EHLO
	smtp3.actcom.co.il") by vger.kernel.org with ESMTP id S262506AbVDLRLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:11:03 -0400
Date: Tue, 12 Apr 2005 20:02:30 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: ak@muc.de, ak@suse.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 072/198] x86_64: Use a VMA for the 32bit vsyscall
Message-ID: <20050412170230.GD2758@granada.merseine.nu>
References: <200504121031.j3CAVnpl005415@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Content-Disposition: inline
In-Reply-To: <200504121031.j3CAVnpl005415@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2005 at 03:31:43AM -0700, akpm@osdl.org wrote:

> From: Andi Kleen <ak@muc.de>
>=20
> Use a real VMA to map the 32bit vsyscall page

[...]

> +/* Setup a VMA at program startup for the vsyscall page */
> +int syscall32_setup_pages(struct linux_binprm *bprm, int exstack)
> +{
> +	int npages =3D (VSYSCALL32_END - VSYSCALL32_BASE) >> PAGE_SHIFT;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm =3D current->mm;
> +
> +	vma =3D kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
> +	if (!vma)
> +		return -ENOMEM;
> +	if (security_vm_enough_memory(npages)) {
> +		kmem_cache_free(vm_area_cachep, vma);
> +		return -ENOMEM;
> +	}
> +
> +	memset(vma, 0, sizeof(struct vm_area_struct));
> +	/* Could randomize here */
> +	vma->vm_start =3D VSYSCALL32_BASE;
> +	vma->vm_end =3D VSYSCALL32_END;
> +	/* MAYWRITE to allow gdb to COW and set breakpoints */
> +	vma->vm_flags =3D VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC|VM_MAYEXEC|VM_M=
AYWRITE;

Any reason for VM_MAYEXEC to be specified twice? did you mean something els=
e?

Cheers,
Muli
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCW/8mKRs727/VN8sRAo+uAJ94O+WbTb7+lw8/0e1PdBEaXxepvgCfSlox
hiMqRxnyCgRIo6FDqF03MqQ=
=51pB
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
