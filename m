Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272985AbRINSsW>; Fri, 14 Sep 2001 14:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273445AbRINSsM>; Fri, 14 Sep 2001 14:48:12 -0400
Received: from home.nohrsc.nws.gov ([192.46.108.2]:17804 "HELO nohrsc.nws.gov")
	by vger.kernel.org with SMTP id <S273444AbRINSr7>;
	Fri, 14 Sep 2001 14:47:59 -0400
Date: Fri, 14 Sep 2001 13:48:16 -0500 (CDT)
From: kelley eicher <keicher@nws.gov>
X-X-Sender: <keicher@home.nohrsc.nws.gov>
To: J <jack@i2net.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 0-order allocation failed in 2.4.10-pre8
In-Reply-To: <3BA24EB0.5000402@i2net.com>
Message-ID: <Pine.LNX.4.33.0109141342340.14906-100000@home.nohrsc.nws.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2001, J wrote:

> Hello,
>     I am reporting the same problem that kelley eicher
> has, "0-order allocation failed (gfp=0x70/1)", hopefully
> my info is helpfull. I added BUG() after the printk's in
> "mm/page_alloc.c:505". I am able to get this message
> when ever I copy a large (2+ gig) file from one XFS filesystem
> to another on the same disk controller. I have attached klogd -p output
> and an output of /proc/slabinfo from <= 1 second before the
> Oops. If anyone would like more info, or for me to apply dangerous
> patches, or to shut up even, let me know.
>
> Jack
>
> Machine:
> Kernel Version 2.4.10-pre8 with SGI-XFS patches and IBM-JFS patches.
> compiled with egcs 2.91-66 ;) (Some more info @ http://whatevr.i2net.com)
> SMP P3 Box with 2 Gig of memory

after spending a few dayz trying to figure out where this is happening, i
noticed that the alloc_pages() errors only occur after used memory goes
above 899MB. this is the limit of physical memory unless you enable the
himem option. the machines i had been seeing this on all had 1G+ memory
and i had enabled the 4G himem option on each of them. so turn that option
off and you will no longer see alloc_pages errors. you'll have to suffer
through only having 900MB of memory to play with though. ;>

-kelley

