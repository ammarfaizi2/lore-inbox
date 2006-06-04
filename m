Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932214AbWFDJGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWFDJGM (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWFDJGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:06:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54711 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932214AbWFDJGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:06:11 -0400
Subject: Re: [RFC] Per-architecture randomization
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44825E42.5090902@comcast.net>
References: <44825E42.5090902@comcast.net>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 11:06:08 +0200
Message-Id: <1149411968.3109.79.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 00:14 -0400, John Richard Moser wrote:
> Pavel Machek recommended per-architecture randomization defaults when I
> poked a (very hackish) patch up here.  As follow-up, I have taken out
> the command line parameter code and used the infrastructure I wrote to
> implement per-architecture randomization settings.
> 
> Three #defines are needed per architecture, preferably in
> include/asm-ARCH/processor.h or equivalent.  These defines are as follows:
> 
>  STACK_ALIGN -- Alignment of the stack, typically 16 (bytes).
>     If not defined, stack randomization is carried out to page
>     granularity
>  ARCH_RANDOM_STACK_BITS -- Bits of entropy to apply to the stack.
>     If not defined, stack randomization is disabled by defining this
>     as 0.
>  ARCH_RANDOM_MMAP_BITS -- Bits of entropy to apply to the mmap() base.
>     If not defined, mmap() randomization is disabled by defining this
>     as 0.


eh....

I think you missed a few things..
like
1) This is per architecture already for the most part!
   arch_align_stack() is obvious per architecture already
   the mmap randomisation also happens in arch/<foo>/mm
   and this is per arch by definition as well
2) you missed that the mmap randomization is *ON TOP OF*
   the stack randomization. So while you say "1Mb" in your
   doc in practice it is 8Mb

Also your patch is still full of XXX's and "other noise"... 
Also you probably should explain what the advantage is over the existing
per architecture approach. Just stating "it's per architecture" (as you
suggest) doesn't cut it since it is per architecture already for the
most part.

If all you want to do is turn 
-       if (current->flags & PF_RANDOMIZE)
-               random_variable = get_random_int() % (8*1024*1024);

that 8 into a per architecture thing.. then your patch is awefully big
and complex to just achieve that.

