Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbTI1O5n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 10:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbTI1O5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 10:57:43 -0400
Received: from fe02.axelero.hu ([195.228.240.90]:25869 "EHLO
	digpala.axelero.hu") by vger.kernel.org with ESMTP id S262583AbTI1O5e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 10:57:34 -0400
Subject: [patch] exec-shield-2.6.0-test6-G3
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 Sep 2003 16:57:33 +0200
Message-Id: <1064761054.29997.39.camel@sunshine>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I`ve made a port of the Ingo's last exec-shield patch. This is my second
patch, so please test this one carefully. 

Against vanilla 2.6.0-test6:
http://www.hup.hu/old/stuff/kernel/exec-shield/exec-shield-2.6.0-test6-G3


Comments, feedbacks welcome.



Test:

Kernel:
Linux sunshine 2.6.0-test6-exec-shield-nptl #1 SMP Sun Sep 28 14:49:15
CEST 2003 i686 GNU/Linux

Test programs:
http://www.research.avayalabs.com/project/libsafe/src/libsafe-2.0-16.tgz
http://pageexec.virtualave.net/paxtest-0.9.1.tar.gz


===========================================
sunshine:/home/trey/exec/libsafe-2.0-16/exploits# echo "2" >
/proc/sys/kernel/exec-shield
sunshine:/home/trey/exec/libsafe-2.0-16/exploits# cat
/proc/sys/kernel/exec-shield
2
===========================================


libsafe-2.0-16 (exec-shield full protection):

---------------------------------------------------------------------
sunshine:/home/trey/exec/libsafe-2.0-16/exploits# ./canary-exploit
This program tries to use printf("%n") to overwrite the
return address on the stack.
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
Segmentation fault
sunshine:/home/trey/exec/libsafe-2.0-16/exploits#
---------------------------------------------------------------------

---------------------------------------------------------------------
sunshine:/home/trey/exec/libsafe-2.0-16/exploits#
./exploit-non-exec-stack
This program demonstrates how a (stack) buffer overflow
can attack linux kernels with *non-executable* stacks.
This is variation on return-int-libc attack.
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
Segmentation fault
sunshine:/home/trey/exec/libsafe-2.0-16/exploits#
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t1
This program tries to use strcpy() to overflow the buffer.
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
Segmentation fault
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t1w
This program tries to use strcpy() to overflow the buffer.
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
Segmentation fault
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t3
This program will exec() a new program. The new program will
overflow the buffer using strcpy().
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
Segmentation fault
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t3w
This program will exec() a new program. The new program will
overflow the buffer using strcpy().
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
Segmentation fault
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t4
This program will fork() child process, and the child
will overflow the buffer using strcpy().
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
parent process terminating
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t4w
This program will fork() child process, and the child
will overflow the buffer using strcpy().
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
parent process terminating
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t5
This program tries to use strcat() to overflow the buffer.
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
Segmentation fault
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t6
This program tries to use scanf() to overflow the buffer.
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
Segmentation fault
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------


===========================================
sunshine:/home/trey/exec/libsafe-2.0-16/exploits# echo "0" >
/proc/sys/kernel/exec-shield
sunshine:/home/trey/exec/libsafe-2.0-16/exploits# cat
/proc/sys/kernel/exec-shield
0
===========================================

libsafe-2.0-16 (exec-shield off):

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./canary-exploit
This program tries to use printf("%n") to overwrite the
return address on the stack.
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
sh-2.05b$ exit
exit
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./exploit-non-exec-stack
This program demonstrates how a (stack) buffer overflow
can attack linux kernels with *non-executable* stacks.
This is variation on return-int-libc attack.
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
sh-2.05b$ exit
exit
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t1
This program tries to use strcpy() to overflow the buffer.
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
sh-2.05b$ exit
exit
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t1w
This program tries to use strcpy() to overflow the buffer.
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
sh-2.05b$ exit
exit
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t3
This program will exec() a new program. The new program will
overflow the buffer using strcpy().
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
sh-2.05b$ exit
exit
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t3w
This program will exec() a new program. The new program will
overflow the buffer using strcpy().
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
sh-2.05b$ exit
exit
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t4
This program will fork() child process, and the child
will overflow the buffer using strcpy().
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
sh-2.05b$ exit
exit
parent process terminating
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t5
This program tries to use strcat() to overflow the buffer.
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
sh-2.05b$ exit
exit
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------

---------------------------------------------------------------------
trey@sunshine:~/exec/libsafe-2.0-16/exploits$ ./t6
This program tries to use scanf() to overflow the buffer.
If you get a /bin/sh prompt, then the exploit has worked.
Press any key to continue...
sh-2.05b$ exit
exit
trey@sunshine:~/exec/libsafe-2.0-16/exploits$
---------------------------------------------------------------------


*********************************************************************


===========================================
sunshine:/home/trey/exec/paxtest-0.9.1# echo "2" >
/proc/sys/kernel/exec-shield
sunshine:/home/trey/exec/paxtest-0.9.1# cat /proc/sys/kernel/exec-shield
2
===========================================

paxtest-0.9.1 (exec-shield full protection):

sunshine:/home/trey/exec/paxtest-0.9.1# ./paxtest
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
Anonymous mapping randomisation test     : 8 bits (guessed)
Heap randomisation test (ET_EXEC)        : 13 bits (guessed)
Heap randomisation test (ET_DYN)         : 13 bits (guessed)
Main executable randomisation (ET_EXEC)  : No randomisation
Main executable randomisation (ET_DYN)   : 12 bits (guessed)
Shared library randomisation test        : 12 bits (guessed)
Stack randomisation test (SEGMEXEC)      : 17 bits (guessed)
Stack randomisation test (PAGEEXEC)      : 17 bits (guessed)
Return to function (strcpy)              : Vulnerable
Return to function (memcpy)              : Vulnerable
Executable shared library bss            : Killed
Executable shared library data           : Killed
Writable text segments                   : Vulnerable

===========================================
sunshine:/home/trey/exec/paxtest-0.9.1# echo "0" >
/proc/sys/kernel/exec-shield
sunshine:/home/trey/exec/paxtest-0.9.1# cat /proc/sys/kernel/exec-shield
0
===========================================

paxtest-0.9.1 (exec-shield off):

sunshine:/home/trey/exec/paxtest-0.9.1# ./paxtest
It may take a while for the tests to complete
Test results:
Executable anonymous mapping             : Vulnerable
Executable bss                           : Vulnerable
Executable data                          : Vulnerable
Executable heap                          : Vulnerable
Executable stack                         : Vulnerable
Executable anonymous mapping (mprotect)  : Vulnerable
Executable bss (mprotect)                : Vulnerable
Executable data (mprotect)               : Vulnerable
Executable heap (mprotect)               : Vulnerable
Executable shared library bss (mprotect) : Vulnerable
Executable shared library data (mprotect): Vulnerable
Executable stack (mprotect)              : Vulnerable
Anonymous mapping randomisation test     : No randomisation
Heap randomisation test (ET_EXEC)        : No randomisation
Heap randomisation test (ET_DYN)         : No randomisation
Main executable randomisation (ET_EXEC)  : No randomisation
Main executable randomisation (ET_DYN)   : No randomisation
Shared library randomisation test        : No randomisation
Stack randomisation test (SEGMEXEC)      : No randomisation
Stack randomisation test (PAGEEXEC)      : No randomisation
Return to function (strcpy)              : Vulnerable
Return to function (memcpy)              : Vulnerable
Executable shared library bss            : Vulnerable
Executable shared library data           : Vulnerable
Writable text segments                   : Vulnerable

-----------------------------------------
#EOF


-- 
Windows not found
(C)heers, (P)arty or (D)ance?
-----------------------------------
Micskó Gábor
Compaq Accredited Platform Specialist, System Engineer (APS, ASE)
Szintézis Computer Rendszerház Rt.      
H-9021 Gyõr, Tihanyi Árpád út 2.
Tel: +36-96-502-216
Fax: +36-96-318-658
E-mail: gmicsko@szintezis.hu
Web: http://www.hup.hu/


