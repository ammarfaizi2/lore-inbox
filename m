Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275195AbRIZNq3>; Wed, 26 Sep 2001 09:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275197AbRIZNqX>; Wed, 26 Sep 2001 09:46:23 -0400
Received: from relay03.cablecom.net ([62.2.33.103]:35336 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S275195AbRIZNqG>; Wed, 26 Sep 2001 09:46:06 -0400
Message-Id: <200109261346.f8QDkRg21436@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: linux-kernel@vger.kernel.org
Subject: Re: stack overflow?
Date: Wed, 26 Sep 2001 15:46:26 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200109261003.f8QA3cg22792@mail.swissonline.ch> <3BB1D836.BD0166AB@didntduck.org>
In-Reply-To: <3BB1D836.BD0166AB@didntduck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 September 2001 15:29, you wrote:
> Christian Widmer wrote:
> > hi
> >
> > i saw very strange behaviour when debuging my modules and i start to
> > think about stack overflow. i know that the kernel stack of eache process
> > is some what smaller than 8KB. but how big is the kernelstack during
> > interrupt time when executing tasklets?
>
> Depends on the architecture, but on the x86 there is no stack switch
> when you receive an interrupt in kernel mode.  Thus, if too many
> interrupts occur you could potentially overflow the stack.  If
> interrupted from user mode the stack switches to the top of the kernel
> stack.

thanks
i could verify that it was a stackoverflow. but this was due to an 
unexpected behaviour of gcc not because of too may interrupts :) 
i realiesd that when i had a look at the assemby output of my code. 
i had a macro that defined its local variables (256 byte). this macro 
was used n times and gcc allocates n * 256 bytes at the function entry 
point also it actualy only needs 256 byte. is his allocation strategy 
not silly?

chris
	
