Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVCVHl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVCVHl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVCVHl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:41:26 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:26802 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262263AbVCVHk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:40:57 -0500
Date: Tue, 22 Mar 2005 08:41:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: 2.6.11-rc4: Alps touchpad too slow
Message-ID: <20050322074146.GA3360@ucw.cz>
References: <20050304221523.GA32685@hexapodia.org> <20050321144412.5e6d9398.akpm@osdl.org> <20050322061336.GA2809@hexapodia.org> <20050321222514.7f98e255.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321222514.7f98e255.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 10:25:14PM -0800, Andrew Morton wrote:

> > With cvsbk rev 423b66b6oJOGN68OhmSrBFxxLOtIEA (rsynced Monday, it claims
> > to be "2.6.12-rc1"), the situation is much improved.  The AlpsPS/2
> > driver recognizes the trackpad, tracking speed is back to normal, and
> > tapping is turned on by default.  (Drat, now I need to figure out how to
> > turn that off again.)

Setting "MaxTapTime" in XF86Config if you're using the Synaptics X
driver, or mousedev.maxtaptime=0 if you are using /dev/input.mice, to 0
should work.

> Wonderful, thanks.
> 
> > The kernel output is a bit odd, though:
> > 
> > [ 1200.254707] Adding 987988k swap on /dev/hda3.  Priority:-1 extents:1
> > [ 1200.330453] EXT3 FS on hda2, internal journal
> > [ 1203.504154] SCSI subsystem initialized
> > [ 1204.039053]   Enabling hardware tapping
> > [ 1204.099034] ieee1394: Initialized config rom entry `ip1394'
> > [ 1204.266077] input: PS/2 Mouse on isa0060/serio1
> > [ 1204.400583] input: AlpsPS/2 ALPS GlidePoint on isa0060/serio1
> > [ 1204.779799] sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
> > [ 1206.183165] kjournald starting.  Commit interval 5 seconds
> > 
> > Note how the "Enabling hardware tapping" message is several lines
> > earlier than it seems it should be... I don't think I'm supposed to be
> > tapping on my SCSI hardware.
> > 
> > ... ah, I think I'm missing the "ALPS GlidePoint detected" message which
> > I used to get.  Without it, the "Enabling hardware tapping" message is a
> > bit opaque.
> 
> Yes, alps_init() had a printk removed and now the output looks funny.

I think just removing the message is better.

> diff -puN drivers/input/mouse/alps.c~alps-printk-tidy drivers/input/mouse/alps.c
> --- 25/drivers/input/mouse/alps.c~alps-printk-tidy	2005-03-21 22:23:46.000000000 -0800
> +++ 25-akpm/drivers/input/mouse/alps.c	2005-03-21 22:23:53.000000000 -0800
> @@ -395,7 +395,7 @@ int alps_init(struct psmouse *psmouse)
>  	}
>  
>  	if (param[0] & 0x04) {
> -		printk(KERN_INFO "  Enabling hardware tapping\n");
> +		printk(KERN_INFO "alps.c: Enabling hardware tapping\n");
>  		if (alps_tap_mode(psmouse, 1))
>  			printk(KERN_WARNING "alps.c: Failed to enable hardware tapping\n");
>  	}
> _

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
