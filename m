Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVCAGcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVCAGcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 01:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVCAGcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 01:32:14 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:53274 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261249AbVCAGcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 01:32:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=kVN4kvClZvBnuOjBwYFPmUlIrEohSLxlkZnBTBGjHklti44/JnDJj/wVQOdJgXjGyMRzjh26iobgBOpLa3yt/LV6SBSpK2eOEDmN1LcomuQG6YYxMAhiRiN6p7DIdAGc1YHAhzYG0CyxbPHMS2NtbB7s15hGrdpxGx2tPjoLEZw=
Message-ID: <8b46b8f1050228223140de6ef0@mail.gmail.com>
Date: Tue, 1 Mar 2005 14:31:23 +0800
From: MingJie Chang <mingjie.tw@gmail.com>
Reply-To: MingJie Chang <mingjie.tw@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: question about sockfd_lookup( ) -- sorry I forget to say the kernel version
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I want to get socket information by the sockfd while accetping,

so I write a module to test sockfd_lookup(),

but I got some problems when I test it.


kernel version: 2.4.20-8smp(RedHat9) and   2.4.26  are tried
ftp server: vsftp 1.1.3-8 and wuftp 2.6.1-20 are tried 


I hope someone can help me...

Thank you

following text is my code and error message
===========================================
=== code ===

int my_socketcall(int call,unsigned long *args)
{
  int ret,err;
  struct socket * sock;

  ret = run_org_socket_call(call,args);   //orignal sys_sockcall()
 
  if(call==SYS_ACCEPT&&ret>=0)
  {
         sock=sockfd_lookup(ret,&err);
         printk("lookup done\n");
  }
  return ret;
}

======================================
=== test and state ===

after inserting module, I use "ftp localhost" to test it.

And it has some error when I use "ls" or "mget"(I just try the 2 commands)

EX1: ls  :file list is printed, but it will block until ctrl + c

ftp> ls
227 Entering Passive Mode (127,0,0,1,68,186)
150 Here comes the directory listing.
-rwxr-xr-x    1 0        0           13744 Feb 28 05:22 socktest
-rw-r--r--    1 501      0           76288 Feb 27 19:05 vsftpd-1.1.0-1.i386.rpm
-rw-------    1 501      0            3778 Feb 27 19:29 vsftpd.conf
(blocking until ctrl+c)

after ctrl+c
receive aborted
waiting for remote to finish abort
226 Directory send OK.
500 Unknown command.
663 bytes received in 51 secs (0.013 Kbytes/sec)

ftp>
------------------------------------------------------------
EX2:mget: block until ctrl + c ,and file is not got

ftp> mget *
(blocking until ctrl+c)
receive aborted
waiting for remote to finish abort
Unknown command.

ftp>
(file is not got)

==================================================
== kernel message ==
and than I remove the module, try to ftp localhost again,
and kernel will print some messages

Unable to handle kernel paging request at virtual address c845a089
printing eip:
c845a089
*pde=02ab4067(01194067)
*pte=00000000(00000000)
Oops: 0000
CPU:    0
EIP:    0819:[<c845a089>]    Not tainted
EFLAGS: 00213296
eax: 00000004   ebx: c6f18000   ecx: 00000004   edx: 00000004
esi: 00000005   edi: ffffffff   ebp: c6f19fbc   esp: c6f19f94
ds: 0821   es: 0821   ss: 0821
Process vsftpd (pid: 606, stackpage=c6f19000)<1>
Stack: 00000005 bffffb80 00000000 00000000 c6f18000 00000000 00000000 c6f18000
      c6f18000 00000004 bffffc58 c00ae4eb 00000005 bffffb80 bffffc30 00000004
      ffffffff bffffc58 00000066 00000833 00000833 00000066 420daa02 0000082b
Call Trace: [<c00ae4eb>]

==================
End of mail
