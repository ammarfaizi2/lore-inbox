Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWDSJk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWDSJk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 05:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWDSJk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 05:40:28 -0400
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63]:47955 "HELO
	smtp009.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750834AbWDSJk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 05:40:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=J3V2K9BXjRZa7aCJWhYR4ddhyiU4inRknUtGuJVe2rtDoXbMRWAX8BGPjUW7DVyS+oElPyuTgru0RH+ZWoMtGTjNblRfJXNvhV2aEJjn9tP6Jwfj+0iI7NaFTHj1Ei1Ify5VeL/pyOfPIWsjTBW+NEqmIaaiQ9vNwC+bgDXavag=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 1/3] UML - Change sigjmp_buf to jmp_buf
Date: Tue, 11 Apr 2006 20:02:59 +0200
User-Agent: KMail/1.8.3
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
References: <200604102337.k3ANb659006843@ccure.user-mode-linux.org>
In-Reply-To: <200604102337.k3ANb659006843@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604112002.59859.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 April 2006 01:37, Jeff Dike wrote:
> Clean up the jmpbuf code.  Since softints, we no longer use sig_setjmp, so
> the UML_SIGSETJMP wrapper now has a misleading name.  Also, I forgot to
> change the buffers from sigjmp_buf to jmp_buf.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>

Can I request (additionally) a look at remaining calls to {sig,}setjmp() and 
sigprocmask(), like the below one and the one in (IIRC) thread_wait()?

I think that probably some of them are valid because signal handlers modify 
the signal mask, so we may still need to play with it, but:

* I don't remember (I may be wrong) mention of this in the changelog of the 
softints patch,

* you had IIRC doubts on the current code (when I noted thread_wait())

* an analysis of what is correct should end up in a comment somewhere 
describing the results.

I won't have the time to work on this soon, at least not this week, and I 
didn't write the code.

When I'll get time, I'll work on merging RemapFilePages in -mm (I'm reasonably 
near to resend it, but I can't until I've made sure all changelogs are 
up-to-date and clear enough).

> Index: linux-2.6.16-mm/arch/um/os-Linux/util.c
> ===================================================================

>  int setjmp_wrapper(void (*proc)(void *, void *), ...)
>  {
>  	va_list args;
> -	sigjmp_buf buf;
> +	jmp_buf buf;
>  	int n;
>
>  	n = sigsetjmp(buf, 1);

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
