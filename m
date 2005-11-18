Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVKRGcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVKRGcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 01:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVKRGcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 01:32:48 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:13197 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932419AbVKRGcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 01:32:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=cRIfSY9x+nhaZZkY1Lf2qFcinHF6sXaop6d5dYZQ7YzJ35efEjFY2iiTR1hk2KpkrFJEIZ4wl4E4FgsfN3pbosfIvZPPiPlr5skwgKx+rzKA18gEsCFtEYbrabdxZIXgCPrpupx/f/AlLgh0JjiLTGXFp22We2t/ahCKpoNAwDg=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: [uml-devel] Re: [PATCH 3/4] UML - Properly invoke x86_64 system calls
Date: Fri, 18 Nov 2005 07:41:37 +0100
User-Agent: KMail/1.8.3
Cc: "Jeff Dike" <jdike@addtoit.com>, akpm@osdl.org,
       "Linux kernel" <linux-kernel@vger.kernel.org>
References: <200511172110.jAHLASIB010204@ccure.user-mode-linux.org> <Pine.LNX.4.61.0511171528570.10664@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511171528570.10664@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180741.37478.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 November 2005 21:37, linux-os (Dick Johnson) wrote:
> On Thu, 17 Nov 2005, Jeff Dike wrote:
> > This patch makes stub_segv use the stub_syscall macros.  This was
> > needed anyway, but the bug that prompted this was the discovery that
> > gcc was storing stuff in RCX, which is trashed across a system
> > call.

> But the C-calling convention used by gcc for 32-bit systems
> is supposed to allow the called-function to destroy general-
> purpose registers but not index registers. In other words,
> ECX, EDX are supposed to be available and EAX is used for
> return-values. The register size isn't supposed to have
> anything to do with it (longword/quadword)!

> In 64-bit world, the same is supposed to apply as well.
> If RCX is now precious, it's a GCC bug that should be fixed.

It's not _normally_ precious, for function calling conventions, but syscalls 
are different.

Read include/asm-x86_64/unistd.h and see that the _syscallX macros contain 
various register clobber. I.e. they explicitly tell GCC "don't use that". We 
(UML code) were missing that. Simple.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com
