Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbTCMIjF>; Thu, 13 Mar 2003 03:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262198AbTCMIjE>; Thu, 13 Mar 2003 03:39:04 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:3014 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S262197AbTCMIiJ>;
	Thu, 13 Mar 2003 03:38:09 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Onur Yalazi <onuryalazi@mersin.edu.tr>
Date: Thu, 13 Mar 2003 09:48:41 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: matroxfb blank screen
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <12A0B77A5B06@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Mar 03 at 23:54, Onur Yalazi wrote:
> 
> I'm trying 2.4.19 gentoo 1.4 rc2 kernel on a p3 450 512mb ram HP vectra 
> using a mga200 on board. When the system boots i get normal  video. 
> After the screen fulls and tries to switch fb mod to  put the shiny logo 
> ( :) ) the video signal goes (I see yellow no signal led lit on the 
> monitor). I've tried many of video=matrox:vesa:... kernel parameters. 
> Sometimes i get "refresh rate out of range" and sometimes "no signal".

Try 2.4.21-preHighest-acGreatest (or 2.4.21-preHighest and enable all
matroxfb related options as last time I checked drivers/video/Config.in
was still wrong in Marcelo's tree). 

Problem is that your onboard G200 uses 14.318MHz XTAL, while all other 
G200's use 27.000MHz, so you are getting 32Hz vertical refresh instead 
of 60Hz... As a temporary solution booting with 
'video=matrox:vesa:....,fv:113' could give you picture, but accelerator 
will run at 53% of its nominal speed and so on.

Or you can replace 27000 with 14318 in drivers/video/matrox/matroxfb_DAC1064.c
and rebuild your kernel. But upgrading to latest Alan's 2.4.x is preferred
solution.
                                                        Petr Vandrovec

P.S.: Of course this assumes that your G200 has connected BIOS to it.
If you'll get "matroxfb: Your Matrox device does not have BIOS" or
"matroxfb: BIOS on your Matrox device does not contain powerup info",
you are lost and I'll have to find another solution for Vectra owners.
                                                        

