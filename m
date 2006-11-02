Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752701AbWKBWc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbWKBWc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbWKBWc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:32:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:1767 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752701AbWKBWc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:32:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sydH6h00I30qCs13iQrdS0MKcXhvELCxca/R3RfkwwPDmuV01yqinRncLKrE32Pqz5yVhd0VrMkG1Hqyed8BJu5QdJ4gvc3qNZoqGFFfnOilE3EvGo5YFaxc6kUX44BbKxRv4vOBjbmr+iP0LghP/ghIEe/9Im4kjjJrx9nrn74=
Message-ID: <454A71EB.4000201@googlemail.com>
Date: Thu, 02 Nov 2006 23:32:11 +0100
From: Gabriel C <nix.or.die@googlemail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:
> Hi
>   

Hi

> As my PhD thesis, I am designing and writing a filesystem, and it's now in 
> a state that it can be released. You can download it from 
> http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
>   

Does not compile for me , using 2.6.18.1 , gcc 4.1.1. Here the error :

/work/crazy/packages/fs/spadfs-0.9.0/super.c: In function 'SPADFS_GET_SB':
/work/crazy/packages/fs/spadfs-0.9.0/super.c:636: error: too few
arguments to function 'get_sb_bdev'
/work/crazy/packages/fs/spadfs-0.9.0/super.c: At top level:
/work/crazy/packages/fs/spadfs-0.9.0/super.c:645: warning:
initialization from incompatible pointer type
/work/crazy/packages/fs/spadfs-0.9.0/super.c:651: warning:
initialization from incompatible pointer type
/work/crazy/packages/fs/spadfs-0.9.0/super.c: In function 'SPADFS_GET_SB':
/work/crazy/packages/fs/spadfs-0.9.0/super.c:637: warning: control
reaches end of non-void function
make[2]: *** [/work/crazy/packages/fs/spadfs-0.9.0/super.o] Error 1
make[1]: *** [_module_/work/crazy/packages/fs/spadfs-0.9.0] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.18-fw2'
make: *** [spadfs] Error 2



> It has some new features, such as keeping inode information directly in 
> directory (until you create hardlink) so that ls -la doesn't seek much, 
> new method to keep data consistent in case of crashes (instead of 
> journaling), free space is organized in lists of free runs and converted 
> to bitmap only in case of extreme fragmentation.
>
> It is not very widely tested, so if you want, test it.
>
> I have these questions:
>
> * There is a rw semaphore that is locked for read for nearly all 
> operations and locked for write only rarely. However locking for read 
> causes cache line pingpong on SMP systems. Do you have an idea how to make 
> it better?
>
> It could be improved by making a semaphore for each CPU and locking for 
> read only the CPU's semaphore and for write all semaphores. Or is there a 
> better method?
>
> * This leads to another observation --- on i386 locking a semaphore is 2 
> instructions, on x86_64 it is a call to two nested functions. Has it some 
> reason or was it just implementator's laziness? Given the fact that locked 
> instruction takes 16 ticks on Opteron (and can overlap about 2 ticks with 
> other instructions), it would make sense to have optimized semaphores too.
>
> * How to implement ordered-data consistency? That would mean that on 
> internal sync event, I'd have to flush all pages of a files that were 
> extended. I could scan all dirty inodes and find pages to flush --- what 
> kernel function would you recommend for doing it? Currently I call only 
> sync_blockdev which doesn't touch buffers attached to pages.
>
> Mikulas
> -
>   

Gabriel

