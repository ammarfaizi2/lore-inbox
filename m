Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289871AbSAOOro>; Tue, 15 Jan 2002 09:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289861AbSAOOrf>; Tue, 15 Jan 2002 09:47:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5761 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289840AbSAOOr0>; Tue, 15 Jan 2002 09:47:26 -0500
Date: Tue, 15 Jan 2002 09:46:54 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Christian Thalinger <e9625286@student.tuwien.ac.at>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: floating point exception
In-Reply-To: <Pine.LNX.4.33.0201151633300.2080-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.3.95.1020115094513.10786A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Zwane Mwaikambo wrote:

> On 14 Jan 2002, Christian Thalinger wrote:
> 
> > It seems the floating point exception is only raised with a new data
> > package. Is there a simple way to raise such a exception?
> 
> New data package? And does the same behaviour re-occur after the fpu
> exception? ie programs start segfaulting etc. Can you try doing a "dmesg"
> after the segfaults and fpu exception and see if there is anything in the
> kernel ring buffer too.
> 
> Regards,
> 	Zwane Mwaikambo


This will allow you to generate some math-errors and see if everything
works okay. By default, upon process creation, math errors like
/0 are masked.

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



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


