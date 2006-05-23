Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWEWJ57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWEWJ57 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 05:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWEWJ57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 05:57:59 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11981 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932159AbWEWJ57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 05:57:59 -0400
Subject: Re: OpenGL-based framebuffer concepts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 23 May 2006 11:11:29 +0100
Message-Id: <1148379089.25255.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-23 at 01:08 -0400, Kyle Moffett wrote:
> generation graphics system, I'd be interested in ideas on a new or  
> modified /dev/fbX device that offers native OpenGL rendering  
> support.  Someone once mentioned OpenGL ES as a possibility as it  

So for a low end video card you want to put a full software opengl es
stack into the kernel including the rendering loops which tend to be
large and slow, or dynamically generated code ?

> framebuffer.  There would also need to be a way for userspace to trap  
> and emulate or ignore unsupported OpenGL commands.  

That would be most of them for a lot of chips because the hardware can
only do "most" of the work, eg using software fixups after a rendering
command or splitting GL commands into a chain of simpler ones as Mesa
does. All large code.

> effort.  Given that sort of support, a rootless xserver would be a  
> fairly trivial wrapper over whatever underlying implementation there  
> was.

You mean move the X server from being root (privileged) to kernel (even
more privileged) and pray there are no bugs in it ?

Bits of the model are right - look at DRI for some (perhaps not pretty)
evidence of that. Clearly the kernel needs to control the GPU, DMA and
access to buffers. It isn't clear anything higher level belongs anywhere
but user space.

Alan

