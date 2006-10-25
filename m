Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWJYPMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWJYPMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 11:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWJYPMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 11:12:24 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:15257 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932460AbWJYPMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 11:12:23 -0400
Date: Wed, 25 Oct 2006 11:10:24 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 04/10] uml: make execvp safe for our usage
Message-ID: <20061025151024.GA4323@ccure.user-mode-linux.org>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan> <20061017212711.26445.79770.stgit@americanbeauty.home.lan> <20061018183707.GB6566@ccure.user-mode-linux.org> <200610210211.28502.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610210211.28502.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 02:11:28AM +0200, Blaisorblade wrote:
> > This is horriby ugly.
> 
> Detail why. The code of execvp()? Passing in the buffer?
> I'm not saying it's the brightest code around here, but it's ok for me.

My initial reaction was mostly due to the look of the code, which is
fixable.  I also don't like carrying around bits of libc (although we
do have setjmp/longjmp, but that's a special case).  However, it's
unlikely that it will need much maintenance, so this is more a taste
thing as well.

> I initially thought to design a two-steps API with a "which" operation (where
> memory allocation was used) to call later execvp(); when I saw the glibc 
> implementation (it allocates one single fixed-size buffer) I saw it was 
> simpler this way.

I think I still like the two-stage thing better.  If the 'which' part
finds something that doesn't exec, then we can just spit out a nice error.

> I'd not do that at boot, but just before the fork()+execve() - it is 
> conceivable that a given user will install a support binary after booting 
> UML.

I was envisioning it being part of bootup, but doing it just before
the exec would be OK, too.

				Jeff
