Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290234AbSAOSb5>; Tue, 15 Jan 2002 13:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290235AbSAOSbt>; Tue, 15 Jan 2002 13:31:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4736 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290234AbSAOSbp>; Tue, 15 Jan 2002 13:31:45 -0500
Date: Tue, 15 Jan 2002 13:31:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Christian Thalinger <e9625286@student.tuwien.ac.at>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: floating point exception
In-Reply-To: <1011118755.13266.0.camel@sector17.home.at>
Message-ID: <Pine.LNX.3.95.1020115132921.818A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan 2002, Christian Thalinger wrote:

> On Tue, 2002-01-15 at 15:34, Zwane Mwaikambo wrote:
> > On 14 Jan 2002, Christian Thalinger wrote:
[SNIPPED...]

> 
> Tried this:
> 
> #define _GNU_SOURCE 1
> #include <fenv.h>
> 
> main() {
>     double zero=0.0;
>     double one=1.0;
>     
>     feenableexcept(FE_ALL_EXCEPT);
>     
>     one /=zero;
> }
> 
Well, that won't even link. The source I showed previously
compiles and link fine. It also shows a FPU exception when
one divides by zero:

Script started on Tue Jan 15 13:27:05 2002
# gcc -o zzz zzz.c -lm
/tmp/ccjhyGHj.o: In function `main':
/tmp/ccjhyGHj.o(.text+0x25): undefined reference to `feenableexcept'
collect2: ld returned 1 exit status
# gcc -o zzz fpu.c
# zzz
Floating point exception (core dumped)
# cat fpu.c
/*
 *  Note FPU control only exists per process. Therefore, you have
 *  to set up the FPU before you use it in any program.
 */
#include <i386/fpu_control.h>

#define FPU_MASK (_FPU_MASK_IM |\
                  _FPU_MASK_DM |\
                  _FPU_MASK_ZM |\
                  _FPU_MASK_OM |\
                  _FPU_MASK_UM |\
                  _FPU_MASK_PM)

void fpu()
{
    __setfpucw(_FPU_DEFAULT & ~FPU_MASK);
}


main() {
   double zero=0.0;
   double one=1.0;
   fpu();

   one /=zero;
}

# cat zzz.c

#define _GNU_SOURCE 1
#include <fenv.h>

main() {
    double zero=0.0;
    double one=1.0;
    
    feenableexcept(FE_ALL_EXCEPT);
    
    one /=zero;
}


You have new mail in /var/spool/mail/root
# exit
exit

Script done on Tue Jan 15 13:28:32 2002



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


