Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSJDC2R>; Thu, 3 Oct 2002 22:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbSJDC2R>; Thu, 3 Oct 2002 22:28:17 -0400
Received: from adsl-157-199-164.dab.bellsouth.net ([66.157.199.164]:21218 "EHLO
	midgaard.us") by vger.kernel.org with ESMTP id <S261448AbSJDC2K>;
	Thu, 3 Oct 2002 22:28:10 -0400
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem
	logging macros, SCSI RAIDdevice)
From: Andreas Boman <aboman@nerdfest.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20021003220553.GA13540@suse.de>
References: <200210031551.g93FpwsR000330@darkstar.example.net>
	 <Pine.LNX.4.44.0210030852330.2066-100000@home.transmeta.com>
	 <20021003165142.GA25316@suse.de> <3D9CABF5.BA216802@digeo.com>
	 <20021003220553.GA13540@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dyvx8y+ztpWmxsR57oxh"
Organization: 
Message-Id: <1033703194.22153.8.camel@asgaard.midgaard.us>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 03 Oct 2002 22:46:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dyvx8y+ztpWmxsR57oxh
Content-Type: multipart/mixed; boundary="=-di2gQQbC111JLZZxuy/m"


--=-di2gQQbC111JLZZxuy/m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-10-03 at 17:05, Dave Jones wrote:
<SNIP>
>  > > We still need some work for low memory boxes (where low isn't
>  > > necessarily all that low). On my 128MB laptop I can lock up the box
>  > > for a minute or two at a time by doing two things at the same time,
>  > > like a bk pull, and switching desktops.
>  >=20
>  > Specific version info and all the usual how-to-reproduce info
>  > would help here.  Things have changed a _lot_ in the past
>  > week or two.
> That was 2.5.39 + bk from just before .40 hit the streets.
> I'll pull something current in a tick, and give that a shot.
>=20
>  > Comparisons with 2.4 are useful.  Simple "here's how to
>  > reproduce" instructions are 100% golden ;)
Usually its difficult with theese 'feeling' issues though...

> theres usually not too much going on on the laptop.
> It runs enlightenment + gnome 1.4. A few gnome-terminals,
> and thats about it. After bitkeeper had sucked down a few
> changesets and started its "lets grind the disk for a while"
> consistency thing, interactive feel is approaching nil.
> Trying to focus a different window takes about 5 seconds minimum.
> Switching desktops takes 30 seconds minimum.
>=20
> My completely unscientific guess here is that bitkeeper is
> whoring all the I/O bandwidth, and we're trying to swap at
> the same time, which is getting starved.
> I'll try and reproduce after some sleep with vmstat running
> if this will be of use.
>=20
<SNIP>
> =20
>  > It should be immune to our traditional catastrophic failure
>  > scenarios, and that's something which we want to keep.  There are
>  > some ten- or twenty-percent regressions in some areas, but at this
>  > time that's a reasonable price to pay for not locking up, not having
>  > five-minute comas, not exhibiting massive stalls when there's a
>  > lot of disk writeout, etc.  I think history teaches us to value
>  > simplicity, predictability and robustness over performance-in-corner-c=
ases.
>=20
> Hmm, my case seems to be everything you say should not be happening
> any more. Sorry 8-)
> I *can't* be the only one seeing this though.
You arent ;)

> The laptop disk is no speed demon, but its quite nippy at ~12MB/s
> For obvious reasons, having swap and / on the same disk is making
> a considerable impact here.
> 		Dave

I'm seeing similar behavior, though not to the extent you describe. 512M
ram, ~600 or so swap on a U160 scsi disk (only one disk in the box
-definitely need one more).=20

rpm -ba mozilla.spec and while its untar/gunziping i keep switching
desktops ("edge flip" in E) between one with a few Eterms and misc
stuff, and one with mozilla. At first it behaves fine, but eventually
the mouse pointer will start jerking around and itll be slightly slower
to switch, a little later the swapping starts and xmms will skip
(sometimes just once, othertimes repetedly). Once the untaring is done
and the build starts the box becomes responsive again.=20

Doing the same thing on 2.4.20-pre5aa2 xmms never skipped, starting a
build of mozilla and evolution at the same time, still no skipping. Drop
xmms and play a music video in MPLayer -still no skipping. I could even
move the MPlayer output window back and forth between the desktops
repetedly although i didnt move it around as fast as when i was just
switching desktops, without sound skips video playback did freeze up a
bit and left funky trails across the mozilla page at times), but sound
didnt skip. Sound started skipping when i had mozilla and evolution both
untar/ungzipping and I moved the window around madly between heads and
desktops.

the attached vmstat 1 from 2.5.40 is taken from when the build has just
started until a little after I killed it (when it had untared and
started ./configure). A little time goes by after i kill it I see a
little more IO and then the box just idles again.

--=20
Andreas Boman <aboman@nerdfest.org>

--=-di2gQQbC111JLZZxuy/m
Content-Disposition: attachment; filename=vmstat-2.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-troff-man; name=vmstat-2.5; charset=ANSI_X3.4-1968

   procs                      memory      swap          io     system      =
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy=
 id
 0  1  0   3396  14400  20252 281056    0    0     7    31 1049   966  2  1=
 97
 2  1  0   3396  15276  20252 281032    0    0     0  9070 1435  2781  4 17=
 79
 2  1  1   3396  24692  20252 272660    0    0     0  9356 1391  2359  3 20=
 77
 1  1  0   3396  34404  20252 263960    0    0   108  8720 1361  2307  3 19=
 78
 2  1  1   3396  53132  20284 251936    0    0    36  9439 1459  2731  4 24=
 72
 1  1  0   3396  63500  20296 242480    0    0    12  7476 1378  3008 33 19=
 49
 4  0  0   3396  79712  20316 227232    0    0    20  9491 1586  3942 17 17=
 66
 2  1  0   3396  90452  20316 217404    0    0     0  6977 1338  4500 40 19=
 41
 3  0  0   3396 100776  20348 208072    0    0    32  8500 1462  3455 37 20=
 43
 2  1  0   3396 104468  20376 199008    0    0    28  7257 1371  4254 42 20=
 38
 1  1  0   3396 131784  20376 183716    0    0     0  9865 1431  4052 15 21=
 64
 3  1  0   3396 143788  20376 172712    0    0     0  8677 1391  4010 39 20=
 42
 1  1  1   3396 153436  20376 163860    0    0     0  7420 1331  2924 36 17=
 47
 9  0  0   3396 165512  20380 152860    0    0     4 10658 1481  4092 15 19=
 65
 1  1  0   3396 174536  20380 148644    0    0     0  8932 1514  4917 38 22=
 40
 1  1  0   3396 189456  20384 134752    0    0     4  8789 1418  4624 40 26=
 34
 2  1  0   3396 197220  20384 127816    0    0     0  8775 1448  3069 34 26=
 40
 1  1  0   3396 210400  20384 115596    0    0     0  7912 1406  4613 42 23=
 35
 4  0  0   3396 208716  20388 107332    0    0     4  7208 1383  4494 38 21=
 41
 3  0  0   3396 228860  20388  93812    0    0     0  8451 1447  4674 34 23=
 44
 2  1  0   3396 247848  20388  85264    0    0     0  8784 1444  4362 31 22=
 47
   procs                      memory      swap          io     system      =
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy=
 id
 1  1  0   3396 236480  20532  96428    0    0   572  6653 1376 10165 53 31=
 16
 3  0  1   3396 207996  20680 112528    0    0  1332  4628 1448 12121 60 29=
 11
 4  1  0   3396 183432  20868 134940    0    0   808  5856 1393 14025 55 36=
  9
 2  1  1   3396 183628  20892 141036    0    0     0  8423 1311  7492 42 14=
 45
 2  0  1   3396 182692  20956 147336    0    0   256  6869 1314  6438 30 18=
 52
 1  1  1   3396 177700  21028 151484    0    0     0  7266 1368  6928 47 19=
 34
 4  0  0   3396 172476  21108 156040    0    0   256  9156 1331  4612 10 14=
 76
 1  1  1   3396 166332  21144 161548    0    0    76  5618 1221  6092 45 13=
 42
 2  1  1   3396 166288  21144 161548    0    0     0 14624 1231  3201 17  7=
 76
 4  0  0   3396 148396  21196 167636    0    0     0  3817 1362  5651 39 18=
 44
 1  1  1   3396 145884  21348 178680    0    0    44  6402 1338 10058 23 31=
 45
 3  1  0   3396 144648  21356 179820    0    0   136  9280 1232  4117 44  9=
 48
 1  1  1   3396 133908  21496 188956    0    0   152  4673 1214  6416 44 22=
 34
 1  1  1   3396 133836  21500 188988    0    0     0 12320 1172  2957 13  6=
 81
 3  0  0   3396 118440  21644 202500    0    0   644  4637 1264  9888 47 28=
 26
 4  0  0   3396 107768  21668 203516    0    0     0  8848 1245  4542 29 10=
 61
 1  1  1   3396 109644  21748 209964    0    0   388  7884 1273  6321 34 22=
 45
 5  0  0   3396 100180  21844 218488    0    0   444  8121 1252  7027 41 20=
 40
 3  1  1   3396  97868  21852 220556    0    0    76  8588 1370  4439 22 14=
 64
 1  1  1   3396  91240  21904 226416    0    0     0  5969 1267  7393 42 18=
 40
 3  0  0   3396  85724  21920 231624    0    0   424  7400 1217  4708 37 14=
 48
   procs                      memory      swap          io     system      =
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy=
 id
 1  1  2   3396  80444  21932 236348    0    0     0 10248 1267  5512 19 15=
 66
 1  1  1   3396  73232  22000 242852    0    0   148  8248 1236  6901 48 19=
 34
 5  0  0   3396  55848  22088 248628    0    0   244  6668 1217  5089 37 15=
 49
 1  1  1   3396  60656  22212 253772    0    0   348  8276 1304  6179 22 14=
 64
 2  1  0   3396  53080  22392 260172    0    0   136  5636 1326  7550 52 23=
 25
 1  1  1   3396  49040  22492 263620    0    0   188  7792 1379  3531  7 11=
 82
 4  0  0   3396  44024  22620 267796    0    0   116  8148 1222  4894 37 14=
 49
 2  1  1   3396  36344  22808 274128    0    0   428  7889 1298  6797 19 22=
 59
 1  1  0   3396  33844  22868 276328    0    0    32  9904 1230  5689 48 12=
 40
 1  1  0   3396  24416  23072 284420    0    0   216  3138 1313  6549 44 19=
 37
 1  1  1   3396  17684  23196 290352    0    0    72  8516 1242  6248 23 14=
 63
 3  0  0   3396  14308  23280 293168    0    0   160  7528 1287  3761 41 11=
 48
 1  2  1   3396   1512  21128 302688    0    0   280  5103 1346  8892 29 24=
 47
 1  2  1   5216   3348  19120 299492    0 1828     0  7631 1423  1560  4  5=
 91
 1  2  1   5216   2916  19128 299732    0    0     8  9833 1346  1953  2  5=
 93
 1  1  1  12552  13856  19120 298196    0 7336   136 14580 1253  4235 36  9=
 55
 3  0  0  12552   3216  19140 299408    0    0   136  5540 1279  3163 20  7=
 73
 2  1  1  20460   2780  19468 308672    0 7908   484 11125 1282  9327 39 26=
 35
 1  2  1  23540   1528  19436 303452    0 3080     0  8232 1265  2440 14  5=
 81
 1  1  0  25572  11904  19424 299704    0 2032    24  8980 1288  2168 24  9=
 67
 2  1  1  27128   2492  19604 308280    0 1556  1456  6205 1356  7760 23 19=
 58
   procs                      memory      swap          io     system      =
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy=
 id
 1  3  2  27868   1472  19584 307736    0  740     0 11104 1305  2033 10  9=
 81
 0  5  1  30432   1576  19544 306240    0 2564     8  8257 1394  1206  1  5=
 94
 0  5  2  30688   1548  19544 306236    0  256     0  9483 1269   631  0  6=
 94
 0  4  1  34788   1632  19516 303624    0 4336     0 11993 1285  1351  3  5=
 92
 2  1  1  37736  12796  19520 298740    0 3328     4 12364 1237  4040 35  8=
 57
 2  1  2  40640   2560  19640 297620    0 2928   540  6092 1320  4530 31 14=
 55
 3  0  0  40640   5576  19760 304528    0    0  1160  5912 1332  6053 22 16=
 62
 3  1  1  41448   2568  19776 306176    0  832   664 10389 1300  5790 20 13=
 67
 5  0  0  41740   8124  19728 300808    0  292   256  5973 1378  6105 40 21=
 40
 3  1  2  41764   2240  19644 300156    0  280   640  7426 1403  4245 17 18=
 65
 2  1  0  41764  12140  19580 295992    0    0   128  8229 1399  3599 31 12=
 57
 1  2  1  41772   1516  19732 301572    0    8  1416  5621 1392 10771 33 31=
 37
 3  0  0  41772   9276  19784 296776    0    0   640  7432 1342  4156 31 14=
 55
 1  1  0  41772   2460  20024 301428    0    0   896  5322 1412  7754 22 30=
 48
 1  2  1  41808   1512  19936 294832    0   36   896  7349 1342  5280 19 16=
 65
 3  1  1  41808   4932  20104 296940   28    0   812  5002 1402  8322 42 26=
 33
 1  2  1  41816   1556  20200 294032    0    8   768  7435 1378  5621 22 24=
 54
 0  1  0  41820   5240  20316 294572    0    4   928  4532 1343  7414 40 19=
 40
 1  2  1  41832   1504  20388 291856    0   12   792  7414 1380  5893 22 17=
 61
 3  0  0  41840   2608  20692 294840    0    8  1048  4801 1433  7643 31 35=
 35
 4  0  1  41840   2596  20888 293356    0    0     8  6648 1359  5357 18 25=
 57
   procs                      memory      swap          io     system      =
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy=
 id
 4  0  0  41840   6004  20756 284540   40    4    40  5057 1348  2733 26 30=
 44
 1  1  0  41820  12672  21180 283368    4   24   844  2281 1387  3338 28 28=
 44
 1  1  0  41820  12412  21432 283368    0    0   268  2947 1339  3808 18 14=
 68
 1  1  0  41816  13396  21640 282212    0    0   232  1633 1378  3240 40 12=
 49
 1  1  0  41816  13216  21648 282212    0    0     8  5642 1429  3585 16 22=
 62
 2  0  0  41816  13196  21832 282212    0    0   184  4016 1336  2220  7 39=
 54
 1  1  0  41816  12876  22016 282212    0    0   184  4112 1363  2347  9 22=
 69
 2  1  0  41816  11968  22192 282924    0    0   768  3088 1476  2351  9 22=
 69
 2  1  0  41816   9140  22200 284200    0    0  1272    32 1217  3178 45 36=
 19
 4  0  0  41820  13712  22188 280732    0  100  1544   260 1305  3531 66 21=
 13
 3  0  0  41820  10560  22252 281876    0    0  1188   391 1222  4079 56 30=
 14
 2  0  1  41820   9348  22252 282160    0    0   284   512 1102  2343 58 38=
  4
 3  0  0  41820  10616  22340 282552    0    0   360   352 1301  2887 50 35=
 15
 2  0  0  41820  10432  22412 283064    0    0   584   448 1172  2411 44 38=
 17
 2  0  0  41820   9508  22452 283332    0    0   300   480 1155  2551 54 33=
 13
 2  0  0  41820   9336  22492 283484    0    0   188   739 1162  2359 55 31=
 14
 1  1  0  41820   9496  22492 283780    0    0   236   352 1074  1878 73 21=
  6
 1  0  0  41820  11308  22540 283928    0    0   264    96 1083  1619  8  6=
 86
 2  0  0  41820  11300  22540 283928    0    0     0     0 1044  1511  4  1=
 95
 2  0  0  41820  11304  22540 283928    0    0     0     0 1108  1894  4  1=
 95
 2  0  1  41820  11136  22540 284056    0    0     0  6400 1385  2240  4 23=
 73
   procs                      memory      swap          io     system      =
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy=
 id
 1  0  0  41820  11196  22540 284056    0    0     0  1680 1091  1597  3  2=
 95
 1  0  0  41820  11188  22540 284056    0    0     0     0 1099  1809  3  1=
 96
 1  0  0  41820  11160  22540 284056    0    0     0    34 1077  1674  5  1=
 94
 1  0  0  41820  11164  22540 284056    0    0     0     0 1101  1751  2  1=
 97
 2  0  1  41820  11108  22540 284056    0    0     0  8363 1149  1689  3  6=
 91
 1  0  1  41820  11148  22540 284056    0    0     0  7648 1233  1798  1  6=
 93
 1  0  1  41820  11200  22540 284056    0    0     0 10272 1204  1782  3  6=
 91
 1  0  0  41820  11088  22540 284184    0    0     0  2020 1198  1587  1  2=
 97
 1  0  0  41820  11088  22540 284184    0    0     0     0 1044  1525  2  1=
 97
 2  0  1  41820  11036  22540 284184    0    0     0  8414 1149  1548  3  7=
 90
 2  0  1  41820  11044  22540 284184    0    0     0 10152 1232  1906  3  8=
 89
 1  0  0  41820  11068  22540 284184    0    0     0  4160 1224  1954  3  8=
 89
 1  0  0  41820  11052  22540 284184    0    0     0     0 1044  1503  3  1=
 96
 1  0  0  41820  11056  22540 284184    0    0     0     0 1048  1458  3  1=
 96
 1  0  0  41820  11036  22540 284184    0    0     0  1106 1066  1470  4  7=
 89
 1  0  0  41820  11040  22540 284184    0    0     0     8 1067  1589  3  1=
 96
 1  0  0  41820  10896  22540 284312    0    0     0     0 1264  2202  3  1=
 96
 1  0  0  41820  10904  22540 284312    0    0     0     0 1098  1797  4  1=
 95
 1  0  0  41820  10964  22540 284312    0    0     0     0 1105  1802  4  1=
 95
 1  0  0  41820  10968  22540 284312    0    0     0    46 1047  1444  3  3=
 94
 1  0  0  41820  11056  22540 284312    0    0     0     0 1058  1561  4  1=
 95
   procs                      memory      swap          io     system      =
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy=
 id
 1  0  0  41820  11060  22540 284312    0    0     0     0 1133  1925  3  1=
 96
 0  0  0  41788  11288  22540 284312    0    0     0     0 1085  1414  5  1=
 94
 0  0  0  41788  11088  22540 284312  172    0   172     0 1053   712  3  0=
 97
 1  0  0  41788  11108  22540 284312    0    0     0   175 1081   779  2  2=
 96
 0  0  0  41788  11104  22540 284312    0    0     0     0 1032   562  1  1=
 98
 1  0  0  41788  11108  22540 284312    0    0     0     0 1024   469  1  0=
 99
 0  0  0  41788  11100  22540 284312    0    0     0     0 1022   501  2  1=
 97
 1  0  0  41788  11104  22540 284312    0    0     0     0 1027   504  1  0=
 99
 0  0  0  41788  11176  22540 284312    0    0     0  1112 1090   646  1  1=
 98
 0  0  0  41788  10476  22540 284312  660    0   660     0 1144  1500  1  0=
 99
 0  0  0  41788  10468  22540 284312    0    0     0     0 1057   870  2  0=
 98
 0  0  0  41788  10464  22540 284312    0    0     0     0 1026   521  2  1=
 97
 2  0  1  41788  10456  22540 284312    0    0     0     0 1069  1050  1  0=
 99
 1  0  0  41788  10448  22540 284312    0    0     0    85 1056   721  2  0=
 98
 1  0  0  41788  10456  22540 284312    0    0     0     9 1030   469  1  0=
 99
 0  0  0  41788  10448  22540 284312    0    0     0     0 1022   481  2  1=
 97
 0  0  0  41788  10488  22544 284320    0    0     4     0 1036   471  1  0=
 99
 0  0  0  41788  10480  22544 284320    0    0     0     0 1030   556  1  0=
 99
 0  0  0  41788  10500  22544 284320    0    0     0    69 1088   879  1  1=
 98
 0  0  0  41788  10492  22544 284320    0    0     0     0 1092   995  2  0=
 98
 0  0  0  41788  10496  22544 284320    0    0     0     0 1090  1328  1  0=
 99
   procs                      memory      swap          io     system      =
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy=
 id
 0  0  0  41788  10460  22544 284328   12    0    20     0 1034   552  2  1=
 97
 0  0  0  41788  10448  22544 284328    0    0     0     0 1030   471  2  0=
 98
 0  0  0  41788  10440  22544 284328   32    0    32     0 1027   536  1  1=
 98
 0  0  0  41788  10432  22544 284328    0    0     0     0 1024   488  2  1=
 97
 1  0  0  41788  10432  22544 284328    0    0     0     0 1098   991  2  6=
 92
 1  0  0  41788  10424  22544 284328    0    0     0     0 1030   515  2  0=
 98
 0  0  0  41788  10428  22544 284328    0    0     0     0 1055   702  2  3=
 95
 0  0  0  41788  10416  22544 284328    0    0     0     8 1124  1021  7  4=
 89
 0  0  0  41788  10416  22544 284328    0    0     0     0 1103   934  4  2=
 94

--=-di2gQQbC111JLZZxuy/m--

--=-dyvx8y+ztpWmxsR57oxh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.1.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9nQ8ahXYFl8ZlUpARAqI6AKDOYvRUzgPYigYEXgf+mBRiX0hi8wCg+ROP
QMTJG6GhdaQ+439AkejNhRk=
=LARm
-----END PGP SIGNATURE-----

--=-dyvx8y+ztpWmxsR57oxh--

