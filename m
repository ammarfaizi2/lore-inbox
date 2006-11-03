Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752938AbWKCCJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbWKCCJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 21:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752937AbWKCCJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 21:09:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:53900 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752653AbWKCCJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 21:09:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BBkuVdPvW+Pn5Jq5A+oxYggkyJ+BziwAApzVDw9mSQDTtuvYFcS6oEDQ8h0/FxCHu/rMVwMX6PrMmtXwmdsh8x2Nr+IVlKYHSly+D3sI9SHihBpkcO96Xn+xV4UTvVyNkD0Ykam44lnBxV2bIqALJVeSJ+6yJ8SvDcsLFat3tuc=
Message-ID: <454AA4C5.3070106@googlemail.com>
Date: Fri, 03 Nov 2006 03:09:09 +0100
From: Gabriel C <nix.or.die@googlemail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <454A71EB.4000201@googlemail.com> <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:
> On Thu, 2 Nov 2006, Gabriel C wrote:
>
>   
>> Mikulas Patocka wrote:
>>     
>>> Hi
>>>
>>>       
>> Hi
>>
>>     
>>> As my PhD thesis, I am designing and writing a filesystem, and it's now in
>>> a state that it can be released. You can download it from
>>> http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
>>>
>>>       
>> Does not compile for me , using 2.6.18.1 , gcc 4.1.1. Here the error :
>>
>> /work/crazy/packages/fs/spadfs-0.9.0/super.c: In function 'SPADFS_GET_SB':
>> /work/crazy/packages/fs/spadfs-0.9.0/super.c:636: error: too few
>> arguments to function 'get_sb_bdev'
>> /work/crazy/packages/fs/spadfs-0.9.0/super.c: At top level:
>> /work/crazy/packages/fs/spadfs-0.9.0/super.c:645: warning:
>> initialization from incompatible pointer type
>> /work/crazy/packages/fs/spadfs-0.9.0/super.c:651: warning:
>> initialization from incompatible pointer type
>> /work/crazy/packages/fs/spadfs-0.9.0/super.c: In function 'SPADFS_GET_SB':
>> /work/crazy/packages/fs/spadfs-0.9.0/super.c:637: warning: control
>> reaches end of non-void function
>> make[2]: *** [/work/crazy/packages/fs/spadfs-0.9.0/super.o] Error 1
>> make[1]: *** [_module_/work/crazy/packages/fs/spadfs-0.9.0] Error 2
>> make[1]: Leaving directory `/usr/src/linux-2.6.18-fw2'
>> make: *** [spadfs] Error 2
>>     
>
> Hmm, I see, they changed some stuff ... and in 2.6.19 too. I made a new 
> version that compiles with 2.6.18 and 2.6.19rc4, so try it.
>   

This error looks fixed, now I have a new one here :)

cc -D__NOT_FROM_SPAD -D__NOT_FROM_SPAD_TREE -Wall
-fdollars-in-identifiers -O2 -fomit-frame-pointer -c -o MKSPADFS.o -x c
MKSPADFS.C
MKSPADFS.C:146: error: expected declaration specifiers or '...' before
'_llseek'
MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'fd'
MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'hi'
MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'lo'
MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'res'
MKSPADFS.C:146: error: expected declaration specifiers or '...' before 'wh'
MKSPADFS.C:146: warning: type defaults to 'int' in declaration of
'_syscall5'
In file included from MKSPADFS.C:153:
GETHSIZE.I: In function 'test_access':
GETHSIZE.I:13: warning: implicit declaration of function '_llseek'
make: *** [MKSPADFS.o] Error 1


> BTW. I've found a weird code in 2.6.19rc4 in vfs_getattr:
> generic_fillattr(inode, stat); (ends with stat->blksize = (1 << 
> inode->i_blkbits);)
> and then
> if (!stat->blksize) {...
>
> Someone made this bug when changing it.
>   
> Mikulas
>
>   

Gabriel

