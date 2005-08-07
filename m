Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbVHGKZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbVHGKZL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 06:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVHGKZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 06:25:11 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:43173 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751425AbVHGKZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 06:25:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=r/Cl0ty9g/FgjFh7oNT4oD79MAKxz74yIJ/u/nDo/VxY7IGZulNzhoMNvSpcQ4V4QGyy3e8gbHSoyT4ijQyhv7HcZRCrr1Nca3I1gFn6t+5x4nD4SpEzG4dVE30KEd4tYRR8d0ll2DjD84Qf4N+Skz+keEsy36HmchW9dphI/sA=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [PATCH] ARCH_HAS_IRQ_PER_CPU avoids dead code in __do_IRQ()
Date: Sun, 7 Aug 2005 12:25:21 +0200
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <200508061814.31719.annabellesgarden@yahoo.de> <200508062329.05081.ioe-lkml@rameria.de>
In-Reply-To: <200508062329.05081.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508071225.21825.annabellesgarden@yahoo.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 6. August 2005 23:28 schrieb Ingo Oeser:
> Hi Karsten,
> 
> On Saturday 06 August 2005 18:14, Karsten Wiese wrote:
> > From: Karsten Wiese <annabellesgarden@yahoo.de>
> > 
> > IRQ_PER_CPU is not used by all architectures.
> > To avoid dead code generation in __do_IRQ()
> > this patch introduces the macro ARCH_HAS_IRQ_PER_CPU.
> > 
> > ARCH_HAS_IRQ_PER_CPU is defined by architectures using
> > IRQ_PER_CPU in their
> > 	include/asm_ARCH/irq.h
> > file.
> 
> Why not the other way around?
> 
> Just define IRQ_PER_CPU to 0 on architectures not needing it and
> add a FAT comment there, that this disables it. Or make it a config option.
> 
> Then just leave the code as is and let GCC optimize the dead code
> away without any changes in the C file. It works, I just checked it ;-)
> 
With my proposal the
	#if defined(ARCH_HAS_IRQ_PER_CPU)
	....
	#endif
lets readers of __do_IRQ() immediately grasp:
 "this block might not be compiled / depends an ARCH"
And you'll get compile error's using IRQ_PER_CPU on ie i386,
letting you immediately know,
that you've got to change something to be able to use IRQ_PER_CPU.

That are advantages I think.
Otherwise your proposal is ok for me too.

   Regards,
   Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
