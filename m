Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbTJILw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 07:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTJILw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 07:52:58 -0400
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:65154 "EHLO
	catv-50624ad9.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S261988AbTJILw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 07:52:56 -0400
Message-ID: <3F854C13.3010902@freemail.hu>
Date: Thu, 09 Oct 2003 13:52:51 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031003
X-Accept-Language: hu, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Gabor MICSKO <gmicsko@szintezis.hu>
Subject: Re: [patch] exec-shield-2.6.0-test6-G3
References: <3F77F752.7020404@externet.hu> <Pine.LNX.4.56.0309301655330.9692@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.56.0309301655330.9692@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ingo, Gabor,

I tried exec-shield-2.6.0-test6-G3 on 2.6.0-test7 patched with
http://www.kernel.org/pub/linux/kernel/v2.6/testing/cset/cset-20031009_0504.txt.gz
(up to cset-1.1320), it patched with some fuzz and offset differences.

I got the following exploit differences with libsafe and paxtest:

libsafe-2.0-16:
[zozo@catv-50624ad9 exploits]$ ./t6
This program tries to use scanf() to overflow the buffer.
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
If you see this statement, it means that the buffer
overflow never occurred.

Should I worry about it?

paxtest-0.9.1:
[zozo@catv-50624ad9 paxtest-0.9.1]$ ./paxtest
It may take a while for the tests to complete
Test results:
Executable anonymous mapping             : Killed
Executable bss                           : Killed
Executable data                          : Killed
Executable heap                          : Killed
Executable stack                         : Killed
Executable anonymous mapping (mprotect)  : Killed
Executable bss (mprotect)                : Vulnerable
Executable data (mprotect)               : Vulnerable
Executable heap (mprotect)               : Vulnerable
Executable shared library bss (mprotect) : Vulnerable
Executable shared library data (mprotect): Vulnerable
Executable stack (mprotect)              : Vulnerable
Anonymous mapping randomisation test     : 16 bits (guessed) *
Heap randomisation test (ET_EXEC)        : 13 bits (guessed) * these 3 are varying
Heap randomisation test (ET_DYN)         : 13 bits (guessed) *
Main executable randomisation (ET_EXEC)  : No randomisation
Main executable randomisation (ET_DYN)   : 12 bits (guessed)
Shared library randomisation test        : No randomisation  *** this changed ***
Stack randomisation test (SEGMEXEC)      : 17 bits (guessed)
Stack randomisation test (PAGEEXEC)      : 17 bits (guessed)
Return to function (strcpy)              : Vulnerable
Return to function (memcpy)              : Vulnerable
Executable shared library bss            : Killed
Executable shared library data           : Killed
Writable text segments                   : Vulnerable

$ uname -a
Linux catv-50624ad9.szolcatv.broadband.hu 2.6.0-test7-exec-shield-nptl #2 SMP Thu Oct 9 10:39:04 CEST 2003 i686 i686 i386 GNU/Linux
$ cat /proc/sys/kernel/exec-shield
2
$ cat /proc/sys/kernel/exec-shield-randomize
1

The system is an almost up-to-date "fedora core".
$ rpm -q glibc gcc gcc32 binutils
glibc-2.3.2-98
gcc-3.3.1-6
gcc32-3.2.3-6
binutils-2.14.90.0.6-3

Gabor MICSKO írta:

> 
> Hi!
> 
> I`ve made a port of the Ingo's last exec-shield patch. This is my second
> patch, so please test this one carefully. 
> 
> Against vanilla 2.6.0-test6:
> http://www.hup.hu/old/stuff/kernel/exec-shield/exec-shield-2.6.0-test6-G3
> 
> 
> Comments, feedbacks welcome.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

