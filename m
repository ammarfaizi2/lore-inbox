Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWEHXFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWEHXFE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 19:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWEHXFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 19:05:04 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:8637 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750832AbWEHXFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 19:05:02 -0400
In-Reply-To: <1147118619.8664.44.camel@localhost.localdomain>
References: <17498.60066.92373.6527@cargo.ozlabs.ibm.com> <445BE729.80903@am.sony.com> <C26C730943E01145B4F89E37FE0A022002BBC74B@itdsrvmail02.utep.edu> <1147118619.8664.44.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <18583972-9E29-4B52-BF2E-53102F1794EB@kernel.crashing.org>
Cc: "Meswani, Mitesh" <mmeswani@utep.edu>, linuxppc-dev@ozlabs.org,
       Arnd Bergmann <arnd.bergmann%ibmde.RSCS@BLDVMB.POK.IBM.COM>,
       linux-kernel@vger.kernel.org, cbe-oss-dev@ozlabs.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Information for setting up SMT related parameters on linux 2.6.16 on POWER5
Date: Tue, 9 May 2006 01:04:51 +0200
To: will_schmidt@vnet.ibm.com
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the HMT_* macros are telling firmware that "this processor thread  
> should
> run at this priority".  Typically used when we're waiting on a  
> spinlock.
> I.e. When we are waiting on a spinlock, we hit the HMT_low macro to  
> drop
> our threads priority, allowing the other thread to use those extra
> cycles finish it's stuff quicker, and maybe even release the lock  
> we're
> waiting for.          HMT_* is all within the kernel though, no  
> exposure
> to userspace apps.

Actually, those macros translate straight into a single machine insn.
No firmware is involved.  See include/asm-powerpc/processor.h.  For
example:

#define HMT_very_low()   asm volatile("or 31,31,31   # very low  
priority")

You can use those same macros from user space, although it is CPU
implementation dependent which priorities you can actually set (you
probably can do low and medium priority).


Segher

