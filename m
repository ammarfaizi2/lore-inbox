Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263035AbVHEOYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbVHEOYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbVHEOYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:24:08 -0400
Received: from pop.gmx.de ([213.165.64.20]:12009 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263035AbVHEOYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:24:07 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] preempt-trace.patch (mono preempt-trace)
Date: Fri, 5 Aug 2005 16:26:52 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050607042931.23f8f8e0.akpm@osdl.org> <20050804152858.2ef2d72b.akpm@osdl.org> <20050805104819.GA20278@elte.hu>
In-Reply-To: <20050805104819.GA20278@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2091281.a8LivTAiUo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508051626.56910.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2091281.a8LivTAiUo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 05 August 2005 12:48, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> > I think Ingo was planning on coming up with some infrastructure which
> > would allow us to debug this further.
>
> yeah. I've done this today and have split it out of the -RT tree, see
> the patch below. After some exposure in -mm i'd like this feature to go
> upstream too.
>
> the patch is against recent Linus trees, 2.6.13-rc4 or later should all
> work. Dominik, could you try it and send us the new kernel logs whenever
> you happen to hit that warning message again? (Please also enable
> CONFIG_KALLSYMS_ALL, so that we get as much symbolic data as possible.)

Here's a preempt trace output from mono. To compile preempt-trace.patch I=20
remove the traps.c patch and added u32 definition for out_count in handle.c=
=2E=20
After those changes, the kernel compiled fine.

Now here's the output, let me know if it is ok, or if you can make any reve=
als=20
where the bug is located.

BUG: mono[10011] exited with nonzero preempt_count 1!
=2D--------------------------
| preempt count: 00000001 ]
| 1 level deep critical section nesting:
=2D---------------------------------------
=2E. [<ffffffff803f791e>] .... _spin_lock+0xe/0x70
=2E....[<0000000000000000>] ..   ( <=3D 0x0)

If there is anything I should test, let me know!

dominik

--nextPart2091281.a8LivTAiUo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQvN3MAvcoSHvsHMnAQJg0AP9GXOzJNdignzBXQCxUw6v03zEc8egllhC
e2NzNz1FaBt/2m0zNl8SLeLrLe6yhatZJjhz5rOmGVxOEx/dJMrVJgPwYlmiMm6b
Uz9GKDgofgpwKqZl/firz7lWEAqO+T8k3quUxqmHSSPiGfyouVFdYwQE6y3FTuTs
yh0dBCrSRhs=
=236I
-----END PGP SIGNATURE-----

--nextPart2091281.a8LivTAiUo--
