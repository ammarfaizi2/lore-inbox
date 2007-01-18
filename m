Return-Path: <linux-kernel-owner+w=401wt.eu-S932154AbXARKee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbXARKee (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 05:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbXARKee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 05:34:34 -0500
Received: from mail.syneticon.net ([213.239.212.131]:37268 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932154AbXARKed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 05:34:33 -0500
Message-ID: <45AF4CF9.1070801@wpkg.org>
Date: Thu, 18 Jan 2007 11:33:29 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061110 Mandriva/1.5.0.8-1mdv2007.1 (2007.1) Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
References: <45AE1D65.4010804@wpkg.org> <Pine.LNX.4.61.0701171435060.18562@yvahk01.tjqt.qr> <45AE2E25.50309@wpkg.org> <45AE8818.1050803@zytor.com>
In-Reply-To: <45AE8818.1050803@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Tomasz Chmielewski wrote:
>>
>> All right.
>> I see that initramfs is attached to the kernel itself.
>>
>> So it leaves me only a question: will I fit all tools into 300 kB 
>> (considering I'll use uClibc and busybox)?
>>
> 
> You don't need to use busybox and have a bunch of tools.
> 
> The klibc distribution comes with "kinit", which does the equivalent to 
> the kernel root-mounting code; it's in the tens of kilobytes, at least 
> on x86.  If you're using ARM, you can compile it as Thumb.

Hmm, I'm having problems compiling klibc-1.4 on ARM (using gcc-4.1.1):

# make
   GEN     klcc/klibc.config
   GEN     klcc/klcc
   HOSTCC  scripts/basic/fixdep
   GEN     usr/klibc/syscalls/SYSCALLS.i
   GEN     usr/klibc/syscalls/syscalls.nrs
   GEN     usr/klibc/syscalls/typesize.c
   KLIBCCC usr/klibc/syscalls/typesize.o
In file included from usr/klibc/../include/sys/poll.h:9,
                  from usr/klibc/../include/poll.h:1,
                  from usr/klibc/syscalls/syscommon.h:13,
                  from usr/klibc/syscalls/typesize.c:1:
usr/klibc/../include/sys/time.h:12: warning: 'struct timezone' declared 
inside parameter list
usr/klibc/../include/sys/time.h:12: warning: 'struct timeval' declared 
inside parameter list
usr/klibc/../include/sys/time.h:13: warning: 'struct timezone' declared 
inside parameter list
usr/klibc/../include/sys/time.h:13: warning: 'struct timeval' declared 
inside parameter list
usr/klibc/../include/sys/time.h:14: warning: 'struct itimerval' declared 
inside parameter list
usr/klibc/../include/sys/time.h:15: warning: 'struct itimerval' declared 
inside parameter list
usr/klibc/../include/sys/time.h:16: warning: 'struct timeval' declared 
inside parameter list
In file included from usr/klibc/../include/poll.h:1,
                  from usr/klibc/syscalls/syscommon.h:13,
                  from usr/klibc/syscalls/typesize.c:1:
usr/klibc/../include/sys/poll.h:18: warning: 'struct timespec' declared 
inside parameter list
In file included from usr/klibc/../include/sys/resource.h:10,
                  from usr/klibc/syscalls/syscommon.h:18,
                  from usr/klibc/syscalls/typesize.c:1:
/usr/include/linux/resource.h:24: error: field 'ru_utime' has incomplete 
type
/usr/include/linux/resource.h:25: error: field 'ru_stime' has incomplete 
type
In file included from usr/klibc/syscalls/syscommon.h:19,
                  from usr/klibc/syscalls/typesize.c:1:
usr/klibc/../include/sys/select.h:15: warning: 'struct timespec' 
declared inside parameter list
In file included from usr/klibc/syscalls/syscommon.h:20,
                  from usr/klibc/syscalls/typesize.c:1:
usr/klibc/../include/sys/socket.h:47: warning: 'struct msghdr' declared 
inside parameter list
usr/klibc/../include/sys/socket.h:48: warning: 'struct msghdr' declared 
inside parameter list
In file included from usr/klibc/../include/sys/stat.h:11,
                  from usr/klibc/syscalls/syscommon.h:21,
                  from usr/klibc/syscalls/typesize.c:1:
usr/include/arch/arm/klibc/archstat.h:33: error: field 'st_atim' has 
incomplete type
usr/include/arch/arm/klibc/archstat.h:34: error: field 'st_mtim' has 
incomplete type
usr/include/arch/arm/klibc/archstat.h:35: error: field 'st_ctim' has 
incomplete type
In file included from usr/klibc/syscalls/syscommon.h:21,
                  from usr/klibc/syscalls/typesize.c:1:
usr/klibc/../include/sys/stat.h: In function 'mkfifo':
usr/klibc/../include/sys/stat.h:30: error: 'S_IFMT' undeclared (first 
use in this function)
usr/klibc/../include/sys/stat.h:30: error: (Each undeclared identifier 
is reported only once
usr/klibc/../include/sys/stat.h:30: error: for each function it appears in.)
usr/klibc/../include/sys/stat.h:30: error: 'S_IFIFO' undeclared (first 
use in this function)
   LIST    usr/klibc/syscalls/syscalls.list
   GEN     usr/klibc/socketcalls/SOCKETCALLS.i
   GEN     usr/klibc/socketcalls/socketcalls.mk
   KLIBCCC usr/klibc/socketcalls/socket.o
In file included from usr/klibc/../include/sys/stat.h:10,
                  from usr/klibc/socketcalls/socketcommon.h:12,
                  from usr/klibc/socketcalls/socket.c:1:
usr/klibc/../include/sys/time.h:12: warning: 'struct timezone' declared 
inside parameter list
usr/klibc/../include/sys/time.h:12: warning: 'struct timeval' declared 
inside parameter list
usr/klibc/../include/sys/time.h:13: warning: 'struct timezone' declared 
inside parameter list
usr/klibc/../include/sys/time.h:13: warning: 'struct timeval' declared 
inside parameter list
usr/klibc/../include/sys/time.h:14: warning: 'struct itimerval' declared 
inside parameter list
usr/klibc/../include/sys/time.h:15: warning: 'struct itimerval' declared 
inside parameter list
usr/klibc/../include/sys/time.h:16: warning: 'struct timeval' declared 
inside parameter list
In file included from usr/klibc/../include/sys/stat.h:11,
                  from usr/klibc/socketcalls/socketcommon.h:12,
                  from usr/klibc/socketcalls/socket.c:1:
usr/include/arch/arm/klibc/archstat.h:33: error: field 'st_atim' has 
incomplete type
usr/include/arch/arm/klibc/archstat.h:34: error: field 'st_mtim' has 
incomplete type
usr/include/arch/arm/klibc/archstat.h:35: error: field 'st_ctim' has 
incomplete type
In file included from usr/klibc/socketcalls/socketcommon.h:12,
                  from usr/klibc/socketcalls/socket.c:1:
usr/klibc/../include/sys/stat.h: In function 'mkfifo':
usr/klibc/../include/sys/stat.h:30: error: 'S_IFMT' undeclared (first 
use in this function)
usr/klibc/../include/sys/stat.h:30: error: (Each undeclared identifier 
is reported only once
usr/klibc/../include/sys/stat.h:30: error: for each function it appears in.)
usr/klibc/../include/sys/stat.h:30: error: 'S_IFIFO' undeclared (first 
use in this function)
In file included from usr/klibc/socketcalls/socketcommon.h:14,
                  from usr/klibc/socketcalls/socket.c:1:
usr/klibc/../include/sys/socket.h: At top level:
usr/klibc/../include/sys/socket.h:47: warning: 'struct msghdr' declared 
inside parameter list
usr/klibc/../include/sys/socket.h:48: warning: 'struct msghdr' declared 
inside parameter list
make[3]: *** [usr/klibc/socketcalls/socket.o] Error 1
make[2]: *** [usr/klibc/socketcalls] Error 2
make[1]: *** [all] Error 2
make: *** [klibc] Error 2



-- 
Tomasz Chmielewski
