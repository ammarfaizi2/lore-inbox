Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTJLXqf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 19:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbTJLXqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 19:46:35 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:54537 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S261240AbTJLXqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 19:46:30 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Mon, 13 Oct 2003 01:46:28 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: __alloc_pages: 0-order allocation failed on 2.4.23-pre5 and pre7
Message-ID: <Pine.OSF.4.51.0310122353440.468559@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  it's a long time I haven't seen sthis messages, but it just happened that
I did on my laptop ASUS L3880C(1GB RAM). The message show on
2.4.23-pre5+acpi20030918 and 2.4.23-pre7. The application get's killed on
2.4.22-acpi20030918 too, just without the "0-order allocation" message.
I enabled in kernel the VM allocation debug option when configuring, but
apparently I have to turn it on also somewhere else. *Documentation* is
missing: 1) the help in "make config/menuconfig" etc. doesn't say anything,
the Documentation subdirectory doesn't say anything except "debug" as
kernel boot option on command-line(I did that too, but no change) and also
linux kernel-FAQ doesn't say either. :(

How I tested?
`gzip -dc file | less' and pressed `G' to jump to the very end of the file.
The filesize is 280MB only. In a while, the mouse stopps moving for a
while, than the system gets sometimes unloaded, fan is raises it's RPM's up
and down town to time, and mouse cursor eventually does a move and then
less command gets killed. In dmesg I found:

__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process less

I can reproduce this. Here's vmstat output started before retrying
this command:

# vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0      0  13412   3748 266364    0    0    14     2  167   132  1  0 99  0
 1  0      0  12740   2992 257324    0    0  4356     0  233  5382 85 13  2  0
 1  0      0  12484   2996 245748    0    0  4996     0  242  6193 96  4  0  0
 2  0      0  12332   3004 234552    0    0  4744     0  238  5944 91  5  4  0
 1  0      0  12136   3008 222468    0    0  3844     0  226  6420 94  3  3  0
 1  0      0  11728   3008 207736    0    0  1152     0  180  7856 93  7  0  0
 1  0      0  11680   3008 192876    0    0  1024     0  187  7743 95  5  0  0
 2  0      0  12052   3008 178152    0    0  1152     0  257  7619 93  7  0  0
 3  0      0  12304   3012 164052    0    0  1028     0  214  7413 90  8  2  0
 1  0      0  12440   3012 150084    0    0  1152     0  219  7429 93  7  0  0
 1  0      0  12392   3012 136232    0    0  1152     0  180  7232 93  7  0  0
 2  0      0  12212   2924 123340    0    0  1024     0  188  6848 93  7  0  0
 2  0      0  12080   2928 111200    0    0   900     0  189  6378 84 15  1  0
 1  0      0  11796   2928  99208    0    0   896     0  185  6378 86 14  0  0
 2  0      0  12420   2928  85944    0    0   896     0  187  6571 90 10  0  0
 1  0      0  12344   2964  72936    0    0  1024    64  192  6794 98  2  0  0
 1  0      0  11812   2968  60808    0    0   900     0  177  6569 96  2  2  0
 1  0      0  13812   2840  47708    0    0   896     0  177  5962 84 16  0  0
 1  0      0  12816   1784  38868    0    0   896     0  177  5707 91  9  0  0
 2  0      0  12956   1804  26876    0    0   916     0  186  6172 87 13  0  0
 2  0      0  13924   1764  14360    0    0  1024     0  179  6171 95  5  0  0
 1  0      0  13096   1708  10340    0    0   388     0  173  2527 54 46  0  0
 2  0      0  12524   1676   5004    0    0   512     0  178  3201 57 43  0  0
 2  2      0  10864   1712   5216    0    0   376     0  241   822 36 64  0  0

     here system starts to block

 4  0      0  11132   1732   4672    0    0   376     0  281   256  7 93  0  0
 4  1      0  10992   1760   3828    0    0  1720     0  467  1942 12 88  0  0
 8  1      0  10292   1788   4268    0    0   500     0  263   326  7 93  0  0
 6  6      0  10324   1788   4024    0    0  1068     0  254  1029  6 94  0  0
10  0      0  10284   1800   4048    0    0   128     0  187    78  1 99  0  0
 3  6      0  10488   1788   3908    0    0  1392     0  256   965  0 100  0  0
 7  0      0  10284   1800   4088    0    0   552     0  256   596  0 100  0  0
 6  0      0  10496   1796   3844    0    0   592     0  204   208  0 100  0  0
 6  0      0  10460   1808   3856    0    0    68     0  168    74  0 100  0  0
 7  1      0  10380   1812   3976    0    0   340     0  182    90  0 100  0  0
 8  0      0  10364   1816   3964    0    0    36     0  165    61  0 100  0  0
 0  7      0 885812   1776   4756    0    0   944     0  235   206  0 21 79  0
 1  5      0 884196   1840   6280    0    0  1592     0  253   246  0  0 100  0

     less is killed already:

__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process less

The machine is Intel P4, HIGHMEM(4GB), HIGHMEM IO enabled kernel, acpi
patch 20030918 over 2.4.23-pre5 kernel tree. Same with 2.4.23-pre7(plain).



Then I tried old 2.4.22 with same acpi patch, The machine is much better
behaving, mouse cursor always moves, and vmstat during the command shows
that kernel managed to reclaim some memory few times, but then it also eats
100% CPU time and finally kill less too, but with diffent message:

$ vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0      0 626472  15352  96152    0    0  1077   139  189  1350 15 14 71  0
 2  0      0 602108  15360 103192    0    0  7048     0  263  8649 81  9 10  0
 3  0      0 577536  15368 110232    0    0  7048     0  300  9220 86  8  6  0
 2  0      0 553100  15372 117144    0    0  6916     0  278  9087 92  6  2  0
 2  0      0 528960  15380 124056    0    0  6920     0  246  8671 87  6  7  0
 2  0      0 505352  15388 130840    0    0  6792     0  269  8415 86  9  5  0
 0  1      0 481632  15396 137564    0    0  6728     0  230  8495 89  4  7  0
 3  0      0 459948  15400 143896    0    0  6340     0  297  7778 81 14  5  0
 3  0      0 436500  15408 151960    0    0  8072     0  302  7731 86  9  5  0
 2  0      0 414004  15424 158488    0    0  6544     0  242  7941 85 10  5  0
 1  0      0 391984  15428 164760    0    0  6276     0  219  7827 91  5  4  0
 2  0      0 370968  15436 170904    0    0  6152     0  243  7480 86  7  7  0
 2  0      0 349436  15440 177048    0    0  6148     0  199  7907 89  7  4  0
 2  0      0 328976  15448 182808    0    0  5768     0  198  7262 89  3  8  0
 2  0      0 308076  15452 188824    0    0  6020     0  194  7342 94  3  3  0
 2  0      0 287540  15460 194456    0    0  5640    12  199  7362 89  7  4  0
 2  0      0 267584  15464 200216    0    0  5764     0  191  6998 85 10  5  0
 0  1      0 247700  15472 206380    0    0  6168     0  224  6814 83 13  4  0
 2  0      0 232376  15476 210840    0    0  4468     0  295  5448 69 15 16  0
 2  0      0 215128  15480 215832    0    0  4996     0  195  6063 74 24  2  0
 1  0      0 195784  15484 221336    0    0  5508     0  248  6834 91  7  2  0
 1  0      0 177956  15488 226456    0    0  5124     0  373  6346 81 14  5  0
 2  0      0 160188  15496 231576    0    0  5128     0  224  6267 83 12  5  0
 1  0      0 141696  15504 236824    0    0  5256     0  250  6677 88  9  3  0
 2  0      0 123408  15508 242072    0    0  5252     0  205  6515 93  3  4  0
 2  0      0 105620  15516 247192    0    0  5128     0  266  6458 92  3  5  0
 2  0      0  87876  15520 252312    0    0  5124     0  189  6244 92  3  5  0
 1  0      0  69964  15524 257432    0    0  5124     0  185  6331 96  3  1  0
 2  0      0  52352  15528 262424    0    0  4996     0  179  6228 92  5  3  0
 1  0      0  35304  15536 267416    0    0  5000     0  182  5958 86  8  6  0
 1  0      0  18372  15540 272280    0    0  4868     0  179  5960 93  4  3  0
 1  0      0  10048  11096 273272    0    0  4868     0  181  6131 97  2  1  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 3  0      0  10512   6800 266564    0    0  4484     0  173  5720 89 10  1  0
 2  0      0  10024   6804 255556    0    0  4740     0  176  6123 92  6  2  0
 1  0      0   9488   6808 242116    0    0  1796     0  131  7398 94  5  1  0
 1  0      0   9516   6808 227524    0    0  1024     0  117  7731 98  2  0  0
 1  0      0   9564   6792 213204    0    0  1152     0  119  7596 97  3  0  0
 1  0      0   9564   6792 199124    0    0  1024     0  117  7472 97  3  0  0
 1  0      0   9568   6796 185428    0    0  1028     0  119  7278 94  5  1  0
 1  0      0   9500   6804 171988    0    0  1160     0  121  7170 94  6  0  0
 1  0      0   9564   6800 158424    0    0  1024     0  117  7172 94  6  0  0
 1  0      0   9540   6804 145368    0    0  1028     0  119  6948 95  3  2  0
 1  0      0   9464   6804 132312    0    0   896     0  115  6975 95  5  0  0
 1  0      0   9476   6804 119384    0    0  1024     0  117  6873 95  5  0  0
 1  0      0   9500   6804 106584    0    0  1024     0  117  6791 92  8  0  0
 1  0      0   9480   6804  93912    0    0   896     0  115  6728 96  4  0  0
 3  0      0   9508   6808  81624    0    0   900     0  116  6505 92  6  2  0
 2  0      0   9568   6808  69208    0    0  1024     0  115  6580 90 10  0  0
 2  0      0   9492   6808  57048    0    0   896     0  117  6481 97  3  0  0
 2  0      0  10496   6808  44120    0    0  1024     0  117  6350 96  4  0  0
 2  0      0  10812   5964  33464    0    0   900     0  117  6253 94  6  0  0
 2  0      0   9816   5960  26348    0    0   768     0  113  5350 89 11  0  0
 3  0      0  10528   5960  17192    0    0   768     0  113  4786 81 19  0  0
 3  0      0  10228   5960  16552    0    0   128     0  141  1239 50 50  0  0
 2  0      0   9188   5968  15784    0    0   136     0  227  1191 48 52  0  0
 1  0      0   5236   5968  15804    0    0   276     0  231  2210 55 45  0  0
 3  0      0   5232   5968  15620    0    0    92     0  215   257  5 95  0  0
 2  0      0   5236   5968  15620    0    0    84     0  136   160  0 100  0  0
 0  0      0 903664   5968  15872    0    0   324     0  164   360  0 36 64  0
 0  0      0 903668   5968  15872    0    0     0     0  192   220  0  0 100  0
 0  0      0 903648   5988  15872    0    0     0    36  107    36  0  0 100  0
 0  0      0 903648   5988  15872    0    0     0     0  134    95  0  0 100  0
 0  0      0 903648   5988  15872    0    0     0     0  134    84  0  0 100  0
 0  0      0 903648   5988  15872    0    0     0     0  107    22  0  9 91  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----


dmesg shows only:

Out of Memory: Killed process 1995 (less).


So the __alloc_pages: 0-order allocation failed is not showing up on
2.4.22, but no idea if that's better/worse.
-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
