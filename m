Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbUKGGBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbUKGGBA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 01:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUKGGBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 01:01:00 -0500
Received: from serio.al.rim.or.jp ([202.247.191.123]:23255 "EHLO
	serio.al.rim.or.jp") by vger.kernel.org with ESMTP id S261541AbUKGGAm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 01:00:42 -0500
Message-ID: <418DB9F4.8030301@yk.rim.or.jp>
Date: Sun, 07 Nov 2004 15:00:20 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: linux-kernel@vger.kernel.org, mru@inprovide.com, anton@samba.org
Subject: Re: Configuration system bug? : tmpfs listing in /proc/filesystems
    when TMPFS was not configured!?
References: <Pine.LNX.4.44.0411070436080.12803-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0411070436080.12803-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> On Sun, 7 Nov 2004, Chiaki wrote:
> 
>>Should not this line be ifdef'ed out???
>>That is, should we modify the line like this?
>>
>>#ifdef CONFIG_TMPFS
>>	error = register_filesystem(&tmpfs_fs_type);
>>#endif
> 
> 
> I'd be more inclined to register under a different
> name than "tmpfs" in the !CONFIG_TMPFS case.

Something like "tMpfs" might be a good idea to
show the strange setting :-)

> 
> But as I said in my earlier reply to you (which you should have
> received before you sent this?), it's been like this ever since
> 2.4.4 when "tmpfs" and CONFIG_TMPFS came into being, so I don't
> see why we need to change it now.

Thank you for your previous e-mail.
I didn't know it reached my computer since my mozilla e-mail
filtering mitakingly classified your kind response into
an unexpected folder. I searched after reading the above paragraph
and found your previous e-mail.

> The real 2.4.9 error is fixed by the patch below that I sent then:
> does that solve your problems?

YES!

With the original 2.6.9, the mount didn't complain at all, and
then I got bizarre behavir afterward and udev script and booting
stopped at that point.

But wih your patch, now mount fails.
So now it is a matter of fixing udev script to
take care of the case of failing tmpfs mounting.
I will re-open the debian bugzilla entry concerning this
so that Debian udev package and possibly an upstream package
can be fixed.



tmpfs mount failure example: (I had created /tmp/t-dir.)

duron:/home/ishikawa# mount -n -o size=1m,mode=0755 -t tmpfs none /tmp/t-dir
mount: wrong fs type, bad option, bad superblock on none,
        or too many mounted file systems
duron:/home/ishikawa#


> Hugh
> 
> --- 2.6.9/mm/shmem.c	2004-10-18 22:56:29.000000000 +0100
> +++ linux/mm/shmem.c	2004-11-06 21:04:41.743173040 +0000
> @@ -1904,6 +1904,8 @@ static int shmem_fill_super(struct super
>  		sbinfo->max_inodes = inodes;
>  		sbinfo->free_inodes = inodes;
>  	}
> +#else
> +	sb->s_flags |= MS_NOUSER;
>  #endif
>  
>  	sb->s_maxbytes = SHMEM_MAX_BYTES;
> 
> 
> 


Thank you very much!



-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
