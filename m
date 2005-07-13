Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVGMX7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVGMX7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVGMX46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 19:56:58 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:39067 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261804AbVGMXzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 19:55:45 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Date: Thu, 14 Jul 2005 09:54:51 +1000
User-Agent: KMail/1.8.1
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       christoph@lameter.com
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2780014.8CMe5b2oIU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507140954.54444.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2780014.8CMe5b2oIU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 14 Jul 2005 05:10, Linus Torvalds wrote:
> On Wed, 13 Jul 2005, Vojtech Pavlik wrote:
> > No, but 1/1000Hz =3D 1000000ns, while 1/864Hz =3D 1157407.407ns. If you=
 have
> > a counter that counts the ticks in nanoseconds (xtime ...), the first
> > will be exact, the second will be accumulating an error.
>
> It's not even that we have a counter like that, it's the simple fact that
> we have a standard interface to user space that is based on milli-, micro-
> and nanoseconds.
>
> (For "poll()", "struct timeval" and "struct timespec" respectively).
>
> It's totally pointless saying that we can do 864 Hz "exactly", when the
> fact is that all the timeouts we ever get from user space aren't in that
> format. So the only thing that matters is how close to a millisecond we
> can get, not how close to some random number.

That may be the case but when I've measured the actual delay of schedule=20
timeout when using nanosleep from userspace, the average at 1000Hz was 1.4m=
s=20
+/- 1.5 sd . When we're expecting a sleep of "up to 1ms" we're getting 50%=
=20
longer than the longest expected. Purely mathematically the accuracy of=20
changing HZ from 1000 -> 864 will not bring with it any significant change =
to=20
the accuracy. This can easily be measured as well to confirm.=20

Using schedule timeout as an argument against it doesn't hold for me.=20
Vojtech's comment of :
> "No, but 1/1000Hz =3D 1000000ns, while 1/864Hz =3D 1157407.407ns. If you =
have a=20
> counter that counts the ticks in nanoseconds (xtime ...), the first will =
be=20
> exact, the second will be accumulating an error."=20
is probably the most valid argument against such a funky number.=20

Cheers,
Con

--nextPart2780014.8CMe5b2oIU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC1anOZUg7+tp6mRURAtONAJ452bI76wL8pFacy6cgyEt+BUcJYACggWMN
mHtUnXMVo15eyIg/81zFM3A=
=FQrD
-----END PGP SIGNATURE-----

--nextPart2780014.8CMe5b2oIU--
