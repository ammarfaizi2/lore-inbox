Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279499AbRKASeC>; Thu, 1 Nov 2001 13:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279502AbRKASdx>; Thu, 1 Nov 2001 13:33:53 -0500
Received: from www.transvirtual.com ([206.14.214.140]:23818 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S279499AbRKASdh>; Thu, 1 Nov 2001 13:33:37 -0500
Date: Thu, 1 Nov 2001 10:33:22 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Tim Waugh <twaugh@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: driver initialisation order problem
In-Reply-To: <3BE15BF0.C6FB873C@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10111011014500.2293-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > drivers/char/joystick/turbografx.c
> > drivers/char/joystick/db9.c
> > drivers/char/joystick/gamecon.c
> 
> don't have a good answer.  maybe move 'em to drivers/input :)

I suggested that before. Linus didn't like that. Actually in time you will
see all input devices moved to drivers/input. It will become more and
more a mess if we don't. I have various devices such as touchscreens,
keyboard, joysticks etc that are serial devices. It is such a nasty hack
at present to reach into char/joytsick to get something like a touchscreen
working. IMO we should have things in the following order:

/drivers/serial 	-> Yes I plan a rewrite of the serial layer.
/drivers/parport
/drivers/usb

/driver/input		
/driver/char		-> The future console system will be inptu api
			   based so input needs to be first.		


Things like hardware protocols, USB, RS232 should come first. Then char
devices like input and things in char come next.



