Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271505AbRHTRuP>; Mon, 20 Aug 2001 13:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271510AbRHTRtz>; Mon, 20 Aug 2001 13:49:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10798 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271505AbRHTRtn>; Mon, 20 Aug 2001 13:49:43 -0400
To: "Kevin Krieser" <kkrieser_list@footballmail.com>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: Re: Swap size for a machine with 2GB of memory
In-Reply-To: <NDBBLFLJADKDMBPPNBALEEKBFCAA.kkrieser_list@footballmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2001 11:42:38 -0600
In-Reply-To: <NDBBLFLJADKDMBPPNBALEEKBFCAA.kkrieser_list@footballmail.com>
Message-ID: <m1ofpamxv5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kevin Krieser" <kkrieser_list@footballmail.com> writes:

> I was just experimenting on my personal Linux computer this weekend, which
> has 512MB of RAM and 700MB of swap.  I also have an unpatched 2.4.8 kernel
> installed.
> 
> I wrote a program that allocated 700MB of RAM and touched every page, then
> read it back in.  When finished, there remained 250+ meg of swap in use, but
> no corresponding free space in RAM, compared to before running my test
> program.  The expected behavior of the 2.4 kernels seemed to be followed,
> where many programs retained space in both RAM and swap.

This was even the behavior in 2.0, and 2.2.  2.4 can simply be more
aggressive about it.  What this sounds like is that, your program
pushed 250MB of other programs into swap.  The programs were the
reread into memory when it was done, and their location in swap was
remembered so that if they were ever pushed into swap again they could
just be dropped from memory, and not need to be written out.

As long as you don't have problems where you can't run your program
multiple times in a row, 2.4 sounds like is is behaving correctly and
sanely.

> However, since my normal behavior is for swap to not be used, I will wait a
> little bit for some of the VM updates to be tested.

Are you saying something is wrong?

> I don't have 2X RAM because when I installed my system, I only had 256MB of
> RAM.

This is not a requirement but is a requirement to have swap > mem if
you are swapping heavily and want good performance.  

Eric
