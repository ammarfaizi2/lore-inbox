Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423295AbWF1MAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423295AbWF1MAj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423296AbWF1MAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:00:39 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:11993 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1423295AbWF1MAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:00:38 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: x86_64 restore_image declaration needs asmlinkage?
Date: Wed, 28 Jun 2006 22:00:32 +1000
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Linux-pm mailing list" <linux-pm@lists.osdl.org>,
       suspend2-devel@lists.suspend2.net
References: <200606282048.38746.ncunningham@linuxmail.org> <200606281353.15252.rjw@sisk.pl>
In-Reply-To: <200606281353.15252.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5939733.ATl6dilPFm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606282200.36268.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5939733.ATl6dilPFm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 28 June 2006 21:53, Rafael J. Wysocki wrote:
> Hi,
>
> On Wednesday 28 June 2006 12:48, Nigel Cunningham wrote:
> > I received a report of problems with CONFIG_REGPARM and suspending, that
> > led me to recheck asm calls and declarations. Not being a guru on these
> > things, I want to ask advice from those who know more.
> >
> > Along the way I noticed that current git has:
> >
> > extern asmlinkage int swsusp_arch_suspend(void);
> > extern asmlinkage int swsusp_arch_resume(void);
> >
> > This is right for x86, but for x86_64, we actually call a C routine in
> > arch/x86_64/kernel/suspend.c, which calls restore_image in
> > arch/x86_64/kernel/suspend_asm.S. Restore image is declared in suspend.c
> > as
> >
> > extern int restore_image(void);
> >
> > should it be:
> >
> > extern asmlinkage int restore_image(void);
> >
> > Having swsusp_arch_resume declared as asmlinkage doesn't matter, does i=
t?
>
> No, it doesn't.  It would have mattered on i386 if the function had taken
> any arguments.  AFAICT, on x86_64 it desn't matter at all.

Right. But what about restore_image lacking the asmlinkage? I'm also wonder=
ing=20
if that does matter.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart5939733.ATl6dilPFm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEom9kN0y+n1M3mo0RAjs7AJ4/q/0+9YrDdjrgTuL1VtSkU03bJwCgxIiC
yc9U85V7tJCbdrT4Y3eZtK4=
=EyaI
-----END PGP SIGNATURE-----

--nextPart5939733.ATl6dilPFm--
