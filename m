Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277693AbRJICIF>; Mon, 8 Oct 2001 22:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277694AbRJICH4>; Mon, 8 Oct 2001 22:07:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31508 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277693AbRJICHq>; Mon, 8 Oct 2001 22:07:46 -0400
Date: Tue, 9 Oct 2001 04:07:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: Re: kswapd problems with 2.4.{9,10}
Message-ID: <20011009040753.I726@athlon.random>
In-Reply-To: <20011009015922.B6F9D1E544@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011009015922.B6F9D1E544@Cantor.suse.de>; from Dieter.Nuetzel@hamburg.de on Tue, Oct 09, 2001 at 03:59:16AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 03:59:16AM +0200, Dieter Nützel wrote:
> Hallo Andrea,
> 
> could this mlock related, too?
> latencytest0.42-png
> 
> SunWave1>./latencytest
> mlockall() failed, exiting. mlock: Operation not permitted
> 
> SunWave1>su
> Password:
> 
> SunWave1#unlimit coredumpsize
> SunWave1#./latencytest
> Speicherschutzverletzung (core dumped)
> 
> Loaded symbols for /usr/X11R6/lib/libXpm.so.4
> Reading symbols from /lib/ld-linux.so.2...done.
> Loaded symbols for /lib/ld-linux.so.2
> #0  0x8048f91 in main (argc=1, argv=0xbffff344) at latencytest.c:233
> 233       if(strcmp(argv[1],"none"))
> (gdb) bt
> #0  0x8048f91 in main (argc=1, argv=0xbffff344) at latencytest.c:233
> #1  0x400c1baf in __libc_start_main () from /lib/libc.so.6
> (gdb) info registers
> eax            0x0      0
> ecx            0x5      5
> edx            0xf7f    3967
> ebx            0x1      1
> esp            0xbffff224       0xbffff224
> ebp            0xbffff2dc       0xbffff2dc
> esi            0x0      0
> edi            0x804a761        134522721
> eip            0x8048f91        0x8048f91
> eflags         0x10246  66118
> cs             0x23     35
> ss             0x2b     43
> ds             0x2b     43
> es             0x2b     43
> fs             0x2b     43
> gs             0x2b     43
> fctrl          0x37f    895
> fstat          0x0      0
> ftag           0x0      0
> fiseg          0x0      0
> fioff          0x0      0
> foseg          0x0      0
> fooff          0x0      0
> fop            0x0      0
> 
> It worked with 2.4.10 (-preX) and 2.4.11-pre1 (I think).
> But _NOT_ with 2.4.11-pre2+ (2.4.11-pre5 + preempt :-) currently.

Are you sure you simply didn't forgot to pass argv[1]? :)

mlockall is somehow simpler than a partial mlocks on a large vma,
mlockall doesn't need to split off the partial vmas, I was only
wondering about the other splitting path stressed by Ben's testcase. 
Also there aren't been recent changes there.

> 
> Do you need the coredump file?
> 
> Thanks,
> 	Dieter


Andrea
