Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268419AbUHLB1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268419AbUHLB1Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 21:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbUHLBZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 21:25:55 -0400
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:63934 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268407AbUHKXmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:42:51 -0400
Message-ID: <411AAEDA.9070601@kolivas.org>
Date: Thu, 12 Aug 2004 09:42:18 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler fairness problem on 2.6 series
References: <20040811022143.4892.qmail@web13910.mail.yahoo.com> <cone.1092193795.772385.25569.502@pc.kolivas.org> <4119F3D9.7040708@gmx.de> <411A024B.6060100@kolivas.org> <411A0B71.4030503@gmx.de> <411A71F1.3090504@gmx.de>
In-Reply-To: <411A71F1.3090504@gmx.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6DF8DDF4BC8D83FEE96BD6FC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DF8DDF4BC8D83FEE96BD6FC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Prakash K. Cheemplavam wrote:
> |
> | I don't think it is the overhead. I rather think the way the kernel
> | schedulers gives mpich and the cpu bound program  resources is unfair.
> 
> Well, I don't know whether it helps, but I ran a profiler and these are
> the functions which cause so much wasted CPU cycles when running 16
> processes of my example with mpich:
> 
> 124910    9.8170  vmlinux                  tcp_poll
> 123356    9.6949  vmlinux                  sys_select
> 85634     6.7302  vmlinux                  do_select
> 71858     5.6475  vmlinux                  sysenter_past_esp
> 62093     4.8801  vmlinux                  kfree
> 51658     4.0600  vmlinux                  __copy_to_user_ll
> 37495     2.9468  vmlinux                  max_select_fd
> 36949     2.9039  vmlinux                  __kmalloc
> 22700     1.7841  vmlinux                  __copy_from_user_ll
> 14587     1.1464  vmlinux                  do_gettimeofday
> 
> Is anything scheduler related?

No

It looks like your select timeouts are too short and when the cpu load 
goes up they repeatedly timeout wasting cpu cycles.
I quote from `man select_tut` under the section SELECT LAW:

1. You should always try use select without a timeout. Your program
  should have nothing to do if there is no  data  available.  Code
  that  depends  on timeouts is not usually portable and difficult
  to debug.

Cheers,
Con

--------------enig6DF8DDF4BC8D83FEE96BD6FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGq7cZUg7+tp6mRURAuH1AJ9dz8ONSdg9XsB31KOzMFeFyQJnQwCffQVf
tYLPQK1+uovX9ux/3961TfQ=
=Qohq
-----END PGP SIGNATURE-----

--------------enig6DF8DDF4BC8D83FEE96BD6FC--
