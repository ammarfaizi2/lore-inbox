Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132111AbRDDUJk>; Wed, 4 Apr 2001 16:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132118AbRDDUJb>; Wed, 4 Apr 2001 16:09:31 -0400
Received: from rm05-24-167-185-21.ce.mediaone.net ([24.167.185.21]:28637 "EHLO
	calvin.localdomain") by vger.kernel.org with ESMTP
	id <S132111AbRDDUJU>; Wed, 4 Apr 2001 16:09:20 -0400
Date: Wed, 4 Apr 2001 15:08:33 -0500
From: Tim Walberg <tewalberg@mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel/sched.c questions
Message-ID: <20010404150833.C28474@mediaone.net>
Reply-To: Tim Walberg <tewalberg@mediaone.net>
Mail-Followup-To: Tim Walberg <tewalberg@mediaone.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA028416D@MAINSERVER>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: =?iso-8859-1?Q?=3CA0C675E9DC2CD411A5870040053AEBA028416D=40MAINSERVER=3E?=
 =?iso-8859-1?Q?_from_Sarda=F1ons=2C_Eliel_on_04=2F04=2F2001_14:52?=
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04/04/2001 16:52 -0300, Sarda=F1ons, Eliel wrote:
>>	Hello, I would like to know why you put this two functions:
>>	void scheduling_functions_start_here(void) { }
>>	...
>>	void scheduling_functions_end_here(void) { }
>>=09

That one I have no idea about - maybe some perverse sort
of comment? Or maybe something somewhere needs to know the
address range that some functions lie within, and these functions
would delimit that range. Of course, that presumes that the
compiler in use doesn't reorder functions in the object code
that emits, but I think that's a fairly safe assumption for
now...

>>	why you put 'case TASK_RUNNING'
>>=09
>>	switch (prev->state) {
>>	                case TASK_INTERRUPTIBLE:
>>	                        if (signal_pending(prev)) {
>>	                                prev->state =3D TASK_RUNNING;
>>	                                break;
>>	                        }
>>	                default:
>>	                        del_from_runqueue(prev);
>>	                case TASK_RUNNING:
>>	}
>>=09


This just indicates that there is nothing to be done for the
TASK_RUNNING case - if it were left out, the default case would
be taken. Of course, a 'case TASK_RUNNING: break;' placed earlier
in the switch construct would be semantically the same, but there
may be reasons related to code optimization that this was done the
way it was.

>>	and the last one:
>>=09
>>	in the function schedule() you always use this syntax:
>>=09
>>	-----
>>	if (a_condition)
>>	    goto bebe;
>>	bebe_back
>>=09
>>=09
>>	bebe:
>>	    do_bebe();
>>	    goto bebe_back;
>>	------
>>	why not just doing:
>>	  =20
>>	   if (a_condition)
>>	         do_bebe();
>>=09
>>=09
>>	I know that goto's are better but finaly you are jumping to a function a=
nd
>>	then calling the function. I think you can improve performance doing thi=
s.


This looks like a hand-optimization to avoid a branch in the most common
case. Chances are a_condition is supposed to be pretty rare, and the code
you suggest would usually include a branch for the usual code path, then.


			tw


--=20
+--------------------------+------------------------------+
| Tim Walberg              | tewalberg@mediaone.net       |
| 828 Marshall Ct.         | www.concentric.net/~twalberg |
| Palatine, IL 60074       |                              |
+--------------------------+------------------------------+

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBOst/P8PlnI9tqyVmEQLPqwCg8ugIPWfbXBapw+5dVCmK2OkmNNgAoM2O
TTax94T0EEazhVvS5la8ocj8
=Iy8H
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
