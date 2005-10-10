Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVJJXjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVJJXjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 19:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVJJXjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 19:39:09 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:43685 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S1751053AbVJJXjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 19:39:07 -0400
Date: Mon, 10 Oct 2005 20:49:13 -0300
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: glommer@br.ibm.com, Anton Altaparmakov <aia21@cam.ac.uk>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051010234913.GB13399@br.ibm.com>
References: <20051010204517.GA30867@br.ibm.com> <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz> <20051010231242.GC11427@br.ibm.com> <Pine.LNX.4.62.0510110112310.27454@artax.karlin.mff.cuni.cz> <20051010233344.GA13399@br.ibm.com> <Pine.LNX.4.62.0510110127130.27454@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0510110127130.27454@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >In the code, we see:
> >
> >if (unlikely(size & (bdev_hardsect_size(bdev)-1) ||
> >                       (size < 512 || size > PAGE_SIZE))) {
> >
> >This is where __getblk_slow, and thus, __getblk fails, and it does not
> >seem to be due to any memory management bug.
> 
> This is a filesystem bug --- filesystem should set it's blocksize with 
> sb_set_blocksize (and refuse to mount if the device doesn't support it) 
> before using it in requests.
> 
> Mikulas
> 
No doubt about it. 
But in case it does not, or in the case the value gets corrupted after
the check but before the call, it will lead some code to dereferencing a 
NULL pointer, and making the whole system crash for a silly thing.

So, for me, checking for the value after the call to __getblk does seem
the right approach. 

-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
glommer@br.ibm.com
=====================================
