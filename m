Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280664AbRKFWss>; Tue, 6 Nov 2001 17:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280663AbRKFWsm>; Tue, 6 Nov 2001 17:48:42 -0500
Received: from user-119a3cr.biz.mindspring.com ([66.149.13.155]:2829 "HELO
	fancypants.trellisinc.com") by vger.kernel.org with SMTP
	id <S280641AbRKFWr6>; Tue, 6 Nov 2001 17:47:58 -0500
From: dank@trellisinc.com
To: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <20011106152215.A31923@codepoet.org>
X-Newsgroups: mlist.linux-kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.2.19ext3 (i686))
Message-Id: <20011106224753.7D45EA3B90@fancypants.trellisinc.com>
Date: Tue,  6 Nov 2001 17:47:53 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011106152215.A31923@codepoet.org> you wrote:
> Sorry, no doughnut for you.  drivers/block/genhd.c:

>    #ifdef CONFIG_PROC_FS
>    int get_partition_list(char *page, char **start, off_t offset, int count)
>        char buf[64];
> so each /proc/partitions line maxes out at 63 bytes.  So not only
> is there no overflow, I am providing 16 extra bytes of padding.

"code poet?"  you've plucked an 80 from the air.  regardless of what the
kernel prints now and how it's limited (deep within drivers/block/genhd.c),
there is no reference to this silent 63 via either explicit comment or
pure code.  your code remains happily ignorant of any modification to this
postcondition, and when that changes (as it surely will), you lose.  it's
uninspired coding like the above that keeps the buffer overflow
technique alive.

now, i imagine you're more skilled than this, and would have invested
the time to do it properly the first time around (certainly *my*
managers wouldn't accept "buried within the backend is a hardcoded
constant...", but i work in network security).  others, however, may
not be so skilled as you, and what of when they're writing your server?

c string processing is all of doable, mature, and meticulous.  "done
properly by beginners" is not how i would describe it.

-- 
nicholas black (dank@trellisinc.com)                      http://trellisinc.com
