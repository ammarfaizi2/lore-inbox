Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSD1Pc6>; Sun, 28 Apr 2002 11:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311262AbSD1Pc5>; Sun, 28 Apr 2002 11:32:57 -0400
Received: from 213-96-224-204.uc.nombres.ttd.es ([213.96.224.204]:46600 "EHLO
	manty.net") by vger.kernel.org with ESMTP id <S311180AbSD1Pc4>;
	Sun, 28 Apr 2002 11:32:56 -0400
Date: Sun, 28 Apr 2002 17:32:53 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcnet32 on 2.4.18 doesn't init on IBM rs/6000 B50 (powerpc)
Message-ID: <20020428153253.GA2924@man.beta.es>
In-Reply-To: <20020425220402.GA3654@man.beta.es> <20020425221519.GA13245@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

          TX packets:494 errors:226 dropped:0 overruns:0 carrier:226
Hi again!

> Can you try something newer (eg 2.4.19-pre7)? There have been a number
> of changes to the pcnet32 driver, one of them (from Paul Mackerras)
> should fix your problem.

It fixes indeed the problem on the init of the card, but I have made a
deeper diagnosis of the problem and there are things left.

I have even got it to work with 2.4.18 without any patch. The problems
appear just when you do a netboot of the machine, if you just boot from the
disk 2.4.18 does ok. But if you boot from the net you get the problem with
detection on 2.4.18 which is solved on 2.4.19 pres, but also you get another
problem with the card, and it is that communication doesn't work like it
should, this problem is not corrected on 2.4.19preX as of pre7 at least.

This problems as I said before are caused when booting from the net and not
when the machine is booted from disk. It looks like the card is left on a
bad state by the openfirmware, in fact I've seen openfirmware fail several
times to retrieve big kernel files (more than 1 MB) and afterwards even fail
to do a bootp request, so I think that the card is left on a bad state that
drives as to things like this one:

A scp of a kernel to another machine connected to the same switched 10Mb LAN:
vmlinux-2.4.18       100% |*****************************|  2399 KB    05:10

          RX packets:1619 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2831 errors:1417 dropped:0 overruns:0 carrier:1417

If I have time I'll test the driver that Tom Gall was sugesting me.

Thanks a lot!
-- 
Manty/BestiaTester -> http://manty.net
