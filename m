Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbUKGRsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbUKGRsX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 12:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUKGRsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 12:48:22 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:24989 "EHLO midnight.suse.cz")
	by vger.kernel.org with ESMTP id S261662AbUKGRrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 12:47:53 -0500
Date: Sun, 7 Nov 2004 18:47:57 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-input@atrey.karlin.mff.cuni.cz,
       linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] small input cleanup
Message-ID: <20041107174757.GA10086@ucw.cz>
References: <20041107031256.GD14308@stusta.de> <200411062249.54887.dtor_core@ameritech.net> <20041107172929.GM14308@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041107172929.GM14308@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 06:29:29PM +0100, Adrian Bunk wrote:
> On Sat, Nov 06, 2004 at 10:49:54PM -0500, Dmitry Torokhov wrote:
> 
> > Hi,
> 
> Hi Dmitry,
> 
> > On Saturday 06 November 2004 10:12 pm, Adrian Bunk wrote:
> > > The patch below does the following cleanups under drivers/input/ :
> > > - make some needlessly global code static
> > > - remove the completely unused EXPORT_SYMBOL'ed function gameport_rescan
> > 
> > It will be used (but in some transformed) once I finish gameport sysfs
> > support, but it probably need not be exported.
> >  
> > > - make the EXPORT_SYMBOL'ed function ps2_sendbyte static since it isn't
> > >   used outside the file where it's defined
> > 
> > libps2 is a library for communicating with standard PS/2 device and while
> > the function is not currently used it is part of the interface. I would
> > like to leave the function as is.
> 
> my personal opinions:
> - if gameport_rescan will not be needed in it's current form, there's
>   no need for it (you can always add the "real" function when it's 
>   required

Well, it works in its current form, and drivers should call it when
their reinit logic fails to reinitialize the device. They don't, which
is a bug, and should be fixed. I don't think removing gameport_rescan()
will help fixing them.

> - could ps2_sendbyte be #ifdef 0'ed until it's required?
>   this way, it wouldn't make the kernel bigger today
 
It is used, just not outside libps2. Does the EXPORT_SYMBOL() make the
kernel so much bigger?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
