Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277228AbRKFBo5>; Mon, 5 Nov 2001 20:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277112AbRKFBor>; Mon, 5 Nov 2001 20:44:47 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:12304 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277228AbRKFBog>;
	Mon, 5 Nov 2001 20:44:36 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mike Maravillo <mike.maravillo@q-linux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-ac6: videodev/__release_region oops! 
In-Reply-To: Your message of "Tue, 06 Nov 2001 04:50:14 +0800."
             <20011106045014.A1361@maravillo.q-linux.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Nov 2001 12:44:23 +1100
Message-ID: <13664.1005011063@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001 04:50:14 +0800, 
Mike Maravillo <mike.maravillo@q-linux.com> wrote:
># lsmod
>Module                  Size  Used by
>tuner                   8368   1  (autoclean)
>bttv                   58864   0  (autoclean)
>videodev                4672   3  (autoclean) [bttv]
>
># lsmod | xargs rmmod
>rmmod: module Module is not loaded
>rmmod: module Size is not loaded
>rmmod: module Used is not loaded
>rmmod: module by is not loaded
>tuner: Device or resource busy
>rmmod: module 8368 is not loaded
>rmmod: module 1 is not loaded
>rmmod: module (autoclean) is not loaded
>xargs: rmmod: terminated by signal 11
>
>Unable to handle kernel paging request at virtual address 80008004
>c0118012
>*pde = 00000000
>Oops: 0000
>CPU:    0
>EIP:    0010:[<c0118012>]    Not tainted
>Using defaults from ksymoops -t elf32-i386 -a i386
>EFLAGS: 00010286
>eax: 80008000   ebx: c0002014   ecx: 80008000   edx: 80008000
>esi: ec000fff   edi: ec000000   ebp: c5c6d000   esp: c4d3ff50
>ds: 0018   es: 0018   ss: 0018
>Process rmmod (pid: 1289, stackpage=c4d3f000)
>Stack: d0130000 00001000 c1430800 d0129062 c0239ff8 ec000000 00001000 02430800 
>       c1430800 d012dae0 00000000 c01b663e c1430800 d0123000 c5c6d000 d012949a 
>       d012dae0 c011589e d0123000 c5c6d000 00000000 c0114cfc d0123000 00000000 
>Call Trace: [<d0130000>] [<d0129062>] [<d012dae0>] [<c01b663e>] [<d012949a>] 
>   [<d012dae0>] [<c011589e>] [<c0114cfc>] [<c0106dd3>] 
>Code: 8b 42 04 39 f8 77 f0 8b 4a 08 39 f1 72 e9 83 7a 0c 00 78 05 
>
>>>EIP; c0118012 <__release_region+22/70>   <=====
>Trace; d0130000 <[videodev].bss.end+edc1/24e21>
>Trace; d0129062 <[videodev].bss.end+7e23/24e21>
>Trace; d012dae0 <[videodev].bss.end+c8a1/24e21>

It is actually failing in rmmod bttv, not rmmod videodev.  videodev
shows up in the ksymoops decode because the bttv symbols have been
removed by the time the oops occurred.  You need the values of
/proc/ksyms and /proc/modules from _before_ rmmod bttv was issued.  man
insmod and read the section "KSYMOOPS ASSISTANCE", in particular
/var/log/ksymoops.  Once you have /var/log/ksymoops setup, reproduce
the bug using

 lsmod | awk '{print $1}' | xargs -l1 -t rmmod

When it fails, tell ksymoops to use the saved ksyms and modules in
/var/log/ksymoops from just before rmmod bttv.  modules.xxx should
contain bttv and videodev but not tuner.

Send the clean decode to l-k, not to me.

