Return-Path: <linux-kernel-owner+w=401wt.eu-S1751953AbXAQAPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbXAQAPx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 19:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbXAQAPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 19:15:53 -0500
Received: from bill.weihenstephan.org ([82.135.35.21]:58615 "EHLO
	bill.weihenstephan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbXAQAPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 19:15:52 -0500
From: Juergen Beisert <juergen127@kreuzholzen.de>
Organization: Privat
To: linux-kernel@vger.kernel.org
Subject: Re: fix typo in geode_configre()@cyrix.c
Date: Wed, 17 Jan 2007 01:15:48 +0100
User-Agent: KMail/1.9.4
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       takada <takada@mbf.nifty.com>
References: <20070109.184156.260789378.takada@mbf.nifty.com> <20070109154342.GB17269@csclub.uwaterloo.ca>
In-Reply-To: <20070109154342.GB17269@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701170115.49168.juergen127@kreuzholzen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 January 2007 16:43, Lennart Sorensen wrote:
> On Tue, Jan 09, 2007 at 06:41:56PM +0900, takada wrote:
> > In kernel 2.6, write back wrong register when configure Geode processor.
> > Instead of storing to CCR4, it stores to CCR3.
> >
> > --- linux-2.6.19/arch/i386/kernel/cpu/cyrix.c.orig	2007-01-09
> > 16:45:21.000000000 +0900 +++
> > linux-2.6.19/arch/i386/kernel/cpu/cyrix.c	2007-01-09 17:10:13.000000000
> > +0900 @@ -173,7 +173,7 @@ static void __cpuinit geode_configure(vo
> >  	ccr4 = getCx86(CX86_CCR4);
> >  	ccr4 |= 0x38;		/* FPU fast, DTE cache, Mem bypass */
> >
> > -	setCx86(CX86_CCR3, ccr3);
> > +	setCx86(CX86_CCR4, ccr4);
> >
> >  	set_cx86_memwb();
> >  	set_cx86_reorder();
>
> Any idea what the consequence of this would be?  Any chance that while
> fixing this file anyhow, adding a missing variant could be done?

Writing back of ccr4 should be intented here, but also writing back the ccr3 
to disable the MAPEN again. So both are required. But the ccr4 first:

   setCx86(CX86_CCR4, ccr4);
   setCx86(CX86_CCR3, ccr3);

Juergen
