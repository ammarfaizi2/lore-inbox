Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287115AbSAGV0C>; Mon, 7 Jan 2002 16:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287141AbSAGVZx>; Mon, 7 Jan 2002 16:25:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33804 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287115AbSAGVZq>;
	Mon, 7 Jan 2002 16:25:46 -0500
Message-ID: <3C3A1256.BFF12A@mandrakesoft.com>
Date: Mon, 07 Jan 2002 16:25:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
In-Reply-To: <20020107132121.241311F6A@gtf.org> <E16NbYF-0001Qq-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> The two main problems I see with this are:
> 
>   - If a filesystem doesn't want to use genericp_ip/sbp then fs.h has
>     to know about it.  Why should fs.h know about every filesystem in
>     the world?

We keep type information through this method.  There is no ugly casting.


>   - You are dreferencing a pointer, and have two allocations for every
>     inode instead of one.

<blink>  re-read....  With patch6/7 there is only one allocation.


> Moving the ext2 headers from include/linux to fs/ext2 is an interesting
> feature of your patch, though it isn't essential to the idea you're
> presenting.  But is there a good reason why ext2_fs_i.h and ext2_fs_sb.h
> should remain separate from ext2_fs.h?  It looks like gratuitous
> modularity to me.

I agree this is a better end goal; my patches simply did not take things
that far.


> Minor nit:
> 
>         if (!inode->u.ext2_ip)
>                 BUG();
> 
> You don't have to do this, if the pointer is null you will get a perfectly
> fine oops.

BUG oops are a little bit more perfectly fine :), since they print out
filename and line number when CONFIG_DEBUG_BUGVERBOSE is enabled..

	Jeff



-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
