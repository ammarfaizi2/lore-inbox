Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVAND3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVAND3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVAND0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:26:37 -0500
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:21699 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S261887AbVANDWb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:22:31 -0500
Date: Fri, 14 Jan 2005 05:22:26 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: bttv/v4l2/Linux 2.6.10-ac8: xawtv hanging in videobuf_waiton
Message-ID: <20050114032226.GB6032@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
	Gerd Knorr <kraxel@bytesex.org>
References: <20050110000043.GA9549@m.safari.iki.fi> <871xct1pq2.fsf@bytesex.org> <20050110161821.GA5561@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110161821.GA5561@m.safari.iki.fi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 06:18:21PM +0200, Sami Farin wrote:
> On Mon, Jan 10, 2005 at 12:35:33PM +0100, Gerd Knorr wrote:
> > Sami Farin <7atbggg02@sneakemail.com> writes:
> > 
> > > when I start xawtv and alevt in the same window and press 'v' in xawtv,
> > > bttv goes berserk, producing around 25 lines per second of debug stuffs.
> > > (xawtv was also in fullscreen mode when I did this).
> > > alevt quits just fine.
> > > 
> > > Jan 10 00:43:26 safari kernel: bttv0: OCERR @ 0d1f9014,bits: HSYNC OFLOW OCERR*
> > > Jan 10 00:43:26 safari last message repeated 11 times
> > > Jan 10 00:43:26 safari kernel: bttv0: timeout: drop=0 irq=7236/7236, risc=0d1f901c, bits: HSYNC OFLOW
> > > Jan 10 00:43:26 safari kernel: bttv0: reset, reinitialize
> > > Jan 10 00:43:26 safari kernel: bttv0: PLL: 28636363 => 35468950 . ok
> > > Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
> > 
> > Any change with latest updates from http://dl.bytesex.org/patches/ ?
> > 
> > I can reproduce with the latest bits.  There was a state handling bug
> 
> (s/can/can't/)
> 
> > when using both video + vbi recently through, not sure whenever the
> > fix made it into 2.6.10 or not.
> 
> I applied that All-2.6.10.diff.gz and now pressing 'v'
> in xawtv caused nice freeze in a couple of seconds (sysrq+b did not work,
> had to cycle power).
> 
> I didn't try alevt yet.

Yup...  now with latest patch from dir 2.6.10-2 (All-2.6.10.diff.gz)
I had one funny experience.  I was playing with 'v' in xawtv
(with alevt), and got Kernel panic - not syncing: Fatal exception
EIP is at check_slabp...
About 100 pixels from my windowmaker background got garbled (I also ran
xrefresh) while panicking ;-> and "rpm -V mozilla" showed three modified
libs.
I made screencap (digicam) of the panicked screen, ask for it if you care.

However, the libs were OK after reboot (maybe because no time for syncing),
but reiserfsck found vpf-10640 error for /var partition.

How to debug this kind of memory corruption?

I have gotten corrupted mozilla libs four times by using bttv...
here what got changed about two weeks ago in file
/usr/lib/mozilla/components/libgklayout.so

OK file:

0035b000  04 00 ff b5 34 ff ff ff  e8 f7 19 d2 ff 58 ff b5  |....4........X..|
0035b010  3c ff ff ff e8 eb 19 d2  ff 5f ff b5 38 ff ff ff  |<........_..8...|
0035b020  e8 df 19 d2 ff 83 c4 10  8d 65 f4 5b 89 f0 5e 5f  |.........e.[..^_|
0035b030  c9 c3 89 f6 55 89 e5 57  56 53 83 ec 2c e8 00 00  |....U..WVS..,...|
0035b040  00 00 5b 81 c3 7e d5 0c  00 8b 7d 08 e8 ff fb ff  |..[..~....}.....|
0035b050  ff 85 c0 89 c6 78 6f 83  ec 0c 8d 45 d8 50 89 45  |.....xo....E.P.E|
0035b060  d4 c7 45 d8 00 00 00 00  e8 37 25 d2 ff 89 04 24  |..E......7%....$|
0035b070  e8 ab e1 ff ff 83 c4 10  85 c0 89 c6 78 3a 83 ec  |............x:..|
0035b080  08 8b 45 d8 8b 10 57 50  ff 52 38 83 c4 10 85 c0  |..E...WP.R8.....|
0035b090  89 c6 78 24 85 ff 74 0f  83 ec 08 8b 07 ff 75 d8  |..x$..t.......u.|
0035b0a0  57 ff 50 0c 83 c4 10 8b  45 d8 8b 55 0c 83 ec 0c  |W.P.....E..U....|
0035b0b0  89 02 8b 10 50 ff 52 04  83 ec 0c ff 75 d4 e8 41  |....P.R.....u..A|
0035b0c0  19 d2 ff 83 c4 10 8d 65  f4 5b 89 f0 5e 5f c9 c3  |.......e.[..^_..|
0035b0d0  83 44 24 04 f8 e9 56 bf  ff ff 90 90 83 44 24 04  |.D$...V......D$.|
0035b0e0  fc e9 4a bf ff ff 90 90  83 44 24 04 f8 e9 4e c0  |..J......D$...N.|
0035b0f0  ff ff 90 90 83 44 24 04  fc e9 42 c0 ff ff 90 90  |.....D$...B.....|
0035b100  83 44 24 04 f8 e9 46 c0  ff ff 90 90 83 44 24 04  |.D$...F......D$.|
0035b110  fc e9 3a c0 ff ff 90 90  83 44 24 04 fc e9 4e c5  |..:......D$...N.|
0035b120  ff ff 90 90 83 44 24 04  f8 e9 5a c5 ff ff 90 90  |.....D$...Z.....|
0035b130  55 e8 00 00 00 00 59 81  c1 8a d4 0c 00 89 e5 8b  |U.....Y.........|
0035b140  91 60 ee ff ff 8b 45 08  83 c2 08 89 10 8b 91 60  |.`....E........`|
0035b150  ee ff ff 83 c2 78 89 50  04 8b 91 60 ee ff ff 81  |.....x.P...`....|
0035b160  c2 98 00 00 00 c7 40 0c  00 00 00 00 89 50 08 c7  |......@......P..|
0035b170  40 10 00 00 00 00 c7 40  14 00 00 00 00 c7 40 18  |@......@......@.|
0035b180  00 00 00 00 c7 40 1c 00  00 00 00 c7 40 20 00 00  |.....@......@ ..|
0035b190  00 00 c7 40 24 00 00 00  00 c7 40 28 00 00 00 00  |...@$.....@(....|
0035b1a0  c6 40 2c 00 c6 40 2d 00  c6 40 2e 00 c9 c3 89 f6  |.@,..@-..@......|
0035b1b0  55 e8 00 00 00 00 59 81  c1 0a d4 0c 00 89 e5 8b  |U.....Y.........|
0035b1c0  91 60 ee ff ff 8b 45 08  83 c2 08 89 10 8b 91 60  |.`....E........`|
0035b1d0  ee ff ff 83 c2 78 89 50  04 8b 91 60 ee ff ff 81  |.....x.P...`....|
0035b1e0  c2 98 00 00 00 c7 40 0c  00 00 00 00 89 50 08 c7  |......@......P..|
0035b1f0  40 10 00 00 00 00 c7 40  14 00 00 00 00 c7 40 18  |@......@......@.|
0035b200  00 00 00 00 c7 40 1c 00  00 00 00 c7 40 20 00 00  |.....@......@ ..|
0035b210  00 00 c7 40 24 00 00 00  00 c7 40 28 00 00 00 00  |...@$.....@(....|
0035b220  c6 40 2c 00 c6 40 2d 00  c6 40 2e 00 c9 c3 89 f6  |.@,..@-..@......|

garbled by bttv:

0035b000  08 00 00 14 00 c0 35 0a  f8 03 00 18 08 cc 35 0a  |......5.......5.|
0035b010  08 08 00 14 00 50 0a 03  f8 0b 00 18 08 64 88 0a  |.....P.......d..|
0035b020  08 00 00 14 00 d0 36 08  f8 03 00 18 08 dc 36 08  |......6.......6.|
0035b030  08 08 00 14 00 b0 ed 06  f8 0b 00 18 08 a4 b2 08  |................|
0035b040  08 00 00 14 00 60 17 08  f8 03 00 18 08 6c 17 08  |.....`.......l..|
0035b050  08 08 00 14 00 50 2b 07  f8 0b 00 18 08 54 24 0b  |.....P+......T$.|
0035b060  08 00 00 14 00 b0 fa 05  f8 03 00 18 08 bc fa 05  |................|
0035b070  08 08 00 14 00 50 e9 08  f8 0b 00 18 08 84 4e 0c  |.....P........N.|
0035b080  08 00 00 14 00 f0 4b 02  f8 03 00 18 08 fc 4b 02  |......K.......K.|
0035b090  08 08 00 14 00 10 0f 09  f8 0b 00 18 08 54 17 05  |.............T..|
0035b0a0  08 00 00 14 00 d0 02 04  f8 03 00 18 08 dc 02 04  |................|
0035b0b0  08 08 00 14 00 20 a6 01  f8 0b 00 18 08 c4 55 06  |..... ........U.|
0035b0c0  08 00 00 14 00 70 ed 05  f8 03 00 18 08 7c ed 05  |.....p.......|..|
0035b0d0  08 08 00 14 00 d0 71 02  f8 0b 00 18 08 b4 59 03  |......q.......Y.|
0035b0e0  08 00 00 14 00 b0 3c 04  f8 03 00 18 08 bc 3c 04  |......<.......<.|
0035b0f0  08 08 00 14 00 20 62 09  f8 0b 00 18 08 24 da 0d  |..... b......$..|
0035b100  08 00 00 14 00 40 42 0c  f8 03 00 18 08 4c 42 0c  |.....@B......LB.|
0035b110  08 08 00 14 00 c0 f0 05  f8 0b 00 18 08 74 12 07  |.............t..|
0035b120  08 00 00 14 00 80 58 06  f8 03 00 18 08 8c 58 06  |......X.......X.|
0035b130  08 08 00 14 00 b0 20 04  f8 0b 00 18 08 a4 fa 0c  |...... .........|
0035b140  08 00 00 14 00 f0 e0 07  f8 03 00 18 08 fc e0 07  |................|
0035b150  08 08 00 14 00 50 0b 05  f8 0b 00 18 08 24 2b 0b  |.....P.......$+.|
0035b160  08 00 00 14 00 80 98 07  f8 03 00 18 08 8c 98 07  |................|
0035b170  08 08 00 14 00 90 a1 08  f8 0b 00 18 08 34 5d 02  |.............4].|
0035b180  08 00 00 14 00 90 40 05  f8 03 00 18 08 9c 40 05  |......@.......@.|
0035b190  08 08 00 14 00 40 a2 04  f8 0b 00 18 08 d4 8d 0b  |.....@..........|
0035b1a0  08 00 00 14 00 b0 0b 0e  f8 03 00 18 08 bc 0b 0e  |................|
0035b1b0  08 08 00 14 00 80 a0 03  f8 0b 00 18 08 b4 00 07  |................|
0035b1c0  08 00 00 14 00 10 e9 0f  f8 03 00 18 08 1c e9 0f  |................|
0035b1d0  08 08 00 14 00 70 0d 02  f8 0b 00 18 08 44 c7 0e  |.....p.......D..|
0035b1e0  08 00 00 14 00 f0 e2 06  f8 03 00 18 08 fc e2 06  |................|
0035b1f0  08 08 00 14 00 40 fe 01  f8 0b 00 18 08 64 0f 05  |.....@.......d..|
0035b200  08 00 00 14 00 90 ad 08  00 00 00 70 38 30 85 0d  |...........p80..|
0035b210  00 00 c7 40 24 00 00 00  00 c7 40 28 00 00 00 00  |...@$.....@(....|
0035b220  c6 40 2c 00 c6 40 2d 00  c6 40 2e 00 c9 c3 89 f6  |.@,..@-..@......|

do those hex numbers look familiar to someone? ;)

-- 
