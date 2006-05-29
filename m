Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWE2Hnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWE2Hnq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 03:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWE2Hnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 03:43:46 -0400
Received: from pool-72-66-202-199.ronkva.east.verizon.net ([72.66.202.199]:38083
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750751AbWE2Hnq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 03:43:46 -0400
Message-Id: <200605290743.k4T7hT1x000374@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: 4Front Technologies <dev@opensound.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: How to check if kernel sources are installed on a system?
In-Reply-To: Your message of "Mon, 29 May 2006 00:05:12 PDT."
             <447A9D28.9010809@opensound.com>
From: Valdis.Kletnieks@vt.edu
References: <1148653797.3579.18.camel@laptopd505.fenrus.org> <20060528130320.GA10385@osiris.ibm.com> <1148835799.3074.41.camel@laptopd505.fenrus.org> <1148838738.21094.65.camel@mindpipe> <1148839964.3074.52.camel@laptopd505.fenrus.org> <1148846131.27461.14.camel@mindpipe> <20060528224402.A13279@openss7.org> <1148878368.3291.40.camel@laptopd505.fenrus.org> <447A883C.5070604@opensound.com> <1148883077.3291.47.camel@laptopd505.fenrus.org> <20060529005705.C20649@openss7.org>
            <447A9D28.9010809@opensound.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148888608_6867P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 29 May 2006 03:43:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1148888608_6867P
Content-Type: text/plain; charset=us-ascii

On Mon, 29 May 2006 00:05:12 PDT, 4Front Technologies said:
> But regparm requires that ALL parts linked into the module need to have regparm
> defined. So it's another headache to write makefiles for the kernel independant
> part to figure out if the distro support regparm or not.

Not true at all.. Or at least not for the most infamous module out there:

% grep NV_API_CALL *.h | head
nv.h:#if !defined(NV_API_CALL)
nv.h:#define NV_API_CALL __attribute__((regparm(0)))
nv.h:#define NV_API_CALL
nv.h:void*  NV_API_CALL  nv_dma_to_mmap_token         (nv_state_t *, NvU64);
nv.h:void*  NV_API_CALL  nv_alloc_kernel_mapping      (nv_state_t *, NvU64, U032, void **);
nv.h:S032   NV_API_CALL  nv_free_kernel_mapping       (nv_state_t *, void *, void *);
nv.h:NvU64  NV_API_CALL  nv_get_kern_phys_address     (NvU64);
nv.h:NvU64  NV_API_CALL  nv_get_user_phys_address     (NvU64);
nv.h:void*  NV_API_CALL  nv_get_adapter_state         (U016, U016);
nv.h:void   NV_API_CALL  nv_lock_rm                   (nv_state_t *);

So there's routines facing the rest of the kernel - those *do* need to have a
regparm that matches the kernel.  But internal to the module, you can have some
other regparm value - the requirement is only that the prototype needs to have
the same regparm as the function body is actually compiled with.

I seem to remember that parts of the *mainline* kernel use 'asmlinkage'
for similar reasons.... ;)

--==_Exmh_1148888608_6867P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEeqYgcC3lWbTT17ARAtPFAKCoqpcdonij8VXYp7Qh9qVHL2Cc4wCfS8UM
K9WRZtnL4ff9A4Huhkx0d1c=
=WZjP
-----END PGP SIGNATURE-----

--==_Exmh_1148888608_6867P--
