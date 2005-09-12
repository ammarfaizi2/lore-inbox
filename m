Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVILR1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVILR1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVILR1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:27:38 -0400
Received: from tomts36.bellnexxia.net ([209.226.175.93]:7366 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932102AbVILR1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:27:38 -0400
Date: Mon, 12 Sep 2005 13:27:27 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: george@mvista.com, johnstul@us.ibm.com
Cc: linux-kernel@vger.kernel.org, michel.dagenais@polymtl.ca
Subject: [patch] i386 and x86_64 TSC set_cyc2ns_scale imprecision
Message-ID: <20050912172727.GA30644@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.31-grsec (i686)
X-Uptime: 12:56:33 up 8 days, 9 min,  3 users,  load average: 0.16, 0.08, 0.05
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I just found out that some precision is unnecessarily lost in the
arch/i386/kernel/timers/timer_tsc.c:set_cyc2ns_scale function. It uses a
cpu_mhz parameter when it could use a cpu_khz. In the specific case of an I=
ntel
P4 running at 3001.171 Mhz, the truncation to 3001 Mhz leads to an imprecis=
ion
of 19 microseconds per second : this is very sad for a timer with nearly
nanosecond accuracy.

The patch for 2.6.13.1 is attached. It patches the x86_64 architecture too.
Please look at the patch for further comments.


Mathieu Desnoyers
Master Student in Computer Engineering
=C9cole Polytechnique de Montr=E9al

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
=2Egpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--9amGYk9869ThD9tj
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="set_cyc2ns_scale_cpu_khz_parameter.diff.gz"
Content-Transfer-Encoding: base64

H4sICLq5JUMAA3NldF9jeWMybnNfc2NhbGVfY3B1X2toel9wYXJhbWV0ZXIuZGlmZgDtVmtP
40YU/ez8irugRTGJHdt5bBKWKihd2kos0A1VValay9jjeBpnbDxjIFvx33uv7bABEmCpqrYS
iGQc+z7OfR4HPAzByLNjiLnIrw3H7Jl227RbXuZHLd7u91ozlgkWtxSfs0yWhxulTJn+PR1j
HjxLrWYYxkvcaY5ldQ1rgP/gOMOOM+z2TWv5B4bVsaxao9F4Iaxb87YDdntoDYaW/cD8aARG
22o6bWjQ0YfRqAawC3DuSe4Du8g9xRMxpJuaJiTsg7/wYyahBfUwYxd4Cumm6FUyX38otgv1
r89RmHT0mrFGzLY+D8iqn+buPPqCt/BOT98o3EbhSlavNZ4wOFsabOsbhXuVwRkZxECKYM4i
JuCKQS4ZSN/DUkxh7qkI6jKfTplULIDzBUxZkk3ZaH7JpfJMP5nroBK8q4ab4e/CZLwSA15O
xpuxrUjPbqXXpBsvHMw4YWW3QoXggQhAcuEzssQleOAnAuEKBWlyxTJIQlBXSZPC9T1BTy9Z
pkBFDAJ+WfYFFxiXBzLioTIJLX0Afi1VKEuUahTnQZKhNCbIC8gylRRVZ4ylqH/OlEKP2Bc+
l9hgzQpZae1ODIg05nNOiUb9KhfOZ9tCoBH3Iwi5kugJ2g6c46VZ2qhTlTjLzYBJkSxwOkZp
Ei/mKjZ9Ty9lyvxpxh9JhEDzeJRLk5/PqX6wVVQZnUdeFjQhZuhkmmDgSZpiE7zZIuVWDTCB
CiclF5JPBWKME+yQ1QD2arAdsJALBuPfxs7xxJ2MD44+uIcH47OTTxgQtJbx+F7GwjyOF+BH
icTGIwc1o3LBRUxGLhOOdWTKXXVSv+f/di5epluOwJ81Q7tTin3qRdwd79+vC0VvVW73ao21
ek+pzkgVbjBkuAv7LsBlhrHfXccVsr7+sV4sN7tnN99Bw+718KDlhvXW0gzbeFbf+p4p5lNj
vc3Nt1Y7h48/foE0S3wmZZKZv4utZqmgLXdICyiQ5jJJ8Lb4re8VYjeYL017kN5KtlVJNh6R
KQ1hBuhTC15GZkr6L+CyQuvbqaxQ+8eY7K71isjeDZ3eWiLrDAoio+OVyF6JbCORGQ+IDKBi
nld6+2Z6g1d++xf5zekTsTWcgX3LbzyEOnYqLU8dYyRmoltvijVnfBfG3lTCDoxPfzn89OFn
d3xyPDlzj05OTif6Ul4LPalcnHpaw0kYUkov8kRxhjO2TykkW1V618himZtQuhPsqgn42y0W
5l5Bkc/iyCdIsmBJ+tpmAomySEa3XSSj27H/P2SvZUzlmQBrhfofJ/7rfs/tdVb5cjPdr5Pd
SPLrhP8utT9qsyR0xx5a3fWE3u82B0joxUH1vL+NsLKv79r/mV3U6w5o/MqjGr/L66LmuIuK
BbKEd0Tg2o7+9UVgr3zp1TAPmwaG1ko1lMVoPSZHw4XWVobrpsA46HQIY3kUGLMAwcWxKxfC
r+9UeGPaabRACRb6yVOXZxd17JsdPIsd8AjQ54AsAW7zUGDDAi7hw59+cCcfT9EfIXC54LhV
VRLUUfIvTNl+n9cSAAA=

--9amGYk9869ThD9tj--
