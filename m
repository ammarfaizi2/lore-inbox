Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUAYW6M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265309AbUAYW6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:58:12 -0500
Received: from smtp08.auna.com ([62.81.186.18]:63883 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S265288AbUAYW6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:58:08 -0500
Date: Sun, 25 Jan 2004 23:58:06 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, jamagallon@able.es,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: mpspec.h, mach_mpspec.h
Message-ID: <20040125225806.GC5409@werewolf.able.es>
References: <20040125172904.GA3195@werewolf.able.es> <20040125191106.GA3203@mars.ravnborg.org> <20040125111959.431dff9d.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040125111959.431dff9d.rddunlap@osdl.org> (from rddunlap@osdl.org on Sun, Jan 25, 2004 at 20:19:59 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.25, Randy.Dunlap wrote:
> On Sun, 25 Jan 2004 20:11:06 +0100 Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> | > 
> | > Workaround is to add -I/usr/src/linux/include/asm/mach-default.
> | 
> | i386 at least always include:
> | -Iinclude/asm-i386/mach-default
> | Which should let gcc include the file in question.
> | 
> | Try to compile with V=1 and post the full command line to gcc.
> 
> JAM, how are you building the sensors modules?
> I.e., is this just a "make modules" or are you building
> modules that are outside of the kernel tree?
> 

Oops, my fault. I was trying to build userspace part from the lm_sensors
tarball, and I did not remember that kernel modules will not build.
Anyways, docs say that you can set COMPILE_KERNEL:=0 in Makefile to build
just userspace, but I think it is outdated. You have to 'make user user_install'.
Variable COMPILE_KERNEL is not used anywhere.

And, after building userspace libsensors, my temperatures still read at 400 C:

werewolf:~# sensors -v
sensors version 2.8.3
werewolf:~# sensors -s
werewolf:~# sensors
w83781d-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +2.02 V  (min =  +1.90 V, max =  +2.10 V)              
VCore 2:   +1.98 V  (min =  +1.90 V, max =  +2.10 V)              
+3.3V:     +3.22 V  (min =  +3.14 V, max =  +3.46 V)              
+5V:       +5.00 V  (min =  +4.73 V, max =  +5.24 V)              
+12V:     +12.04 V  (min = +11.37 V, max = +12.59 V)              
-12V:     -12.29 V  (min = -12.57 V, max = -11.35 V)       ALARM  
-5V:       -4.98 V  (min =  -5.25 V, max =  -4.74 V)       ALARM  
CPU0 Fan: 4500 RPM  (min = 84375 RPM, div = 2)              ALARM  
CPU1 Fan: 4383 RPM  (min =   -1 RPM, div = 2)              ALARM  
CPU0 Tmp:   +380°C  (high =    +0°C, hyst =  +640°C)   ALARM  
CPU1 Tmp: +390.0°C  (high =  +800°C, hyst =  +750°C)          
vid:      +2.000 V

???

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc1-jam3 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
