Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030740AbWK3RGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030740AbWK3RGw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 12:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030770AbWK3RGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 12:06:51 -0500
Received: from ip-85-160-4-204.eurotel.cz ([85.160.4.204]:49670 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1030740AbWK3RGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 12:06:50 -0500
Date: Thu, 30 Nov 2006 18:06:46 +0100
From: "gary.czek" <gary@czek.info>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ICH6M SATA Controller, SATA2 NCQ disk and high iowait CPU time
Message-ID: <20061130180646.66dc622b@localhost>
In-Reply-To: <456A5936.9080903@gmail.com>
References: <1164404380.20334.37.camel@localhost>
	<456A5936.9080903@gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.6; i486-pc-linux-gnu)
X-Operating-System: Ubuntu Edgy Eft (Linux i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <htejun@gmail.com> wrote:

> gary.czek wrote:
> > Hi, I have problem with my notebook Fujitsu-Siemens V8010. It has
> > Intel ICH6M chipset with SATA Controller. And SATA II disk Fujitsu
> > MHT2040BH with NCQ. If there is request on disk, iowait time of CPU
> > gets to 100% and whole system gets totally unresponsible. For
> > example apt upgrade (of average 10 packages totaling 30MB in .debs)
> > gets 30 minutes. CPU iowait time gets about 95% for whole 30
> > minutes.
> > 
> > My notebook details:
> > CPU: Intel Celeron M 1,4GHz
> > MEM: 256MB 333MHz
> > HDD: Fujitsu MHT2040BH SATA II, NCQ, 5400rpm, 8MB buffer
> > SWP: 512MB swap partition
> > Chipset: ICH6M 82801FBM
> > GPU: Intel i915GM integrated
> > 
> > kernel: 2.6.19-rc5
> > SATA Controller/disk driver: ata_piix and ahci tested, but results
> > of both were almost the same.
> 
> 1. does 'mount -o remount,barrier=0 /' change anything?
> 
> 2. 256MB is really small if you're running modern desktop
> environment. Please post the result of 'vmstat 5' while the machine
> is really slow.
> 

First of all. I've reinstalled Ubuntu and installed Xfce instead of
Gnome. It seemed to me that it was much faster after reinstall. But as
I installed as much programs as I had installed before reinstall it
seems to me that it goes back to problems. Maybe it could by because of
I have running MySQL and PostgreSQL dbs. But they are accessed
minimally-not big queries and not so frequently (Only for use on
localhost). I use for some work postgres and for other mysql.


1. no, that changes nothing. Maybe I just didn't recognised the
difference.

2. if I coldn't find the real problem, I'll buy 1Gig RAM immediatelly.

"vmstat 5" when system is really slow shows following:

procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 0  9 285904   3044    832  42088   75   46   247    98  484  746  5  2 80 13
 0  4 285560   3628    692  43724  686   71   913   418  952 1651 18  3  0 79
 0  3 285000   3616    688  43100  822   15  1431   766  939 1761 16  4  0 80
 0  3 284372   3612    700  42344  703    0  1234    43  941 1697 18  3  7 72
 1  2 284012   3176    580  42800  406    0  1054    74  834 1602 15  4 36 45
 0  3 283820   3888    824  40044  413   23  1102    95  865 1767 17  3  0 80
 0  1 286364   3904    900  41508   63  540  1023   629  928 1646 15  3  0 82
 0  2 287500   4884   1120  44840  388  338  1606   431  902 1670 13  4  0 83
 0 10 291148   3104   1296  46088  396  827   923   877  917 1521 10  3  0 87
 0  3 292952   3728   1492  47524  259  474   730   606  889 1754 15  2  0 84
 0  2 294960   3540   1588  47488  633  632   970   678  863 1630 12  2  0 86
 0  2 297444   3828   1676  46496  648  674   774   735  886 1906 14  2  0 84
 0  3 298184   3616   1684  46420  593  290   759   331  844 1792 12  3  0 85
 0  5 297836   3852   1508  43576  632  168   990   229  814 1605 10  1  0 88
 0  3 297996   4084   1240  41552  876  315   981   345  866 1466  7  2  0 91
 0  5 296632   3272   1100  38324 1084   19  1593    59  878 1756  8  2  0 90
 0  9 295768   3840   1128  38332  801   14  1244   170  870 1385  9  2  0 89
 0  5 294748   3812   1068  37924  705    0  1053    61  844 1547 12  2  0 86
 0  6 293664   3588   1100  37844  832    0  1206    23  848 1765 16  1  0 82
 0  2 293040   4308   1152  37388  638    5  1070   101  680 1524 13  1  0 86
 2  4 294140   3908   1248  37772   30  235   750   425  791 1539 14  3  0 83
 0  2 295608   3876   1452  38568  185  356   676   464  883 1658 12  3  0 85
 0  4 297092   3552   1500  38188  497  424   842   532  871 1433  9  2  0 89
 0  4 298484   4004   1488  38136  612  416   806   563  866 1371  9  2  0 89
 0  5 300004   4376   1476  38524  468  433   913   490  773 1475 12  1  0 86
 0  3 303592   3948   1508  39556  286  844   993  1022  459 1457 16  1  0 82
 0  2 305068   3644   1428  39000  399  385   868   482  871 1579 12  3  0 84
 0  2 304912   3460   1464  40136  317   52  1200   139  710 1573 12  2  0 87
 0  3 305848   3924   1808  39856  462  326   794   470  659 1491 13  3  0 84
 0  9 312892   3260   1200  48304  354 1590  1477  5350  846 3194  8  6  0 87
 0 12 314740   3356   1252  48252  747  478  1306  1416  643 1370  2  1  0 96
 0  9 315192   3800   1380  46372  727  260  1390  1706  430 1484  2  1  0 97
 0  5 313996   3716   1540  43844  826   49  1387   181  457 1311  0  1  0 99
 0  9 313088   2928   1528  40200 1021   25  1742    67  435 1275  1  1  0 98
 0 10 312608   3664   1484  38452  714    0  1438   436  391 1139  1  1  0 98
 0 10 311692   3520   1564  37928  986    0  1876    87  431 1133  1  1  0 98
 0  8 297540   3436   1532  38008 1000    0  1813   111  763 1360  3  2  0 95
 0 10 296264   3636   1292  39056  796    0  2186   196  853 1456  1  2  0 97
 0 10 295476   3948    984  40616  440   25  2082   162  783 1380  1  1  0 97
 0  9 293580  25044   1088  44084  346    0  1915   159  373 1339  3  1  0 96
 0 21 292148  16892   1220  45908 1228    0  1618   286  414 2652  1  2  0 97
 0 20 290812   3420   1276  48468 1349    0  1862    14  575 1823  3  3  0 94
 0 25 290764   3172   1036  45176  831  231  1337   289  824 3387  1  2  0 96
 0 20 289884   4144    772  42756  802   22  1173    34  794 1227  0  2  0 98
 0 23 289976   3612    644  44300  722  186  1204   211  595 1203  0  2  0 98
 0 22 289108   3088    720  45608  694    0  1087    28  379 1092  3  0  0 97
 0 24 288328   3824    844  44304  699   13  1266    61  382 1210  2  1  0 97
 0 18 287232   3792    816  42800 1013    0  1258    46  392 1209  5  1  0 94
 0 19 286932   4348    764  44516  598  104  1489   141  379 1127 25  0  0 75
 0 17 286136   3924    836  44672  678    6  1015    71  403 1122  3  1  0 96
 0 20 286872   3116    688  45728  566  318  1508   345  445 1017  2  1  0 96
 0 18 288712   4008    736  45680  403  446  1121   474  759  950  2  1  0 97
 0 22 288700   3068    652  46824  722  163  1489   208  684 1135  1  1  0 98
 0 30 289812   3204    720  46408  471  307  1002   317  454 1240  7  1  0 92
 0 26 290196   2940    744  45684  726  228  1573   304  467 1198  3  1  0 96
 2 18 289556   3776    752  42448  825   46  1425   126  457 1552 15  1  0 85
 0 15 288872   3684    772  41244  696    5  1326    30  423 1384 21  1  0 78
 0 16 288168   3916    688  41116  661    5  1601    50  430 1266 12  1  0 88
 0 15 287252   3460    768  40552  791    0  1431    58  456 1361  6  1  0 94
 0 12 286428   3952    764  40156  694    8  1329    50  438 1330  4  1  0 95
 0 13 286400   3472    796  40304  636  202  1585   235  450 1293  4  1  0 95
 0 13 287240   3444    756  41528  398  295  1398   323  453 1202 10  1  0 88
 0 10 287868   3996    816  42396  378  216  1378   274  459 1208  6  0  0 93
 0 16 289792   2976    884  42992  404  474  1381   477  448 1302  8  1  0 90
 1 13 289424   4032    772  41468  707   69  1407   128  914 1462 15  2  0 83
 0 10 290736   3380    664  42468  508  434  1635   461  934 1551 31  1  0 68
