Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313162AbSDSXNJ>; Fri, 19 Apr 2002 19:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312944AbSDSXNG>; Fri, 19 Apr 2002 19:13:06 -0400
Received: from tomts14-srv.bellnexxia.net ([209.226.175.35]:48881 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S313747AbSDSXIB>; Fri, 19 Apr 2002 19:08:01 -0400
Subject: Re: severe slowdown with 2.4 series w/heavy disk access (revisited)
From: Shane <shane@zeke.yi.org>
To: linux-kernel@vger.kernel.org
Cc: lkml-frank@unternet.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 19 Apr 2002 19:07:29 -0400
Message-Id: <1019257649.17679.45.camel@mars.goatskin.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,


>Hi'all,

>Anyone remember this thread:
>   "severe slowdown with 2.4 series w/heavy disk access"
>http://hypermail.spyroid.com/linux-kernel/archived/2001/week52/0266.html
>It describes the tendency of 2.4 series kernels to slowdown under I/O
>load. 

[..snip..]

I tried copying a 650MB file to the same file system on an IDE disk  
and...

(This is while the copy is running)

$ time ls -l
total 1284548
-rw-r--r--    1 shane    shane    685183312 Apr 19 18:13 650MB_tar_ball
-rw-r--r--    1 shane    shane    628895744 Apr 19 18:44 X
0.00user 0.00system 0:00.00elapsed 0%CPU (0avgtext+0avgdata
0maxresident)k
0inputs+0outputs (191major+35minor)pagefaults 0swaps
$ time ls -l
total 1287624
-rw-r--r--    1 shane    shane    685183312 Apr 19 18:13 650MB_tar_ball
-rw-r--r--    1 shane    shane    632041472 Apr 19 18:44 X
0.01user 0.00system 0:00.00elapsed 500%CPU (0avgtext+0avgdata
0maxresident)k
0inputs+0outputs (191major+35minor)pagefaults 0swaps
$ time ls -l
total 1290188
-rw-r--r--    1 shane    shane    685183312 Apr 19 18:13 650MB_tar_ball
-rw-r--r--    1 shane    shane    634662912 Apr 19 18:44 X
0.01user 0.00system 0:00.00elapsed 500%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (191major+35minor)pagefaults 0swaps

vmstat 1 was running as well

   procs              memory      swap     io        system         cpu
 r w b  swpd   free     buf  cache si so bi bo   in    cs  us  sy  id
 0 0 0  53580  12296   3008 258120 0 0 0     0  180    87   0   0 100
 1 0 0  53580  12296   3008 258120 0 0 0     0  176    67   0   0 100
 3 0 0  53580 120492   3008 149836 0 0 2316  0  240   232   1  13  86
 2 0 0  53580  59432   3008 210596 0 0 30208 0  852  1491   3  42  55
 0 1 0  53580   4740   3012 264864 0 0 30212 0  652  1107   1  39  60
 0 1 1  53580   4600   3012 264696 0 0 23048 5760  586   885   2  31  67
 1 1 2  53580   4492   3016 264784 0 0 2560 17540  504   207   0   7  93
 0 1 1  53580   4324   3016 264944 0 0 2560 18304  501   256   0   6  94
 0 1 1  53580   4284   3016 264968 0 0 2048 16128  509   244   0   6  94
 0 1 1  53580   4488   3016 264740 0 0 2048 18020  499  206   0   5  95
 1 0 0  53604   4216   3028 266368 0 0 9732 10192  539   438   0  18  82
 0 1 1  53604   4424   3028 266056 0 0 6144 18148  525   395   2   6  92
 1 0 0  53604   3924   2904 266860 0 6019968 3900  614   866   0  35  65
 1 0 0  53604   4668   2908 265728 0 0 29188    0  634  1077   0  39  61
...

This is on a UP AMD Tbird, 384MB, on an IDE disk on a Promise TX133
controller. The Gnome desktop was responsive throughout the copy.

This is with the 2.4.19-pre6aa1 kernel. Give it a try...if you want.

Regards,

Shane


 

