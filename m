Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVJBDh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVJBDh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 23:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVJBDh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 23:37:27 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:45779 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750955AbVJBDh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 23:37:27 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Strange disk corruption with Linux >= 2.6.13
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Sun, 02 Oct 2005 05:37:21 +0200
References: <4RlFC-2ev-17@gated-at.bofh.it> <4Rxdq-2Tc-19@gated-at.bofh.it> <4SXfs-7hM-27@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1ELufB-0001IH-TL@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito <rbrito@ime.usp.br> wrote:
> On Sep 28 2005, Nigel Cunningham wrote:

>> 3) Is the corruption only ever in memory, or seen on disk too?
> 
> I have noticed the problem mostly on disk. One strange situation was
> when I was untarring a kernel tree (compressed with bzip2) and in the
> middle of the extraction, bzip2 complained that the thing was
> corrupted.
> 
> I removed what was extracted right away and tried again to extract the
> tree (at this point, suspecting even that something in software had
> problems). The problem with bzip2 occurred again. Then, I rebooted the
> system an the problem magically went away.

I have a similar problem:
It's a corruption while reading data from the HDD into the cache.
The affected page will contain (pseudo?)random data in the first four
bytes (at least on my system it did).

If you waited long enough, the cache page would be discarded and the next
read from the disk would be correct. However, if it happens e.g. in an
inode block, the corruption may find it's way to the disk and/or fubar
your data.

This happens mostly if there are concurrent DMA transfers like playing
sound or watching TV on bttv cards. I'm affected by the later cause,
setting no_overlay reduced it.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
