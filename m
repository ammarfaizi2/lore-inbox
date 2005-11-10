Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVKJJiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVKJJiK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 04:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVKJJiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 04:38:10 -0500
Received: from smtp04.auna.com ([62.81.186.14]:64439 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S1750726AbVKJJiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 04:38:08 -0500
Date: Thu, 10 Nov 2005 10:37:26 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Neil Brown <neilb@suse.de>
Cc: Chris Boot <bootc@bootc.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-mm1 RAID-1 in D< state
Message-ID: <20051110103726.35e54d65@werewolf.auna.net>
In-Reply-To: <17266.56637.123797.468396@cse.unsw.edu.au>
References: <4371FA5B.6030900@bootc.net>
	<17266.30440.930561.902428@cse.unsw.edu.au>
	<3356B173-1C22-4C46-8CC4-1A08C303C63D@bootc.net>
	<17266.56637.123797.468396@cse.unsw.edu.au>
X-Mailer: Sylpheed-Claws 1.9.100cvs5 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_AemMN+ItUJs/NO1y.x7xHX.";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.218.199] Login:jamagallon@able.es Fecha:Thu, 10 Nov 2005 10:38:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_AemMN+ItUJs/NO1y.x7xHX.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Nov 2005 16:40:13 +1100, Neil Brown <neilb@suse.de> wrote:

>=20
> Thanks for the trace.  I see what is happening.
> I changed
>   wait_event_timeout_interruptible=20
> in md.c(md_thread) to
>   wait_event_timeout
>=20
> as the thread no longer needs to be able to respond the signals.
> However that has the side-effect of putting the process in the 'D'
> state and adding to the 'uptime'.
>=20
> I guess I'll put that back...
>=20
> NeilBrown
>=20
>=20
> Signed-off-by: Neil Brown <neilb@suse.de>
>=20
> ### Diffstat output
>  ./drivers/md/md.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff ./drivers/md/md.c~current~ ./drivers/md/md.c
> --- ./drivers/md/md.c~current~	2005-11-10 16:39:04.000000000 +1100
> +++ ./drivers/md/md.c	2005-11-10 16:39:28.000000000 +1100
> @@ -3439,10 +3439,11 @@ static int md_thread(void * arg)
>  	allow_signal(SIGKILL);
>  	while (!kthread_should_stop()) {
> =20
> -		wait_event_timeout(thread->wqueue,
> -				   test_bit(THREAD_WAKEUP, &thread->flags)
> -				   || kthread_should_stop(),
> -				   thread->timeout);
> +		wait_event_timeout_interruptible
> +			(thread->wqueue,
> +			 test_bit(THREAD_WAKEUP, &thread->flags)
> +			 || kthread_should_stop(),
> +			 thread->timeout);
>  		try_to_freeze();
> =20
>  		clear_bit(THREAD_WAKEUP, &thread->flags);

s/wait_event_timeout_interruptible/wait_event_interruptible_timeout/

;)

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam1 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_AemMN+ItUJs/NO1y.x7xHX.
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDcxTWRlIHNEGnKMMRAtKIAKCkqDET0RuFgfeYHrle+IsJoXYl+ACeJjF6
hn3Bxm4OIxI3A6wv2ZT5vJA=
=DwXz
-----END PGP SIGNATURE-----

--Sig_AemMN+ItUJs/NO1y.x7xHX.--
