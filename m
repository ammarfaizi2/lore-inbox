Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWGQU61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWGQU61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 16:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWGQU61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 16:58:27 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:58557 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750808AbWGQU61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 16:58:27 -0400
Date: Mon, 17 Jul 2006 22:53:26 +0200
To: linux-kernel@vger.kernel.org
Subject: io-scheduler test with bonnie on compactflash (2.6.17)
Message-ID: <20060717205325.GA6803@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a small pc which boots from a compactflash card.  I tested to
see if there were any significant differences between io scedulers
in this case.  Disk seeks are supposed to be a no-op in this case.

I post the results here in case someone is interested.

bonnie -s 1024
==============
cfq:
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mini             1G  9439  98  8251   7  5369   4  8207  82 21348  12  1367   9
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  6771  30 +++++ +++   198   0  2312  10 +++++ +++    80   0

deadline:
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mini             1G  9049  93  8872   7  4989   4  9758  98 21459  12 468.2   2
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  6968  32 +++++ +++   148   0  5888  26 +++++ +++    67   0

noop:
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mini             1G  9294  97 10829   9  4655   3  9042  90 21529  12 261.0   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  7426  34 +++++ +++   139   0  2215   9 +++++ +++    65   0

compact format:
cfq1:    mini,1G,9439,98,8251,7,5369,4,8207,82,21348,12,1367.4,9,16,6771,30,+++++,+++,198,0,2312,10,+++++,+++,80,0
cfq2:    mini,1G,9410,97,8370,7,5347,4,8177,82,21295,12,1319.4,9,16,6041,27,+++++,+++,175,0,2846,12,+++++,+++,74,0
deadline:mini,1G,9049,93,8872,7,4989,4,9758,98,21459,12,468.2,2,16,6968,32,+++++,+++,148,0,5888,26,+++++,+++,67,0
noop:    mini,1G,9294,97,10829,9,4655,3,9042,90,21529,12,261.0,1,16,7426,34,+++++,+++,139,0,2215,9,+++++,+++,65,0

bonnie++ -s 1024
================
cfq:
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mini             1G  9437  98  8100   7  5296   4  8129  81 21330  12  1376   9
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  6306  29 +++++ +++   173   0  2614  11 +++++ +++    73   0

deadline:
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mini             1G  9063  94 11267   9  5548   4  9536  95 21530  12 782.9   4
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16 10126  46 +++++ +++   156   0  2115   9 +++++ +++    71   0

noop:
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
mini             1G  9288  97 10493   9  4615   3  9582  96 21524  12 258.1   1
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  7179  32 +++++ +++   138   0  3706  16 +++++ +++    67   0

compact:
cfq:     mini,1G,9437,98,8100,7,5296,4,8129,81,21330,12,1375.8,9,16,6306,29,+++++,+++,173,0,2614,11,+++++,+++,73,0
deadline:mini,1G,9063,94,11267,9,5548,4,9536,95,21530,12,782.9,4,16,10126,46,+++++,+++,156,0,2115,9,+++++,+++,71,0
noop:    mini,1G,9288,97,10493,9,4615,3,9582,96,21524,12,258.1,1,16,7179,32,+++++,+++,138,0,3706,16,+++++,+++,67,0


The machine has a via C3 nehemiah processor, and uses a 4GB 100x kingston 
compactflash card.  This card does 21MB/s when reading according to
hdparm (and 20MB/s according to the spec.) The card uses a
ide-compactflash converter, which supports udma2.

A nice little machine that I mostly use for car navigation
and mp3/ogg/cd-player.  The kernel is loaded 12s after power-on,
X shows itself after 35s, and my navigation software after 45s. :-)

Helge Hafting




