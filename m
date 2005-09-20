Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbVITNcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbVITNcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 09:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbVITNcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 09:32:50 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:3202 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965011AbVITNcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 09:32:50 -0400
Date: Tue, 20 Sep 2005 15:32:44 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Artem B. Bityutskiy" <dedekind@yandex.ru>
Cc: Peter Menzebach <pm-mtd@mw-itcon.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: data  loss on jffs2 filesystem on dataflash
Message-ID: <20050920133244.GC4634@wohnheim.fh-wedel.de>
References: <432812E8.2030807@mw-itcon.de> <432817FF.10307@yandex.ru> <4329251C.7050102@mw-itcon.de> <4329288B.8050909@yandex.ru> <43292AC6.40809@mw-itcon.de> <43292E16.70401@yandex.ru> <43292F91.9010302@mw-itcon.de> <432FE1EF.9000807@yandex.ru> <432FEF55.5090700@mw-itcon.de> <433006D8.4010502@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <433006D8.4010502@yandex.ru>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 September 2005 16:55:52 +0400, Artem B. Bityutskiy wrote:
> Peter Menzebach wrote:
> >No, not at then moment. If I have some time, I can try to rewrite the 
> >chipset driver, that it reports a sector size of 1024.

Don't.  I'm actually glad about some flash with sizes not exactly
matching a power of two.  It causes you some pain, but generally helps
to find bugs.

> I glanced at the manual. Uhh, DataFlash is very specific beast. It 
> suppoers page program with built-in erase command... So DataFlash 
> effectively may be considered as a block device. Then you may use any FS 
> on it providing you have wrote proper driver? Why do you need JFFS2 then 
> :-) ?

Still can't.  Block devices have the attribute that writing AAA... to
a block containing BBB... gives you one of three possible results in
case of power failure:

1. BBB...BBB all written
2. AAA...AAA nothing written
3. AAA...BBB partially written.

Flash doesn't have 3, but two more cases:
4. FFF...FFF erased, nothing written
5. AAA...FFF erased, partially written

Plus the really obnoxious
6. FFF...FFF partially erased.  Looks fine but some bits may flip
   randomly, writes may not stick, etc.

Now try finding a filesystem that is robust if 4-6 happens. ;)

> JFFS2 orients to "classical" flashes. They have no "write page with 
> built-in erase" operation.

What does this thing do?

> BTW, having 8*1056 write buffer is not perfect ides, better make it as 
> small as possible, i.e., 1056 bytes.

Definitely.

Jörn

-- 
You can't tell where a program is going to spend its time. Bottlenecks
occur in surprising places, so don't try to second guess and put in a
speed hack until you've proven that's where the bottleneck is.
-- Rob Pike
