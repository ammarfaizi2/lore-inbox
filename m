Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291381AbSBXV1i>; Sun, 24 Feb 2002 16:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291348AbSBXV1T>; Sun, 24 Feb 2002 16:27:19 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:44036 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291324AbSBXV1K>; Sun, 24 Feb 2002 16:27:10 -0500
Date: Sun, 24 Feb 2002 22:27:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ben Clifford <benc@hawaga.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.5-dj1 - problem with /dev/input/mice
Message-ID: <20020224222708.A1814@ucw.cz>
In-Reply-To: <20020222022329.A3533@suse.cz> <Pine.LNX.4.33.0202241249540.11220-100000@barbarella.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0202241249540.11220-100000@barbarella.hawaga.org.uk>; from benc@hawaga.org.uk on Sun, Feb 24, 2002 at 01:00:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 01:00:00PM -0800, Ben Clifford wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> > >  -dj includes a different input layer to Linus' tree, which requires
> 
> I've just moved from Linus 2.5.3 to 2.5.5-dj1.
> 
> I've tried the following both with modules and linked into bzImage.
> 
> I've tried pointing the software at /dev/input/mice and also at /dev/psaux
> which I created as a symlink to /dev/input/mice (to maintain compatibility
> with my working 2.5.3 setup)
> 
> I have a PS/2 mouse.
> 
> I've loaded mousedev.o and psmouse.o
> 
> gpm works. (**1)
> 
> cat /dev/input/mice
> gives random binary spew that looks pretty much like mouse input.
> 
> When I run my Xserver, the mouse pointer doesn't move. If I then kill off
> the Xserver, gpm doesn't work any more and cat/dev/input/mice doesn't
> generate anything any more.
> 
> If I unload psmouse.o and then load it again, I am back to (**1) until I
> load the Xserver again.

That's interesting. It almost looks like if the Xserver messed with the
mouse hardware somehow, which I hope it can't. Does 'dmesg' say anything
relevant?

I can help you find the cause - if you enable I8042_DEBUG_IO in
drivers/input/serio/i8042.h, you'll see all the data coming in and out
to the keyboard/aux controller.

-- 
Vojtech Pavlik
SuSE Labs
