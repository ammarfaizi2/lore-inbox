Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVFFBLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVFFBLA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 21:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVFFBLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 21:11:00 -0400
Received: from mail4.worldserver.net ([217.13.200.24]:37328 "EHLO
	mail4.worldserver.net") by vger.kernel.org with ESMTP
	id S261157AbVFFBK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 21:10:57 -0400
Date: Mon, 6 Jun 2005 03:10:56 +0200
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Cc: mpm@selenic.com
Subject: Re: Easy trick to reduce kernel footprint
Message-ID: <20050606011056.GB18603@core.home>
References: <20050605223528.GA13726@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050605223528.GA13726@alpha.home.local>
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 12:35:28AM +0200, Willy Tarreau wrote:

> saves 23 kB (2%) on the overall image without touching any code. The LZMA
> implementation could save 145 kB (12%), but would require a different
> extraction code (I've already seen patches to bring LZMA support on 2.4).

The patch for 2.4 is here:
http://www.zelow.no/floppyfw/download/Development/Patches/kernel/040-lzma-vmlinuz.diff
and it actually works.

My not working patch is here:
http://debian.christian-leber.de/kernel_lzma/lzma_image.patch
you have to apply the patch from the other mail before.
(or here: http://debian.christian-leber.de/kernel_lzma/lzma_ramdisk.patch)

If you just want to see how it doesn't work, here is a kernel image to
see it failing in qemu, basically it just decompresses again and again.
http://debian.christian-leber.de/kernel_lzma/bzImage

The decompression works correctly(checksum), i think the problem is the address
where the decompressed kernel image should be, i just can't get out how
this piece of code is supposed to work.

Therefore it could be a small problem only.


Another minor problem of lzma is that you need slightly more memory than
with gzip. (at least when you can't have the output in a continuous
piece of memory)
On the plus side is also that the lzma decompression code itself is
smaller and doesn't have such a ugly "interface".


Christian Leber

-- 
http://www.nosoftwarepatents.com

