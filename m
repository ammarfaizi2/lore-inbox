Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131756AbRDMUqY>; Fri, 13 Apr 2001 16:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131806AbRDMUqO>; Fri, 13 Apr 2001 16:46:14 -0400
Received: from web4306.mail.yahoo.com ([216.115.104.198]:49668 "HELO
	web4306.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131756AbRDMUp6>; Fri, 13 Apr 2001 16:45:58 -0400
Message-ID: <20010413204557.21595.qmail@web4306.mail.yahoo.com>
Date: Fri, 13 Apr 2001 13:45:57 -0700 (PDT)
From: Jerry Hong <jhong001@yahoo.com>
Subject: thread problem with libc for Linux
To: gcc@gcc.gnu.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
  I am using RedHat 6.2, gcc 2.95.2(libc.so.6).
  I have a problem runing threads on Linux. I build
the application with the following line:
  g++  -D_REENTRANT -D_UNIX -DXML_LINUX -o tapp \
     testt.c unixfileio.cpp -lpthread
    
  The program is creating a certain number of threads,
then wait for all threads it creates to finish. 
  When I create less than 40 threads, everything works
fine. However when I creates more than 40 threads, I
got "Segmentation fault".  It doesn't complain any
thing in my program at all.  I am sure all the threads
the main thread created are finished and they all have
done their job,  the problem here is caused by main
thread exiting.  I really don't know what can cause
such problem.  The following is the backtrace info
when I created 41 threads.

  Jack

     
(gdb) set arg 1 41
(gdb) r
Starting program: /home/liug/aaa/tapp 1 41
rtfint.cpp: rtf_config_env =
/home/liug/aaa/RtfConfig.xml
[New Thread 1313 (manager thread)]
[New Thread 1311 (initial thread)]
....
Program received signal SIGSEGV, Segmentation fault.
0x401ca0d6 in chunk_free (ar_ptr=0x4025ed60,
p=0x80a1ba8) at malloc.c:3097
3097    malloc.c: No such file or directory.
(gdb) 
(gdb) bt
#0  0x401ca0d6 in chunk_free (ar_ptr=0x4025ed60,
p=0x80a1ba8) at malloc.c:3097
#1  0x401c9fba in __libc_free (mem=0x80a1c88) at
malloc.c:3023
#2  0x402506e1 in __deregister_frame_info
(begin=0x806f008) at ../../gcc/frame.c:581
#3  0x804c873 in __do_global_dtors_aux ()
#4  0x806c3c9 in _fini ()
#5  0x4019125a in exit (status=0) at exit.c:57
#6  0x401889d1 in __libc_start_main () at
../sysdeps/generic/libc-start.c:92



__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
