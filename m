Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131141AbRBLTIg>; Mon, 12 Feb 2001 14:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130251AbRBLTI0>; Mon, 12 Feb 2001 14:08:26 -0500
Received: from [63.109.146.2] ([63.109.146.2]:36605 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S131141AbRBLTIV>;
	Mon, 12 Feb 2001 14:08:21 -0500
Message-ID: <4461B4112BDB2A4FB5635DE19958743202240E@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'rhairyes@lee.k12.nc.us'" <rhairyes@lee.k12.nc.us>,
        linux-kernel@vger.kernel.org
Subject: RE: linux-logo.h
Date: Mon, 12 Feb 2001 11:08:12 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Hairyes (rhairyes@lee.k12.nc.us) said:
>Could anyone tell me about linux_logo.h.  I want to put my
>own picture in there. What format is the picture written in?
>Any any idea on how I could change it?  Also, could the
>picture be any bigger than 80x80,  I would like for it to take
>up the whole screen.

Probably the best thing for you do is to check out the 
FreeLords LPP patch, at http://lpp.freelords.org.  

Some people consider that one overkill, however...

If you want to do it yourself, then the easiest way to put 
your own picture into linux_logo.h is to get the GIMP plugin 
called "glogo".  I found a copy by searching on some GIMP 
plugin index web pages.  The linux_logo.h just stores the
images (and the palettes) as big arrays of hex numbers.

In the GIMP, you create three versions of your image - one
with 214 colors, one with 16, and one in black and white.
Then you run the glogo plugin and feed it your three images.
It will output a file that you can name linux_logo.h and
copy into the include/linux directory.

However, if I recall correctly, the 80x80 restriction is 
coded into the kernel in at least two places, as well as the 
glogo plug in.  (yuck!)

So, what you really want is a patch I made for the 2.2.17 
and later series which makes it easy to put bigger logos in, 
and also center them on the screen and other little things.
My patch is not that exciting though, anyone with some C
programming skill could do the same thing in a couple of
hours, no previous kernel experience necessary.

I have a hacked up version of glogo to go along with my
kernel patch, which moves some of the LOGO_W and LOGO_H 
#defines around to tidy it up a bit.  It also makes it easy
to have completely different images for the 16 color and
B&W images - you could leave the 80x80 penguin in for those
if you want, while putting in a nice big 214 color logo.

If you want my patch and glogo hack, just email me.

There are other, similar patches out there.  I read
about one last fall that actually had the ability to convert 
a png into the linux_logo.h during a kernel build.  

Also note that putting in a huge logo will make your kernel 
bzImage or zImage noticeably larger.  This is not likely to be 
a problem if you use modules for most things.

Best wishes,

Torrey Hoffman
torrey.hoffman@myrio.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
