Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264886AbUFAFGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264886AbUFAFGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 01:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUFAFGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 01:06:52 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:10707 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S264886AbUFAFGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 01:06:48 -0400
Date: Tue, 1 Jun 2004 15:06:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@redhat.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: compat syscall args
Message-Id: <20040601150633.5f708220.sfr@canb.auug.org.au>
In-Reply-To: <20040529122319.49eaafe1.davem@redhat.com>
References: <20040529122319.49eaafe1.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__1_Jun_2004_15_06_33_+1000_LUdQ3kkFykjJQvk6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__1_Jun_2004_15_06_33_+1000_LUdQ3kkFykjJQvk6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Dave,

On Sat, 29 May 2004 12:23:19 -0700 "David S. Miller" <davem@redhat.com> wrote:
>
> 
> Arnd asked:
> 
> > If sparc64 has this problem only for the fifth syscall argument, 
> > does that mean that e.g. compat_sys_futex and 
> > compat_sys_mq_timed{send,receive} have the same bug? If this is
> > a more general, i.e. not limited to the last argument, there is a
> > potential problem in lots of syscalls.
> 
> Here is the issue.  In the sparc64 C calling conventions, it is
> assumed that 32-bit signed values are sign extended by the
> caller.
> 
> This means that, at syscall invocation time, we have to choose
> between either:
> 
> 1) sign extending all syscall args for the C code, then explicitly
>    zero-extending all non-signed syscall args.  This would require
>    the most amount of compat layer code help.
> 
> 2) zero extending all syscall args for the C code, then expliticly
>    sign-extending all signed syscall args.
> 
> 3) some mixture of 1 and 2
> 
> #3 is what sparc64 does, it hits the highest number of system
> call arguments correctly.  Specifically we:
> 
> arg0: zero-extend
> arg1: zero-extend
> arg2: zero-extend
> arg3: zero-extend
> arg4: leave as-is
> arg5: leave as-is
> 
> I remember discussing this with Andi Kleen before.

Yeah, you and Andi and I (and others, I think) had this discussion, but it ended like this:

--------------------
Date: Thu, 13 Jun 2002 22:56:52 -0700 (PDT)
Message-Id: <20020613.225652.109741623.davem@redhat.com>
To: ak@suse.de
Cc: sfr@canb.auug.org.au, ralf@gnu.org, engebret@us.ibm.com,
   schwidefsky@de.ibm.com, linux390@de.ibm.com, anton@samba.org
Subject: Re: [PATCH] Consolidate sys32_utime
From: "David S. Miller" <davem@redhat.com>

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 14 Jun 2002 07:53:10 +0200

   On Thu, Jun 13, 2002 at 10:37:23PM -0700, David S. Miller wrote:
   > We could easily change that to "all args zero-extended" if that makes
   > everything easier.  It probably does.
   
   I've had good experiences with zero extension at least so far.
   Would be probably good just for consistency.

So be it, the convention is that all arguments are zero extended from
32-bits to 64-bits when the syscall is invoked.
----------------------------------------------------------------------

Did something change along the way?
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__1_Jun_2004_15_06_33_+1000_LUdQ3kkFykjJQvk6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAvA7dFG47PeJeR58RAuy3AKC+MHvH/OB2z1/Uom5d4hDfjOQx5gCfT/aw
K+iMB8dAHkR81WmmnYTJQEA=
=CLGU
-----END PGP SIGNATURE-----

--Signature=_Tue__1_Jun_2004_15_06_33_+1000_LUdQ3kkFykjJQvk6--
