Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUJUQEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUJUQEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270418AbUJUQDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:03:00 -0400
Received: from corpmailsmtp02.digitalnetworksna.com ([209.10.223.203]:23269
	"EHLO corpmailsmtp02.digitalnetworksna.com") by vger.kernel.org
	with ESMTP id S270759AbUJUPyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:54:50 -0400
Message-ID: <82D5E38355314D46AF3015FF55F6955802F83513@CORPMAIL3>
From: John Ripley <jripley@rioaudio.com>
To: "'Timothy Miller'" <miller@techsource.com>, Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Date: Thu, 21 Oct 2004 08:54:46 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Timothy Miller [mailto:miller@techsource.com]
> Sent: 21 October 2004 16:13
> To: Jon Smirl
> Cc: Linux Kernel Mailing List
> Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
> 
> Jon Smirl wrote:
> > I have heard a lot of complaints from embedded people about 
> having few
> > choices for graphics chips. Many of the low end chips from 
> ATI/NVidia
> > are no longer in production and you are forced into buying more chip
> > than you want. You should ask about this on embedded 
> developer lists.
> > 
> > For the new X servers you have to have hardware alpha blending.
> > Another important feature is accelerated drawing to off-screen
> > buffers. Also, DMA command queues help a lot with parallelizing
> > drawing.
> 
> DMA not only allows for more parallelism, but it's also more 
> efficient 
> to transport commands and image data using DMA than with PIO, 
> particular 
> on some platforms which do not try to optimize PIOs.
> 
> > If you implement VGA you will be able to boot and work in any x86
> > system without writing any code other than the BIOS.
> 
> I don't think we can get away without supporting some minimal VGA 
> functionality.

Actually what I'd love to see is an FPGA based graphics card which is
*extremely* minimal - essentially just a integer DSP. I'd issue coprocessor
commands to it like:

QueueSpanRender(long out_address, int pixels, Texture *source_tex, TexCoords
*coords);

And that would be about the most complicated thing it would do. All
geometry, clipping, texture coordinate calculation etc done on the CPU. Even
the coefficients for traversing the texture are done by the CPU. You then
only need to implement a very small number of primitives in FPGA. You could
probably "emulate" VGA and friends using a small microcontroller on the
board monitoring frame buffer and IO access, and a ton of waitstates :) But
hey, that's just to boot the machine.

In a purely software renderer, it's the pixel pushing which (last I checked)
takes an enormous chunk of CPU time. You latest GPUs are doing something
like 4-32 texture lookups and applications per cycle these days, which a
general purpose CPU really struggles to get anywhere near. It's something a
DSP/dedicated hardware can do far better than a general purpose CPU. It'd be
interesting to try, actually: run Doom 3 on linux under Mesa (if that's at
all possible :), turn off all pixel rendering in Mesa, and see how much
faster it runs.

This would probably also make a good trade-off on an embedded platform.

- John Ripley
