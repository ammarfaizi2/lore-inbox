Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129306AbRA2XUE>; Mon, 29 Jan 2001 18:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbRA2XTy>; Mon, 29 Jan 2001 18:19:54 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:13537 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S129306AbRA2XTq>; Mon, 29 Jan 2001 18:19:46 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Strange oops with 2.4.1-pre12  (RTL & DRM)
Message-ID: <3A75FA8B.AA345254@fi.muni.cz>
Date: Mon, 29 Jan 2001 23:19:39 GMT
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: Czech, en
Content-Type: text/plain; charset=iso-8859-2
Mime-Version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre12-RTL3.11b i686)
Organization: unknown
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello


I've got this strange oops with this very latest kernel.
I also have to mention that this happens when I run RTLinux application
(so this kernel contains RTL patch) and DRI is activated.

I'm not necessarily saing this is linux kernel bug as it could
be the problem of RTL patch or some DRM issue - however as I've no
idea what is the reason for this NMI lockup on one of my CPU
I'm posting it here. 
System is BP6 2x480MHz Celereon.

Also this is probably the first time I've seen that the system went
smoothly to the console mode and displayed this oops message.
(I've rewritten important parts on paper by hand soI hope there are
no mistakes)
With previous kernel the typical scenario is that machine is frozen
and in the mouse position there is white box probably with this size
64x64 pixels.

If anyone wants to know more details feel free to ask.


$ /var/tmp/ksymoops-2.3.4/ksymoops oops 
ksymoops 2.3.4 on i686 2.4.1-pre12-RTL3.11b.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-pre12-RTL3.11b/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

EIP: 0010:[<c01f1ab7>]
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: [<c01079f9>] [<c0107c0c>] [<c01f1905>] [<c01137f8>]
[<c010925b>] 
        [<c011579d>] [<c01079f9>] [<c0107c07>] [<c01f1905>] [<c01137f8>]
Code: 7e f9 e9 be 3c f2 ff 80 3b 00

>>EIP; c01f1ab7 <stext_lock+637/59c6>   <=====
Trace; c01079f9 <__down+41/dc>
Trace; c0107c0c <__down_failed+8/c>
Trace; c01f1905 <stext_lock+485/59c6>
Trace; c01137f8 <do_page_fault+0/408>
Trace; c010925b <error_code+12b/138>
Trace; c011579d <add_wait_queue_exclusive+39/54>
Trace; c01079f9 <__down+41/dc>
Trace; c0107c07 <__down_failed+3/c>
Trace; c01f1905 <stext_lock+485/59c6>
Trace; c01137f8 <do_page_fault+0/408>
Code;  c01f1ab7 <stext_lock+637/59c6>
00000000 <_EIP>:
Code;  c01f1ab7 <stext_lock+637/59c6>   <=====
   0:   7e f9                     jle    fffffffb <_EIP+0xfffffffb>
c01f1ab2 <stext_lock+632/59c6>   <=====
Code;  c01f1ab9 <stext_lock+639/59c6>
   2:   e9 be 3c f2 ff            jmp    fff23cc5 <_EIP+0xfff23cc5>
c011577c <add_wait_queue_exclusive+18/54>
Code;  c01f1abe <stext_lock+63e/59c6>
   7:   80 3b 00                  cmpb   $0x0,(%ebx)


-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
