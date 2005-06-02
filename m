Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVFBUop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVFBUop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVFBUoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:44:11 -0400
Received: from mail.tyan.com ([66.122.195.4]:24078 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261346AbVFBUkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:40:47 -0400
Message-ID: <3174569B9743D511922F00A0C94314230A403985@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: RE: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor
	 e dual way
Date: Thu, 2 Jun 2005 13:42:00 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        cpuid(1, &eax, &ebx, &ecx, &edx);
        smp_num_siblings = (ebx & 0xff0000) >> 16;

For amd dual core, smp_num_siblings is set to 1, and it mean has two cores.

                seq_printf(m, "siblings\t: %d\n",
                                c->x86_num_cores * smp_num_siblings);

for Intel it would be 
	c->x86_num_cores  is 2 and smp_num_siblings is 2 too....
	so every core will be HT....


Function 0000_0001[EBX]
EBX[23:16] Logical Processor Count. If CPUID Fn[8000_0001, 0000_0001][EDX:
HTT, ECX:
CMPLegacy] = 11b, then this field indicates the number of CPU cores in the
processor.
Otherwise, this field is reserved.

what is intel value about cpuid(1) ebx [23:16], when the CPU is dual core,
but HT is disabled.
1?

YH

> -----Original Message-----
> From: Ashok Raj [mailto:ashok.raj@intel.com] 
> Sent: Thursday, June 02, 2005 12:07 PM
> To: YhLu
> Cc: Andi Kleen; linux-kernel@vger.kernel.org
> Subject: Re: 2.6.12-rc5 is broken in nvidia Ck804 Opteron 
> MB/with dual cor e dual way
> 
> On Thu, Jun 02, 2005 at 11:56:25AM -0700, YhLu wrote:
> > 
> >    Really?,  smp_num_siblings is global variable and 
> initially is set 1.
> > 
> >    YH
> > 
> But detect_ht() can override it.. thats just the start value.
> 
> try cscope :-)
> 
> Cheers,
> ashok
> 
