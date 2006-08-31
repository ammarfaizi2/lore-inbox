Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWHaS0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWHaS0Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWHaS0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:26:24 -0400
Received: from 82-69-39-138.dsl.in-addr.zen.co.uk ([82.69.39.138]:57494 "EHLO
	ty.sabi.co.UK") by vger.kernel.org with ESMTP id S932440AbWHaS0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:26:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17655.10081.79181.750626@base.ty.sabi.co.UK>
Date: Thu, 31 Aug 2006 19:16:01 +0100
X-Face: SMJE]JPYVBO-9UR%/8d'mG.F!@.,l@c[f'[%S8'BZIcbQc3/">GrXDwb#;fTRGNmHr^JFb
 SAptvwWc,0+z+~p~"Gdr4H$(|N(yF(wwCM2bW0~U?HPEE^fkPGx^u[*[yV.gyB!hDOli}EF[\cW*S
 H<GG"+i\3#fp@@EeWZWBv;]LA5n1pS2VO%Vv[yH?kY'lEWr30WfIU?%>&spRGFL}{`bj1TaD^l/"[
 msn( /TH#THs{Hpj>)]f><W}Ck9%2?H"AEM)+9<@D;3Kv=^?4$1/+#Qs:-aSsBTUS]iJ$6
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: When to use mmiowb()?
In-Reply-To: <44F699CE.8050803@drzeus.cx>
References: <44F699CE.8050803@drzeus.cx>
X-Mailer: VM 7.17 under 21.4 (patch 19) XEmacs Lucid
From: pg_lkm@lkm.for.sabi.co.UK (Peter Grandi)
X-Disclaimer: This message contains only personal opinions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On Thu, 31 Aug 2006 10:11:58 +0200, Pierre Ossman
>>> <drzeus-list@drzeus.cx> said:

drzeus-list> I'm been trying to wrap my head around all this
drzeus-list> memory barrier business, and I'm slowly grasping
drzeus-list> the inter-CPU behaviours. Barriers with regard to
drzeus-list> devices still has me a bit confused though. [ ... ] 
drzeus-list> This leads me to believe that memory-barriers.txt
drzeus-list> is closer to the truth, but then the question is
drzeus-list> what those special cirumstances that require
drzeus-list> mmiowb() are.

I have just been staring at a new driver which containts (more
or less these lines:

------------------------------------------------------------------------
#if !(defined CONFIG_ARCH_IA64_SN2 || defined CONFIG_ARCH_IA64_GENERIC)
#define mmiowb()		((void) 0)
#endif
------------------------------------------------------------------------

Very funny, isn't it? :-)

Now the story is that there is not one truth, but several. About
as many as there are platforms and configurations.

On most popular platforms and most configurations 'mmiowb' is
not necessary, so people don't bother and ''it works''. On a few
platforms and configurations it matters, so people using them do
apply it rather more extensively.

In theory it should be used everywhere there is a sequence
hazard, but that's an itch that only a minority needs to
scratch.

Free (and commercial) software is based on the ''social''
definition of ''works'', perhaps regrettably, which means that
if enough people don't see errors, the errors don't ''exist''.

Then there are forward looking people like Linus who was using
an Alpha to develop the kernel (and more recently a G5 IIRC)
precisely to create for himself itches to scratch, triggered by
configurations that the overwhelming majority of x86 users would
not see...

BTW, in a related issue Linus has said that one of the big
problems with kernel development is that a lot of people just
don't get race conditions (which are an intrinsically hard
subject anyhow), and that this has influenced his overall kernel
design.
