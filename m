Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271191AbTHLSkj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271212AbTHLSkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:40:39 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:21253 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S271191AbTHLSk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:40:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Brandon Stewart <rbrandonstewart@yahoo.com>,
       linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Requested FAQ addition - Mandrake and partial-i686 platforms
Date: Tue, 12 Aug 2003 21:40:12 +0300
X-Mailer: KMail [version 1.4]
References: <3F38FE5B.1030102@yahoo.com>
In-Reply-To: <3F38FE5B.1030102@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308122140.13098.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 August 2003 17:48, Brandon Stewart wrote:
> Apparently, there is an issue with glibc on versions less than 2.3.1-15
> (and maybe others), where it mistakenly treats CPUs as full i686
> compliant when they only execute a subset of the i686 instructions. For
> example, the VIA C3 supports pretty much everything i686 except CMOV,
> yet the broken versions of glibc will detect it as fully i686 compliant.
>
>  From someone who emailed me privately, this apparently affects K6-III
> as well. Possibly other Cyrix or AMD CPUs are affected, though I don't
> have a complete list.
>
> The problem is that Mandrake 9.1 ships with a broken glibc. So you would
> expect that the incorrectly detected CPUs just wouldn't work. But
> apparently, Mandrake added a CMOV instruction emulator patch to their
> kernel, both the one that ships precompiled and the source rpm.
>
> So people will find that compiling the Mandrake version works fine, yet
> any kernel downloaded from kernel.org, 2.6 or other, will not work at
> all. The symptom is that booting the shiny new kernel will hang after
> "Freeing unused kernel memory". Doing a magic sysreq will reveal that
> /sbin/init is executing do_invalid_op(). You can keep pressing the magic
> sysreq stack dump key, and you will keep getting a new stack trace.
> Caps-lock works, and CTRL-ALT-DEL will reboot the machine.

Hm. I was right. ;)

> There are three possible workarounds:
> 1) Upgrade glibc to a working version. I haven't done this myself, so I
> don't know if the bug has been fixed yet. But it would be the best
> solution. 2) Remove i686 libraries from glibc. This can be done by 'mv
> /lib/i686 /lib/i686.invalid'. This is what I did, and it works. While some
> performance is lost, it's not noticeable, especially given that the
> stock Mandrake kernel is i386 compatible, and so has limited optimization.
> 3) Reapply the CMOV emulation patch to your downloaded kernel. Not
> recommended since it turns one CPU cycle into 400.

4) Never never never never NEVER compile for 586+

You lost several days debugging this. It's $days*24*60*60=$days*86400 seconds
~= $days * 86400000000000 CPU cycles. A bit high price for using optimized
binaries, eh?

IMHO:
Speed optimizations make sense in heavy CPU bound tasks like bzip2.
CPU-heavy part of code is usually small, can be hand-optimized.
The remaining 99,999% of code is best optimized for size.
At least you will save on pagein and icache footprint.

After you happily compiled a piece of code with all bells and
whistles for your new shiny 986+ processor, do take a look at
generated assembly. There might be surprizes.

BTW, will anyone bet that gcc generates better code with cmov's
than without? ;)
--
vda
