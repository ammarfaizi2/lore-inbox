Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVDLFrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVDLFrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVDLFrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:47:09 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:9864 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261976AbVDLFm4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:42:56 -0400
In-Reply-To: <1113272915.5388.37.camel@gaston>
References: <1113272915.5388.37.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <f54dd3f8af3f508dc7774fb841a8877a@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: "Kumar Gala" <galak@freescale.com>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "linuxppc-dev list" <linuxppc-dev@ozlabs.org>,
       "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>,
       "Jason McMullan" <jason.mcmullan@timesys.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] ppc32: refactor FPU exception handling
Date: Tue, 12 Apr 2005 00:42:36 -0500
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

Sorry about that, we have had some back and forth on this on the ppc 
embedded list.

Not sure I understand your concern about the duplication of the fast 
exception return path?  Jason's patch pretty much just moved code out 
of head.S into fpu.S so we dont duplicate it between head.S and 
head_44x.S & head_fsl_booke.S

- kumar

On Apr 11, 2005, at 9:28 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2005-04-11 at 17:02 -0500, Kumar Gala wrote:
>  > Andrew,
>  >
> > Moved common FPU exception handling code out of head.S so it can be 
> used
> > by several of the sub-architectures that might of a full PowerPC 
> FPU. 
> >
> > Also, uses new CONFIG_PPC_FPU define to fix alignment exception
> > handling for floating point load/store instructions to only occur if 
> we
> > have a hardware FPU.
> >
> > Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
> > Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
>
>
>
> Andrew, please hold on this patch, it hasn't been properly discussed
>  with the relevant maintainer, that is Paul Mackerras.
>
> I can see matter for debate in there, like the whole duplication of the
>  fast exception return path...
>
> It's also touching quite sensitive bits of kernel code (head.S) that
>  needs careful auditing and testing before beeing pushed upstream.
>
> Ben.

