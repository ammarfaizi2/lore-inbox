Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbULCJyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbULCJyZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbULCJyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:54:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:65485 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262131AbULCJyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:54:02 -0500
X-Authenticated: #4512188
Message-ID: <41B037B8.20204@gmx.de>
Date: Fri, 03 Dec 2004 10:54:00 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041114)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041202121938.12a9e5e0.akpm@osdl.org> <41AF94B8.8030202@gmx.de> <20041203070108.GA10492@suse.de> <41B02DFD.9090503@gmx.de> <20041203012645.21377669.akpm@osdl.org> <20041203093903.GE10492@suse.de>
In-Reply-To: <20041203093903.GE10492@suse.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE9C3D4D97DEB88A948BD9F97"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE9C3D4D97DEB88A948BD9F97
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe schrieb:
> On Fri, Dec 03 2004, Andrew Morton wrote:
> 
>>Is this a parallel IDE system?  SATA?  SCSI?  If the latter, what driver
>>and what is the TCQ depth?
> 
> 
> Yeah, that would be interesting to know. Or of the device is on dm or
> raid. And what filesystem is being used?

It is ext3. (The writing-makes-reading-starve problem happen on reiserfs 
as well. ext2 is not so bad and xfs behaves best, ie my email client 
doesn't get unuasable with my earlier tests, but "only" very slow. But 
then I only wrote down 2gb and nothing continuesly.)

> # cd /sys/block/<dev>/queue/iosched
> # echo 6 > idle
> # echo 150 > slice
> 
> These are the first I tried, there may be better settings. If you have
> your filesystem on dm/raid, you probably want to do the above for each
> device the dm/raid is composed of.

Yes, I have linux raid (testing md1). Have appield both settings on both 
drives and got a interesting new pattern: Now it alternates. My email 
client is still not usale while writing though...


0  3   4120   5276   1792 856784    0    0  3880 81372 1528   931  1 17 
  0 82
  0  4   4120   5576   1800 856148    0    0  1292 121136 1379   872  5 
12  0 83
  0  3   4120   6624   1796 857700    0    0  1548  4464 1324   712  4 7 
  0 89
  1  3   4120   5200   1568 859600    0    0 42608  2308 1679  1392  3 
28  0 69
  1  3   4120   5212   1472 856672    0    0 12372 94992 1451  1047  1 
30  0 69
  1  2   4120   5700   1476 856892    0    0  2576 27252 1337   770  2 9 
  0 89
  0  3   4120   5404   1484 860292    0    0  2076 63876 1323   758  2 
13  0 85
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  1  2   4120   5536   1492 860240    0    0 49248    12 1783  1478  2 
26  0 72
  0  3   4120   5476   1492 857976    0    0 21852 98552 1500  1021  2 
20  0 78
  0  3   4120   5340   1552 860104    0    0  2672 36920 1321   717  1 
15  0 84
  0  4   4120   5436   1588 861080    0    0  2364 20748 1331   716  1 
12  0 87
  0  3   4120   5092   1632 860012    0    0 59520     0 1810  1591  3 
32  0 65
  0  3   4120   5568   1616 858252    0    0 58232     0 1833  1519  2 
30  0 68
  0  2   4120   5508   1548 857784    0    0  3864 70500 1347   767  1 
13  0 86
  0  2   4120   5376   1488 857760    0    0  5164 41440 1317   800  2 
15  0 83
  0  3   4120   5256   1484 858448    0    0  6452 111292 1342   829  2 
22  0 76
  0  3   4120   5832   1488 858768    0    0  2060 26624 1320   769  2 5 
  0 93
  3  4   4120   5564   1492 859644    0    0 20568    12 1426  1048  1 
25  0 75
  0  2   4120   5448   1516 857548    0    0 41056 47636 1746  1355  2 
29  0 69
  0  2   4120   5572   1524 858020    0    0  2332 25020 1330   737  1 
10  0 89
  0  3   4120   5508   1568 858020    0    0  4152 130164 1338   844  2 
20  0 78
  1  3   4120   6260   1588 858840    0    0   836 14288 1314   747  1 3 
  0 96
  1  3   4120   5192   1644 860304    0    0 41628    12 1677  2226  2 
31  0 67
  2  3   4120   5308   1588 857448    0    0 53324  1456 2044  9456  2 
60  0 38


Prakash

--------------enigE9C3D4D97DEB88A948BD9F97
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBsDe4xU2n/+9+t5gRAm/bAJ9B0EugIJU8hegKwXebnYPN7FyaTQCfY6IZ
Qsp30nblgAWcBh3hyUAvXLE=
=YTun
-----END PGP SIGNATURE-----

--------------enigE9C3D4D97DEB88A948BD9F97--
