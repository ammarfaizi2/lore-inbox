Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291387AbSAaXGH>; Thu, 31 Jan 2002 18:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291388AbSAaXF5>; Thu, 31 Jan 2002 18:05:57 -0500
Received: from www.transvirtual.com ([206.14.214.140]:51985 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291387AbSAaXFq>; Thu, 31 Jan 2002 18:05:46 -0500
Date: Thu, 31 Jan 2002 15:05:03 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers
In-Reply-To: <3C59BC36.14267AE7@linux-m68k.org>
Message-ID: <Pine.LNX.4.10.10201311500070.23385-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +       printk(amikbd_messages[scancode]);      /* scancodes >= 0x78 are error codes */
> 
> Damn, Geert was faster with this. :)

Fixed. 

> > +       for (i = 0; i < 0x78; i++)
> > +               if (amikbd_keycode[i])
> > +                       set_bit(amikbd_keycode[i], amikbd_dev.keybit);
> 
> Do I understand it correctly, that amikbd_keycode[i] must have non zero
> value for a valid key? If yes, something must be wrong here:

Yes. amikbd_keycode is a map from scancode values to event key values. Now

> > +static unsigned char amikbd_keycode[0x78] = {
> > +         0,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 43,  0, 82,
> 
> 0 is a valid keycode on the Amiga, it should be KEY_GRAVE.

Okay so it should be:

     static unsigned char amikbd_keycode[0x78] = {
 	       41, 2, 3, 4, 5, ...

If amikbd_keycode[0] is set 41 then 
   
set_bit(amikbd_keycode[i], amikbd_dev.keybit);

will be called in the above code. 



