Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbVIVKcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbVIVKcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 06:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbVIVKcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 06:32:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60329 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751469AbVIVKcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 06:32:05 -0400
Date: Wed, 21 Sep 2005 21:07:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: J Engel <joern@wohnheim.fh-wedel.de>
Cc: "Artem B. Bityutskiy" <dedekind@yandex.ru>,
       Peter Menzebach <pm-mtd@mw-itcon.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: data  loss on jffs2 filesystem on dataflash
Message-ID: <20050921190759.GC467@openzaurus.ucw.cz>
References: <432817FF.10307@yandex.ru> <4329251C.7050102@mw-itcon.de> <4329288B.8050909@yandex.ru> <43292AC6.40809@mw-itcon.de> <43292E16.70401@yandex.ru> <43292F91.9010302@mw-itcon.de> <432FE1EF.9000807@yandex.ru> <432FEF55.5090700@mw-itcon.de> <433006D8.4010502@yandex.ru> <20050920133244.GC4634@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050920133244.GC4634@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I glanced at the manual. Uhh, DataFlash is very specific beast. It 
> > suppoers page program with built-in erase command... So DataFlash 
> > effectively may be considered as a block device. Then you may use any FS 
> > on it providing you have wrote proper driver? Why do you need JFFS2 then 
> > :-) ?
> 
> Still can't.  Block devices have the attribute that writing AAA... to
> a block containing BBB... gives you one of three possible results in
> case of power failure:
> 
> 1. BBB...BBB all written
> 2. AAA...AAA nothing written
> 3. AAA...BBB partially written.
> 
> Flash doesn't have 3, but two more cases:
> 4. FFF...FFF erased, nothing written
> 5. AAA...FFF erased, partially written
> 
> Plus the really obnoxious
> 6. FFF...FFF partially erased.  Looks fine but some bits may flip
>    randomly, writes may not stick, etc.
> 
> Now try finding a filesystem that is robust if 4-6 happens. ;)

ext2 and anything that does not do journalling?

I do not thing behaviour on powerfail is part of block device definition.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

