Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278643AbRKFIWH>; Tue, 6 Nov 2001 03:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278649AbRKFIV5>; Tue, 6 Nov 2001 03:21:57 -0500
Received: from pasky.ji.cz ([62.44.12.54]:45807 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S278643AbRKFIVj>;
	Tue, 6 Nov 2001 03:21:39 -0500
Date: Tue, 6 Nov 2001 09:21:33 +0100
From: Petr Baudis <pasky@pasky.ji.cz>
To: Jakob ?stergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org,
        Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011106092133.X11619@pasky.ji.cz>
Mail-Followup-To: Jakob ?stergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org,
	Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
	Tim Jansen <tim@tjansen.de>
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160MMf-1ptGtMC@fmrl05.sul.t-online.com> <20011104143631.B1162@pelks01.extern.uni-tuebingen.de> <160Nyq-2ACgt6C@fmrl07.sul.t-online.com> <20011104163354.C14001@unthought.net> <20011105144112.Q11619@pasky.ji.cz> <20011106082501.B1588@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011106082501.B1588@unthought.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as I can see, I cannot read /proc/[pid]/* info using sysctl.
That can be added. We just have existing interface, and I don't propose to
stick on its actual state as it isn't convenient, but to extend it to cope our
needs.

> Then I need the other /proc/* files as well, not just /proc/sys/*
IMHO whole /proc should be mirrored by sysctl. Then, we can in 2.7 slowly move
those only to /proc/sys. Ideally, only /proc/[pid]/ and /proc/sys/ should be
present in /proc/.

> It seems to me that the sysctl interface does not have any type checking,
> so if for example I want to read the jiffies counter and supply a 32-bit
> field, sysctl will happily give me the first/last 32 bits of a field that
> could as well be 64 bits (bit widths do sometimes change, even on architectures
> that do not change).   How am I to know ?
 From the sysctl() manpage:

 size_t *oldlenp;  /* available room for old value,
                      overwritten by actual size of old value */

So, it will happily give you first/last 32 bits (at least something and your
application won't crash UNhappily ;), however it will write to location pointed
by oldlenp that jiffies are 64 bits.

> This could be tightened up of course - but the problem of knowing which
> unit some number may be represented in is still there.  For example,
> assuming I could read out partition sizes, well are they in blocks, bytes,
> kilobytes, or what ?    Oh, I'm supposed to *know*, and *assume* such things
> never change ?
Obviously they shouldn't. Any reason to change them? If you decide it would
be nice to give you also size in something different from blocks, you can just
introduce new ctl with suffix e.g. kb or so.

-- 

				Petr "Pasky" Baudis

UN*X programmer, UN*X administrator, hobbies = IPv6, IRC
Real Users hate Real Programmers.
Public PGP key, geekcode and stuff: http://pasky.ji.cz/~pasky/
