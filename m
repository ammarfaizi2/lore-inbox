Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289854AbSAKDwT>; Thu, 10 Jan 2002 22:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289855AbSAKDwJ>; Thu, 10 Jan 2002 22:52:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24068 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289854AbSAKDwH>;
	Thu, 10 Jan 2002 22:52:07 -0500
Message-ID: <3C3E6163.2E4ECB03@mandrakesoft.com>
Date: Thu, 10 Jan 2002 22:52:03 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Fix fs/fat/inode.c when compiled with gcc-3.0.x
In-Reply-To: <20020111034703.GK13931@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> Hello.  Currently when fs/fat/inode.c is compiled with gcc-3.0.x, there
> are to lines which will cause a __divdi3 call to be used.  But on most
> archs, there isn't currently a __divdi3 implementation in the kernel, so
> FAT will no longer link (or load as a module).  The easy fix (pointed
> out by Andrew Morton) is to replace the divide by 512 with a shift right
> by 9, which has the same effect but doesn't use a divide.
> 
> This is vs 2.4.18-pre3, but applies to 2.5.2-pre9 as well (and probably
> pre10 too..)
> 
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
> 
> ===== fs/fat/inode.c 1.10 vs edited =====
> --- 1.10/fs/fat/inode.c Wed Nov 21 15:12:16 2001
> +++ edited/fs/fat/inode.c       Thu Jan 10 15:40:11 2002
> @@ -406,7 +406,7 @@
>         }
>         inode->i_blksize = 1 << sbi->cluster_bits;
>         inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
> -                          & ~(inode->i_blksize - 1)) / 512;
> +                          & ~(inode->i_blksize - 1)) >> 9;
>         MSDOS_I(inode)->i_logstart = 0;
>         MSDOS_I(inode)->mmu_private = inode->i_size;
> 

wow, I always assumed the compiler was smart enough to replace a "/ 512"
with a shift.

	Jeff



-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
