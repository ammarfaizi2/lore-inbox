Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161250AbVKRVz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161250AbVKRVz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161251AbVKRVz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:55:57 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:1703 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1161250AbVKRVz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:55:56 -0500
Message-ID: <437E4DEA.9070502@vc.cvut.cz>
Date: Fri, 18 Nov 2005 22:55:54 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Giuliano Pochini <pochini@shiny.it>, alex@alexfisher.me.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jeff V. Merkey" <jmerkey@utah-nac.org>,
       Michael Buesch <mbuesch@freenet.de>
Subject: Re: Would I be violating the GPL?
References: <XFMail.20051102104916.pochini@shiny.it> <Pine.LNX.4.61.0511102002160.17092@yvahk01.tjqt.qr> <20051110191244.GG9488@csclub.uwaterloo.ca> <Pine.LNX.4.61.0511172221580.4792@yvahk01.tjqt.qr> <20051118151932.GH9488@csclub.uwaterloo.ca>
In-Reply-To: <20051118151932.GH9488@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Thu, Nov 17, 2005 at 10:23:21PM +0100, Jan Engelhardt wrote:
> 
>>Building for VMware Workstation 5.0.0.
> 
> 
> Well I only looked at 4.5.2
> 
> 
>>Using 2.6.x kernel build system.
>>make -C /lib/modules/2.6.13-AS20/build/include/.. SUBDIRS=$PWD 
>>SRCROOT=$PWD/. modules
...
>>  CC [M]  /usr/lib/vmware/modules/source/vmmon-only/common/task.o
>>cc1plus: warning: command line option "-Wstrict-prototypes" is valid for 
>>Ada/C/ObjC but not for C++
>>cc1plus: warning: command line option 
>>"-Werror-implicit-function-declaration" is valid for C/ObjC but not for C++
>>cc1plus: warning: command line option "-Wdeclaration-after-statement" is 
>>valid for C/ObjC but not for C++
>>cc1plus: warning: command line option "-Wno-pointer-sign" is valid for 
>>C/ObjC but not for C++
>>cc1plus: warning: command line option "-Wstrict-prototypes" is valid for 
>>Ada/C/ObjC but not for C++
>>cc1plus: warning: command line option "-ffreestanding" is valid for C/ObjC 
>>but not for C++
>>include/asm/bitops.h: In function ???int find_first_bit(const long unsigned 
>>int*,
>>unsigned int)???:
>>include/asm/bitops.h:334: warning: comparison between signed and unsigned 
>>integer expressions
>>[...]
> 
> 
> Whyever is anything calling cc1plus when the file appear to all be .c?

It is vmmon from my vmware-any-any-updates, not from VMware itself.  I use 
templates from C++ to compile same C code against different structures 
(different ABI), so you can use same vmmon module for all VMware's products.

Using templates instead of including same sources with random #define before 
looked fine at that time when kernel did not use these additional options and/or 
c++ did not complain about them.

Now it seems that I should return back to compiling same sources with different 
#defines as it seems impossible to get rid of these warnings without declaring 
own rules... (and with g++ 4.0 it now even emits incorrect warnings about using 
uninitialized struct members, which is another reason to get rid of c++ compiler 
for me).

So if I would be making decision now and not five years ago, I would not pick 
c++ templates to do the job.
							Petr Vandrovec

