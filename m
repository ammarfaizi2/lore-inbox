Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261251AbREQGxX>; Thu, 17 May 2001 02:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261252AbREQGxN>; Thu, 17 May 2001 02:53:13 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:3248 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S261251AbREQGw5>; Thu, 17 May 2001 02:52:57 -0400
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com (Linus Torvalds),
        viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <E150B2Z-0004fV-00@the-village.bc.nu>
Organisation: SAP LinuxLab
Date: 17 May 2001 08:46:11 +0200
In-Reply-To: <E150B2Z-0004fV-00@the-village.bc.nu>
Message-ID: <m34ruk5v7w.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Thu, 17 May 2001, Alan Cox wrote:
> I think you have a major tool problem.
> 
> bash-2.04$ size mm/shmem.o
>    text	   data	    bss	    dec	    hex	filename
>    7422	    572	      0	   7994	   1f3a	mm/shmem.o
> bash-2.04$ size fs/ramfs/ramfs.o 
>    text	   data	    bss	    dec	    hex	filename
>    3185	    368	      0	   3553	    de1	fs/ramfs/ramfs.o
> 
> Never trust ls -l size for binaries, its very very unrelated.
> 
> So ramfs is 3553 bytes, shmem.o in total is 8K on current -ac.

But you cannot disable shmem.o totally. That's my whole point in the
discussion. Why add something what is mostly included in the kernel
already?

You have to compare shmem with tmpfs against shmem w/o it:

   text    data     bss     dec     hex filename
   3398     376       0    3774     ebe fs/ramfs/ramfs.o
   5150     484       0    5634    1602 mm/shmem.o
   9174     636       0    9810    2652 mm/shmem.o+tmpfs

So tmpfs is 400 Bytes bigger than ramfs. 

If you add the correct timestamp handling the difference will go down
further. And we gain functionality, don't we?

Greetings
		Christoph


