Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVEIS4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVEIS4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 14:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVEIS4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 14:56:13 -0400
Received: from nysv.org ([213.157.66.145]:44440 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261494AbVEISz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 14:55:27 -0400
Date: Mon, 9 May 2005 21:55:12 +0300
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, AndrewMorton <akpm@osdl.org>,
       Carlos Carvalho <carlos@fisica.ufpr.br>
Subject: Re: [ck] Re: [PATCH] implement nice support across physical cpus on SMP
Message-ID: <20050509185512.GC1399@nysv.org>
References: <20050509112446.GZ1399@nysv.org> <200505092147.06384.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9QtXyXGM8HCrXlir"
Content-Disposition: inline
In-Reply-To: <200505092147.06384.kernel@kolivas.org>
User-Agent: Mutt/1.5.6+20040907i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9QtXyXGM8HCrXlir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2005 at 09:47:05PM +1000, Con Kolivas wrote:
>
>Thanks for feedback.

For once I can give something back, it seems; thus it's my pleasure.

>> top - 11:09:24 up 15:30,  2 users,  load average: 4.99, 3.55, 1.63
>>   PID USER      PR  NI  VIRT  SHR S %CPU %MEM    TIME+  #C COMMAND
>>  3917 mjt       25   0  5660  936 R 99.6  0.0   6:11.35  0 load_base.sh
>>  3918 mjt       24   0  5660  936 R 99.6  0.0   6:11.34  3 load_base.sh
>>  3916 mjt       39   0  5660  936 R 65.7  0.0   3:28.95  2 load_base.sh
>>  3919 mjt       39  19  5660  936 R  7.0  0.0   0:23.54  1 load_base.sh
>>  3920 mjt       39  19  5660  936 R  3.0  0.0   0:10.33  2 load_base.sh
>
>These runs don't look absolutely "ideal" as one nice 19 task is bound to c=
pu1=20
>however since you're running hyperthreading it would seem the SMT nice cod=
e=20
>is keeping that under check anyway (0:23 vs 6:11)

So let no one touch the SMT code as long as it works...

>These runs pretty much confirm what I found to happen. My test machine for=
=20
>this was also 4x. I can't see how the code would behave differently on 2x.=
=20

Who on whichever list one is subscribed to or not would care to
replicate these results on 2x and report?

Thank you.

>Perhaps if I make the prio_bias multiplied instead of added to the cpu loa=
d=20
>it will be less affected by SCHED_LOAD_SCALE. The attached patch was=20
>confirmed during testing to also provide smp distribution according to nic=
e=20
>on 4x. Carlos I know your machine is in production so you testing may not =
be=20
>easy for you. Please try this on top if you have time.

I have no idea about SCHED_LOAD_SCALE, I'm afraid, but I will give
this latest patch a run while I'm at it.

The load.sh is the same I posted before

$ ./load.sh 5
top - 19:41:33 up 9 min,  2 users,  load average: 0.40, 0.10, 0.03
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
   =20
 2798 mjt       25   0  5660 1140  936 R 99.9  0.0   0:02.04  2 load_base.s=
h  =20
 2799 mjt       25   0  5660 1140  936 R 99.9  0.0   0:02.04  3 load_base.s=
h  =20
 2797 mjt       25   0  5660 1140  936 R 51.8  0.0   0:01.16  0 load_base.s=
h  =20
 2801 mjt       39  19  5660 1140  936 R  7.0  0.0   0:00.12  1 load_base.s=
h  =20
 2800 mjt       39  19  5660 1140  936 R  3.0  0.0   0:00.05  0 load_base.s=
h  =20

top - 19:42:20 up 10 min,  2 users,  load average: 2.83, 0.78, 0.26
PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND      =
 =20
 2798 mjt       35   0  5660 1140  936 R 99.5  0.0   0:48.55  2 load_base.s=
h  =20
 2799 mjt       35   0  5660 1140  936 R 99.5  0.0   0:48.55  3 load_base.s=
h  =20
 2797 mjt       34   0  5660 1140  936 R 61.7  0.0   0:27.43  0 load_base.s=
h  =20
 2801 mjt       39  19  5660 1140  936 R  6.0  0.0   0:03.11  1 load_base.s=
h  =20
 2800 mjt       39  19  5660 1140  936 R  3.0  0.0   0:01.35  0 load_base.s=
h  =20

top - 19:43:00 up 10 min,  2 users,  load average: 3.88, 1.31, 0.46
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
   =20
 2798 mjt       24   0  5660 1140  936 R 99.9  0.0   1:29.13  2 load_base.s=
h  =20
 2799 mjt       24   0  5660 1140  936 R 99.5  0.0   1:29.12  3 load_base.s=
h  =20
 2797 mjt       24   0  5660 1140  936 R 49.8  0.0   0:50.19  0 load_base.s=
h  =20
 2801 mjt       39  19  5660 1140  936 R  7.0  0.0   0:05.76  1 load_base.s=
h  =20
 2800 mjt       39  19  5660 1140  936 R  3.0  0.0   0:02.48  0 load_base.s=
h  =20

$ ./load.sh 7
top - 19:43:49 up 11 min,  2 users,  load average: 4.98, 1.97, 0.73
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
   =20
 2807 mjt       21   0  5660 1140  936 R 99.9  0.0   0:27.73  0 load_base.s=
h  =20
 2804 mjt       34   0  5660 1140  936 R 99.6  0.0   0:23.46  1 load_base.s=
h  =20
 2808 mjt       20   0  5660 1140  936 R 99.6  0.0   0:25.51  2 load_base.s=
h  =20
 2805 mjt       39   0  5660 1140  936 R 39.8  0.0   0:08.12  3 load_base.s=
h  =20
 2806 mjt       33   0  5660 1140  936 R 37.9  0.0   0:12.46  3 load_base.s=
h  =20
 2788 mjt       20   0  5168 1092  832 R  1.0  0.0   0:00.56  3 top        =
   =20
 2809 mjt       39  19  5660 1140  936 R  1.0  0.0   0:00.41  3 load_base.s=
h  =20
 2810 mjt       39  19  5660 1144  936 R  1.0  0.0   0:00.40  3 load_base.s=
h  =20

top - 19:44:20 up 12 min,  2 users,  load average: 5.78, 2.45, 0.92
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
   =20
 2807 mjt       22   0  5660 1140  936 R 99.9  0.0   0:56.56  0 load_base.s=
h  =20
 2804 mjt       35   0  5660 1140  936 R 99.5  0.0   0:52.29  1 load_base.s=
h  =20
 2808 mjt       21   0  5660 1140  936 R 99.5  0.0   0:54.34  2 load_base.s=
h  =20
 2805 mjt       35   0  5660 1140  936 R 33.8  0.0   0:15.99  3 load_base.s=
h  =20
 2806 mjt       39   0  5660 1140  936 R 21.9  0.0   0:20.22  3 load_base.s=
h  =20
 2788 mjt       20   0  5168 1092  832 R  1.0  0.0   0:00.65  3 top        =
   =20
 2809 mjt       39  19  5660 1140  936 R  1.0  0.0   0:00.80  3 load_base.s=
h  =20
 2810 mjt       39  19  5660 1144  936 R  1.0  0.0   0:00.79  3 load_base.s=
h  =20

top - 19:45:00 up 12 min,  2 users,  load average: 6.37, 3.02, 1.18
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
   =20
 2804 mjt       28   0  5660 1140  936 R 99.9  0.0   1:32.02  1 load_base.s=
h  =20
 2807 mjt       35   0  5660 1140  936 R 99.9  0.0   1:36.29  0 load_base.s=
h  =20
 2808 mjt       33   0  5660 1140  936 R 99.5  0.0   1:34.07  2 load_base.s=
h  =20
 2806 mjt       27   0  5660 1140  936 R 30.9  0.0   0:31.09  3 load_base.s=
h  =20
 2805 mjt       39   0  5660 1140  936 R 24.9  0.0   0:26.81  3 load_base.s=
h  =20
 2809 mjt       39  19  5660 1140  936 R  1.0  0.0   0:01.34  3 load_base.s=
h  =20
 2810 mjt       39  19  5660 1144  936 R  1.0  0.0   0:01.33  3 load_base.s=
h  =20

Then I decided to do something crazier and renice some pids, to see
what happens...

top - 19:45:45 up 13 min,  2 users,  load average: 6.70, 3.58, 1.45
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
   =20
 2807 mjt       37   0  5660 1140  936 R 99.9  0.0   2:21.19  0 load_base.s=
h  =20
 2804 mjt       30   0  5660 1140  936 R 99.5  0.0   2:16.92  1 load_base.s=
h  =20
 2806 mjt       36   0  5660 1140  936 R 41.8  0.0   0:43.73  2 load_base.s=
h  =20
 2805 mjt       39   0  5660 1140  936 R 21.9  0.0   0:39.13  2 load_base.s=
h  =20
 2809 mjt       39  19  5660 1140  936 R  6.0  0.0   0:02.10  3 load_base.s=
h  =20
 2808 mjt       39  10  5660 1140  936 R  2.0  0.0   2:16.01  2 load_base.s=
h  =20
 2810 mjt       39  19  5660 1144  936 R  2.0  0.0   0:01.96  2 load_base.s=
h  =20

top - 19:46:20 up 14 min,  2 users,  load average: 6.83, 3.95, 1.66
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
   =20
 2804 mjt       35   0  5660 1140  936 R 99.6  0.0   2:52.38  1 load_base.s=
h  =20
 2805 mjt       37   0  5660 1140  936 R 99.6  0.0   0:54.29  3 load_base.s=
h  =20
 2807 mjt       21   0  5660 1140  936 R 99.6  0.0   2:56.65  0 load_base.s=
h  =20
 2806 mjt       21   0  5660 1140  936 R 23.9  0.0   0:53.67  2 load_base.s=
h  =20
 2808 mjt       39  10  5660 1140  936 R 21.9  0.0   2:34.49  2 load_base.s=
h  =20
 2809 mjt       39  19  5660 1140  936 R  2.0  0.0   0:02.66  2 load_base.s=
h  =20
 2810 mjt       39  19  5660 1144  936 R  2.0  0.0   0:02.57  2 load_base.s=
h  =20

top - 19:47:00 up 14 min,  2 users,  load average: 6.91, 4.33, 1.88
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
   =20
 2805 mjt       32   0  5660 1140  936 R 99.9  0.0   1:34.05  3 load_base.s=
h  =20
 2807 mjt       37   0  5660 1140  936 R 99.9  0.0   3:36.42  0 load_base.s=
h  =20
 2804 mjt       30   0  5660 1140  936 R 99.6  0.0   3:32.15  1 load_base.s=
h  =20
 2806 mjt       36   0  5660 1140  936 R 40.8  0.0   1:07.04  2 load_base.s=
h  =20
 2808 mjt       39  10  5660 1140  936 R 21.9  0.0   2:41.09  2 load_base.s=
h  =20
 2809 mjt       39  19  5660 1140  936 R  2.0  0.0   0:03.32  2 load_base.s=
h  =20
 2810 mjt       39  19  5660 1144  936 R  1.0  0.0   0:03.23  2 load_base.s=
h  =20

And sudo renice before I call it a day

top - 19:48:27 up 16 min,  2 users,  load average: 7.21, 5.05, 2.34
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
   =20
 2806 mjt       28   0  5660 1140  936 R 99.9  0.0   1:57.55  2 load_base.s=
h  =20
 2807 mjt       27   0  5660 1140  936 R 99.9  0.0   5:00.99  0 load_base.s=
h  =20
 2810 mjt       26 -10  5660 1144  936 R 96.3  0.0   0:05.56  3 load_base.s=
h  =20
 2804 mjt       39   0  5660 1140  936 R 24.8  0.0   4:57.88  1 load_base.s=
h  =20
 2808 mjt       36  10  5660 1140  936 R  9.5  0.0   2:56.90  1 load_base.s=
h  =20
 2805 mjt       39   0  5660 1140  936 R  1.0  0.0   2:29.56  1 load_base.s=
h  =20

top - 19:49:10 up 16 min,  2 users,  load average: 7.65, 5.46, 2.61
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
   =20
 2806 mjt       24   0  5660 1140  936 R 99.9  0.0   2:39.96  2 load_base.s=
h  =20
 2807 mjt       23   0  5660 1140  936 R 99.9  0.0   5:43.40  0 load_base.s=
h  =20
 2810 mjt       26 -10  5660 1144  936 R 99.9  0.0   0:45.87  1 load_base.s=
h  =20
 2805 mjt       39   0  5660 1140  936 R 17.5  0.0   2:36.59  3 load_base.s=
h  =20
 2808 mjt       39  10  5660 1140  936 R  8.7  0.0   2:59.79  3 load_base.s=
h  =20
 2804 mjt       27   0  5660 1140  936 R  7.1  0.0   5:03.47  3 load_base.s=
h  =20

top - 19:49:45 up 17 min,  2 users,  load average: 7.36, 5.63, 2.77
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND    =
   =20
 2806 mjt       31   0  5660 1140  936 R 99.9  0.0   3:15.66  2 load_base.s=
h  =20
 2807 mjt       29   0  5660 1140  936 R 99.9  0.0   6:19.10  0 load_base.s=
h  =20
 2810 mjt       26 -10  5660 1144  936 R 99.9  0.0   1:16.74  3 load_base.s=
h  =20
 2804 mjt       39   0  5660 1140  936 R 17.5  0.0   5:09.32  1 load_base.s=
h  =20
 2805 mjt       39   0  5660 1140  936 R 17.5  0.0   2:45.17  1 load_base.s=
h  =20
 2808 mjt       39  10  5660 1140  936 R  8.7  0.0   3:02.87  1 load_base.s=
h  =20

Seems good enough under this very fabricated stress, hopefully someone
can tell me a good practical application with processes of different
nices going all over the place, so I can try something else.

But these processes are still clinging a bit to cpu 1 here, that's probably
another SMT feature.
Who tests this on SMP without SMT? Anyone? You! Over there!

This box will go into production soon and then I can maybe get some
glimpses of what happens in practice, and that's about it.
And it'll probably run everything with default values, except a light
mysql -5.

Thanks!

--=20
mjt


--9QtXyXGM8HCrXlir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCf7IQIqNMpVm8OhwRAkOwAKDUDZ8dx8yT3cHUWyMoX1qG7Eh++wCdGCY5
pDlaB0sqrInchG0WD1q1EEA=
=RC/i
-----END PGP SIGNATURE-----

--9QtXyXGM8HCrXlir--
