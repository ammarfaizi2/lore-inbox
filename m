Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312813AbSDBH7Z>; Tue, 2 Apr 2002 02:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312814AbSDBH7Q>; Tue, 2 Apr 2002 02:59:16 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:59911
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S312813AbSDBH66>; Tue, 2 Apr 2002 02:58:58 -0500
Message-Id: <5.1.0.14.2.20020402022939.02296c68@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 02 Apr 2002 02:53:14 -0500
To: Keith Owens <kaos@ocs.com.au>
From: Stevie O <stevie@qrpff.net>
Subject: Re: 2.5.7 oops & ksymoops 2.4.5 & libbfd.a 
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <26460.1017728260@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:17 PM 4/2/2002 +1000, Keith Owens wrote:
>On Tue, 02 Apr 2002 00:47:41 -0500, 
>I <stevie@qrpff.net> wrote:
>>So I downloaded it, tried to compile, and got a bunch of 'undefined reference's from merge.o in libbfd.a.
>
>ksymoops works for me using binutils version 2.10.91 (with BFD
>2.10.91.0.2).  I have no idea why ksymoops fails with other versions of
>libbfd, especially with unresolved references.  AFAICT this is a bfd
>problem.  Ask the binutils people and, if you get an answer, let us
>know what it was.

Aha!

Some more extensive googling turned up a clue -- it's not ksymoops-specific.

What apparently happens is, some naughty application installs either (a) a new version of libbfd.(a|so), or (b) a new version of libiberty.(a|so) , so the two don't match.

The solution is to download, compile, and re-install binutils :)

Oh, and btw: binutils by-default installs them to /usr/local/lib/; however the offending versions are typically (at least, they were in my case, and I have Slack 8) in /usr/lib. So you'll likely need to do what I did:

cd /usr/lib
mv libbfd.a libbfd_old.a
mv libiberty.a libiberty_old.a

voila! ksymoops compiled & linked & installed (& worked!) just fine.

----
pardon me while i use this as scratch space to copy the oops down
/me wouldn't mind a null-modumb cable for a serial console atm...
----

Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c01366ee
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c01366ee>] Not tainted
EFLAGS: 0010286
eax: 00001000 ebx: 0000000e ecx: 00000008 edx: 00002012
esi: 00000008 edi: 00002012 ebp: 00000000 esp: c12cfd78
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 1, threadinfo=c12ce000 task=c12cc040)
Stack: 00001000 00002012 00000000 c1376800 c1376800 c0136d98 00000000 00002012
        00001000 c1376800 d180b000 d181c3ec c0136f9f 00000000 00002012 00001000
        c1376800 c01769e6 00000000 00002012 00001000 00000302 00000000 c1376954

Call Trace: [<c0136d98>] [<c0136f9f>] [<c01769e6>] [<c0135ec0>] [<c0169068>]
        [<c016992c>] [<c018062c>] [<c013b659>] [<c013a300>] [<c0169d0f>] [<c0169808>]
        [<c013a4d0>] [<c014b0f9>] [<c014b3d0>] [<c014b214>] [<c014b7f0>] [<c010527d>]
        [<c0105073>] [<c0106fac>]

Code: 0f b7 45 10 b0 00 66 0f b6 55 10 01 d0 0f b7 c0 89 44 24 10
 <0>Kernel panic: Attempted to kill init! <- always fun


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

