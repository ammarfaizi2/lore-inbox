Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287865AbSBCXeT>; Sun, 3 Feb 2002 18:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287866AbSBCXeI>; Sun, 3 Feb 2002 18:34:08 -0500
Received: from [217.9.226.246] ([217.9.226.246]:11136 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S287865AbSBCXeB>; Sun, 3 Feb 2002 18:34:01 -0500
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020202192334.GA21556@earthlink.net>
X-No-CC: Post to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020202192334.GA21556@earthlink.net>
Date: 04 Feb 2002 01:33:19 +0200
Message-ID: <877kpuw37k.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "rwhron" == rwhron  <rwhron@earthlink.net> writes:

rwhron> bonnie++
rwhron> Version 1.02a     ---------------------Sequential Output--------------------
rwhron>                   -----Per Char-----  ------Block-------  -----Rewrite------
rwhron> Kernel      Size  MB/sec  %CPU   Eff  MB/sec  %CPU   Eff  MB/sec  %CPU   Eff
rwhron> 2.4.17      1024    3.41  98.0  3.48   14.56  65.6 22.19    8.83  51.0 17.32
rwhron> 2.4.17rat   1024    3.36  98.0  3.43   10.64  41.6 25.57    6.79  37.2 18.27

rwhron> Version 1.02a     -----------Sequential Input-----------   ------Random-----
rwhron>                   -----Per Char-----  ------Block-------   ------Seeks------
rwhron> Kernel      Size  MB/sec  %CPU   Eff  MB/sec  %CPU   Eff    /sec  %CPU   Eff
rwhron> 2.4.17      1024    3.98  97.2  4.10   16.39  60.6 27.05     132   2.0  6609
rwhron> 2.4.17rat   1024    3.92  96.0  4.08   15.46  57.0 27.12     126   2.0  6302

rwhron>                  -------Sequential Create-----------
rwhron>                  ------Create-----  -----Delete-----
rwhron>            files  /sec  %CPU   Eff  /sec  %CPU   Eff
rwhron> 2.4.17     16384  4421  96.8  4567  4719  97.4  4845
rwhron> 2.4.17rat  16384  3973  97.6  4070  4531  95.0  4769

rwhron>                  -------Random Create----------------
rwhron>                  ------Create-----   -----Delete-----
rwhron>            files  /sec  %CPU   Eff   /sec  %CPU   Eff
rwhron> 2.4.17     16384  4475  98.0  4566   4124  94.0  4387
rwhron> 2.4.17rat  16384  4203  98.0  4288   4005  94.4  4242

Hmm, I've got different results with bonnie++, are you sure you didn't
swap the results :)

Linux 2.5.3-dj1
--------------
Version  1.02b      ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
merlin         496M           22038  13 11768   8           19219   6 183.9   0
merlin         496M           22495  13 11216   6           22390   6 183.9   0
merlin         496M           22292  13 11713   7           19249   6 188.8   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
merlin           10  2015  99 +++++ +++ +++++ +++  2526  99 +++++ +++  8514  99
merlin           10  2354  99 +++++ +++ +++++ +++  2656  99 +++++ +++ 10195 100
merlin           10  2871  99 +++++ +++ +++++ +++  3036  99 +++++ +++ 12012  98

Linux 2.5.3-dj1-radix-pagecache
-------------------------------
Version  1.02b      ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
merlin         496M           22397  13 11248   7           22595   7 178.6   0
merlin         496M           22088  12 11204   7           22591   7 188.1   0
merlin         496M           24767  14 10966   7           22474   7 191.1   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
merlin           10  2485  99 +++++ +++ +++++ +++  2456  99 +++++ +++  9614 100
merlin           10  2653  99 +++++ +++ +++++ +++  2884 100 +++++ +++ 11101 100
merlin           10  1948  99 +++++ +++ +++++ +++  2530  99 +++++ +++  9294  99
