Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270257AbRHSTu2>; Sun, 19 Aug 2001 15:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270725AbRHSTuT>; Sun, 19 Aug 2001 15:50:19 -0400
Received: from [24.93.35.62] ([24.93.35.62]:24841 "EHLO ns1.austin.rr.com")
	by vger.kernel.org with ESMTP id <S270257AbRHSTuM>;
	Sun, 19 Aug 2001 15:50:12 -0400
From: "Marvin Justice" <mjustice@austin.rr.com>
To: "'Matthias Schniedermeyer'" <ms@citd.de>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Strange Slowdown
Date: Sun, 19 Aug 2001 14:53:46 -0500
Message-ID: <000001c128e8$a8f31070$36481c18@ujx7u>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20010818182300.A15860@citd.de>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > After i switched "High Memory-Support" to "OFF"(4GB
> Before) the speed went
> > > to normal, but now less than half RAM is used.
> > > Any suggestions?
> >
> > This sounds like the top of memory is running uncached due
> to wrong mtrr
> > settings from the BIOS. Can you post your /proc/mtrr
>
> Because of other reasons i'm back to 2.2.19
>
> /proc/mtrr from 2.2.19 show this
> -- /proc/mtrr --
> reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
> reg01: base=0x40000000 (1024MB), size= 512MB: write-back, count=1
> reg02: base=0x60000000 (1536MB), size= 256MB: write-back, count=1
> reg03: base=0x70000000 (1792MB), size= 128MB: write-back, count=1
> reg04: base=0x78000000 (1920MB), size=  64MB: write-back, count=1
> reg05: base=0x7c000000 (1984MB), size=  32MB: write-back, count=1
> -- end --
> (32MB "missing". Seems like Linux uses these "missing" MBs.)
>
> For the 2.4.X-Kernel i had switched off the MTRR-Kernel-Option!
>
> Maybe i should try it another time with MTRR-Support switched on.
> Or i should use "mem=2016M".
>

I had a similar problem which could be solved by either passing the "mem="
option at boot time as you suggest(in which case you permanently lose the
upper 32MB) or by using the /proc/mtrr interface ( as described in
Documentation/mtrr.txt) to assign the "missing" region. For your system you
might try something like:

echo "base=0x7e000000 size=0x2000000 type=write-back" >| /proc/mtrr

Marvin Justice

