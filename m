Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130576AbQKJUf0>; Fri, 10 Nov 2000 15:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130841AbQKJUfF>; Fri, 10 Nov 2000 15:35:05 -0500
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:10900 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S130576AbQKJUfD>; Fri, 10 Nov 2000 15:35:03 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Andi Kleen <ak@suse.de>
cc: "Theodore Y. Ts'o" <tytso@MIT.EDU>, Paul Jakma <paulj@itg.ie>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Message-ID: <80256993.00710D4F.00@d06mta06.portsmouth.uk.ibm.com>
Date: Fri, 10 Nov 2000 18:42:40 +0000
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



No, misunderstood.

GKHI is not implemented using dynamic probes.  GKHI places in the kernel
calls to APIs in the DProbes code. Since we'ed rather have Dprobes out of
the kernel then essentially it acts as a loader after the fact, i.e. it
fixes up the DProbes API calls when the DProbe module loads. Compare this
with the usual loading process where the fix-ups are done in the module
being loaded. Now, you might want to ask me why I want DProbes as a module?
They again you might not. Either way is fine by me ;-)


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


Andi Kleen <ak@suse.de> on 10/11/2000 16:54:05

Please respond to Andi Kleen <ak@suse.de>

To:   "Theodore Y. Ts'o" <tytso@MIT.EDU>
cc:   Richard J Moore/UK/IBM@IBMGB, Paul Jakma <paulj@itg.ie>, Michael
      Rothwell <rothwell@holly-springs.nc.us>, Christoph Rohland
      <cr@sap.com>, linux-kernel@vger.kernel.org
Subject:  Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)




On Fri, Nov 10, 2000 at 11:24:28AM -0500, Theodore Y. Ts'o wrote:
> Right.  So what you're saying is that GKHI is adding complexity to the
> kernel to make it easier for peopel to put in non-standard patches which
> exposes non-standard interfaces which will lead to kernels not supported
> by the Linux Kernel Development Community.  Right?

My understanding is that GKHI does not change the kernel at all, except
for the three hooks needed for dprobes. All GKHI hooks are implemented
as dynamic probes, which are just like debugger breakpoints.
A dynamic probes breakpoint does not require any source
changes, but you have to check the assembly to find the right point for
them (at least in the current version, I don't know if IBM is planning
to support source level dprobes using the debugging information)

IMHO GKHI does not make mainteance of additional modules any easier,
because
you always have to recheck the assembly if the dynamic probe still fits
(which may in some cases even be more work than reporting source patches,
it is also harder when you want to cover multiple architectures)

It will just help some people who have a unrational aversion against kernel
recompiles and believe in vendor blessed binaries.


-Andi




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
