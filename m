Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281541AbRKSAXd>; Sun, 18 Nov 2001 19:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281862AbRKSAXY>; Sun, 18 Nov 2001 19:23:24 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16228 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281541AbRKSAXF>; Sun, 18 Nov 2001 19:23:05 -0500
Date: Mon, 19 Nov 2001 01:23:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: VM tests on 2.4.15-pre6 and 2.4.15pre6aa1
Message-ID: <20011119012312.B1331@athlon.random>
In-Reply-To: <20011118095720.A324@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011118095720.A324@earthlink.net>; from rwhron@earthlink.net on Sun, Nov 18, 2001 at 09:57:20AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2001 at 09:57:20AM -0500, rwhron@earthlink.net wrote:
> Hope this information is useful!

yes it's useful. It seems normal, as said this kernel isn't going to
swap very easily, it tends to shrink the cache too much, and I only
cared to fix the >=3G boxes with no swap at all but with lots of cache
where I wanted to be sure the anon pages into the lru weren't going to
make the system sluggish (google setup incidentally). I increased
significantly the vm_mapped_ratio default setting to be sure no to have
swap_out in our way during the testing (of course, increasing
vm_mapped_ratio doesn't mean the swap_out doesn't work, but only makes
harder to the machine to run into swap, it tends to shrink the cache
more).

So if you've time to test, I'd like to know what you get also after a:

	echo 9 >/proc/sys/vm/vm_mapped_ratio

and also after backing out those two patches in order:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre6aa1/10_vm-14-no-anonlru-1-simple-cache-1
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre6aa1/10_vm-14-no-anonlru-1

and again using "echo 9 >/proc/sys/vm/vm_mapped_ratio" after backing out
the two patches.

thanks for the feedback,

Andrea
