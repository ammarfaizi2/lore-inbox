Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130828AbRBWENG>; Thu, 22 Feb 2001 23:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131237AbRBWEM4>; Thu, 22 Feb 2001 23:12:56 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:20387 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130828AbRBWEMj>; Thu, 22 Feb 2001 23:12:39 -0500
Message-ID: <3A95E3B4.9F6E8022@redhat.com>
Date: Thu, 22 Feb 2001 23:14:44 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: k.hindenburg@gte.net
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: __buggy_fxsr_alignment error 2.4.1 and 2.4.2
In-Reply-To: <20010222224322.A15511@amdk7.gte.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kurt V. Hindenburg" wrote:
> 
> asm-i386:
> init/main.o(.text.init+0x63): undefined reference to `__buggy_fxsr_alignment'
> 
> I don't recall this error in 2.4.0, but it is present in 2.4.1 and was not
> fixed in 2.4.2.
> 
>  >sh scripts/ver_linux
> -- Versions installed: (if some fields are empty or look
> -- unusual then possibly you have very old versions)
> Linux amdk7 2.4.1 #3 Sat Feb 3 18:50:44 EST 2001 i686 unknown
> Kernel modules         2.4.1
> Gnu C                  pgcc-2.95.2.1
> Gnu Make               3.79.1
> Binutils               2.10.1
> Linux C Library        2.1.3
> Dynamic linker         ldd: version 1.9.9
> Procps                 2.0.7
> Mount                  2.10q
> Net-tools              1.57
> Console-tools          0.2.3
> Sh-utils               2.0
> Modules Loaded         ppp_deflate bsd_comp ppp_async
> 
> Fix: Comment out line 217 in include/asm-i386/bugs.h
> /*    __buggy_fxsr_alignment(); */
> 
> It compiles after this change.

That "bug" is there for a reason.  Get a real compiler, then it will work OK. 
Compile that kernel with your compiler, your fix in place, and then try to run
it on a PIII or later CPU and it will Oops all over the place.  Run it on any
CPU that supports FXSAVE and it will likely blow chunks (all the Intel CPUs
will, but I don't know for sure about the AMD CPUs that support FXSAVE).

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
