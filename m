Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTJaJSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 04:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTJaJSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 04:18:39 -0500
Received: from smtp1.cistron.nl ([62.216.30.40]:40330 "EHLO smtp1.cistron.nl")
	by vger.kernel.org with ESMTP id S263128AbTJaJSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 04:18:34 -0500
Message-ID: <3FA25377.3050207@cistron.nl>
Date: Fri, 31 Oct 2003 13:20:07 +0100
From: age <ahuisman@cistron.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, nuno.silva@vgertech.com
Subject: Re: READAHEAD
References: <bnrdqi$uho$1@news.cistron.nl> <20031030134407.0c97c86e.akpm@osdl.org>
In-Reply-To: <20031030134407.0c97c86e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
 > age <ahuisman@cistron.nl> wrote:
 >
 >>I have a problem which i don`t understand and i hope that you
 >> will and can  help me. The problem is that i experience strange disk
 >> read performance. I have to set hdparm -m16 -u1 -c1 -d1 -a4096 /dev/hde
 >> to get  timing buffered disk reads of 56 MB/SEC.
 >> When i disable readahead i get 17 MB/SEC
 >> When i enable readahead with -a8 i get  17 MB/SEC
 >> When i enable readahead with -a16 i get 24,5 MB/SEC
 >> When i enable readahead with -a32 i get 30,5 MB/SEC
 >> When i enable readahead with -a64 i get 35 MB/SEC
 >> When i enable readahead with -a128 i get 39 MB/SEC
 >> When i enable readahead with -a256 i get 39 MB/SEC
 >> When i enable readahead with -a512 i get 41 MB/SEC
 >> When i enable readahead with -a1024 i get 50 MB/SEC
 >> When i enable readahead with -a2048 i get 50 MB/SEC
 >> When i enable readahead with -a4096 i get 56 MB/SEC
 >> With -a8192,-a16384 and -a32768 i get also 56MB/SEC
 >>
 >> Before, i never had to set readahead so high
 >> Please could you tell me, what is going on here ?
 >
 >
 > Lots of people have been reporting this.  It's rather weird.
 >
 > Is the same effect observable when reading a large file, or is it only
 > observable via `hdparm -t'?
 >

Hi Andrew,

Here are some tests with bonnie++.
The used command is : bonnie++ -d /home/test -s 1024 -n 10 -u root
TCQ and write cache enabled.


The first test with hdparm -a0 -c1 -m16 -u1 -d1 /dev/hde :

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
wuuk             1G  3610  98 56878  85 10010  35  3129  90 17355  55 181.2  2
                     ------Sequential Create------ --------Random Create--------
                     -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                  10 11117  95 +++++ +++ 18414  98 11888  99 +++++ +++ 19189  98


The second test with hdparm -a16 -c1 -m16 -u1 -d1 /dev/hde :

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
wuuk             1G  3611  98 56404  85 12104  36  3260  92 27741  54 193.3   1
                     ------Sequential Create------ --------Random Create--------
                     -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                  10 11571  99 +++++ +++ 18477  99 11901  99 +++++ +++ 19250  99

The third test with hdparm -a256 -c1 -m16 -u1 -d1 /dev/hde :

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
wuuk             1G  3614  98 57510  85 15597  28  3621  95 43004  45 188.5   1
                     ------Sequential Create------ --------Random Create--------
                     -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                  10 11622  99 +++++ +++ 18439  99 11905  99 +++++ +++ 19378  99


The fourth test with hdparm -a4096 -c1 -m16 -u1 -d1 /dev/hde :

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
wuuk             1G  3610  98 57770  85 18518  32  3636  96 42748  39 186.9   1
                     ------Sequential Create------ --------Random Create--------
                     -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                  10 11653  98 +++++ +++ 18608  99 11908  99 +++++ +++ 19503  99

If you need more information, please tell me.

groetjes,(greetings)

Age Huisman.












