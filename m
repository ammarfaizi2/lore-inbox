Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUHKB0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUHKB0G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 21:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267865AbUHKB0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 21:26:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9185 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264857AbUHKB0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 21:26:02 -0400
Date: Tue, 10 Aug 2004 18:25:43 -0700
From: "David S. Miller" <davem@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: AES assembler optimizations
Message-Id: <20040810182543.064c4bc5.davem@redhat.com>
In-Reply-To: <16665.28728.720742.251546@cargo.ozlabs.ibm.com>
References: <2riR3-7U5-3@gated-at.bofh.it>
	<m3d620v11e.fsf@averell.firstfloor.org>
	<1092067328.4332.40.camel@orion>
	<20040809171231.GG2716@mea-ext.zmailer.org>
	<cfb901$ctg$1@terminus.zytor.com>
	<20040810133609.4f1ca352.davem@redhat.com>
	<16665.28728.720742.251546@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004 11:02:48 +1000
Paul Mackerras <paulus@samba.org> wrote:

> David S. Miller writes:
> 
> > On sparc64, we:
> > 
> > 1) Always save the full FPU state at context switch time if it
> >    is active.
> > 
> > 2) On entry to a FPU-using kernel routine, we save the FPU if
> >    it is active.
> 
> How is that implemented?  Do you have some magic to make gcc emit a
> call to an fpu-save routine in the prolog if the function uses the
> FPU?  Or are you only talking about functions written in assembler?

All FPU usage is explicit, and VISEntry (if using the full FPU register
set) or VISEntryHalf (if using only the lower 32 registers) calls
are made to enter an FPU usage area, and VISExit/VISExitHalf is invoked
afterwards.

We could do it with traps, but there is no reason when we know
exactly where these places are and the save code is only a
handful of instructions.

