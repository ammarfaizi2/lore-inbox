Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbULCLxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbULCLxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 06:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbULCLxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 06:53:42 -0500
Received: from mail.gmx.de ([213.165.64.20]:64402 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262172AbULCLxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 06:53:09 -0500
X-Authenticated: #4512188
Message-ID: <41B05397.7060808@gmx.de>
Date: Fri, 03 Dec 2004 12:52:55 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041114)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
References: <20041203070108.GA10492@suse.de> <41B02DFD.9090503@gmx.de> <20041203012645.21377669.akpm@osdl.org> <20041203093903.GE10492@suse.de> <41B03722.5090001@gmx.de> <20041203103130.GH10492@suse.de> <20041203103828.GI10492@suse.de> <41B043AF.3070503@gmx.de> <20041203104828.GJ10492@suse.de> <41B04D8A.7060707@gmx.de> <20041203112914.GM10492@suse.de>
In-Reply-To: <20041203112914.GM10492@suse.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8AFA8C28779B4A401502C91C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8AFA8C28779B4A401502C91C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe schrieb:
> On Fri, Dec 03 2004, Prakash K. Cheemplavam wrote:
> 
>>Jens Axboe schrieb:
>>
>>>On Fri, Dec 03 2004, Prakash K. Cheemplavam wrote:
>>>
>>>
>>>>>But at least this patch lets you set slice_sync and slice_async
>>>>>seperately, if you want to experiement.
>>>>
>>>>An idea, which values I should try?
>>>
>>>
>>>Just see if the default ones work (or how they work :-)
>>>
>>>
>>>>BTW, I just did my little test on the ide drive and it shows the same 
>>>>problem, so it is not sata / libata related.
>>>
>>>
>>>Single read/writer case works fine here for me, about half the bandwidth
>>>for each. Please show some vmstats for this case, too. Right now I'm not
>>>terribly interested in problems with raid alone, as I can poke holes in
>>>that. If the single drive case is correct, then we can focus on raid.
>>
>>I have not enough space to perform this test on the ide drive, so I did 
>>it on the sata (single disk). The patch doesn't seem to be better. (But 
>>on the other hand I haven't tested you first version on single disk.) At 
>>least it still doesn't look good enough in my eyes.
>>
>> procs -----------memory---------- ---swap-- -----io---- --system-- 
>>----cpu----
>> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
>>sy id wa
>> 1  3   2704   5368   1528 906540    0    4  2176 24068 1245   743  0 
>>7  0 93
>> 0  3   2704   5432   1532 906252    0    0  5072 28160 1277   782  1 
>>8  0 91
>> 0  5   2704   5688   1532 906080    0    0  9280  4524 1309   842  1 
>>10  0 89
>> 1  3   2704   5232   1544 906208    0    0  6404 76388 1285   716  1 
>>14  0 85
>> 0  3   2704   5496   1544 906524    0    0  8328 26624 1301   856  1 
>>8  0 91
>> 0  3   2704   5512   1528 906636    0    0  9484 22016 1302   883  1 
>>8  0 91
>> 0  3   2704   5816   1500 906296    0    0  5508 10288 1270   749  1 
>>9  0 90
>> 0  4   2704   5620   1488 906608    0    0  3076 19920 1267   818  0 
>>13  0 87
>> 1  4   2704   5684   1456 906432    0    0  3204 18432 1252   704  1 
>>8  0 91
>> 1  3   2704   5504   1408 906168    0    0  5252 28672 1279   777  1 
>>14  0 85
>> 0  4   2704   5120   1404 906296    0    0  8968 16384 1351   876  1 
>>9  0 90
>> 0  4   2704   5364   1404 905620    0    0  5252 26112 1339   835  1 
>>14  0 85
>> 0  4   2704   5600   1432 905036    0    0  1468 15876 1312   741  2 
>>8  0 90
>> 1  4   2704   5556   1424 904704    0    0  1664 26112 1243   714  1 
>>10  0 89
>> 0  4   2704   5492   1428 904100    0    0  1412 31232 1253   760  1 
>>15  0 84
>> 0  4   2704   5568   1432 903456    0    0  1668 29696 1253   703  1 
>>14  0 85
>> 1  4   2704   5620   1408 902980    0    0  1280 28672 1248   732  0 
>>14  0 86
>> 0  4   2704   5236   1404 902888    0    0  2180 28704 1252   705  1 
>>11  0 88
>> 0  4   2704   5632   1388 902180    0    0  1536 28160 1251   731  1 
>>11  0 88
>> 0  3   2704   5120   1356 905968    0    0   384 57896 1257   751  1 
>>14  0 85
> 
> 
> Try increasing slice_sync and idle, just for fun.

Changed to 150 resp. 6:

procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  1  5   2704   5720    960 900020    0    0    68 26624 1251   741  1 
16  0 83
  1  3   2704   5708   1004 900312    0    0   312  4044 1294   686  1 
11  0 88
  0  1   2704   5484   1024 899800    0    0   396 40008 1236   608  1 
5  0 94
  0  3   2704   5284   1036 900696    0    0   516 49196 1246   682  1 
5  0 94
  1  3   2704   5640   1040 900956    0    0  1416 21504 1252   722  1 
4  0 95
  0  3   2704   5120   1040 902108    0    0  2688 12288 1230   672  1 
2  0 97
  1  3   2704   5416   1036 902276    0    0  3076     0 1248   632  0 
2  0 98
  0  4   2704   5448   1092 902748    0    0 11700    16 1306   857  1 
16  0 83
  0  3   2704   5712   1132 900704    0    0  1064 63488 1259   755  1 
15  0 84
  0  3   2704   5476   1156 901336    0    0  5656  8296 1272   725  1 
7  0 92
  0  3   2704   5320   1208 900996    0    0  2988  3972 1256   696  1 
18  0 81
  1  4   2704   5288   1240 899660    0    0  1956 60964 1278   757  1 
12  0 87
  0  3   2704   5596   1292 899032    0    0  1688 24732 1284   813  1 
8  0 91
  0  3   2704   6124   1308 899776    0    0  1424 42496 1253   678  1 
7  0 92
  1  3   2704   5744   1324 900124    0    0    16 23552 1250   707  1 
9  0 90
  0  3   2704   5108   1332 900768    0    0  1800 19968 1242   703  1 
4  0 95
  0  3   2704   5640   1332 900132    0    0  3204 16896 1240   689  1 
1  0 98
  0  3   2704   5512   1344 900696    0    0  2564  3036 1255   652  1 
2  0 97
  2  3   2704   5264   1364 901384    0    0  2704 42572 1253   726  1 
10  0 89
  1  3   2704   5096   1368 898108    0    0  1808 51724 1240  1984  1 
53  0 46
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  1  4   2704   5572   1348 896164    0    0  2816 18944 1239  1304  1 
30  0 69
  0  4   2704   5436   1332 896152    0    0  3204 17408 1239   716  0 
6  0 94
  0  4   2704   5452   1324 895884    0    0  3076 20480 1248   711  2 
8  0 90
  0  4   2704   5444   1328 895668    0    0  3020 16384 1360   830  1 
7  0 92
  0  4   2704   5708   1328 895248    0    0  1976 21952 1509  1213  4 
8  0 88
  0  4   2704   5708   1328 895020    0    0  1536 25200 1258   803  2 
10  0 88
  0  4   2704   5836   1332 894880    0    0  3204 16264 1281   908  3 
8  0 89
  0  4   2704   5668   1320 895084    0    0   896 18172 1433   941  1 
7  0 92
  0  4   2704   5324   1324 895644    0    0  4612 15924 1450   968  1 
7  0 92
  0  3   2704   5464   1324 897836    0    0  7176 42820 1421  1074  1 
29  0 70
  1  3   2704   5304   1324 898092    0    0   896 11516 1266   727  1 
2  0 97
  0  4   2704   5336   1312 898080    0    0  2436 16684 1270   971  1 
10  0 89
  0  3   2704   5608   1328 897816    0    0 17040 14124 1463  1162  3 
7  0 90
  0  3   2704   5272   1348 897960    0    0 18196 11264 1435  1281  2 
13  0 85
  0  3   2704   5592   1348 897488    0    0  6792 24284 1348  1102  6 
8  0 86
  0  3   2704   5528   1364 897448    0    0   872 19516 1239   760  1 
6  0 93
  0  3   2704   5592   1364 897348    0    0  1976 22408 1253   761  1 
5  0 94
  0  3   2704   5528   1364 897252    0    0  2048 30820 1267   858  1 
8  0 91
  0  3   2704   5528   1372 897132    0    0  5640 18812 1382   907  1 
6  0 93
  0  3   2704   5208   1368 897388    0    0  2820 17356 1352   863  1 
5  0 94

Prakash

--------------enig8AFA8C28779B4A401502C91C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBsFOXxU2n/+9+t5gRAvu+AJ9ycFgL9yFyuPzAsKKT7vcHkm9USQCfVfXA
yOkhiLP0kT1/rks+aJuiq98=
=YcWy
-----END PGP SIGNATURE-----

--------------enig8AFA8C28779B4A401502C91C--
