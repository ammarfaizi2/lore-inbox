Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130633AbQLZTy7>; Tue, 26 Dec 2000 14:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131410AbQLZTyt>; Tue, 26 Dec 2000 14:54:49 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:35122 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S130633AbQLZTye>;
	Tue, 26 Dec 2000 14:54:34 -0500
Message-ID: <3A48F053.1F03404E@student.ethz.ch>
Date: Tue, 26 Dec 2000 20:24:03 +0100
From: Giacomo Catenazzi <cate@student.ethz.ch>
X-Mailer: Mozilla 4.73 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tim Wright <timw@splhi.com>,
        Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
In-Reply-To: <fa.gm0b5nv.1h2mope@ifi.uio.no> <fa.n7l96dv.2nah0l@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Dec 2000 19:24:06.0083 (UTC) FILETIME=[69A5B930:01C06F71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 25 Dec 2000, Alan Cox wrote:
> 
> > > One thing we _could_ potentially do is to simplify the CPU selection a
> > > bit, and make it a two-stage process. Basically have a
> > >
> > >     bool "Optimize for current CPU" CONFIG_CPU_CURRENT
> > >
> > > which most people who just want to get the best kernel would use. Less
> > > confusion that way.
> >
> > If we do that I'd rather see a make autoconfig that does the lot from
> > proc/pci etc 8)
> 

I have already made such program.
I detect most of PCI devices, filesystem (if in /etc/fstab or
/proc/mounts,
console, devices (char and blk dev), other deviced that use
resources,...
[ and I detect also some net protocols !]

> Good point. No point in adding a new config option, we should just have a
> new configurator instead. Of course, it can't handle many of the
> questions, so it would still have to fall back on asking.

My idea is to add also a CONFIG_EXPERT CONFIG_NOVICE,...
In a CONFIG_NOVICE, we can add the (undetectable) software protocols
(PPP, ...
also if user don't use it! (and IMHO we can configure a NOVICE system
that would boot and work without any questions).

Problem: How include it in 2.4?
I designed it to use esr's CML2 (for 2.5) and backport as user program
a version of CML2 with the autoconfigure.
The other possible mode: autoconfigure write to .config and user will do
a make oldconfig. But there are to many question (my autoconfigure
say that a driver is need, but it doesn't say 'no'.

Problem 2: ESR now requires Python 2, which is not yet in Debian, and I
think
that this further requisite will delay the inclusion of CML2 in kernel
:-(


	giacomo

PS: my autoconfigure is in http://people.debian.org/~cate/autoconfigure
It is updated to the 2.4.0-test12!

PPS: Comments are welcome!

> 
> That _would_ be a nice addition eventually. It's a bigger project than the
> one I envisioned, though.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
