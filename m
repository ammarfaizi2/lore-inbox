Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319110AbSIDJVD>; Wed, 4 Sep 2002 05:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319112AbSIDJVD>; Wed, 4 Sep 2002 05:21:03 -0400
Received: from pop.sttl.uswest.net ([206.81.192.7]:28684 "HELO
	sttlpop6.sttl.uswest.net") by vger.kernel.org with SMTP
	id <S319110AbSIDJVC>; Wed, 4 Sep 2002 05:21:02 -0400
Date: Wed, 04 Sep 2002 02:25:24 -0700
Message-ID: <3D75D184.6020303@cs.rose-hulman.edu>
From: "Leslie Donaldson" <donaldlf@cs.rose-hulman.edu>
To: "Remco Post" <r.post@sara.nl>
Cc: "Thunder from the hill" <thunder@lightweight.ods.org>,
       "Oliver Pitzeier" <o.pitzeier@uptime.at>, linux-kernel@vger.kernel.org,
       ink@jurassic.park.msu.ru
User-Agent: Mozilla/5.0 (X11; U; Linux alpha; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: [PATCH] include/linux/ptrace.h Re: Kernel 2.5.33 compile errors
 (Re: Kernel 2.5.33 successfully compiled)
References: <9556288E-BFD8-11D6-8DD9-000393911DE2@sara.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  Here is my latest.

Steps
O) Fix sound support.
         Add the following line to 
/usr/src/linux-2.5.X/linux-2.5.33/sound/core/device.c

         #include <asm-generic/errno-base.h>

O) The following file needed to be copied (a quick hack)
      Luckly the lower end alphas have the same chipsets as pc's

        cd include/asm-alpha
        cp ../asm-i386/kmap_types.h  .

O) Argument list changed to do_fork add another zero. The uid is in
      a register someplace but I'm not sure which one....

      FILE: arch/alpha/kernel/process.c
       add a last argument of zero to the 2 calls to do_fork

O) ptrace needs to include sched.h

      FILE:  include/linux/ptrace.h  Line: 27
      add  >> #include <linux/sched.h>

O) The CIA chipset has a type in the file... sigh...

     FILE:  arch/alpha/kernel/core_cia.c
     Line:232
     Line:261

     change
        mase = 0x18;
     to
        mask = 0x18;

O) Delete the following lines from the top of :

      NOTE: This is a synthetic file so the compile must fail to fix it.

      FILE: arch/alpha/vmlinux.lds.s

# 1 "vmlinux.lds.S"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "vmlinux.lds.S"
# 1 "/usr/src/linux-2.5.X/linux-2.5.33/include/linux/config.h" 1



# 1 "/usr/src/linux-2.5.X/linux-2.5.33/include/linux/autoconf.h" 1
# 5 "/usr/src/linux-2.5.X/linux-2.5.33/include/linux/config.h" 2
# 2 "vmlinux.lds.S" 2



Okay. I will try a rebbot tomorrow. I also want to try to compile the 
modules. sigh.

just everyone know I run a pure redhat rawhide. therefore.. here are my 
packages..

gcc-3.2-4.src.rpm
glibc-2.2.90-26.src.rpm
binutils-2.13.90.0.2-2.src.rpm

If these numbers don't scare you.....

Leslie Donaldson

-- 
/----------------------------\ Current Contractor: None
|    Leslie F. Donaldson     | Current Customer  : None
|    Computer Contractor     | Skills: Unix/OS9/VMS/Linux/SUN-OS/C/C++/assembly
| Have Computer will travel. | WWW  : http://www.cs.rose-hulman.edu/~donaldlf
\----------------------------/ Email: mail://donaldlf@cs.rose-hulman.edu
Goth Code V1.1: GoCS$$ TYg(T6,T9) B11Bk!^1 C6b-- P0(1,7) M+ a24 n--- b++:+
                H6'11" g m---- w+ r+++ D--~!% h+ s10 k+++ R-- Ssw LusCA++



