Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbULBWQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbULBWQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 17:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbULBWQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 17:16:00 -0500
Received: from pop.gmx.net ([213.165.64.20]:26772 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261781AbULBWPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 17:15:43 -0500
X-Authenticated: #4512188
Message-ID: <41AF94B8.8030202@gmx.de>
Date: Thu, 02 Dec 2004 23:18:32 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041114)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
References: <20041202130457.GC10458@suse.de>	<20041202134801.GE10458@suse.de>	<20041202114836.6b2e8d3f.akpm@osdl.org>	<20041202195232.GA26695@suse.de> <20041202121938.12a9e5e0.akpm@osdl.org>
In-Reply-To: <20041202121938.12a9e5e0.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig559EAC5132B65144CC4A3F9A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig559EAC5132B65144CC4A3F9A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton schrieb:
> Jens Axboe <axboe@suse.de> wrote:
> 
>>n Thu, Dec 02 2004, Andrew Morton wrote:
>>
>>>Jens Axboe <axboe@suse.de> wrote:
>>>
>>>>as:
>>>>Reader: 27985KiB/sec (max_lat=34msec)
>>>>Writer:    64KiB/sec (max_lat=1042msec)
>>>>
>>>>cfq:
>>>>Reader: 12703KiB/sec (max_lat=108msec)
>>>>Writer:  9743KiB/sec (max_lat=89msec)
> 
> 
> Did a quick test here, things seem OK.
> 
> Writer:
> 
> 	while true
> 	do
> 	dd if=/dev/zero of=foo bs=1M count=1000 conv=notrunc
> 	done
> 
> Reader:
> 
> 	time cat 1-gig-file > /dev/null
> 	cat x > /dev/null  0.07s user 1.55s system 3% cpu 45.434 total
> 
> `vmstat 1' says:
> 
> 
>  0  5   1168   3248    472 220972    0    0    28 24896 1249   212  0  7  0 94
>  0  7   1168   3248    492 220952    0    0    28 28056 1284   204  0  5  0 96
>  0  8   1168   3248    500 221012    0    0    28 30632 1255   194  0  5  0 95
>  0  7   1168   2800    508 221344    0    0    16 20432 1183   170  0  3  0 97
>  0  8   1168   3024    484 221164    0    0 15008 12488 1246   460  0  4  0 96
>  1  8   1168   2252    484 221980    0    0 27808  6092 1270   624  0  4  0 96
>  0  8   1168   3248    468 221044    0    0 32420  4596 1290   690  0  4  0 96
>  0  9   1164   2084    456 222212    4    0 28964  1800 1285   596  0  3  0 96
>  1  7   1164   3032    392 221256    0    0 23456  6820 1270   527  0  4  0 96
>  0  9   1164   3200    388 221124    0    0 27040  7868 1269   588  0  3  0 97
>  0  9   1164   2540    384 221808    0    0 21536  4024 1247   540  0  4  0 96
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  1 10   1164   2052    392 222276    0    0 33572  5268 1298   745  0  4  0 96
>  0  9   1164   3032    400 221316    0    0 28704  5448 1282   611  0  4  0 97
> 

I am happy that finally the kernel devs see that there is a problem. In my case (as I 
mentioned in another thread) the reader is pretty starving while I a writer is active. 
(esp my email client makes trouble while writing is going on.) This is vmstat using your 
scripts above (though using cfq2 scheduler):

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  1  3   3080   2528   1256 818976    0    0  6404 101236 1332   929  1 26  0 73
  0  3   3080   2768   1252 820104    0    0  2820 32632 1328  1087  1 20  0 79
  2  1   3080   6992   1292 814808    0    0  4928 106912 1337  1364 16 29  0 55
  0  3   3080   2772   1252 818516    0    0  3076 42176 1357  1351  2 41  0 57
  0  3   3080   2644   1256 817548    0    0  3332 110104 1375   873  1 36  0 63
  0  3   3080   2592   1248 815928    0    0  2820 76860 1324   894  1 41  0 58
  7  3   3080   2208   1248 817176    0    0  3328 134144 1352  1058  2 30  0 68
  4  4   3080   2516   1248 817516    0    0  3588 47768 1327  1244  1 19  0 80
  0  3   3080   2400   1220 818688    0    0  3844 24760 1312  1251  1 23  0 76
  0  3   3080   2656   1196 816468    0    0  3588 132372 1352  1126  1 52  0 47
  0  3   3080   2688   1188 815316    0    0  3076 77824 1328   933  1 35  0 64
  0  3   3080   2336   1156 816744    0    0  2924 114688 1333  1038  1 25  0 74
  0  3   3080   2528   1184 816812    0    0  2508 67736 1340   882  1 12  0 87
  0  3   3080   2208   1156 817712    0    0  3592 75624 1326  2289  1 36  0 63
  0  3   3080   2664   1156 818240    0    0  5124 15692 1302   992  1 18  0 81
  0  3   3080   2580   1160 815832    0    0  4356 155792 1375  1064  1 39  0 60
  0  3   3080   2472   1160 817124    0    0  3076 100852 1345  1138  1 23  0 76
  2  4   3080   2836   1148 816228    0    0  3336 100412 1352  1379  1 47  0 52
  0  4   3080   2708   1144 815964    0    0  3844 48908 1343   871  1 25  0 74
  0  3   3080   2748   1152 815984    0    0  3332 71996 1338   843  1 27  0 72

Cheers,

Prakash

--------------enig559EAC5132B65144CC4A3F9A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBr5S8xU2n/+9+t5gRAs1yAKD7LjRcYdRdqoDrWGLjChLhjQXAtgCdECfZ
EnYoLKZ+cES1fClTbukAMNE=
=yG0A
-----END PGP SIGNATURE-----

--------------enig559EAC5132B65144CC4A3F9A--
