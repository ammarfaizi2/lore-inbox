Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133062AbRECTcw>; Thu, 3 May 2001 15:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133040AbRECTci>; Thu, 3 May 2001 15:32:38 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:52752 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S133076AbRECTa7>; Thu, 3 May 2001 15:30:59 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: esr@thyrsus.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
Message-ID: <86256A41.006B2177.00@smtpnotes.altec.com>
Date: Thu, 3 May 2001 14:30:14 -0500
Subject: Re: [kbuild-devel] Why recovering from broken configs is too hard
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>Its worked well enough for the past five years. On odd occasions you do find
>you've inadventantly unconfigured something but normally the conflict vanishes
>with almost no ripples.

>I'm quite happy for oldconfig to continue to do what it did before. I'm quite
>happy to accept its mathematically imperfect, because it hasnt gone far wrong
>yet

Here's a real-life example of how well it works.  I tend to bounce back and
forth between Linus' -pre patches and your -ac patches.  For instance, when
2.4.4-ac4 came out, I was running 2.4.5-pre1.  Here's what I did:

zcat patch-2.4.5-pre1.gz | patch -p1 -s -E -R
zcat patch-2.4.4-ac4.gz | patch -p1 -s -E
mv .config ..
make mrproper
mv ../.config .
make oldconfig
make dep && make bzlilo modules modules_install

I apply nearly every patch set that comes along from you or Linus, and this is
the way I usually do it.  Every once in a while, I run through all the options
in menuconfig just to make certain nothing has gotten hosed up.  Only once can I
remember needing to change an option that had been set incorrectly by oldconfig.

Wayne


