Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWEXDlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWEXDlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 23:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWEXDlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 23:41:52 -0400
Received: from smtp.enter.net ([216.193.128.24]:63493 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932547AbWEXDlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 23:41:51 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: OpenGL-based framebuffer concepts
Date: Tue, 23 May 2006 23:41:41 +0000
User-Agent: KMail/1.8.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <1148379089.25255.9.camel@localhost.localdomain> <4472E3D8.9030403@garzik.org>
In-Reply-To: <4472E3D8.9030403@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605232341.42722.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 May 2006 10:28, Jeff Garzik wrote:
> Alan Cox wrote:
> > On Maw, 2006-05-23 at 01:08 -0400, Kyle Moffett wrote:
> >> generation graphics system, I'd be interested in ideas on a new or
> >> modified /dev/fbX device that offers native OpenGL rendering
> >> support.  Someone once mentioned OpenGL ES as a possibility as it
> >
> > So for a low end video card you want to put a full software opengl es
> > stack into the kernel including the rendering loops which tend to be
> > large and slow, or dynamically generated code ?
>
> Indeed, consider the extent of that phrase "dynamically generated code."
>
> To do modern OpenGL (mostly fragment and vertex shaders), you basically
> must have a compiler front-end (C-like language), a code generator (JIT)
> backend for your architecture (x86, x86-64, ...), and a code generator
> backend for your GPU.
>
> Further, as Keith Whitwell and others have rightly pointed out, a modern
> GPU needs such advanced resource management that the X server (or
> whatever driver) essentially becomes a _multi-tasking scheduler_.
> Consider the case of two resource-hungry 3D processes rendering to the
> same X11 screen, and you'll see why a GPU scheduler is needed.
>
> Modern graphics is highly aligned with the Cell processor programming
> model:  shipping specialized binary code elsewhere, to be remotely
> executed.
>
> OTOH, I think a perfect video driver would be in kernel space, and do
>
> * delivery of GPU commands from userspace to hardware, hopefully via
> zero-copy DMA.  For older cards without a true instruction set, "GPU
> commands" simply means userspace prepares hardware register
> read/write/test commands, and blasts the sequence to hardware at the
> appropriate moment (a la S3 Savage's BCI).
> * delivery of bytecode commands (faux GPU commands) from userspace to
> kernel to hardware.  Much like today's ioctls, but much more efficient
> delivery.  Used for mode switching commands, basic monitor management
> commands, and other not-vendor-specific operations that belong in the
> kernel.
> * interrupt and DMA handling
> * multi-context, multi-thread GPU resource scheduler (2D/3D context
> switching is lumped in here too)
> * suspend and resume
>
> and nothing else.

Thanks for this list. Looks like if I'm going to do any code writing it won't 
be solo, because a lot of this stuff  - mostly the scheduler and interrupt 
handling - is way over my head. (However, I will try to learn and will be 
doing even more research when I get to the point where this is needed to be 
done)

DRH
