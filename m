Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290249AbSAOSuh>; Tue, 15 Jan 2002 13:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290243AbSAOSuS>; Tue, 15 Jan 2002 13:50:18 -0500
Received: from chello212186127068.14.vie.surfer.at ([212.186.127.68]:30371
	"EHLO server.home.at") by vger.kernel.org with ESMTP
	id <S290248AbSAOSuI>; Tue, 15 Jan 2002 13:50:08 -0500
Subject: Re: floating point exception
From: Christian Thalinger <e9625286@student.tuwien.ac.at>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020115132921.818A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020115132921.818A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 15 Jan 2002 19:49:11 +0100
Message-Id: <1011120551.13266.2.camel@sector17.home.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-15 at 19:31, Richard B. Johnson wrote:
> On 15 Jan 2002, Christian Thalinger wrote:
> 
> > On Tue, 2002-01-15 at 15:34, Zwane Mwaikambo wrote:
> > > On 14 Jan 2002, Christian Thalinger wrote:
> [SNIPPED...]
> 
> > 
> > Tried this:
> > 
> > #define _GNU_SOURCE 1
> > #include <fenv.h>
> > 
> > main() {
> >     double zero=0.0;
> >     double one=1.0;
> >     
> >     feenableexcept(FE_ALL_EXCEPT);
> >     
> >     one /=zero;
> > }
> > 
> Well, that won't even link. The source I showed previously
> compiles and link fine. It also shows a FPU exception when
> one divides by zero:
> 
> Script started on Tue Jan 15 13:27:05 2002
> # gcc -o zzz zzz.c -lm
> /tmp/ccjhyGHj.o: In function `main':
> /tmp/ccjhyGHj.o(.text+0x25): undefined reference to `feenableexcept'
> collect2: ld returned 1 exit status

This depends on the libc version. Seems you have 2.1. For me it's 2.2.

[root@sector17:/root/src]# cat fpu-exception.c
#define _GNU_SOURCE 1
#include <fenv.h>

main() {
    double zero=0.0;
    double one=1.0;
    
    feenableexcept(FE_ALL_EXCEPT);
    
    one /=zero;
}
[root@sector17:/root/src]# gcc -Wall -lm -o fpu-exception
fpu-exception.c
fpu-exception.c:4: warning: return type defaults to `int'
fpu-exception.c: In function `main':
fpu-exception.c:11: warning: control reaches end of non-void function
[root@sector17:/root/src]# ./fpu-exception  
Floating point exception
[root@sector17:/root/src]# 


