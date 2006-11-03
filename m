Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752874AbWKCBW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbWKCBW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 20:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbWKCBW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 20:22:59 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:42133 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1752874AbWKCBW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 20:22:58 -0500
Date: Fri, 3 Nov 2006 02:22:57 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Gabriel C <nix.or.die@googlemail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <454A71EB.4000201@googlemail.com>
Message-ID: <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <454A71EB.4000201@googlemail.com>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Nov 2006, Gabriel C wrote:

> Mikulas Patocka wrote:
>> Hi
>>
>
> Hi
>
>> As my PhD thesis, I am designing and writing a filesystem, and it's now in
>> a state that it can be released. You can download it from
>> http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
>>
>
> Does not compile for me , using 2.6.18.1 , gcc 4.1.1. Here the error :
>
> /work/crazy/packages/fs/spadfs-0.9.0/super.c: In function 'SPADFS_GET_SB':
> /work/crazy/packages/fs/spadfs-0.9.0/super.c:636: error: too few
> arguments to function 'get_sb_bdev'
> /work/crazy/packages/fs/spadfs-0.9.0/super.c: At top level:
> /work/crazy/packages/fs/spadfs-0.9.0/super.c:645: warning:
> initialization from incompatible pointer type
> /work/crazy/packages/fs/spadfs-0.9.0/super.c:651: warning:
> initialization from incompatible pointer type
> /work/crazy/packages/fs/spadfs-0.9.0/super.c: In function 'SPADFS_GET_SB':
> /work/crazy/packages/fs/spadfs-0.9.0/super.c:637: warning: control
> reaches end of non-void function
> make[2]: *** [/work/crazy/packages/fs/spadfs-0.9.0/super.o] Error 1
> make[1]: *** [_module_/work/crazy/packages/fs/spadfs-0.9.0] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6.18-fw2'
> make: *** [spadfs] Error 2

Hmm, I see, they changed some stuff ... and in 2.6.19 too. I made a new 
version that compiles with 2.6.18 and 2.6.19rc4, so try it.

BTW. I've found a weird code in 2.6.19rc4 in vfs_getattr:
generic_fillattr(inode, stat); (ends with stat->blksize = (1 << 
inode->i_blkbits);)
and then
if (!stat->blksize) {...

Someone made this bug when changing it.

Mikulas
