Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315281AbSEGCEB>; Mon, 6 May 2002 22:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSEGCEA>; Mon, 6 May 2002 22:04:00 -0400
Received: from mark.mielke.cc ([216.209.85.42]:62729 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S315281AbSEGCD7>;
	Mon, 6 May 2002 22:03:59 -0400
Date: Mon, 6 May 2002 21:58:48 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: gzip vs. bzip2 (mainly de-)compression "benchmark"
Message-ID: <20020506215848.A7517@mark.mielke.cc>
In-Reply-To: <Pine.LNX.4.44.0205061152480.19017-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think it is fair to measure compression speed of a relatively
small image, such as the kernel image, to the compression of your
entire root partition. There are certain file formats that are more
difficult for bzip2 to deal with, than others.

The kernel image itself will not take 10 minutes to decompress with
bzip2. For floppy disks, it is doubtful that the image could be read
off the floppy faster than even older computers could un-bzip2 the
images, meaning that execution time is irrelevant in this context.

mark


On Mon, May 06, 2002 at 11:58:42AM -0600, Thunder from the hill wrote:
> Hi,
> 
> gzipping, bzip2ing a solaris disk image from my old sparc64 under alpha
> (approx. 2 GiB) and relative load.
> This has been done for testing purposes for those fiddling around with the 
> kernel compression algorithms.
> 
> # ls -l ; ls -lh
> -rw-r--r--    1 root     root   2164082688 May  5 04:41 old-root
> -rw-r--r--    1 root     root         2.0G May  5 04:41 old-root
> 
> # time gzip -9n old-root
> 9035.15user 119.40system 11:38:12elapsed 21%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (166major+112minor)pagefaults 0swaps
> 
> # ls -l ; ls -lh
> -rw-r--r--    1 65534    65534   546148165 May  2 11:30 old-root.gz
> -rw-r--r--    1 65534    65534        521M May  2 11:30 old-root.gz
> 
> # time gzip -cd old-root.gz > /dev/null
> 134.11user 66.22system 10:42.91elapsed 31%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (102major+37minor)pagefaults 0swaps
> 
> # time bzip2 -9z old-root
> (Unfortunately crashed shortly after completion when I modprobed khttpd and
> tried to make a connection. I can redo that if you are interested in the
> results, but I tell you it took some time... user was in the 11,000 I 
> remember.)
> 
> # ls -l ; ls -lh
> -rw-r--r--    1 root     root    496780930 May  5 04:41 old-root.bz2
> -rw-r--r--    1 root     root         474M May  5 04:41 old-root.bz2
> 
> # time bzip2 -cdk old-root.bz2 > /dev/null
> 1010.44user 33.15system 58:12.14elapsed 29%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (117major+914minor)pagefaults 0swaps
> 
> Penguin: Linux 2.4.8 (didn't have time to compile the latest here) on an
> 	 Alpha 300, 384 MiB RAM. Meanwhile someone was compiling Redhat
> 	 Package Manager v4.1, later the Linux Kernel v2.4 repository.
> 
> Regards,
> Thunder
> -- 
> if (errno == ENOTAVAIL)
>     fprintf(stderr, "Error: Talking to Microsoft server!\n");
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

