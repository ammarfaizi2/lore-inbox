Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWFZIai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWFZIai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 04:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWFZIai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 04:30:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52872 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964932AbWFZIag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 04:30:36 -0400
Subject: Re: ia32 binfmt problem with x86-64
From: Arjan van de Ven <arjan@infradead.org>
To: Markus Schoder <lists@gammarayburst.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606260143.16362.lists@gammarayburst.de>
References: <200606260143.16362.lists@gammarayburst.de>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 10:30:34 +0200
Message-Id: <1151310634.3185.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 01:43 +0200, Markus Schoder wrote:
> The 32 bit emulation for x86-64 has the following in 
> arch/x86_64/ia32/ia32_binfmt.c:
> 
> #define elf_read_implies_exec(ex, have_pt_gnu_stack)	  \
>   (!(have_pt_gnu_stack))
> 
> I guess it should be same definition as in include/asm-i386/elf.h and 
> include/asm-x86_64/elf.h instead:
> 
> #define elf_read_implies_exec(ex, executable_stack) \
>   (executable_stack != EXSTACK_DISABLE_X)
> 
> >From the usage in fs/binfmt_elf.c it looks like the semantics of that 
> macro changed slightly but was not fixed in all places (ia64 seems to 
> have a similar problem from the looks of it).
> 
> The current behavior leads to 32 bit executables not setting the 
> READ_IMPLIES_EXEC personality when they are marked as requiring an 
> executable stack (64 bit executables do however).

Hi,

regardless of the inconsistency you found; I think the behavior is
correct. "Legacy" binaries get read-implies-exec (since that is the old
behavior), "new" binaries get "we honor the stack you set". Why should
read-implies-exec be set when an application asks for an executable
stack? I disagree that it should be set; the application should just use
the proper PROT_EXEC flags for its allocations; now it's not an option
to fix legacy apps (the ones without the pt_gnu_stack marker), but for
new things for sure is/was; this has been the case for the last... 3+
years already.

So... fix the app ! (and.. which app is this ?)

Greetings,
    Arjan van de Ven

