Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291246AbSBSLOq>; Tue, 19 Feb 2002 06:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291247AbSBSLOf>; Tue, 19 Feb 2002 06:14:35 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:11251 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S291246AbSBSLOW>;
	Tue, 19 Feb 2002 06:14:22 -0500
Date: Tue, 19 Feb 2002 04:14:09 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020219041409.J24428@lynx.adilger.int>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0202151501220.11494-100000@dragon.pdx.osdl.net> <Pine.LNX.4.33L2.0202151657230.11494-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L2.0202151657230.11494-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Fri, Feb 15, 2002 at 05:10:48PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 15, 2002  17:10 -0800, Randy.Dunlap wrote:
> On Fri, 15 Feb 2002, Randy.Dunlap wrote:
> | On Fri, 15 Feb 2002, Andreas Dilger wrote:
> | | HDR=`binoffset $1 0x1f 0x8b 0x08 0x0`
> | | dd if=$1 bs=1 skip=$HDR | zcat | strings /dev/stdin | grep CONFIG_
> 
> Interim report:  I agree with the spirit of no temp. file, but one of
> zcat or strings isn't working for me when I use only pipes.  The final
> output file is empty (length = 0).
> 
> Hers's the current script:
> 
> HDR=`binoffset $1 0x1f 0x8b 0x08 0x0`
> dd if=$1 bs=1 skip=$HDR | zcat - | strings /dev/stdin \
>   | grep "[A-Za-z_0-9]=[ym]$" | sed "s/^/CONFIG_/" > $1.old.config

Hmm, I tried this, and it works with 'strings /dev/stdin < tmpfile' but
not 'cat tmpfile | strings /dev/stdin' which is sort of wierd.

I suppose you could always either:
a) fix 'strings' so that it accepts a '-' parameter to read from stdin
b) write a special-purpose 'strings | grep | sed' replacement tool for
   this purpose (or even include the binoffset part and link with zlib
   to do the decompression part).  No idea how hard it would be.  As
   for speed, almost anything would be faster in-memory than writing
   out the temp file.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

