Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285431AbRLNRgj>; Fri, 14 Dec 2001 12:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285432AbRLNRga>; Fri, 14 Dec 2001 12:36:30 -0500
Received: from mail.myrio.com ([63.109.146.2]:9980 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S285431AbRLNRgP>;
	Fri, 14 Dec 2001 12:36:15 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CB05@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Tommi Kyntola'" <kynde@ts.ray.fi>,
        Adam Jaskiewicz <adamjaskie@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: RE: Graphical boot ( under kernel and not lilo)
Date: Fri, 14 Dec 2001 09:35:21 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tommi Kyntola wrote:
[... earlier discussion snipped ...]
 
> I have made a patch for 2.4.X that makes three new compile options -
> custom boot logo, non blinking fbcon cursor and totally hidden fbcon 
> cursor. Custom boot logo stuff requires a picture in some well known 

I also have done patches for this stuff. Recently I've 
finished up a simple patch for 2.4.x that allows arbitrary 
sized images which can be different sizes for black&white, 16, 
and 214 colors.  We use it here for our set top boxes - I put 
console on tty2, and use the "fbv" program in userspace to 
splash other images after init starts.  

I've also updated the glogo "gimp" plugin to save images
in the 2.4.x linux_logo.h format (well, including the changes
from my patch.)  I haven't posted these patches to the list
yet because I haven't been able to test them fully... also
I've just learned of the similar work other people have done.

I would like to see something like this make it in to 2.5 at 
least, and maybe into 2.4 as well.  But I understand that the 
console layer is being extensively rewritten for 2.5, so I guess 
that logo stuff will need to wait...

At the very least, a patch that moved the definition of
LOGO_H and LOGO_W from fbcon.c over to linux_logo.h would
make it much easier to write tools that save images as
linux_logo.h without requiring kernel patches.

That cleanup at least should go into 2.4, IMHO.

For 2.5, I'd like to see options like this in the kernel
configuration under the framebuffer stuff:

- Use fancy splash image options (y/N):
	- Select 214-color splash image (/boot/logo-214.png)
	- Select 16-color splash image (/boot/logo-16.png)
	- Select b&w splash image (/boot/logo-bw.png)
	- multiple images on SMP (Y/n)
	- Center image horizontally (y/N)
	- Center image vertically (y/N)
	- Background/border color (0x000000)
	- Foreground/text color (0x777777)
	- Default console output to tty2 (y/N)

Some kernel developers might complain that things like this are
unnecessary fluff, but it's convenient for embedded developers
and it would allow distributors to put their distribution logos
in a standard place to be picked up for custom kernel compiles,
also it would make it much easier for users to customize their
linux boot.  And, it doesn't really add much bloat to the kernel.

Oddly enough, people like to customize these things.  

Torrey Hoffman
