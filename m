Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbTBVOKO>; Sat, 22 Feb 2003 09:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTBVOKO>; Sat, 22 Feb 2003 09:10:14 -0500
Received: from pc2-cmbg2-4-cust80.cmbg.cable.ntl.com ([80.2.247.80]:51191 "EHLO
	flat") by vger.kernel.org with ESMTP id <S261356AbTBVOKN>;
	Sat, 22 Feb 2003 09:10:13 -0500
From: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [2.4{,-ac}] [DRM] 3D Performance regression since 2.4.20
Date: Sat, 22 Feb 2003 14:20:24 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302221420.25060.cb-lkml@fish.zetnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Symptoms:
2.4.19 has good 3D performance. 2.4.20 and 2.4.21-pre4-ac5 both have
significantly reduced 3D performance when measured with glxgears and quake3.

This appears to be due to an increase in system time while using DRM.

On 2.4.21-pre4-ac5:
$ DISPLAY=:0.0 sh -c "vmstat 5 & glxgears"
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1      0  95544   9952  69252    0    0   368    76  144   288 93  4  4  0
4214 frames in 5.0 seconds = 842.800 FPS
 1  0      0  93760   9976  69252    0    0     0    38  104   322 33 67  0  0
5106 frames in 5.0 seconds = 1021.200 FPS
 2  0      0  93756   9976  69256    0    0     0     0  102   146 34 66  0  0
5100 frames in 5.0 seconds = 1020.000 FPS
 1  0      0  93732  10000  69256    0    0     2    20  103   150 34 66  0  0
5105 frames in 5.0 seconds = 1021.000 FPS
 2  0      0  93732  10000  69256    0    0     0     0  101   146 28 72  0  0
5103 frames in 5.0 seconds = 1020.600 FPS

On 2.4.19
$ DISPLAY=:0.0 sh -c "vmstat 5 & glxgears"
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0   2220  88872  10356  77128    0    2   334    55  197   495 65 32  4  0
 2  0   2220  87148  10356  77128    0    0     1    58  118   620 97  3  0  0
4717 frames in 5.0 seconds = 943.400 FPS
 1  0   2220  87128  10372  77128    0    0     0    20  103   365 91  9  0  0
 1  0   2220  87128  10372  77128    0    0     0    20  102   152 91  9  0  0
6553 frames in 5.0 seconds = 1310.600 FPS
 1  0   2220  87112  10388  77128    0    0     0    17  103   147 92  8  0  0
 1  0   2220  87112  10388  77128    0    0     0    17  103   148 92  8  0  0
6556 frames in 5.0 seconds = 1311.200 FPS
 1  0   2220  87100  10400  77128    0    0     1     2  102   146 92  8  0  0
 1  0   2220  87100  10400  77128    0    0     1     2  102   143 92  8  0  0

Hardware is AMD Duron 1.2GHz, VIA KT133A, G400 16MB.

Software is Debian sid, XFree86 4.2.1


