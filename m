Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWCKFIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWCKFIc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 00:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWCKFIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 00:08:32 -0500
Received: from mx1.mm.pl ([217.172.224.151]:9166 "EHLO mx1.mm.pl")
	by vger.kernel.org with ESMTP id S1750987AbWCKFIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 00:08:32 -0500
From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: [PATCH] mm: Implement swap prefetching tweaks
Date: Sat, 11 Mar 2006 06:04:56 +0100
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200603102054.20077.kernel@kolivas.org> <4412079C.5000200@bigpond.net.au> <200603111518.46474.kernel@kolivas.org>
In-Reply-To: <200603111518.46474.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1672411.fA6VGTd1lx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603110605.03046.astralstorm@gorzow.mm.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1672411.fA6VGTd1lx
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 11 March 2006 05:18, Con Kolivas wrote yet:
> On Saturday 11 March 2006 10:11, Peter Williams wrote:
> > Andrew Morton wrote:
> > > Con Kolivas <kernel@kolivas.org> wrote:
> > >>	 * We also test if we're the only
> > >>+	 * task running anywhere. We want to have as little impact on all
> > >>+	 * resources (cpu, disk, bus etc). As this iterates over every cpu
> > >>+	 * we measure this infrequently.
> > >>+	 */
> > >>+	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
> > >>+		unsigned long cpuload =3D nr_running();
> > >>+
> > >>+		if (cpuload > 1)
> > >>+			goto out;
> > >
> > > Sorry, this is just wrong.  If swap prefetch is useful then it's also
> > > useful if some task happens to be sitting over in the corner
> > > calculating pi.
> >
> > On SMP systems, something based on the run queues' raw_weighted_load
> > fields (comes with smpnice patch) might be more useful than nr_running()
> > as it contains information about the priority of the running tasks.
> > Perhaps (raw_weighted_load() > SCHED_LOAD_SCALE) or some variation,
> > where raw_weighted_load() is the sum of that field for all CPUs) would
> > suffice.  It would mean "there's more than the equivalent of one nice=
=3D=3D0
> > task running" and shouldn't be any more expensive than nr_running().
> > Dividing SCHED_LOAD_SCALE by some number would be an obvious variation
> > to try as would taking into account this process's contribution to the
> > weighted load.
> >
> > Also if this was useful there's no real reason that raw_weighted_load
> > couldn't be made available on non SMP systems as well as SMP ones.
>
> That does seem reasonable, but I'm looking at total system load, not per
> runqueue. So a global_weighted_load() function would be required to return
> that. Because despite what anyone seems to want to believe, reading from
> disk hurts. Why it hurts so much I'm not really sure, but it's not a SCSI
> vs IDE with or without DMA issue. It's not about tweaking parameters. It
> doesn't seem to be only about cpu cycles. This is not a mistuned system
> that it happens on. It just plain hurts if we do lots of disk i/o, perhaps
> it's saturating the bus or something. Whatever it is, as much as I'd _lik=
e_
> swap prefetch to just keep working quietly at ultra ultra low priority, t=
he
> disk reads that swap prefetch does are not innocuous so I really do want
> them to only be done when nothing else wants cpu.

Wouldn't the change break prefetching if I have 98% CPU time free and not=20
100%? Something like an audio player in the background?

It seems that any Seti@home type of calculation would kill it.
In reality, we don't want disk reads when something interactive is running,=
 so=20
maybe you'd look at the nice level of the task?
(higher than x =3D don't count it?)

=2D-=20
GPG Key id:  0xD1F10BA2
=46ingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm

--nextPart1672411.fA6VGTd1lx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEElp/lUMEU9HxC6IRAqcWAJ0dIw/7KwJG9Pr7FbtCt1YWL1MvFQCgg0EB
tVknpnBfRuCvJjV8MObyz50=
=h5Vs
-----END PGP SIGNATURE-----

--nextPart1672411.fA6VGTd1lx--
