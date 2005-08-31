Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVHaRXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVHaRXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVHaRXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:23:04 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:48859
	"EHLO gwia-smtp.id2.novell.com") by vger.kernel.org with ESMTP
	id S964827AbVHaRXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:23:02 -0400
Subject: Re: State of Linux graphics
From: David Reveman <davidr@novell.com>
To: Allen Akin <akin@pobox.com>
Cc: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>,
       Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050831063355.GE27940@tuolumne.arden.org>
References: <9e47339105083009037c24f6de@mail.gmail.com>
	 <1125422813.20488.43.camel@localhost>
	 <20050831063355.GE27940@tuolumne.arden.org>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 13:20:09 -0400
Message-Id: <1125508809.8716.76.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-30 at 23:33 -0700, Allen Akin wrote:
> On Tue, Aug 30, 2005 at 01:26:53PM -0400, David Reveman wrote:
> | On Tue, 2005-08-30 at 12:03 -0400, Jon Smirl wrote:
> | > In general, the whole concept of programmable graphics hardware is
> | > not addressed in APIs like xlib and Cairo. This is a very important
> | > point. A major new GPU feature, programmability is simply not
> | > accessible from the current X APIs. OpenGL exposes this
> | > programmability via its shader language.
> | 
> |                                                           ... I don't
> | see why this can't be exposed through the Render extension. ...
> 
> What has always concerned me about this approach is that when you add
> enough functionality to Render or some new X extensions to fully exploit
> previous (much less current and in-development!) generations of GPUs,
> you've essentially duplicated OpenGL 2.0.  You need to identify the
> resources to be managed (framebuffer objects, vertex objects, textures,
> programs of several kinds, etc.); explain how they're specified and how
> they interact and how they're owned/shared; define a vocabulary of
> commands that operate upon them; think about how those commands are
> translated and executed on various pieces of hardware; examine the
> impact of things like graphics context switching on the system
> architecture; and deal with a dozen other matters that have already been
> addressed fully or partly in the OpenGL world.
> 
> I think it makes a lot of sense to leverage the work that's already been
> done:  Take OpenGL as a given, and add extensions for what's missing.
> Don't create a parallel API that in the long run must develop into
> something at least as rich as OpenGL was to start with.  That costs time
> and effort, and likely won't be supported by the hardware vendors to the
> same extent that OpenGL is (thanks to the commercial forces already at
> work).  Let OpenGL do 80% of the job, then work to provide the last 20%,
> rather than trying to do 100% from scratch.

Sounds sane. This is actually what I've done in Xgl to make it possible
to write some more interesting compositing managers. I implemented
GLX_MESA_render_texture so that a compositing manager can bind
redirected windows to textures and draw the screen using OpenGL.

Using OpenGL instead of X Render might very well be the way we end up
doing things. The current X Render API is sufficient for even more
complex cairo applications and that's good as they can then be
accelerated on servers without GL support. But you're probably right,
the next time we think of extending X Render we might want to reconsider
if that's such a good idea. If it's not likely that anything but a
OpenGL based server will accelerate it, then it might be a bad idea to
add it to X Render.

-David

