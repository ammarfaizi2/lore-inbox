Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135271AbRAGARH>; Sat, 6 Jan 2001 19:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135321AbRAGAQ5>; Sat, 6 Jan 2001 19:16:57 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:11440 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S135271AbRAGAQv>; Sat, 6 Jan 2001 19:16:51 -0500
Date: Sat, 06 Jan 2001 16:13:37 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: [PATCH] up to 50% faster sys_poll()
To: Manfred <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Reply-to: dank@alumni.caltech.edu
Message-id: <3A57B4B1.C8BADE31@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3A579508.CF755874@alumni.caltech.edu>
 <3A57A668.7D4D8E46@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred wrote:
> The improvement with large number of pipes probably comes from replacing
> __get_free_page() with kmalloc() - kmalloc is faster, especially on SMP.
> ...
> I expected 2 improvements:
> * poll with < 24 descriptors: around 800 cpu ticks faster, but that's
> just one or two microseconds.
> * if one of the first 8 descriptors has new data: add another ~200 cpu
> ticks.

OK, I reran with different numbers of fd's, again on a 650 MHz dual PIII SMP.

Times in microseconds to find 1 active pipe out of N total pipes:

                number of pipes
kernel        1      8      10000   30000
-----------------------------------------
2.4.0         7     10      14600   45843
2.4.0-pp      5      8      14321   44903

For small N, your patch makes poll() 2 microseconds faster uniformly.
That's a 20-30% speedup, not bad.
Anyone know if this would actually help real-life programs?

BTW, your change makes poll() slightly faster than select().

For large N, your patch speeds poll() up by 2-5%.  
(Increasing /proc/sys/fs/file-max to 70000 appears to reduce the speedup.)
I doubt that will have much effect on real-life programs.
- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
