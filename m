Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281048AbRKGXPW>; Wed, 7 Nov 2001 18:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281050AbRKGXPN>; Wed, 7 Nov 2001 18:15:13 -0500
Received: from vega.ipal.net ([206.97.148.120]:49352 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S281048AbRKGXPL>;
	Wed, 7 Nov 2001 18:15:11 -0500
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
To: i@stingr.net (Paul P Komkoff Jr)
Date: Wed, 7 Nov 2001 17:15:10 -0600 (CST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mail List)
In-Reply-To: <20011108012452.A14971@stingr.net> from "Paul P Komkoff Jr" at Nov 08, 2001 01:24:52 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011107231510.7C4FF240@vega.ipal.net>
From: phil-linux-kernel@ipal.net (Phil Howard)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul P Komkoff Jr wrote:

> How much time you will parse a single integer ? Without any text around
> needs to be thrown away, optionally with 0x and considered it __int64 ?

And it's not much even with letters following like "k" and "m".


> This is much better than current /proc, yeah ? Anyway, Linus will keep proc
> ASCII, and we don't have another Linus.

Do we need another?


> So proposed standard for /proc - is a good idea. Let's get rid of
> progressbars, percent-o-meters with pseudographics. Maybe we should switch
> from single file, for ex, cpuinfo, to dir with many INDIVIDUAL files
> containing single number or feature-set in it. Splitting away parts that
> need to be formatted in-kernel and then parsed in-user maybe a good decision
> 'coz ... maybe they are rarely used ?

Sounds like a lot more open() calls to me.  If one is insisting on
saving CPU time (be it in kernel space or user space), I doubt if
this accomplishes that.  Not that that is everyone's goal.


> Another point. Including formatting code in EVERY kernel part that resides in
> /proc maybe (as for me) a bad idea - so one can do simple interface,
> formatting functions, and switch modules to use them

So a common core formatter for everything?  That could be done in
userspace or as a module, right?  Insert the module (or compile it
in directly) and /kerntxt becomes mountable and mirrors /kernel but
in text format.  How about a FS type for making any arbitrary info
tree much like /proc but served via a user space process?  Then it
can get the info from somewhere else, format it, and hand it back.
It could have other uses besides just /proc stuff.


> Another point is writable /proc files - but no one in this thread said
> something clever about it and ... maybe discuss it later ?

Those tend to be single value writes, true?  If in binary format,
then there will need to be a "setkernel" comand or some such thing
which opens the named path, and writes the data in the indicated
binary format.

So instead of:
    echo 0 > /proc/sys/net/ipv4/tcp_ecn
you might have:
    setkernel /kernel/sys/net/ipv4/tcp_ecn -i4 0


FYI: I really don't care much how this gets formatted or reformatted,
as long as it isn't XML (worst of both worlds: more CPU to parse and
breaks cat and grep).  Logical is nice.  Fast is nice.  Compact is
nice.  Readable is nice.  Easy to code in scripts is nice.  Easy to
code in C is nice.  The ultimate solution to make it possible to have
all these features at the same time ... priceless.

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
