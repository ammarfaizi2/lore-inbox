Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284108AbRLAOAe>; Sat, 1 Dec 2001 09:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284109AbRLAOAO>; Sat, 1 Dec 2001 09:00:14 -0500
Received: from femail6.sdc1.sfba.home.com ([24.0.95.86]:30942 "EHLO
	femail6.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S284108AbRLAOAD>; Sat, 1 Dec 2001 09:00:03 -0500
Message-ID: <3C08E196.51F22885@didntduck.org>
Date: Sat, 01 Dec 2001 08:56:38 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Cornelis <Frank.Cornelis@rug.ac.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: ptrace on i386
In-Reply-To: <Pine.GSO.4.31.0112011106410.4313-100000@eduserv.rug.ac.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Cornelis wrote:
> 
> Hi,
> 
> In linux/arch/i386/kernel/ptrace.c next code is being used in the xxxreg
> functions:
>         if (regno > GS*4)
>                 regno -= 2*4;
> Why this discontinuity? It doesn't prevent ORIG_EAX and EIP from being
> written and makes the defines CS, EIF, ... from linux/include/asm/ptrace.h
> useless. BTW: regno should really call reg_offset since it's no register
> number but an offset.

It's because the %fs and %gs segment registers are not saved on the
stack upon kernel entry anymore.  Thus, the following values have to be
shifted by 2 positions to maintain compatability with the ptrace
register structure.

-- 

						Brian Gerst
