Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVFTNui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVFTNui (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 09:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFTNuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 09:50:35 -0400
Received: from [213.69.232.60] ([213.69.232.60]:55314 "HELO ei.schottelius.org")
	by vger.kernel.org with SMTP id S261247AbVFTNuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 09:50:18 -0400
Date: Mon, 20 Jun 2005 15:51:32 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: Writing as init without /dev/console?
Message-ID: <20050620135132.GB2779@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Currently I do not open /dev/console in cinit, but currently
I do see very strange behaviour:

If the first printf() in the following code (from serv/cinit.c) is
enabled, the socket communication will later fail:

----------------------------------------------------------------------
#ifdef DEBUG
//   printf("ARGC=3D%d\n",argc);
#endif

   set_signals(ACT_SERV);  /* set signal handlers */
#ifdef DEBUG
   printf("ARGC=3D%d\n",argc);
#endif
----------------------------------------------------------------------

I don't know what could be the relation between this printf and the
behaviour that cinit-0.1 later hangs in comm/do_result when reading
the resulting byte from a socket.

If you want to see the full code, it can be found at [0].

This code contains serv/cinit.c, which is the same as found
in cinit-0.0.8 [1] and serv/cinit.c-cinit0.1, which is the one
with a bit more debugging and the printf() before set_signals,
which makes cinit hang in comm/do_result at the position when
fpoint() is called.

Perhaps this is an issue with not opening /dev/console? It's just
a guess, because I don't have any idea what could cause this behaviour.

If someone has _any_ idea, I would be very thankful.

Nico

[0]: http://creme.schottelius.org/~nico/pre-release/cLinux/cinit-0.1-rc4.ta=
r.bz2

P.S.: I do read replies to the mailing list via web-interface, replies
      to me must be confirmed otherwise.

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQrbJ47OTBMvCUbrlAQLXnA//We5VknCfDrGo4Je8imeLSXm1pM7f2c51
qWpzPDRuykSEZnxP0LdB0EWl44UYbLWW9y5WtVf64JwTbRduBJ/8Zisp1VBcnues
E16deb9juPFNtV+wSR0avkdXdwvhlEpIgSUKHdvLzlLC08SnOkFYakTjscoWYWK8
5qMfA0v/MPL8ho74DgABwTCjkrr05dIvaZ9edk0snjgu7v6PCHw4voGRjn5/zZH9
TfRnAE3WravOE0GF/NlQfBPoyt0cocGgTPpNxYNXORsRkPwD1TmlUP+LxXUqLS95
c6V2qP4pNLCsP6WcKNwz3rw386qe6VxZDcfeTZJLBEgEES7Kor3FI9AnrxOpOVNL
KdDG3jBAzLt8KcvgyE7ZL/gl62Y8dsyuHW8DdwOcGMAI9lJuuy+an13CE3pgak5c
1VRLCm0a9lzOe0h3lZ4owuLcUQbqGqLDCKDVmMbv4nVhnASx1Ep8BxklPDvYztJ4
7N9tnIsjVZqElHQcxnuNv7Ybg4xpUaluDYU1RBA8LBOX0s0/vLiaSX2PLZC2mXzi
fflpyX4CRUOLyL+d5cSEHUCiRTf3vM7Ljh9vSoceZ4LqjPYU/spIQ67fkRXa4p32
LBVEKEL69sq2wbB99U7juDXBLM7oT/OsFqmLiA/uEVQfw5lduCXPoZNv8QgYsWoT
uEUPU/LiNHY=
=z+EM
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
