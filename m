Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTJ2E5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 23:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTJ2E5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 23:57:37 -0500
Received: from auth22.inet.co.th ([203.150.14.104]:20237 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S261861AbTJ2E5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 23:57:33 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Nick Piggin <piggin@cyberone.com.au>, Dave Olien <dmo@osdl.org>
Subject: Re: 2.6.0-test8/test9 io scheduler needs tuning?
Date: Wed, 29 Oct 2003 12:56:17 +0800
User-Agent: KMail/1.5.2
Cc: cliff white <cliffw@osdl.org>, linux-kernel@vger.kernel.org
References: <200310261201.14719.mhf@linuxmail.org> <20031028211844.GA8285@osdl.org> <3F9F28B8.9030807@cyberone.com.au>
In-Reply-To: <3F9F28B8.9030807@cyberone.com.au>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310291256.17904.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 October 2003 10:40, Nick Piggin wrote:
> 
> Dave Olien wrote:
> 
> >Yes, it seems Nick's latest patch from 10/27, has helped reaim
> >considerably.
> >
> >The dbt2 workload still has a problem though.  Mary ran this patch today,
> >with deadline and with as-iosched:
> >
> >2.6.0-test9, elevator=deadline			1644 NOTPM 
> >2.6.0-test9, unpatched as-iosched		 977 NOTPM
> >2.6.0-test9, as-iosched with as-fix.patch	 980 NOTPM
> >
> >Higher NOTPM numbers are better.
> >
> 
> OK, how does 2.6.0-test5 go on these tests?
> 

-test5 looks good with 4 dd loops 4K x 5000. The disk is busy as expected.

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 3  2  3      0 114488  11816 165872    0    0     0 39352 1116  1047 34 66  0
 0  4  1      0 114616  11848 165872    0    0     0   932 1162  1495 49 51  0
 0  4  2      0 114848  11852 165872    0    0     0 25300 1283 11355 59 41  0
 0  4  1      0 115168  11860 165872    0    0     0 14364 1328  1286 79 21  0
 1  4  2      0 114464  11912 165872    0    0     4 12196 1424  1488 38 62  0
 0  4  1      0 113968  11912 150412    0    0     0 31460 1316  1308 72 28  0
 0  4  2      0  93424  11936 165872    0    0     0 25148 1249  1374 61 39  0
 6  2  3      0 118704  11936 140748    0    0     0 19972 1156  1061 82 18  0
 4  4  3      0 102128  11960 157672    0    0     0 16324 1217   655 43 57  0
 0  4  2      0  93568  11980 165872    0    0     0 35948 1230  1199 50 50  0
 0  4  4      0  95680  12056 148552    0    0     4 28840 1148  1443 42 58  0
 0  4  2      0  75456  12068 165872    0    0     0 23936 1145  1354 61 39  0
 1  3  4      0  95488  12076 146204    0    0     0 30080 1197  1410 60 40  0
 0  4  4      0  75904  12120 165872    0    0     0 23476 1171  1338 48 52  0
 0  4  4      0  76032  12120 165872    0    0     0  9312 1259  1169 83 17  0
 1  4  4      0  76160  12120 165872    0    0     0  9008 1282  1324 83 17  0
 5  2  4      0  84608  12120 150592    0    0     0 17116 1357   892 42 58  0
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 4  4  4      0  69312  12152 165872    0    0     0 12016 1437   892 39 61  0
 0  4  4      0  68608  12152 165872    0    0     0 45376 1302  1236 67 33  0
 1  4  4      0  71936  12160 155532    0    0     0 21628 1127  1233 72 28  0
 4  0  0      0 128000  12176 100984    0    0     0    68 1160  1790 67 33  0
 4  0  0      0  98752  12200 129524    0    0     0 31108 1216  1493 53 47  0
 2  2  1      0 114048  12236 111252    0    0     0 49072 1103  1540 44 56  0
 6  1  1      0 103424  12264 122360    0    0     0 22928 1089  1078 39 61  0
 0  4  4      0  58752  12288 165872    0    0     0 20816 1208  1014 42 58  0
 0  4  4      0  65216  12288 157616    0    0     0 12664 1279  1199 83 17  0
 0  4  4      0  70016  12288 151924    0    0     0 10912 1466  1535 78 22  0
 2  4  4      0  54144  12320 165872    0    0     0 33336 1367  1505 39 61  0
 0  4  1      0  63296  12344 156824    0    0     0 35460 1239  1142 34 66  0
 0  4  1      0  68480  12344 146736    0    0     0 12992 1087  1336 79 21  0
 0  4  1      0  48192  12356 165872    0    0     0 27260 1226  1303 63 38  0
 4  3  1      0  48448  12404 165872    0    0     0 20204 1118  1224 41 59  0
 0  4  2      0  47872  12444 165872    0    0     0 15636 1260  1036 29 71  0
 0  4  1      0  47360  12444 165872    0    0     0 39544 1550  1137 73 27  0
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  4  2      0  66176  12444 131464    0    0     0  7744 1154  1235 83 17  0
 0  4  2      0  15248  12468 158968    0    0     0 38432 1330  1354 42 58  0
 5  0  1      0  21096  12500 153784    0    0     0 10516 1173  1391 66 34  0
 0  4  2      0   8288  12524 165872    0    0     0 43688 1167  1205 56 44  0
 6  2  1      0  15208  12524 158452    0    0     0 24712 1150  1052 77 23  0
 5  4  2      0  20896  12544 153536    0    0     0 23460 1109  2717 24 76  0
 3  1  3      0   9088  12568 148068    0    0     0 10012 1182  1287 45 55  0
 0  4  3      0   4736  11600 152360    0    0    76 41456 1290  1353 59 41  0
 2  2  3      0   4884  11632 152228    0    0     0 21648 1116  1253 61 39  0
 0  4  3      0   5096  11656 152360    0    0     0 13516 1180  1511 61 39  0
 1  3  3      0   5192  11656 152360    0    0     0 30244 1187  1303 58 42  0
 0  4  3      0  18728  11656 134228    0    0     0 13896 1188  1331 79 21  0
 0  4  3      0   4720  11464 148240    0    0     0 25356 1363  1452 58 42  0
 9  0  1      0  44384  11504 109656    0    0     0  1168 1202   493 37 63  0
 0  4  3      0   4336  11564 148240    0    0     0 21092 1150  1169 38 62  0
 0  4  1      0   4264  11564 137308    0    0     0 25324 1372  1298 76 24  0
 1  3  3      0   6832   9220 119764    0    0     4 22976 1333  1546 48 52  0
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 2  3  4      0   9904   9244 108500    0    0    12 45416 1280  1561 53 47  0
 0  4  2      0  13360   8880 111916    0    0     0 22484 1171  1421 58 42  0
 1  3  4      0  14704   8928 116296    0    0     0  6052 1103  1480 48 52  0
 0  4  1      0  15972   8924 114916    0    0     0 59612 1182   763 52 48  0
 1  4  2      0   4772   8948 126216    0    0     0 20096 1092  1297 59 41  0
 7  1  2      0  11684   8964 119392    0    0     0  9436 1113  1314 33 67  0
 0  4  3      0   5096   8984 126216    0    0     0 17428 1300   963 54 46  0
 1  4  3      0   4776   8984 126216    0    0     0 19224 1219  1356 79 21  0
 0  4  3      0   4972   8984 126216    0    0     0 14704 1288  1173 83 17  0
 0  4  3      0  26868   9020  94336    0    0     0 20624 1277  1462 55 45  0
 0  4  3      0   5296   9036 126216    0    0     0  9892 1487  1434 54 46  0
 0  4  3      0   4976   9036 126216    0    0     0 32264 1266  1285 75 25  0
 0  4  1      0   5360   9036 126216    0    0     0 17008 1186  1358 80 20  0
 6  2  1      0  42800   9064  89960    0    0     0 14196 1267   559 35 65  0
 0  4  1      0  26224   9092 106216    0    0     0 20112 1178  1187 56 44  0
 0  4  2      0  45940   9128  86220    0    0     0 40196 1179  1425 42 58  0
 0  4  4      0   9840   8908 118928    0    0     0 28412 1195  9048 36 64  0
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  4  3      0   4432   8940 126160    0    0     0 46816 1290  1413 53 47  0
 1  4  4      0   4624   8944 126112    0    0     0  5276 1224  1175 83 17  0
 8  0  4      0   5144   8752 126068    0    0     0  2352 1258  1171 42 58  0
 2  4  4      0   4828   8752 126068    0    0     0 33200 1308   975 70 30  0
 0  4  1      0   5212   8760 126068    0    0     0 24304 1270   775 72 28  0
 1  4  4      0  25316   8840 105672    0    0     0 29824 1209  1467 35 65  0
 1  4  5      0   4964   8848 126068    0    0     0 14264 1271  1438 57 43  0
 1  4  5      0   4900   8848 126068    0    0     0 31776 1197  1246 73 27  0
 1  4  1      0   4964   8856 126068    0    0     0 16076 1173  1328 83 17  0
 9  1  5      0   4260   8892 126068    0    0     0 23992 1252  2280 37 63  0
 2  4  6      0   5284   8916 126068    0    0     0 12236 1250   846 40 60  0
 1  4  6      0   5412   8916 126068    0    0     0 26204 1403  1263 75 25  0
 2  3  6      0  11876   8916 119992    0    0     0 18996 1308  1281 60 40  0
 4  1  3      0  36132   8960  95756    0    0     0 22516 1194  1658 49 51  0
 1  4  6      0   4900   8988 126068    0    0     0 22708 1266  1446 44 56  0
 4  4  4      0   9380   8988 115648    0    0     0 21944 1337  1489 72 28  0
 6  2  4      0   4840   8988 126088    0    0    20 22176 1259   997 75 25  0
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 1  4  1      0   5096   8992 126088    0    0     0 12632 1269  1905 90 10  0
 0  4  1      0  23592   9000 107920    0    0     0 18484 1397  1605 74 26  0
 1  3  3      0   5224   9072 126088    0    0     4 20816 1464  1603 39 61  0

Back to -test9

Also used only noop. Does not make much of a difference as i do not wish to claim it is better ;)

Request queue size above 128 does not make a significant difference either.

I'd say going down to 4 still works about as well in terms of total throughput.

And it is still bloody impossible to make the disk LED stay on.

I'll be back with "measurements" by weekend.

Regards
Michael
	

