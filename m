Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUCPLgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 06:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUCPLgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 06:36:23 -0500
Received: from ns.suse.de ([195.135.220.2]:6047 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261417AbUCPLgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 06:36:17 -0500
Date: Tue, 16 Mar 2004 12:36:15 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: dynamic sched timeslices
Message-ID: <20040316113615.GK4452@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andrew Morton <akpm@osdl.org>, hch@infradead.org,
	linux-kernel@vger.kernel.org
References: <20040315224201.GX4452@tpkurt.garloff.de> <20040315225939.A23686@infradead.org> <20040315230950.GB4452@tpkurt.garloff.de> <20040315154042.40c58c5b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+Y6HH/CKFMvGZLq9"
Content-Disposition: inline
In-Reply-To: <20040315154042.40c58c5b.akpm@osdl.org>
X-Operating-System: Linux 2.6.4-1-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+Y6HH/CKFMvGZLq9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Mar 15, 2004 at 03:40:42PM -0800, Andrew Morton wrote:
> Kurt Garloff <garloff@suse.de> wrote:
> Your patch didn't come with any subjective or measured testing results.=
=20

We've done some measurements with 2.4 and O(1):
* HZ=3D1000 cost about 1.5% perf. on a kernel compile (plus problems
  with lost timer ticks)
* Seting the scheduling timeslices from 1ms--30ms rather than 10ms thr
  300ms cost another ~3% kernel compile performance
* Depending on the workload the effect can be larger. Numbercrunching
  would come to mind.
* Some people are unhappy that nice is not nice enough.

> In
> theory, the scheduler should magically tune itself to the current workloa=
d.

No, the computer can not take the decision whether a machine is sitting
in a machine room and mainly doing batch processing or whether it's used
by somebody sitting in front of it as workstation.

You can add heuristics and look at the load and sleep_avg of processes,
and scale timeslices dynamically, but these heuristics are IMVHO a very=20
bad idea. They tend to break in subtle ways and disallow to reproduce
benchmark numbers etc.

I do know that the priorites do ensure that interactive processes have
some bonus, so even with long timeslices a system should be usable.
But heuristics fail and some situtaions with high load just can't be=20
solved by such bonuses.

> If your patch is indeed necessary then this may point at a bug in the
> current CPU scheduler.

No, why should it? How should the computer know what the user wants if
he has no way to tell him?

It's a classical throughput vs. latency tradeoff and the patch allows
the user to set it. I'm sure some people are willing to have long
timeslices in order to gain 5% and don't care about the sched latencies.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--+Y6HH/CKFMvGZLq9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAVuavxmLh6hyYd04RAohyAJ91BrjIz+xy/z9JmOjKCUxCWYgNjwCgrXvX
vdjQoQB5xpwNYq61/7128MQ=
=KuB+
-----END PGP SIGNATURE-----

--+Y6HH/CKFMvGZLq9--
