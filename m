Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbTAJK2y>; Fri, 10 Jan 2003 05:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTAJK2y>; Fri, 10 Jan 2003 05:28:54 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:56843 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S264842AbTAJK2w>; Fri, 10 Jan 2003 05:28:52 -0500
Subject: Re: [Linux-fbdev-devel] rotation.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.44.0301091949560.5660-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0301091949560.5660-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1042171520.933.126.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Jan 2003 18:26:51 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 03:54, James Simmons wrote:
> 
> > However, as Geert mentioned, if you want to support rotation
> > generically, then you have to do it in the fbcon level.  The driver need
> > not know if the display is rotated or not.  All it needs to do is fill a
> > region with color, color expand a bitmap and move blocks of data, and
> > optionally 'pan' the window.  Fbcon will pass the correct (ie, oriented)
> > information for the driver.
> 
> Yes. Hardware rotation shouldn't also not effect the way accel 
> operatations are done.
 
The main difference is if the hardware supports rotation, fbcon will
present it with "normal" data.  With the generic implementation, fbcon
will present the driver with rotated data.

So we need a driver capabilities field either in fb_info or
fb_fix_screeninfo.

> 
> > This will not be too processor intensive as long as some data is
> > prepared beforehand, like a rotated fontdata.
> 
> Yeap!! The only thing is we could end up with 4 times the amount of data.
>  

Not really.  We can dynamically rotate the fontdata using the default
display->fontdata into another buffer.  I believe I have functions that
do that in the patch I submitted.  (Sorry, I lost it when one of my
drives crashed :-(.

Tony

