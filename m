Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272240AbRHWJWs>; Thu, 23 Aug 2001 05:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272241AbRHWJWi>; Thu, 23 Aug 2001 05:22:38 -0400
Received: from d06lmsgate-2.uk.ibm.com ([195.212.29.2]:41356 "EHLO
	d06lmsgate-2.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S272240AbRHWJWW>; Thu, 23 Aug 2001 05:22:22 -0400
Importance: Normal
Subject: Re: Is there any interest in Dynamic API
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFD58750A9.2C3F311E-ON80256AB1.00331AB2@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Thu, 23 Aug 2001 10:21:25 +0100
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.6 |December 14, 2000) at
 23/08/2001 10:19:40
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Kieth Owens" <kaos@ocs.com.au> wrote:
>"Richard J Moore" <richardj_moore@uk.ibm.com> wrote:
>>I was wondering whether the kernel community had any interest in seeing a
>>dynamic api capability in the kernel. What I have in mind the ability for
a
>>kernel module to request a system call entry be added by supplying a call
>>name to a create_dynamic_api service.
>
>Why does this remind me of SVCUPDTE?

Damn! I've been rumbled.

>
>You will have problems on architectures where indirect function calls
>require extra handling.  IA64 has to load a global data pointer (gp) as
>well as the function address for an indirect call.  The existing
>syscall table avoids this overhead because all system calls are in the
>kernel with a constant gp.  To allow syscalls to modules you either
>load a gp for each entry point (which slows down all syscalls) or you
>need arch specific trampoline code to enter and exit a syscall in a
>module.  PPC64 looks like it has the same problem.
>
>There is also the problem of generating syscalls in userspace pic code.
>Each arch is different, look at all the hassles glibc goes through to
>create syscall interfaces.  It is not surprising that _syscall[0-5] are
>deprecated interfaces.  It is much easier to use a device or fs interface.

Thanks, these are good areguments for not pursuing this. We'll proceed with
conversion of dprobes to a device driver rather than a kernel module.


Richard Moore -  RAS Project Lead - Linux Technology Centre (ATS-PIC).
http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


Keith Owens <kaos@ocs.com.au> on 23/08/2001 03:44:22

Please respond to Keith Owens <kaos@ocs.com.au>

To:   Richard J Moore/UK/IBM@IBMGB
cc:   linux-kernel@vger.kernel.org
Subject:  Re: Is there any interest in Dynamic API


On Wed, 22 Aug 2001 18:44:27 +0100,
"Richard J Moore" <richardj_moore@uk.ibm.com> wrote:
>I was wondering whether the kernel community had any interest in seeing a
>dynamic api capability in the kernel. What I have in mind the ability for
a
>kernel module to request a system call entry be added by supplying a call
>name to a create_dynamic_api service.

Why does this remind me of SVCUPDTE?

You will have problems on architectures where indirect function calls
require extra handling.  IA64 has to load a global data pointer (gp) as
well as the function address for an indirect call.  The existing
syscall table avoids this overhead because all system calls are in the
kernel with a constant gp.  To allow syscalls to modules you either
load a gp for each entry point (which slows down all syscalls) or you
need arch specific trampoline code to enter and exit a syscall in a
module.  PPC64 looks like it has the same problem.

There is also the problem of generating syscalls in userspace pic code.
Each arch is different, look at all the hassles glibc goes through to
create syscall interfaces.  It is not surprising that _syscall[0-5] are
deprecated interfaces.  It is much easier to use a device or fs interface.





