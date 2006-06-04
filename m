Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932183AbWFDUjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWFDUjZ (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 16:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWFDUjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 16:39:25 -0400
Received: from pool-72-66-198-190.ronkva.east.verizon.net ([72.66.198.190]:57797
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932183AbWFDUjY (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 16:39:24 -0400
Message-Id: <200606042038.k54KcZFm031888@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Ingo Molnar <mingo@elte.hu>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
        Andrew Morton <akpm@osdl.org>,
        Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
In-Reply-To: Your message of "Sun, 04 Jun 2006 12:41:21 +0200."
             <20060604104121.GA16117@elte.hu>
From: Valdis.Kletnieks@vt.edu
References: <20060603232004.68c4e1e3.akpm@osdl.org> <986ed62e0606040238t712d7b01xde5f4a23da12fb1a@mail.gmail.com> <20060604024937.0fb57258.akpm@osdl.org> <6bffcb0e0606040308j28d9e89axa0136908c5530ae3@mail.gmail.com>
            <20060604104121.GA16117@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149453514_2972P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Jun 2006 16:38:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149453514_2972P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <31870.1149453503.1@turing-police.cc.vt.edu>

On Sun, 04 Jun 2006 12:41:21 +0200, Ingo Molnar said:

> could you please apply the following patches ontop of -mm3:
> 
>   http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm3.patch
>   http://redhat.com/~mingo/lockdep-patches/lockdep-tracer-2.6.17-rc5-mm3.patch

Just for grins, I tried building this, and got this error:

  CC      kernel/irq/handle.o
kernel/irq/handle.c:246:35: error: macro "early_init_irq_lock_type" passed 1 arguments, but takes just 0
kernel/irq/handle.c:247: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
make[2]: *** [kernel/irq/handle.o] Error 1

It won't build if you don't have CONFIG_TRACE_IRQFLAGS defined - and that
is defined like this:

config TRACE_IRQFLAGS
        bool
        default y
        depends on TRACE_IRQFLAGS_SUPPORT
        depends on PROVE_SPIN_LOCKING || PROVE_RW_LOCKING

but my config has:
% grep PROVE .config
# CONFIG_PROVE_SPIN_LOCKING is not set
# CONFIG_PROVE_RW_LOCKING is not set
# CONFIG_PROVE_MUTEX_LOCKING is not set
# CONFIG_PROVE_RWSEM_LOCKING is not set

So using the defaults for the PROVE_* won't compile clean.  Yes, probably
a stupid setting for anybody applying the patches, but.. ;)

(I'm off to go build kernels without the patch, and with the PROVE_* set)..


--==_Exmh_1149453514_2972P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEg0TKcC3lWbTT17ARAqk9AJ9fm+O615nn3O/Wd1zFBYQqSISsqACfUJtX
x6yNI6yVFMjsMF6WPA+A5Ko=
=45Ms
-----END PGP SIGNATURE-----

--==_Exmh_1149453514_2972P--
