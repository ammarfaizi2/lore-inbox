Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317484AbSGEPgf>; Fri, 5 Jul 2002 11:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317483AbSGEPge>; Fri, 5 Jul 2002 11:36:34 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:9609 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S317484AbSGEPgb>; Fri, 5 Jul 2002 11:36:31 -0400
Message-ID: <3D25BB54.7010005@namesys.com>
Date: Fri, 05 Jul 2002 19:29:24 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: reiserfs-dev@namesys.com, gelato@gelato.unsw.edu.au,
       linux-kernel@vger.kernel.org, Oleg Drokin <green@namesys.com>
Subject: Re: [reiserfs-dev] Results of testing Reiserfs on large block devices.
References: <15653.12329.565726.228100@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:

>Hi folks,
>   I couldn't get Reiserfs to work on large devices.  I've tracked the
>problem down.
>
>  When Reiserfs is mounted, it tries to allocate a chunk of memory for
>bitmaps using kmalloc.  The largest chunk allocatable by kmalloc is
>128k.  This limits the size of a reiserfs to just under 2TB on a
>64-bit platform (16384 bitmaps times 8bytes per pointer) or just under
>4TB on a 32 bit platform (32768 bitmaps times 4bytes per pointer).
>
>This reasoning assumes that the number of bitmaps is given by the
>formula (number_of_blocks + (8 * blocksize - 1))/(8 * blocksize) where
>blocksize is 4096 bytes.  Thus 
>	  number_of_blocks = 8 * 4096 * (16384 - 1) - 1  [64 bit]
>								
>	  number_of_blocks = 8 * 4096 * (32768 - 1) - 1  [32 bit]
>
>Hacking mm/slab.c to increase the memory limit allowed larger
>filesystems to be mounted, but I haven't tested these thoroughly yet.
>--
>Dr Peter Chubb				    peterc@gelato.unsw.edu.au
>You are lost in a maze of BitKeeper repositories, all almost the same.
>
>
>
>  
>
Thanks for figuring this out.  Oleg will fix it.

-- 
Hans



