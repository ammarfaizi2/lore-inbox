Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265529AbUBFP5d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 10:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265533AbUBFP5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 10:57:33 -0500
Received: from mx1.mail.ru ([194.67.23.21]:10257 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S265529AbUBFP5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 10:57:31 -0500
Message-ID: <4023B961.2090103@mail.ru>
Date: Fri, 06 Feb 2004 16:57:21 +0100
From: marcel cotta <mc123@mail.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
Followup-To: marcel,cotta,<mc123@mail.ru>
To: Hugh Dickins <hugh@veritas.com>
CC: Good Oleg <olecom.gnu-linux@mail.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG]: kernel BUG at mm/swapfile.c:806! (2.6)
References: <Pine.LNX.4.44.0402060701290.2888-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0402060701290.2888-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Fri, 6 Feb 2004, [koi8-r] "Good Oleg[koi8-r] "  wrote:
> 
> 
>>PC(see below) 256Mib of RAM, linux-2.6.2, 300Mib swap file (swapon /mnt/swap/swap)
>>When programs cause big memory usage i have this
>>(since my 2.4.22 to 2.6.0-test11 migration):
>>
>>Feb  6 02:26:27 gluon kernel: ------------[ cut here ]------------
>>Feb  6 02:26:27 gluon kernel: kernel BUG at mm/swapfile.c:806!
>>Feb  6 02:26:27 gluon kernel: invalid operand: 0000 [#1]
>>Feb  6 02:26:27 gluon kernel: CPU:    0
>>Feb  6 02:26:27 gluon kernel: EIP:    0060:[<c015c7c4>]    Tainted: PFS
>>Feb  6 02:26:27 gluon kernel: EFLAGS: 00010246
>>Feb  6 02:26:27 gluon kernel: EIP is at map_swap_page+0x34/0x60
> 
> 
> [ helpful info snipped ]
> 
> Interesting, thank you.  That's the second report (first on 16 Jan,
> and in that case Not Tainted).  I looked around and found some bugs in
> the swapfile page accounting (if swapfile filesystem blocksize < 4k:
> is yours?  never heard back from Marcel on that) - still intermittently
> working on and testing the fixes there - but in the end nothing which
> would actually cause this BUG.  Was rather thinking it came from slab
> corruption, but a second report makes that (a little) less likely.
> I'll look again later on, but other eyes may find it sooner.
> 
> Hugh
> 
> 
> 

oops, i thought i told you that my blocksize is exactly 4k - sorry

btw, i hit this bug again a few days after i reported it
one time it went crazy and oopsed 8 times in about 8 minutes

i think it only happened when the system was swapping heavily
(swapd creating new swapfiles as fast as it could) and i manually
swapon'ed another (bigger, ~50MB) swapfile by hand

marcel
