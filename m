Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264061AbUFCUJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUFCUJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 16:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUFCUJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 16:09:32 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:11500 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S264061AbUFCUJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 16:09:28 -0400
Date: Thu, 3 Jun 2004 22:09:06 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Jesse Barnes <jbarnes@engr.sgi.com>, Nathan Straz <nstraz@sgi.com>,
       Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stock IA64 kernel on SGI Altix 350
Message-ID: <20040603200905.GA27701@fi.muni.cz>
References: <20040603170147.GK10708@fi.muni.cz> <200406031030.36181.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406031030.36181.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Wow, mail to lkml is way faster than asking local SGI support :-).
Thank you all for fast reply and sorry for posting to the wrong list.

Jesse Barnes wrote:
: The 2.6 kernel, as of 2.6.0-test10 iirc, should work ok.  Recent kernels 
: contain an 'sn2_defconfig' file that you can use to build a usable kernel:
:   # tar zxf linux-2.6.6.tar.gz
:   # cd linux-2.6.6
:   # make sn2_defconfig
:   # make -j<some high number> compressed
:   # boot your kernel
: 
	Thanks, I did not know about sn2_defconfig nor compressed
(I was trying to boot gzip-9'ed vmlinux, which was probably the reason
of why I failed). Is make sn2_defconfig and make compressed documented
anywhere in the kernel sources? I think short Documentation/ia64/README.Altix
or README.sn2 would be helpful.

	However - it still does not work, altough I got at least some
console messages. I have tried both stock 2.6.6 and 2.6.7-rc2-mm2
(make sn2_defconfig, make -j compressed).

Uncompressing Linux... done
Memory: 11803200k/11929104k available (7422k code, 137904k reserved, 4016k data, 336k init)
McKinley Errata 9 workaround not needed; disabling it
Calibrating delay loop... 2077.40 BogoMIPS
Dentry cache hash table entries: 2097152 (order: 10, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 9, 8388608 bytes)
Mount-cache hash table entries: 1024 (order: 0, 16384 bytes)
Boot processor id 0x0/0x0
task migration cache decay timeout: 10 msecs.
Mount-cache hash table entries: 1024 (order: 0, 16384 bytes)
Boot processor id 0x0/0x0
task migration cache decay timeout: 10 msecs.
CPU 1: base freq=200.000MHz, ITC ratio=14/2, ITC freq=1400.000MHz+/--1ppm
Calibrating delay loop... 16.44 BogoMIPS

... both kernel versions (2.6.6 and 2.6.7-rc2-mm2) hang there. Also note
the strange bogomips value for CPU 1. The system has three bricks
(6 CPUs, 1400MHz/3MB cache). Firmware is pretty recent (the newest
we could find at www.sgi.com):

002c06#0a: SGI SAL Version 3.25 rel040225 IP41 built 12:01:43 PM Feb 25, 2004

I have the following compiler (default in SLES 8):

$ gcc -v
Reading specs from /usr/lib/gcc-lib/ia64-suse-linux/3.2.2/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr --with-local-prefix=/usr/local --infodir=/usr/share/info --mandir=/usr/share/man --libdir=/usr/lib --enable-languages=c,c++,f77,objc,java,ada --enable-libgcj --with-gxx-include-dir=/usr/include/g++ --with-slibdir=/lib --with-system-zlib --enable-shared --enable-__cxa_atexit ia64-suse-linux
Thread model: posix
gcc version 3.2.2

: But don't forget that you need to pass 'console=ttyS0' on your kernel boot 
: line (it's easiest to add this to your elilo.conf file).

	Yes, of course. I have the following in my elilo.conf:

prompt
timeout = 80
read-only
relocatable
 
image = /vmlinuz-2.6.6
    label = 2.6.6
    root = 900
    append = "console=ttyS0"
[...]

: Yep, linux-ia64@vger.kernel.org
: 
	OK.

: Stock (i.e. non-SGI or non-SuSE) 2.4 kernels won't work on Altix.  You need 
: 2.6.
: 
	OK. 2.6 was my primary target, I have tried 2.4 only because
2.6 failed to me.

: It should work fine.  And linux-ia64 is probably a better list (more chance of 
: me seeing your message).
: 
	Thanks, I will subscribe to it.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
++> I consider none of the code I contributed to glibc (which is quite a <++
++> lot) to be as part of the GNU project.             -- Ulrich Drepper <++
