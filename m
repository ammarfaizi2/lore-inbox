Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317639AbSHUBZn>; Tue, 20 Aug 2002 21:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317641AbSHUBZm>; Tue, 20 Aug 2002 21:25:42 -0400
Received: from ppp-217-133-223-78.dialup.tiscali.it ([217.133.223.78]:16845
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317639AbSHUBZm>; Tue, 20 Aug 2002 21:25:42 -0400
Subject: Re: [PATCH] (re-xmit): kprobes for i386
From: Luca Barbieri <ldb@ldb.ods.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       "Vamsi Krishna S ." <vamsi@in.ibm.com>
In-Reply-To: <20020820200453.407422C066@lists.samba.org>
References: <20020820200453.407422C066@lists.samba.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-UkzkmpwPZ3tahG697mpi"
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 Aug 2002 03:29:37 +0200
Message-Id: <1029893377.24300.162.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UkzkmpwPZ3tahG697mpi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > > +	if (kprobe_running() && kprobe_fault_handler(regs, trapnr))
> > > +		return;
> > >  	if (!(regs->xcs & 3))
> > >  		goto kernel_trap;
> > The kprobe check should be after the kernel_trap label.
> 
> No.  The entire *point* of being able to register a kprobe fault
> handler is to be able to handle any kernel faults yourself if you want
> to.
It seems you have misunderstood my point.
My idea is that since kprobes are only used for kernel mode address, we
should move the kprobe check in the code that executes after we check
that the fault is happening in kernel mode.

Soemthing like this:
if (!(regs->xcs & 3))
	goto kernel_trap;

[...]

kernel_trap:
	if (kprobe_running() && kprobe_fault_handler(regs, trapnr))
		return;


--=-UkzkmpwPZ3tahG697mpi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9Yu0Adjkty3ft5+cRAlKhAKDeY7nJ28T4fODsp9Hd4JHMRAGyCgCgt7Fo
jxlHSUHGxFC/PPBfk0cSk7s=
=oyti
-----END PGP SIGNATURE-----

--=-UkzkmpwPZ3tahG697mpi--
