Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264063AbTJ1RnC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 12:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264065AbTJ1RnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 12:43:02 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:51416 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S264063AbTJ1Rm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 12:42:57 -0500
Subject: Re: 2.6.0-test8/test9 io scheduler needs tuning?
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Michael Frank <mhf@linuxmail.org>, cliff white <cliffw@osdl.org>,
       linux-kernel@vger.kernel.org,
       Nigel Cunningham <ncunningham@clear.net.nz>
In-Reply-To: <3F9DF0D3.60707@cyberone.com.au>
References: <200310261201.14719.mhf@linuxmail.org>
	 <20031027145531.2eb01017.cliffw@osdl.org>
	 <3F9DAF2C.8010308@cyberone.com.au> <200310281213.31709.mhf@linuxmail.org>
	 <3F9DF0D3.60707@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VcPFLn8idIPXPvwcFnIu"
Message-Id: <1067362972.13998.13.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 28 Oct 2003 18:42:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VcPFLn8idIPXPvwcFnIu
Content-Type: multipart/mixed; boundary="=-Pt7hJK71LcweSJ036wOj"


--=-Pt7hJK71LcweSJ036wOj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-28 at 05:30, Nick Piggin wrote:

> The bi / bo fields in vmstat aren't exactly what the disk is doing, rathe=
r
> the requests the queue is taking. The interesting thing is how your final
> measurement compares with 2.4.

I've attached a small script I made to investigate some weird I/O
problems I'm seeing with both AS and deadline. Maybe the script can be
of some help, who knows.

It produces vmstat-like one line per second output.
It takes the data from /proc/diskstats (output should be the same order
as in that file, it's described in Documentation/iostats.txt)

Example output (from one of my tests that showed the problem):

$diskstat.sh hde
row     reads   rmerge  rsect   rms     writes  wmerge  wsect   wms     io =
     ms      ms2
1       0       0       0       0       0       0       0       0       163=
     0       0
2       3       0       24      46      751     530     10032   241626  135=
     1463    223510
3       1       0       64      15      590     402     8056    147398  149=
     1019    148466
4       1       0       160     16      599     593     9592    144204  156=
     1016    147806
5       1       0       8       21      522     485     7896    134072  133=
     1016    152418
6       1       0       8       14      541     265     6504    163212  139=
     1014    149101
7       3       0       264     63      495     153     5248    127999  147=
     1016    145554
.....

It's a sequential write, only one writer, lots of I/O-requests for a
very small number of sectors and the drive isn't very active.
It's a file recieved via network and written to disk.

Corresponding 'vmstat 1' output (not at the same time as the output
above):

24  procs -----------memory---------- ---swap-- -----io---- --system-- ----=
cpu----
25   r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us s=
y id wa
26   2  5  20400   2256  42956 297704    0    0    12  2300 4452  6010  4 2=
5  0 71
27   3  4  20544   2524  42536 298276    0  144    16  3476 3605  4366  3 2=
1  0 76
28   0 10  20544   2104  41876 299380    0    0    16  2996 4094  5107  4 2=
2  0 74
29   1 10  20548   2456  40656 300252    0    4    40  3228 4389  5725  4 2=
7  0 69
30   0  5  20832   2176  40108 301252    0  288    16  2780 4530  6889  5 2=
6  0 69

Normally I see bursts of >30MB/s with a few seconds interval.
In this example there's some swapping but I havn't seen any indication
that swapping is the cause since it happens when there's no swapping
going on as well.

When this happens (not all the time) the machine freezes for 1-2 seconds
every 3-15 seconds. X freezes and if I ssh into the machine that freezes
as well at these intervals.

I've tried profiling when this happens but it just shows all time in
default_idle.

Maybe my problem is related, or maybe not...

--=20
/Martin

--=-Pt7hJK71LcweSJ036wOj
Content-Disposition: attachment; filename=diskstat.sh
Content-Type: text/x-sh; name=diskstat.sh; charset=iso-8859-15
Content-Transfer-Encoding: base64

Iy9iaW4vYmFzaA0KDQpudW09MA0KZm9yIGxvb3AgaW4gYSBiIGMgZCBlIGYgZyBoIGkgaiBrDQpk
bw0KCW9sZFskbnVtXT0wDQoJbnVtPSQoKCRudW0gKyAxKSkNCmRvbmUNCg0Kcm93PTANCg0Kd2hp
bGUgdHJ1ZTsgZG8gZ3JlcCAiJDEgIiAvcHJvYy9kaXNrc3RhdHMgfCBhd2sgJ3twcmludCAkNCwk
NSwkNiwkNywkOCwkOSwkMTAsJDExLCQxMiwkMTMsJDE0fSc7IHNsZWVwIDE7IGRvbmUgfCB3aGls
ZSByZWFkIGEgYiBjIGQgZSBmIGcgaCBpIGogaw0KZG8NCglpZiBbICQoKCRyb3cgJSAzMCkpID09
IDAgXTsgdGhlbg0KCQkjZWNobyAtZSAicm93XHRyZWFkc1x0cm1lcmdlXHRyc2VjdFx0cm1zXHRc
dHdyaXRlc1x0d21lcmdlXHR3c2VjdFx0d21zXHRcdGlvXHRtc1x0bXMyIg0KCQllY2hvIC1lICJy
b3dcdHJlYWRzXHRybWVyZ2VcdHJzZWN0XHRybXNcdHdyaXRlc1x0d21lcmdlXHR3c2VjdFx0d21z
XHRpb1x0bXNcdG1zMiINCglmaQ0KCXJvdz0kKCgkcm93ICsgMSkpDQoNCgludW09MA0KCWZvciBs
b29wIGluIGEgYiBjIGQgZSBmIGcgaCBpIGogaw0KCWRvDQoJCWlmIFsgJHtvbGRbJG51bV19ID09
IDAgXTsgdGhlbg0KCQkJb2xkWyRudW1dPSR7IWxvb3B9DQoJCQlkaWZmWyRudW1dPTANCgkJZWxz
ZQ0KCQkJZGlmZlskbnVtXT0kKCgkeyFsb29wfSAtICR7b2xkWyRudW1dfSkpDQoJCQlvbGRbJG51
bV09JHshbG9vcH0NCgkJZmkNCgkJbnVtPSQoKCRudW0gKyAxKSkNCglkb25lDQoNCgllY2hvIC1l
ICIkcm93XHQke2RpZmZbMF19XHQke2RpZmZbMV19XHQke2RpZmZbMl19XHQke2RpZmZbM119XHQk
e2RpZmZbNF19XHQke2RpZmZbNV19XHQke2RpZmZbNl19XHQke2RpZmZbN119XHQkaVx0JHtkaWZm
WzldfVx0JHtkaWZmWzEwXX0iDQpkb25lDQo=

--=-Pt7hJK71LcweSJ036wOj--

--=-VcPFLn8idIPXPvwcFnIu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/nqqcWm2vlfa207ERAjxLAJ9bmoClz8sy65dp7I0ZWVnTkgn1MACfRV5w
S4tTYIw4MmdJZHgPKN2dXvw=
=h5ej
-----END PGP SIGNATURE-----

--=-VcPFLn8idIPXPvwcFnIu--
