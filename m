Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUHSUcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUHSUcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267376AbUHSUcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:32:04 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:53584 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267370AbUHSUb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:31:59 -0400
Date: Fri, 20 Aug 2004 00:32:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.8.1-mm2 --- UML build fixes
Message-ID: <20040819223214.GD7440@mars.ravnborg.org>
Mail-Followup-To: Jeff Dike <jdike@addtoit.com>,
	Sam Ravnborg <sam@ravnborg.org>, Chris Wedgwood <cw@f00f.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040819014204.2d412e9b.akpm@osdl.org> <20040819122915.GA2085@taniwha.stupidest.org> <20040819205506.GA7440@mars.ravnborg.org> <200408192119.i7JLJNdW004190@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408192119.i7JLJNdW004190@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 05:19:23PM -0400, Jeff Dike wrote:
> sam@ravnborg.org said:
> > What makes um so speciel that it cannot handle .lds files in arch/um/
> > kernel like all other architectures? That would allow um to utilise
> > the kbuild infrastructure, and no need for duplication. 
> 
> Beats me, as the comment says, I could not get the kbuild .lds.S : .lds rule
> to fire for uml.lds.S.  make kept sending it to the asm .S.o rule.

That's beause so little of the kbuild infrastructure is enabled
when including arch/um/Makefile

You need to move the *.lds.S files to for example arch/um/kernel then
you can use the kbuild infrastructure.

The fact that the .S.o rule is enabled is due to the kallsyms hack.

> > Code located in arch/um/ is an error. No code should stay there. 
> 
> OK, that's easily fixed.
> 
> > In general they seems too complicated for the task solved - but it may
> > be needed. 
> 
> Yeah, they are.  They desperately need a reaming.

For klibc I'm halfway with kbuild infrastructure to build user programs.
Syntax is very similar to what is know today, and I hope we can use it
for um as well.

See: linux-sam.bkbits.net select klibc
Browse source and look into usr/kinit/Makefile for an example

But to use this for um we would need to separte all user mode programs
out in separate directories . as discused before.

	Sam
