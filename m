Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbULCL1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbULCL1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 06:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbULCL1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 06:27:25 -0500
Received: from imap.gmx.net ([213.165.64.20]:46540 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261430AbULCL1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 06:27:12 -0500
X-Authenticated: #4512188
Message-ID: <41B04D8A.7060707@gmx.de>
Date: Fri, 03 Dec 2004 12:27:06 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041114)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
References: <20041202121938.12a9e5e0.akpm@osdl.org> <41AF94B8.8030202@gmx.de> <20041203070108.GA10492@suse.de> <41B02DFD.9090503@gmx.de> <20041203012645.21377669.akpm@osdl.org> <20041203093903.GE10492@suse.de> <41B03722.5090001@gmx.de> <20041203103130.GH10492@suse.de> <20041203103828.GI10492@suse.de> <41B043AF.3070503@gmx.de> <20041203104828.GJ10492@suse.de>
In-Reply-To: <20041203104828.GJ10492@suse.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB8890639E654752719DF3134"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB8890639E654752719DF3134
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe schrieb:
> On Fri, Dec 03 2004, Prakash K. Cheemplavam wrote:
> 
>>>But at least this patch lets you set slice_sync and slice_async
>>>seperately, if you want to experiement.
>>
>>An idea, which values I should try?
> 
> 
> Just see if the default ones work (or how they work :-)
> 
>>BTW, I just did my little test on the ide drive and it shows the same 
>>problem, so it is not sata / libata related.
> 
> 
> Single read/writer case works fine here for me, about half the bandwidth
> for each. Please show some vmstats for this case, too. Right now I'm not
> terribly interested in problems with raid alone, as I can poke holes in
> that. If the single drive case is correct, then we can focus on raid.

I have not enough space to perform this test on the ide drive, so I did 
it on the sata (single disk). The patch doesn't seem to be better. (But 
on the other hand I haven't tested you first version on single disk.) At 
least it still doesn't look good enough in my eyes.

  procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  1  3   2704   5368   1528 906540    0    4  2176 24068 1245   743  0 
7  0 93
  0  3   2704   5432   1532 906252    0    0  5072 28160 1277   782  1 
8  0 91
  0  5   2704   5688   1532 906080    0    0  9280  4524 1309   842  1 
10  0 89
  1  3   2704   5232   1544 906208    0    0  6404 76388 1285   716  1 
14  0 85
  0  3   2704   5496   1544 906524    0    0  8328 26624 1301   856  1 
8  0 91
  0  3   2704   5512   1528 906636    0    0  9484 22016 1302   883  1 
8  0 91
  0  3   2704   5816   1500 906296    0    0  5508 10288 1270   749  1 
9  0 90
  0  4   2704   5620   1488 906608    0    0  3076 19920 1267   818  0 
13  0 87
  1  4   2704   5684   1456 906432    0    0  3204 18432 1252   704  1 
8  0 91
  1  3   2704   5504   1408 906168    0    0  5252 28672 1279   777  1 
14  0 85
  0  4   2704   5120   1404 906296    0    0  8968 16384 1351   876  1 
9  0 90
  0  4   2704   5364   1404 905620    0    0  5252 26112 1339   835  1 
14  0 85
  0  4   2704   5600   1432 905036    0    0  1468 15876 1312   741  2 
8  0 90
  1  4   2704   5556   1424 904704    0    0  1664 26112 1243   714  1 
10  0 89
  0  4   2704   5492   1428 904100    0    0  1412 31232 1253   760  1 
15  0 84
  0  4   2704   5568   1432 903456    0    0  1668 29696 1253   703  1 
14  0 85
  1  4   2704   5620   1408 902980    0    0  1280 28672 1248   732  0 
14  0 86
  0  4   2704   5236   1404 902888    0    0  2180 28704 1252   705  1 
11  0 88
  0  4   2704   5632   1388 902180    0    0  1536 28160 1251   731  1 
11  0 88
  0  3   2704   5120   1356 905968    0    0   384 57896 1257   751  1 
14  0 85




What I don't like about the time sliced cfq (first version as well) is 
that I don't get good sustained rate anymore if I have only one writer 
and nothing else. IIRC with plain cfq I at least got near to maximum 
throughput (40-50mb/sec) now it oscillates much more. I have to recheck 
with plain cfq though. It might be ext3 related...

  0  2   2684   7016   9384 900664    0    0     0 59128 1217   576  1 
7  0 92
  1  1   2684   5160   9368 898660    0    0     0 12300 1239  4861  1 
60  0 39
  0  3   2684   5532   9364 896360    0    0     0 18684 1246  1723  1 
48  0 51
  0  3   2684   5596   9364 896616    0    0     0 24576 1246   686  1 
9  0 90
  0  3   2684   5596   9364 896612    0    0     0 38400 1261   718  0 
13  0 87
  0  3   2684   5532   9360 896564    0    0     0 37888 1257   708  1 
13  0 86
  0  3   2684   5532   8848 896884    0    0     0 36864 1260   825  1 
12  0 87
  1  3   2696   5596   7440 898120    0    0     0 31744 1247   703  1 
11  0 88
  0  3   2700   5660   5352 900080    0    0     0 37888 1258   768  1 
13  0 86
  0  2   2700   6816   5216 900436    0    0     0 68772 1266   783  1 
25  0 74
  0  2   2700   6884   5216 900436    0    0     0 19616 1247   679  2 
1  0 97
  1  2   2700   7096   5216 900436    0    0     0 14976 1249   786  1 
3  0 96
  0  2   2700   5352   4572 902432    0    0     4 66544 1263  2333  1 
21  0 78



Prakash

--------------enigB8890639E654752719DF3134
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBsE2NxU2n/+9+t5gRAivGAJ9cF1F1BGIIbMRRlzrVg5za8xzItQCg5WAi
knC7th1QNeHk9ruXsFCHaMo=
=1QlO
-----END PGP SIGNATURE-----

--------------enigB8890639E654752719DF3134--
