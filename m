Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282845AbRLLXu3>; Wed, 12 Dec 2001 18:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282898AbRLLXuV>; Wed, 12 Dec 2001 18:50:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:52040 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282845AbRLLXuK>; Wed, 12 Dec 2001 18:50:10 -0500
Date: Thu, 13 Dec 2001 00:49:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Slow Disk I/O with QPS M3 80GB HD
Message-ID: <20011213004933.T4801@athlon.random>
In-Reply-To: <20011210203452.A3250@lucon.org> <20011210235708.A17743@lucon.org> <20011211154331.A32433@lucon.org> <20011212092954.N4801@athlon.random> <20011212153806.A22202@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011212153806.A22202@lucon.org>; from hjl@lucon.org on Wed, Dec 12, 2001 at 03:38:06PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 03:38:06PM -0800, H . J . Lu wrote:
> H.J.
> ----
> 3 files on USB:
> 
> # ls -l
> total 5984
> -rwxr-xr-x    1 root     root      1991481 Dec  8 21:44 dsc00002.jpg
> -rwxr-xr-x    1 root     root      2432127 Dec  8 23:54 dsc00005.jpg
> -rwxr-xr-x    1 root     root      1675563 Dec  8 23:59 dsc00009.jpg
> 
> 1. 2.4.10-pre10
> 
> # time /bin/cp * /tmp/
> real    0m0.623s
> user    0m0.000s
> sys     0m0.100s
> 
> 2. 2.4.10-pre10aa1
> 
> # time /bin/cp * /tmp/
> real    0m8.952s
> user    0m0.000s
> sys     0m0.190s
> 
> 
> 3. 2.4.10-pre11
> 
> # time /bin/cp * /tmp/
> real    0m8.851s
> user    0m0.000s
> sys     0m0.170s

but the above have nothing to do with the blkdev-pagecache.
Blkdev-pagecache can matter only with blkdev accesses, blkdev-pagecache
cannot make any difference if the I/O passes through any fs (not via the
block_dev layer) like in the above case.

Can you try to take those cp under strace timestamp and see what's the
syscall that blocks?

Andrea
