Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262626AbRFRT3B>; Mon, 18 Jun 2001 15:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262649AbRFRT2v>; Mon, 18 Jun 2001 15:28:51 -0400
Received: from SSH.ChaoticDreams.ORG ([64.162.95.164]:8580 "EHLO
	ssh.chaoticdreams.org") by vger.kernel.org with ESMTP
	id <S262626AbRFRT2c>; Mon, 18 Jun 2001 15:28:32 -0400
Date: Mon, 18 Jun 2001 12:28:00 -0700
From: Paul Mundt <lethal@ChaoticDreams.ORG>
To: =?iso-8859-1?Q?Ren=E9?= Rebe <rene.rebe@gmx.net>
Cc: James Simmons <jsimmons@transvirtual.com>, linux-kernel@vger.kernel.org,
        ademar@conectiva.com.br, rolf@sir-wum.de,
        linux-fbdev-devel@lists.sourceforge.net
Subject: Re: sis630 - help needed debugging in the kernel
Message-ID: <20010618122800.A10027@ChaoticDreams.ORG>
In-Reply-To: <20010616232740.092475e2.rene.rebe@gmx.net> <Pine.LNX.4.10.10106170652280.17509-100000@transvirtual.com> <20010618203203.35390ca8.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.13i
In-Reply-To: <20010618203203.35390ca8.rene.rebe@gmx.net>; from rene.rebe@gmx.net on Mon, Jun 18, 2001 at 08:32:03PM +0200
Organization: Chaotic Dreams Development Team
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2001 at 08:32:03PM +0200, René Rebe wrote:
> > Try booting at 640x480 with a color depth of 32. Then
> > try booting at a different resolution (1024x768) at the default color
> > depth. I want to see if its a error with the resolution setting or if it
> > is a error with setting up the data relating to the color depth handling. 
> > The results should give me some clue.
> 
> I can't set the videomode for the driver ...? I tried:
> 
> video=sis:vesa:0x112
> video=sis:xres:640,yres:480,depth:32
> video=sis,xres:640,yres:480,depth:32
> 
> Is there another way to tell the fb driver what mode to use??
> 
Yep, in fbmem.c the name entry is "sisfb" as opposed to just "sis". Also, the
driver requires that the mode is passed video a "mode:" argument as is
outlined in the sisfb_setup(). Take a look at drivers/video/sis/sis_main.h,
specifically sisbios_mode[] for a list of supported modes.

Something like:

video=sisfb:mode:640x480x32

should do the job.

Regards,

-- 
Paul Mundt <lethal@chaoticdreams.org>

