Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWEXDjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWEXDjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 23:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWEXDjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 23:39:06 -0400
Received: from smtp.enter.net ([216.193.128.24]:43525 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932205AbWEXDjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 23:39:04 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: OpenGL-based framebuffer concepts
Date: Tue, 23 May 2006 23:38:53 +0000
User-Agent: KMail/1.8.1
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Manu Abraham <abraham.manu@gmail.com>,
       linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <1148379089.25255.9.camel@localhost.localdomain>
In-Reply-To: <1148379089.25255.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605232338.54177.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 May 2006 10:11, Alan Cox wrote:
> On Maw, 2006-05-23 at 01:08 -0400, Kyle Moffett wrote:
> > generation graphics system, I'd be interested in ideas on a new or
> > modified /dev/fbX device that offers native OpenGL rendering
> > support.  Someone once mentioned OpenGL ES as a possibility as it
>
> So for a low end video card you want to put a full software opengl es
> stack into the kernel including the rendering loops which tend to be
> large and slow, or dynamically generated code ?

Agreed. Anything of the sort should be in userspace. 

> > framebuffer.  There would also need to be a way for userspace to trap
> > and emulate or ignore unsupported OpenGL commands.
>
> That would be most of them for a lot of chips because the hardware can
> only do "most" of the work, eg using software fixups after a rendering
> command or splitting GL commands into a chain of simpler ones as Mesa
> does. All large code.

Putting a full GL stack into the kernel is just plain idiotic. Among the 
suggestions I made in an initial reply to this was keeping everything 
possible in userspace adn providing only the minimum necessary stuff 
in-kernel.

Doing otherwise - providing full emulation for unsupported commands or 
features - is just copying the mistakes made by M$ with DirectX.

> > effort.  Given that sort of support, a rootless xserver would be a
> > fairly trivial wrapper over whatever underlying implementation there
> > was.
>
> You mean move the X server from being root (privileged) to kernel (even
> more privileged) and pray there are no bugs in it ?
>
> Bits of the model are right - look at DRI for some (perhaps not pretty)
> evidence of that. Clearly the kernel needs to control the GPU, DMA and
> access to buffers. It isn't clear anything higher level belongs anywhere
> but user space.

Exactly what I suggested on seeing the original post.

I am currently looking for some information or help in making the Framebuffer 
devices use DRM and setting up a userspace system that interfaces with the 
DRM backed framebuffer device to provide full 2D and 3D acceleration of all 
supported features and *userspace* emulation of the unsupported stuff.

Mesa is a good place to start for the 3D stuff, and either XAA or one of the 
numerous 2D graphics packages would be a place to start for the 2D 
acceleration.

DRH
