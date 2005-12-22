Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVLVMEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVLVMEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 07:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVLVMEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 07:04:31 -0500
Received: from ns2.suse.de ([195.135.220.15]:6817 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964823AbVLVMEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 07:04:30 -0500
Date: Thu, 22 Dec 2005 13:04:24 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: console on POWER4 not working with 2.6.15
Message-ID: <20051222120424.GA24475@suse.de>
References: <20051220204530.GA26351@suse.de> <20051220214525.GB7428@pb15.lixom.net> <20051221175628.GA29363@suse.de> <17322.33982.22166.437385@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17322.33982.22166.437385@cargo.ozlabs.ibm.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Dec 22, Paul Mackeras wrote:

> Olaf Hering writes:
> 
> > I finally managed to find the culprit.
> > 
> > good: 25635c71e44111a6bd48f342e144e2fc02d0a314
> > bad:  f9bd170a87948a9e077149b70fb192c563770fdf
> > 
> > ...
> > powerpc: Merge i8259.c into arch/powerpc/sysdev
> > 
> > This changes the parameters for i8259_init so that it takes two
> > parameters: a physical address for generating an interrupt
> > acknowledge cycle, and an interrupt number offset.  i8259_init
> > now sets the irq_desc[] for its interrupts; all the callers
> > were doing this, and that code is gone now.  This also defines
> > a CONFIG_PPC_I8259 symbol to select i8259.o for inclusion, and
> > makes the platforms that need it select that symbol.
> 
> Try this patch... it fixes things on the p630 at work.

This fixes it also for me. Thanks.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
