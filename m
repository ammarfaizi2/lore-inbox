Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263171AbVHEUqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbVHEUqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVHEUqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:46:18 -0400
Received: from pop.gmx.de ([213.165.64.20]:35562 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263171AbVHEUqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:46:10 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] preempt-trace.patch (mono preempt-trace)
Date: Fri, 5 Aug 2005 22:48:50 +0200
User-Agent: KMail/1.8.2
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20050607042931.23f8f8e0.akpm@osdl.org> <200508052123.49640.dominik.karall@gmx.net> <20050805200448.GA25002@elte.hu>
In-Reply-To: <20050805200448.GA25002@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1518776.ekuE4aFjTP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508052248.56335.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1518776.ekuE4aFjTP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 05 August 2005 22:04, Ingo Molnar wrote:
> * Dominik Karall <dominik.karall@gmx.net> wrote:
> > With FRAME_POINTERS enabled:
> >
> > BUG: mono[3193] exited with nonzero preempt_count 1!
> > ---------------------------
> >
> > | preempt count: 00000001 ]
> > | 1 level deep critical section nesting:
> >
> > ----------------------------------------
> > .. [<ffffffff80400a46>] .... _spin_lock+0x16/0x80
> > .....[<ffffffff801ed30c>] ..   ( <= sys_semtimedop+0x28c/0x7c0)
>
> thanks. It seems semundo->lock somehow leaked. One possibility would be
> of semundo->refcount going from 2 to 1 while another thread has it
> locked. I dont see what prevents this scenario from happening. To test
> this theory, could you apply the patch below, which will do semundo
> locking not conditional on the refcount - does it fix the bug?

yeah! it works, great job! :)

dominik

--nextPart1518776.ekuE4aFjTP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQvPQuAvcoSHvsHMnAQI8SQP+PAw7Fjju96li69uFAafoa1OdRdgumVL9
dTxL0YSAuDnuzc++5l06d0uZ8J5pQWgSYjWOU3jLlSimufEbaBhjp4LrE4/uxChV
HuPfE8HW7h3ybw7ce75mcq/tWOVePURlaR1k1hoxbSa+ruajEUXhtEpqGsR0dbpH
RopY6egZfXc=
=0iOA
-----END PGP SIGNATURE-----

--nextPart1518776.ekuE4aFjTP--
