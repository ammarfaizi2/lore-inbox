Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbUKKHHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUKKHHv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 02:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbUKKHHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 02:07:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:36327 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262049AbUKKHHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 02:07:22 -0500
X-Authenticated: #4512188
Message-ID: <41930F9C.8010308@gmx.de>
Date: Thu, 11 Nov 2004 08:07:08 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041109)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc1 and prev] System unuseable while writing to disk
References: <418FE968.4030300@gmx.de> <41927019.9050508@tmr.com>
In-Reply-To: <41927019.9050508@tmr.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig17DB99036B57750AE4A3F6E1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig17DB99036B57750AE4A3F6E1
Content-Type: multipart/mixed;
 boundary="------------020001050303090208000800"

This is a multi-part message in MIME format.
--------------020001050303090208000800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bill Davidsen wrote:
> Prakash K. Cheemplavam wrote:
> 
>> Hi,
>>
>> I have a problem which doesn't seem to be connected to the i/o 
>> schedulers, because all I tested (cfq, deadline, noop) show the same:
>>
>> While writing (when the kernel actually commits to hd) my system gets 
>> very unresponsive esp when another app I want to use wants to write 
>> (read?) from hd, as well. This is *not* a UDMA problem (at least no 
>> apparent...)! More specific:
>>
>> I wrote this primitive code for writing sequentially:
> 
> 
> May I suggest running "vmstat 1" while this is happening? Looking at the 
> waitio time vs. transfer rates might reveal something. If it all looks 

Here you go. I hope you can see anything. (I attached the file as well...):


procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  0  0      0 775044  14520 136460    0    0   935    86 1251   909 13 
5 57 25
  0  0      0 775036  14520 136460    0    0     0     0 1270   536  1 
0 99  0
  0  0      0 775036  14520 136460    0    0     0     0 1225   655  1 
1 98  0
  0  0      0 775036  14520 136460    0    0     0     0 1187   530  1 
0 99  0
  0  0      0 775036  14520 136460    0    0     0     0 1184   517  0 
0 100  0
  0  0      0 775036  14520 136460    0    0     0     0 1188   548  1 
1 98  0
  0  0      0 774876  14532 136460    0    0    12     0 1185   681  2 
1 94  3
  0  0      0 774876  14532 136460    0    0     0     0 1185   479  0 
0 100  0
  0  0      0 774876  14532 136460    0    0     0     0 1180   436  1 
0 99  0
  1  1      0 571740  14732 333736    0    0    32 42628 1325   633  3 
43 52  2
  2  2      0 217812  15072 676648    0    0     0 45184 1523  1771 14 
78  0  8
  1  2      0 220436  15072 676648    0    0     0 49664 1582  1365  9 
6  0 85
  0  2      0  85460  15984 808012    0    0   164 73984 1487  1143 18 
32  0 49
  0  1      0  85716  15984 808140    0    0     0 29056 1493  1381  4 
6  0 90
  0  1      0  86100  15984 808140    0    0     0 40320 1420  1367  3 
2  0 95
  0  1      0  86100  15984 808140    0    0     0 44416 1386   693  0 
2  0 98
  0  1      0  86100  15984 808140    0    0     0 50304 1518  1413  5 
6  0 89
  0  1      0  86164  15984 808140    0    0     0 28544 1452   827  1 
2  0 97
  0  1      0  86292  15984 808140    0    0     0 35840 1386   809  1 
2  0 97
  0  1      0  86356  15984 808140    0    0     0 37376 1450  1373  3 
3  0 94
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  1  1      0  86484  15984 808140    0    0     0 42880 1752  2494  7 
6  0 87
  0  1      0  86484  15984 808140    0    0     0 31872 1608  2098  7 
4  0 89
  0  1      0  86484  15984 808140    0    0     0 45952 1530   795  1 
2  0 97
  0  1      0  86484  15984 808140    0    0     0 44288 1515   814  0 
3  0 97
  0  1      0  90580  15984 808140    0    0     0 29052 1471  1365  5 
5  0 90
  1  0      0  90148  16108 809356    0    0   976  2088 1383  1319 22 
11  0 67
  0  0      0  90148  16108 809360    0    0     4    16 1444   833 10 
5 84  1
  0  0      0  90148  16108 809360    0    0     0     0 1256   473  0 
0 100  0
  0  0      0  90148  16108 809360    0    0     0     0 1379   611  3 
1 96  0
  0  0      0  90148  16108 809360    0    0     0     0 1526  2439 16 
5 79  0
  0  0      0  90148  16164 809360    0    0     0   120 1563  1824 16 
4 80  0


Beginning and end the system is idle and then I start writing down the 
file. During that time thunderbird gets unusable.

> I can't say that I see any such thing with ext[23], so it may be a 
> reiser issue and someone else will have to help. Did you look at the 
> logs to see that there are no useful warnings there?

Nothing in the logs, unfortunately.

Cheers,

Prakash

--------------020001050303090208000800
Content-Type: application/pgp-keys;
 name="vmstat.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="vmstat.txt"

cHJvY3MgLS0tLS0tLS0tLS1tZW1vcnktLS0tLS0tLS0tIC0tLXN3YXAtLSAtLS0tLWlvLS0t
LSAtLXN5c3RlbS0tIC0tLS1jcHUtLS0tCiByICBiICAgc3dwZCAgIGZyZWUgICBidWZmICBj
YWNoZSAgIHNpICAgc28gICAgYmkgICAgYm8gICBpbiAgICBjcyB1cyBzeSBpZCB3YQogMCAg
MCAgICAgIDAgNzc1MDQ0ICAxNDUyMCAxMzY0NjAgICAgMCAgICAwICAgOTM1ICAgIDg2IDEy
NTEgICA5MDkgMTMgIDUgNTcgMjUKIDAgIDAgICAgICAwIDc3NTAzNiAgMTQ1MjAgMTM2NDYw
ICAgIDAgICAgMCAgICAgMCAgICAgMCAxMjcwICAgNTM2ICAxICAwIDk5ICAwCiAwICAwICAg
ICAgMCA3NzUwMzYgIDE0NTIwIDEzNjQ2MCAgICAwICAgIDAgICAgIDAgICAgIDAgMTIyNSAg
IDY1NSAgMSAgMSA5OCAgMAogMCAgMCAgICAgIDAgNzc1MDM2ICAxNDUyMCAxMzY0NjAgICAg
MCAgICAwICAgICAwICAgICAwIDExODcgICA1MzAgIDEgIDAgOTkgIDAKIDAgIDAgICAgICAw
IDc3NTAzNiAgMTQ1MjAgMTM2NDYwICAgIDAgICAgMCAgICAgMCAgICAgMCAxMTg0ICAgNTE3
ICAwICAwIDEwMCAgMAogMCAgMCAgICAgIDAgNzc1MDM2ICAxNDUyMCAxMzY0NjAgICAgMCAg
ICAwICAgICAwICAgICAwIDExODggICA1NDggIDEgIDEgOTggIDAKIDAgIDAgICAgICAwIDc3
NDg3NiAgMTQ1MzIgMTM2NDYwICAgIDAgICAgMCAgICAxMiAgICAgMCAxMTg1ICAgNjgxICAy
ICAxIDk0ICAzCiAwICAwICAgICAgMCA3NzQ4NzYgIDE0NTMyIDEzNjQ2MCAgICAwICAgIDAg
ICAgIDAgICAgIDAgMTE4NSAgIDQ3OSAgMCAgMCAxMDAgIDAKIDAgIDAgICAgICAwIDc3NDg3
NiAgMTQ1MzIgMTM2NDYwICAgIDAgICAgMCAgICAgMCAgICAgMCAxMTgwICAgNDM2ICAxICAw
IDk5ICAwCiAxICAxICAgICAgMCA1NzE3NDAgIDE0NzMyIDMzMzczNiAgICAwICAgIDAgICAg
MzIgNDI2MjggMTMyNSAgIDYzMyAgMyA0MyA1MiAgMgogMiAgMiAgICAgIDAgMjE3ODEyICAx
NTA3MiA2NzY2NDggICAgMCAgICAwICAgICAwIDQ1MTg0IDE1MjMgIDE3NzEgMTQgNzggIDAg
IDgKIDEgIDIgICAgICAwIDIyMDQzNiAgMTUwNzIgNjc2NjQ4ICAgIDAgICAgMCAgICAgMCA0
OTY2NCAxNTgyICAxMzY1ICA5ICA2ICAwIDg1CiAwICAyICAgICAgMCAgODU0NjAgIDE1OTg0
IDgwODAxMiAgICAwICAgIDAgICAxNjQgNzM5ODQgMTQ4NyAgMTE0MyAxOCAzMiAgMCA0OQog
MCAgMSAgICAgIDAgIDg1NzE2ICAxNTk4NCA4MDgxNDAgICAgMCAgICAwICAgICAwIDI5MDU2
IDE0OTMgIDEzODEgIDQgIDYgIDAgOTAKIDAgIDEgICAgICAwICA4NjEwMCAgMTU5ODQgODA4
MTQwICAgIDAgICAgMCAgICAgMCA0MDMyMCAxNDIwICAxMzY3ICAzICAyICAwIDk1CiAwICAx
ICAgICAgMCAgODYxMDAgIDE1OTg0IDgwODE0MCAgICAwICAgIDAgICAgIDAgNDQ0MTYgMTM4
NiAgIDY5MyAgMCAgMiAgMCA5OAogMCAgMSAgICAgIDAgIDg2MTAwICAxNTk4NCA4MDgxNDAg
ICAgMCAgICAwICAgICAwIDUwMzA0IDE1MTggIDE0MTMgIDUgIDYgIDAgODkKIDAgIDEgICAg
ICAwICA4NjE2NCAgMTU5ODQgODA4MTQwICAgIDAgICAgMCAgICAgMCAyODU0NCAxNDUyICAg
ODI3ICAxICAyICAwIDk3CiAwICAxICAgICAgMCAgODYyOTIgIDE1OTg0IDgwODE0MCAgICAw
ICAgIDAgICAgIDAgMzU4NDAgMTM4NiAgIDgwOSAgMSAgMiAgMCA5NwogMCAgMSAgICAgIDAg
IDg2MzU2ICAxNTk4NCA4MDgxNDAgICAgMCAgICAwICAgICAwIDM3Mzc2IDE0NTAgIDEzNzMg
IDMgIDMgIDAgOTQKcHJvY3MgLS0tLS0tLS0tLS1tZW1vcnktLS0tLS0tLS0tIC0tLXN3YXAt
LSAtLS0tLWlvLS0tLSAtLXN5c3RlbS0tIC0tLS1jcHUtLS0tCiByICBiICAgc3dwZCAgIGZy
ZWUgICBidWZmICBjYWNoZSAgIHNpICAgc28gICAgYmkgICAgYm8gICBpbiAgICBjcyB1cyBz
eSBpZCB3YQogMSAgMSAgICAgIDAgIDg2NDg0ICAxNTk4NCA4MDgxNDAgICAgMCAgICAwICAg
ICAwIDQyODgwIDE3NTIgIDI0OTQgIDcgIDYgIDAgODcKIDAgIDEgICAgICAwICA4NjQ4NCAg
MTU5ODQgODA4MTQwICAgIDAgICAgMCAgICAgMCAzMTg3MiAxNjA4ICAyMDk4ICA3ICA0ICAw
IDg5CiAwICAxICAgICAgMCAgODY0ODQgIDE1OTg0IDgwODE0MCAgICAwICAgIDAgICAgIDAg
NDU5NTIgMTUzMCAgIDc5NSAgMSAgMiAgMCA5NwogMCAgMSAgICAgIDAgIDg2NDg0ICAxNTk4
NCA4MDgxNDAgICAgMCAgICAwICAgICAwIDQ0Mjg4IDE1MTUgICA4MTQgIDAgIDMgIDAgOTcK
IDAgIDEgICAgICAwICA5MDU4MCAgMTU5ODQgODA4MTQwICAgIDAgICAgMCAgICAgMCAyOTA1
MiAxNDcxICAxMzY1ICA1ICA1ICAwIDkwCiAxICAwICAgICAgMCAgOTAxNDggIDE2MTA4IDgw
OTM1NiAgICAwICAgIDAgICA5NzYgIDIwODggMTM4MyAgMTMxOSAyMiAxMSAgMCA2NwogMCAg
MCAgICAgIDAgIDkwMTQ4ICAxNjEwOCA4MDkzNjAgICAgMCAgICAwICAgICA0ICAgIDE2IDE0
NDQgICA4MzMgMTAgIDUgODQgIDEKIDAgIDAgICAgICAwICA5MDE0OCAgMTYxMDggODA5MzYw
ICAgIDAgICAgMCAgICAgMCAgICAgMCAxMjU2ICAgNDczICAwICAwIDEwMCAgMAogMCAgMCAg
ICAgIDAgIDkwMTQ4ICAxNjEwOCA4MDkzNjAgICAgMCAgICAwICAgICAwICAgICAwIDEzNzkg
ICA2MTEgIDMgIDEgOTYgIDAKIDAgIDAgICAgICAwICA5MDE0OCAgMTYxMDggODA5MzYwICAg
IDAgICAgMCAgICAgMCAgICAgMCAxNTI2ICAyNDM5IDE2ICA1IDc5ICAwCiAwICAwICAgICAg
MCAgOTAxNDggIDE2MTY0IDgwOTM2MCAgICAwICAgIDAgICAgIDAgICAxMjAgMTU2MyAgMTgy
NCAxNiAgNCA4MCAgMAo=
--------------020001050303090208000800--

--------------enig17DB99036B57750AE4A3F6E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBkw+gxU2n/+9+t5gRAq/KAJ45dY3gAgIq5ApF1qvWjytDZyWjbACgso+h
Q3kUn+VFLVc4Ol38EsHNZic=
=opnW
-----END PGP SIGNATURE-----

--------------enig17DB99036B57750AE4A3F6E1--
