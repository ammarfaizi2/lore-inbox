Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292259AbSBOXJQ>; Fri, 15 Feb 2002 18:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292258AbSBOXJG>; Fri, 15 Feb 2002 18:09:06 -0500
Received: from air-2.osdl.org ([65.201.151.6]:28682 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292253AbSBOXIu>;
	Fri, 15 Feb 2002 18:08:50 -0500
Date: Fri, 15 Feb 2002 15:04:16 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <20020215155143.I14054@lynx.adilger.int>
Message-ID: <Pine.LNX.4.33L2.0202151501220.11494-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2002, Andreas Dilger wrote:

| On Feb 14, 2002  08:48 -0800, Randy.Dunlap wrote:
| > gziphdr=`binoffset $1 0x1f 0x8b 0x08 0x0`
| > # increment by 1 since tail offsets are 1-based, not 0-based
| > gziphdr=$((gziphdr + 1))
| >
| > tail -c +$gziphdr $1 | gunzip > $1.tmp
| > strings $1.tmp | grep CONFIG_ > $1.old.config
| > rm $1.tmp
|
| How about something like the below (avoids writing a multi-MB temp file):
|
| HDR=`binoffset $1 0x1f 0x8b 0x08 0x0`
| dd if=$1 bs=1 skip=$HDR | zcat | strings /dev/stdin | grep CONFIG_

I tried that, but I didn't know about /dev/stdin,
so I agree with you.
I had tried 'strings -', but strings didn't like that.  :(

| Note also that it is enough to store the config options without the
| leading CONFIG_ part, and then use 'grep "[A-Z0-9]*=[ym]$"' to get
| the actual config strings.  You can add a final 'sed "s/^/CONFIG_/"'
| step to return it to the original format.  So:
|
| dd if=$1 bs=1 skip=$HDR | zcat | strings /dev/stdin | grep "[A-Z0-9]=[ym]$" \
| 	| sed "s/^//CONFIG_"
| --

Yes, I said that I intended to remove the leading "CONFIG_".
I'll do that soon and package it all up and repost it.
Oh, and make it a CONFIG option.

Thanks for your help.

-- 
~Randy

