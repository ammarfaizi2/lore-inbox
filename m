Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276646AbRJMJTI>; Sat, 13 Oct 2001 05:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276688AbRJMJS5>; Sat, 13 Oct 2001 05:18:57 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:44562 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S276646AbRJMJSw>; Sat, 13 Oct 2001 05:18:52 -0400
Message-ID: <3BC80719.AE6BFF07@namesys.com>
Date: Sat, 13 Oct 2001 13:19:21 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: ejolson@math.uci.edu
CC: linux-kernel@vger.kernel.org, Alexander Zarochentcev <zam@namesys.com>,
        reisefs-dev@namesys.com
Subject: Re: reiserfs performance loss
In-Reply-To: <200110121954.MAA27243@math.uci.edu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Olson wrote:
> 
> Dear Hans and linux-kernel,
> 
> I am experiencing read performance loss of between 5 to 20 times
> due to what I think is data fragmentation in big files.
> 
> I am using linux-2.4.4 with the linux-2.4.4-knfsd-6.g.patch on a
> dual processor VIA694 motherboard system with a 40GB Maxtor drive
> on the builtin IDE controller DMA enabled and 512MB main memory.
> 
> The reiserfs partition is 31GB and about 60-70% full.  Also, tail-
> packing has not been disabled.
> 
> My application consists of 8 programs tied together using MPI.
> Each program opens a separate output file and periodically writes
> about 200k of data every 10-40 minutes.  Some programs run on
> remote machines and use the kernel nfsd to write their files on
> the server; other programs run directly on the server.  It is
> possible all 8 programs write at the same time.
> 
> In this way 8 data files of about 500MB each are created.
> 
> For backup these data files are copied to a second server using
> rsync.  The second server is identical to the main server in both
> hardware and software.  Running hdparm -t gives about 20 MB/sec
> for each machine.  However,
> 
>         time cat *.dat >/dev/null
> 
> reads the data locally on the secondary server 5 to 20 times faster
> than reading them locally on the main server.
> 
> Main server timings are
> 
>         real    6m26.789s
>         user    0m0.210s
>         sys     0m9.630s
> 
> and secondary server timings are
> 
>         real    0m34.358s
>         user    0m0.250s
>         sys     0m9.830s
> 
> This is 11 times speed difference.  I think the original copies of
> the files are quite fragmented.  However, I would have expected at
> most a two fold decrease in actual performace.  Is this reasonable?
> 
> I have experienced no other difficulties with reiserfs and like it
> very much.
> 
> All the best, Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


take a look at zam's new bitmap.c (zam please send), and try changing it around
to see the effect on your app.  you'll find the new one is much easier to hack
on.
