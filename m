Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRJ3THY>; Tue, 30 Oct 2001 14:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277559AbRJ3THP>; Tue, 30 Oct 2001 14:07:15 -0500
Received: from femail30.sdc1.sfba.home.com ([24.254.60.20]:39812 "EHLO
	femail30.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274862AbRJ3THI>; Tue, 30 Oct 2001 14:07:08 -0500
Date: Tue, 30 Oct 2001 14:07:38 -0500
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
Message-ID: <20011030140738.A2847@cy599856-a.home.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E15xu2b-0008QL-00@the-village.bc.nu> <Pine.LNX.4.33.0110280945150.7360-100000@penguin.transmeta.com> <20011030095606.I618@suse.de> <dn7ktdpjg7.fsf@magla.zg.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dn7ktdpjg7.fsf@magla.zg.iskon.hr>
User-Agent: Mutt/1.3.23i
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.4.13-ac4 i586 K6-3+
X-Uptime: 13:30:20 up 6 min,  2 users,  load average: 1.09, 0.63, 0.27
From: Josh McKinney <forming@home.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Tue, Oct 30, 2001 at 10:26:32AM +0100, Zlatko Calusic wrote:
> 
> Followup on the problem. Yesterday I was upgrading my Debian Linux. To
> do that I have to remount /usr read-write. After the update finished,
> I tested once again disk writing speed. And there it was, full
> 22MB/sec (on the same partition). And once I get to that point, disk
> will remain performant. Then I thought (poor man's logic) that poor
> performance might have something to do with my /usr mounted read-only
> (BTW, it's on the same disk I'm having problems with).
> 
> Quick test: reboot (/usr is ro), check speed -> only 8MB/sec, remount
> /usr rw, but unfortunately didn't help, writing speed remains low.
> 
> So it was just an idea. I still don't know what can be done to return
> speed to normal. I don't know if I have mentioned, but reading from
> the same disk is always going at the full speed.
> 
> So, something might be wrong with my setup, but I'm still unable to
> find what.
> 
> I'm compiling with 2.95.4 20011006 (Debian prerelease) from the Debian
> unstable distribution. Kernel is completely monolithic (no modules).
>

I am also seeing some not_so_great performance from my ide drive.  It
is a IBM 30GB 7200rpm drive on a promise ata/100 controller.  I am
also using Debian unstable, but I hope that isn't really the problem.
The vmstat output seems very erratic.  It has large bursts then really
slow spots.

I am running 2.4.13-ac4, with rik's swapoff patch.

This is the command I used.

time nice -n -20 dd if=/dev/zero of=/mp3/foobara bs=1024k count=1024
1024+0 records in
1024+0 records out
0.02s user 23.95s system 20% cpu 1:57.24 total

And here is the vmstat output...

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0      0 112636  18728  78352   0   0    58  2139  145    90   5  10  85
 0  0  3      0 112636  18728  78352   0   0     0    48  115    73   0   5  95
 1  0  0      0  91052  18728  99856   0   0     0    65  135    81   0  40  60
 1  0  1      0  41900  18728 149008   0   0     0 31474  198    32   1  99   0
 0  1  1      0   6104  18756 184748   0   0     0 10608  193    35   1  78  21
 0  1  1      0   3064  18768 187756   0   0     0 10296  189    52   0  35  65
 0  1  5      0   3060  18796 187704   0   0     0 10808  205    62   2  21  77
 0  1  2      0   3064  18948 187412   0   0     0 130132 2654   812   0  23  76
 0  1  2      0   3060  18956 187404   0   0     0 10692  188    54   0  26  74
 1  0  3      0   3060  18964 187392   0   0     0  9818  199    53   1  26  73
 0  1  3      0   3060  18976 187368   0   0     0  7308  186    52   1  23  76
 0  3  2      0   3068  19016 187296   0   0     0 73788 1459   417   0  23  77
 0  3  3      0   3076  19444 186436   0   0     0  6392  188    31   1   9  90
 0  3  3      0   3076  19444 186436   0   0     0 10832  188    15   0   2  98
 0  3  3      0   3076  19444 186436   0   0     0 10536  188    17   0   4  96
 0  3  2      0   3076  19444 186436   0   0     0  6556  191    31   0   1  99
 2  0  0      0   3064  19444 186448   0   0     0 17424  724   120   0   9  91
 1  0  1      0   3064  19444 186896   0   0     0 22724  201    33   2  98   0
 0  1  1      0   3064  19444 186540   0   0     0  9872  187    47   1  46  53
 0  1  1      0   3060  19444 186464   0   0     0  2840  193    57   0  15  85
 0  1  1      0   3060  19444 186464   0   0     0 11088  201    54   0  19  81
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  2      0   3060  19500 186360   0   0     0 118288 2232   604   0  25  75
 0  3  2      0   3060  19500 186360   0   0     0  7748  185    57   1   1  98
 0  3  2      0   3060  19500 186360   0   0     0 11776  184    54   0   2  98
 0  3  2      0   3060  19500 186360   0   0     0  7924  181    52   0   1  99
 0  3  2      0   3060  19500 186360   0   0     0  4776  182    64   0   1  99
 0  3  1      0   3060  19500 186360   0   0     0   952  183    50   0   2  98
 0  3  1      0   3060  19500 186360   0   0     0     0  180    48   0   1  99
 1  0  2      0   3064  19500 186356   0   0     0   296  242    80   0  12  88
 0  1  0      0   3060  19500 186360   0   0     0 19668  730   282   1   7  93
 0  1  0      0   3060  19500 186360   0   0     0  6764  200   133   1   2  97
 1  0  0      0   3064  19500 186356   0   0     0 16680  171   123   1  64  35
 1  0  1      0   3060  19500 186360   0   0     0 26903  193    33   1  99   0
 0  1  1      0   3064  19500 186356   0   0     0  7756  184    40   1  54  45
 0  1  5      0   3060  19500 186360   0   0     0 10915  182    66   0  23  77
 0  3  3      0   3060  19668 186024   0   0     0 105102 2059   629   0  18  82
 0  3  3      0   3060  19668 186024   0   0     0  7772  181    59   0   1  99
 0  4  1      0   3060  19668 185948   0   0     1  7440  187    68   0   2  98
 0  4  1      0   3060  19668 185948   0   0     0   260  187    57   0   2  98
 0  4  1      0   3064  19668 185948   0   0     0     0  181    69   0   1  99
 0  5  2      0   3276  19668 185944   0   0     5   522  180    69   3   5  92
 1  1  2      0   3064  19668 185740   0   0    25 26593  190    96   0  78  22
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  4  4      0   3064  19788 184768   0   0    13 99062 2190   647   0  20  79
 0  4  1      0   3064  19788 184768   0   0     0  2440  218    57   0   3  97
 0  4  1      0   3064  19788 184768   0   0     1     0  217    51   0   0 100
 1  1  5      0   3060  19788 185148   0   0    24 14692  214   108   2  46  52
 0  4  2      0   3064  19824 185068   0   0     8 19965  940   240   0  24  75
 0  4  2      0   3064  19824 185068   0   0     0  3224  293    64   0   0 100
 0  4  2      0   3064  19824 185068   0   0     0  4624  310    64   0   3  97
 0  4  2      0   3140  19824 184864   0   0     4  3316  245    86   1   4  95
 0  4  2      0   3140  19824 184864   0   0     0  2608  252    58   0   1  99
 0  4  2      0   3140  19824 184864   0   0     0  6208  262    58   0   0 100
 1  3  2      0   3144  19824 184864   0   0     0 11864  228    58   1   1  98
 0  4  1      0   3140  19824 184864   0   0     4  1200  241    86   1   5  94
 0  4  3      0   3140  19824 184864   0   0     0    27  182    51   0   1  99
 1  1  3      0   3064  19824 184936   0   0    16 24423  183   104   1  61  38
 0  3  6      0   3064  19940 183904   0   0    69 44339  995   314   1  25  74
 0  3  5      0   3064  19940 183904   0   0     0   100  180    51   0   0 100
 0  3  5      0   3064  19940 183904   0   0     0     0  187    50   0   1  99



-- 
Linux, the choice                | "Shelter," what a nice name for for a place
of a GNU generation       -o)    | where you polish your cat. 
Kernel 2.4.13-ac4          /\    | 
on a i586                 _\_v   | 
                                 | 
