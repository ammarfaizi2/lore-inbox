Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbTDREyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 00:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTDREyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 00:54:20 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:29691 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262856AbTDREyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 00:54:19 -0400
Date: Thu, 17 Apr 2003 23:05:00 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andries.Brouwer@cwi.nl
Cc: akpm@digeo.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct loop_info
Message-ID: <20030417230500.I26054@schatzie.adilger.int>
Mail-Followup-To: Andries.Brouwer@cwi.nl, akpm@digeo.com,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <UTC200304172334.h3HNYgI06614.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200304172334.h3HNYgI06614.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Apr 18, 2003 at 01:34:42AM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 18, 2003  01:34 +0200, Andries.Brouwer@cwi.nl wrote:
> Until now as the source already says, we had a very unpleasant
> situation with struct loop_info:
> 
> -/* 
> - * Note that this structure gets the wrong offsets when directly used
> - * from a glibc program, because glibc has a 32bit dev_t.
> - * Prevent people from shooting in their own foot.  
> - */
> -#if __GLIBC__ >= 2 && !defined(dev_t)
> -#error "Wrong dev_t in loop.h"
> -#endif 
> -
> -/*
> - *     This uses kdev_t because glibc currently has no appropiate
> - *     conversion version for the loop ioctls. 
> - *     The situation is very unpleasant        
> - */
> 
> In the patch below I remove the definition for this struct from
> <linux/loop.h> and put it in <asm/loopinfo.h>.

Great.  Now we have 20 copies of asm-foo/loopinfo.h.  Couldn't you
just have asm-generic/loopinfo.h and each of the arch-specific
pieces just include that?

> In this struct the occurrences of dev_t have been replaced by their
> actual values (short int / int / long int).

Even better, have specific sized types (__u16, __u32, __u64) for the
fields, so there is no ambiguity (e.g. sparc64, or 32-bit code running
on x86-64).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

