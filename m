Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285330AbRLNLhU>; Fri, 14 Dec 2001 06:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285336AbRLNLhK>; Fri, 14 Dec 2001 06:37:10 -0500
Received: from ws-002.ray.fi ([193.64.14.2]:58964 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S285330AbRLNLhA>;
	Fri, 14 Dec 2001 06:37:00 -0500
Date: Fri, 14 Dec 2001 13:33:15 +0200 (EET)
From: Tommi Kyntola <kynde@ts.ray.fi>
X-X-Sender: <lk@behemoth.ts.ray.fi>
To: Adam Jaskiewicz <adamjaskie@yahoo.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Graphical boot ( under kernel and not lilo)
In-Reply-To: <01121317093400.05946@aragorn>
Message-ID: <Pine.LNX.4.33.0112141309320.2611-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Hello hackers,
> > I think that linux has somehow grown up and I would like to suggest we (
> > mostly you as my knowledge ... ) integrate the "new version" of
> > linux_logo.h which makes fullscreen tty1 graphical(maybe as non default
> > ).
> > What do you think about that ?
> 
> IIRC, you can already do that using the framebuffer device. Please tell 
> me if I am wrong.

Yes, atleast the are various patches out there for various 2.4.X kernels,
and as the include/linux/linux_logo.h format changed some of them work and 
some require tweaking. The simplest ones allow larger pictures than 80x80 
and more complicated ones also display a progress bar (google: linux 
progress patch).

I have made a patch for 2.4.X that makes three new compile options -
custom boot logo, non blinking fbcon cursor and totally hidden fbcon 
cursor. Custom boot logo stuff requires a picture in some well known 
format and then uses convert, ppm* progs and one custom tool to
convert it to linux_logo.h alike "format". I've omitted the progress bar 
stuff because that'd require placing code snippets allover the linux init
code. I'm glad to make that available somewhere, but it's all been done 
over and over again by loads of people out there, sadly none of that code 
has ever made it to the kernel.

My guess is that the people that have needed some tweaking to the graphical
booting (companies involved in making embedded linux boxes) have tweaked the
drivers/video/fbcon.c themselves, like myself, but have thought that
linux is fine without the bloat that bootlogo ehancements requires.
Besides there's been discussion about this here in lkml before.

You see, using a larger picture as a boot logo requires that it's compiled 
into the kernel and it indeed increases it's size (some 100kb and then 
some for a fullscreen picture). But indeed for embedded boxes it's 
sometimes the only possible solution.

For the record, redirecting the kernel output to tty2 (kernel parameter
console=/dev/tty2 or perhaps even append="console/dev/tty2" for lilo),
and spalshing the picture from inittab or rc.sysinit (or similar) 
('cat /dev/fb0 > /tmp/screenshot' and 'cat /tmp/screenshot > /dev/fb0')
may be sufficient, since the kernel boots fairly swiftly and 
usually it's the userspace bootstuff that takes the time. 
Redirecting the rc.sysinit to tty2 from inittab might also come in handy.

-- 
  Tommi "Kynde" Kyntola      
     /* A man alone in the forest talking to himself and 
        no women around to hear him. Is he still wrong?  */

