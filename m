Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280236AbRJaO13>; Wed, 31 Oct 2001 09:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280238AbRJaO1U>; Wed, 31 Oct 2001 09:27:20 -0500
Received: from mail201.mail.bellsouth.net ([205.152.58.141]:46661 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280236AbRJaO1K>; Wed, 31 Oct 2001 09:27:10 -0500
Message-ID: <3BE00A61.EAA52CE1@mandrakesoft.com>
Date: Wed, 31 Oct 2001 09:27:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: pre6 oom killer oops
In-Reply-To: <Pine.GSO.4.21.0110310916210.5536-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Wed, 31 Oct 2001, Jeff Garzik wrote:
> 
> > further comments #2:
> >
> > when rebooting, there was some disk corruption in the ext2 filesystem.
> >
> > It is my guess that this is to the large number of buffers in the vmstat
> > output, which I believe are dirty buffers that never got written out
> 
> Judging by your log it's not an OOM - page table corruption got caught by
> do_wp_page(), which means that handle_mm_fault() fails (surprise, surprise),
> which kills the process.
> 
> Looks like a massive memory corruption - later it fscked you in pte_alloc()
> and then it screwed buffer cache lists.

I'm reinstalling now, with a bad blocks check, to make sure random disk
crap isn't affecting things.  Disk is good AFAIK.  Vaguely recent ATA-33
drive.  I'll switch to the other alpha to see if I can see similar
symptoms.  

Unfortunately I don't know of a good alpha memory tester like
memtest86.  SRM firmware tests memory ok, but that probably doesn't mean
much.

Final comment before leaving this machine.  Restarting the rpm-rebuilder
(post reboot and fsck), I still see a very large number of buffs.  Since
there is zero swapped, this may or may not be normal.  The cache value
appears sane, FWIW.


   procs                      memory    swap          io    
system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us 
sy  id
 2  0  0      0  35024  13016 267256   0   0     3   491 1046   136  84 
12   4
 1  0  0      0 106776  14864 191984   0   0   380     0 1903   696  13 
20  67
 3  0  0      0  85448  16424 210216   0   0   239    11 1066  1305  58 
25  17
 1  0  0      0  83624  16560 210712   0   0   107    21 1068   550  54 
25  21
 1  0  0      0  81952  16600 211224   0   0     3     0 1030    96 
93   6   0
 1  0  0      0  78720  16704 212080   0   0   144    11 1045   118  79 
12   9
 2  0  0      0  79608  16728 212400   0   0    30     0 1037   108 
86   8   5
 1  0  0      0  73288  16792 212736   0   0    35    11 1039    84 
91   5   4
 1  0  0      0  71784  16792 212736   0   0     0    11 1038    25 
99   1   0
 1  0  0      0  81560  16944 214840   0   0   446     0 1049   259  70 
19  11
 1  0  0      0  76920  16984 215480   0   0     4     0 1031   487  75 
24   1
 1  0  0      0  79384  17016 215600   0   0     0     0 1029    23 
94   6   0
 0  1  1      0  79432  17056 215976   0   0    12  1396 1132   188  48 
12  40
 0  1  1      0  79384  17056 216008   0   0    11  4542 1107    14  
0   2  98
 1  0  0      0  74400  17128 216984   0   0   331   217 1090   269  25 
10  65
 2  0  0      0  70456  17136 217064   0   0     0   288 1030   119 
96   4   0
 1  0  0      0  72200  17152 217176   0   0     0     0 1050    96 
97   3   0
 1  0  0      0  67232  17152 217264   0   0     0   107 1041    93 
98   2   0
 1  0  0      0  70072  17160 217416   0   0     0     0 1029    91 
97   3   0
 1  0  0      0  68272  17168 217496   0   0     0    75 1035   122 
96   4   0

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

