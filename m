Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbTBJPrt>; Mon, 10 Feb 2003 10:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbTBJPrt>; Mon, 10 Feb 2003 10:47:49 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:19373 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S264756AbTBJPro>; Mon, 10 Feb 2003 10:47:44 -0500
Message-ID: <3E47CBE8.2000303@blue-labs.org>
Date: Mon, 10 Feb 2003 10:57:28 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: __down_failed, 2,5,59
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root     27966  0.0  0.0  1500  620 ?        D    00:08   0:00 
.././config/imake/imake -I.././config/cf -Wundef -DTOPDIR=.. -DCURDIR=fonts

imake         D 00000082     0 27966      1               12121 (NOTLB)
Call Trace:
 [<c01630e5>] unlock_nd+0x55/0xa0
 [<c0108246>] __down+0x96/0x100    
 [<c011db90>] default_wake_function+0x0/0x40
 [<c010845c>] __down_failed+0x8/0xc
 [<c016360b>] .text.lock.namei+0x7d/0x172
 [<c0151e33>] filp_open+0x43/0x70
 [<c015228b>] sys_open+0x5b/0x90
 [<c010955f>] syscall_call+0x7/0xb

# ls -l /proc/27966/fd
total 0
lrwx------    1 root     root           64 Feb 10 10:50 0 -> /dev/null
l-wx------    1 root     root           64 Feb 10 10:50 1 -> 
/tmp/cron.root.12339 (deleted)
l-wx------    1 root     root           64 Feb 10 10:50 2 -> 
/tmp/cron.root.12339 (deleted)
lrwx------    1 root     root           64 Feb 10 10:50 3 -> 
/var/tmp/portage/xfree-4.2.99.4/work/xc/fonts/Makefile (deleted)
l-wx------    1 root     root           64 Feb 10 10:50 4 -> 
/var/tmp/portage/xfree-4.2.99.4/work/xc/fonts/Imakefile.c
# ls -Lil /proc/27966/fd
total 1200
     55 crw-rw-rw-    1 root     root       1,   3 Dec 31  1969 0
  41799 -rw-------    0 root     root       611482 Feb 10 10:36 1
  41799 -rw-------    0 root     root       611482 Feb 10 10:36 2
 293141 -rw-r--r--    0 root     root            0 Feb 10 00:08 3
 293142 -rw-r--r--    1 root     root            0 Feb 10 00:08 4


# lsof -p 27966
COMMAND   PID USER   FD   TYPE DEVICE    SIZE   NODE NAME
imake   27966 root  cwd    DIR    8,1     240 290354 
/var/tmp/portage/xfree-4.2.99.4/work/xc/fonts
imake   27966 root  rtd    DIR    8,1     384      2 /
imake   27966 root  txt    REG    8,1   25218 292705 
/var/tmp/portage/xfree-4.2.99.4/work/xc/config/imake/imake
imake   27966 root  mem    REG    8,1   90645 176866 /lib/ld-2.3.1.so
imake   27966 root  mem    REG    8,1   23201 258203 /lib/libsandbox.so
imake   27966 root  mem    REG    8,1 1432487 176723 /lib/libc-2.3.1.so
imake   27966 root  mem    REG    8,1   12247 176867 /lib/libdl-2.3.1.so
imake   27966 root    0u   CHR    1,3             55 /dev/null
imake   27966 root    1w   REG    8,1  611482  41799 
/tmp/cron.root.12339 (deleted)
imake   27966 root    2w   REG    8,1  611482  41799 
/tmp/cron.root.12339 (deleted)
imake   27966 root    3u   REG    8,1       0 293141 
/var/tmp/portage/xfree-4.2.99.4/work/xc/fonts/Makefile (deleted)
imake   27966 root    4w   REG    8,1       0 293142 
/var/tmp/portage/xfree-4.2.99.4/work/xc/fonts/Imakefile.c



root       723  0.0  0.6  6020 4412 pts/5    D    00:18   0:00 python2.2 
/usr/bin/emerge xfree

python2.2     D 00000086     0   723  12064                     (NOTLB)
Call Trace:
 [<c0108246>] __down+0x96/0x100
 [<c011db90>] default_wake_function+0x0/0x40
 [<c010845c>] __down_failed+0x8/0xc
 [<c01529e9>] .text.lock.open+0x55/0x7c
 [<c015c7f7>] sys_stat64+0x37/0x40
 [<c010955f>] syscall_call+0x7/0xb

# ls -l /proc/723/fd
total 0
lrwx------    1 root     root           64 Feb 10 10:50 0 -> /dev/pts/5
lrwx------    1 root     root           64 Feb 10 10:50 1 -> /dev/pts/5
lrwx------    1 root     root           64 Feb 10 10:50 2 -> /dev/pts/5
# ls -Lil /proc/723/fd
total 0
   1030 crw-------    1 david    tty      136,   5 Feb 10 00:18 0
   1030 crw-------    1 david    tty      136,   5 Feb 10 00:18 1
   1030 crw-------    1 david    tty      136,   5 Feb 10 00:18 2


# lsof -p 723
COMMAND   PID USER   FD   TYPE DEVICE    SIZE   NODE NAME
python2.2 723 root  cwd    DIR    8,1     264   2779 /root
python2.2 723 root  rtd    DIR    8,1     384      2 /
python2.2 723 root  txt    REG    8,1  682120  65317 /usr/bin/python2.2
python2.2 723 root  mem    REG    8,1   90645 176866 /lib/ld-2.3.1.so
python2.2 723 root  mem    REG    8,1   16272  65270 
/usr/lib/python2.2/lib-dynload/select.so
python2.2 723 root  mem    REG    8,1   26680  65306 
/usr/lib/python2.2/lib-dynload/strop.so
python2.2 723 root  mem    REG    8,1   12247 176867 /lib/libdl-2.3.1.so
python2.2 723 root  mem    REG    8,1   84042 176705 /lib/libpthread-0.10.so
python2.2 723 root  mem    REG    8,1   11061 176746 /lib/libutil-2.3.1.so
python2.2 723 root  mem    REG    8,1 1065659 270107 
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2/libstdc++.so.5.0.2
python2.2 723 root  mem    REG    8,1  184308 176865 /lib/libm-2.3.1.so
python2.2 723 root  mem    REG    8,1   40460 270115 
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2/libgcc_s.so.1
python2.2 723 root  mem    REG    8,1 1432487 176723 /lib/libc-2.3.1.so
python2.2 723 root  mem    REG    8,1   15272  65288 
/usr/lib/python2.2/lib-dynload/fcntl.so
python2.2 723 root  mem    REG    8,1   18996  65283 
/usr/lib/python2.2/lib-dynload/time.so
python2.2 723 root  mem    REG    8,1    7092 258169 
/usr/lib/python2.2/site-packages/missingos.so
python2.2 723 root  mem    REG    8,1   65368  65279 
/usr/lib/python2.2/lib-dynload/cPickle.so
python2.2 723 root  mem    REG    8,1   20943  65266 
/usr/lib/python2.2/lib-dynload/cStringIO.so
python2.2 723 root  mem    REG    8,1    8259  65287 
/usr/lib/python2.2/lib-dynload/grp.so
python2.2 723 root  mem    REG    8,1    8738  65294 
/usr/lib/python2.2/lib-dynload/pwd.so
python2.2 723 root  mem    REG    8,1   19096  40187 
/usr/lib/python2.2/site-packages/fchksum.so
python2.2 723 root  mem    REG    8,1   50054 174377 
/lib/libnss_compat-2.3.1.so
python2.2 723 root  mem    REG    8,1   88984 176721 /lib/libnsl-2.3.1.so
python2.2 723 root  mem    REG    8,1   72573   2238 /usr/lib/libz.so.1.1.4
python2.2 723 root    0u   CHR  136,5           1030 /dev/pts/5
python2.2 723 root    1u   CHR  136,5           1030 /dev/pts/5
python2.2 723 root    2u   CHR  136,5           1030 /dev/pts/5


The above occurred last night 'round midnight.  Kernel is vanilla 
2.5.59, underlying filesystem is reiserfs.  Single Athlon CPU.

David

-- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE


