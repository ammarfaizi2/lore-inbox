Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbTAKFO5>; Sat, 11 Jan 2003 00:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267072AbTAKFO4>; Sat, 11 Jan 2003 00:14:56 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:35591 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267052AbTAKFOz>; Sat, 11 Jan 2003 00:14:55 -0500
Subject: Re: [Linux-fbdev-devel] rotation.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.44.0301101940460.18287-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0301101940460.18287-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1042261811.932.145.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Jan 2003 13:13:20 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 03:42, James Simmons wrote:
> 
> > > Yes. Hardware rotation shouldn't also not effect the way accel 
> > > operatations are done.
> >  
> > The main difference is if the hardware supports rotation, fbcon will
> > present it with "normal" data.  With the generic implementation, fbcon
> > will present the driver with rotated data.
> > 
> > So we need a driver capabilities field either in fb_info or
> > fb_fix_screeninfo.
> 
> We can just test if the rotation hook exist for the fbdev driver. No hook 
Okay.  What will the hook do, BTW?  Just turn hardware rotation to
the appropriate orientation?  Something like...

int fb_rotate(struct fb_info *info, int rotate);

Then we can do something like:

if (info->fbops->fb_rotate) {
	info->fbops->fb_rotate(info, FB_ROTATE_CCW);
	"pass 'normally' oriented data"
else
	"pass data rotated CCW"
}

Also, you may want to place the rotate field in fb_fix_screeninfo
instead.  You mentioned that rotation is to be activated at the console
layer, so the rotate field is for informational purposes only.

> then use generic code in fbcon. Also we have a angle field in var so we 
> can see if the user wants the data rotated.
> 
> > Not really.  We can dynamically rotate the fontdata using the default
> > display->fontdata into another buffer.  I believe I have functions that
> > do that in the patch I submitted.  (Sorry, I lost it when one of my
> > drives crashed :-(.
> 
> I have that patch. It just has to be updated to the latest changes.
> 
> 
Yeap.  Geert forwarded them to me.  Thanks Geert :-)

Tony



