Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135655AbRAHRiX>; Mon, 8 Jan 2001 12:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135669AbRAHRiP>; Mon, 8 Jan 2001 12:38:15 -0500
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:26263 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S135655AbRAHRiG>; Mon, 8 Jan 2001 12:38:06 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101081733.f08HXoe02651@wittsend.ukgateway.net>
Subject: Re: PATCH for 2.4.0: assign ad1848 mixer operations to correct module
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 8 Jan 2001 17:33:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Reply-To: rankinc@zip.com.au
In-Reply-To: <E14FdQR-0004fZ-00@the-village.bc.nu> from "Alan Cox" at Jan 08, 2001 02:37:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > + if (owner)
> > +   ad1848_mixer_operations.owner = owner;
> > +
> >   if ((e = sound_install_mixer(MIXER_DRIVER_VERSION,
> >              dev_name,
> >              &ad1848_mixer_operations,
> > 
> > BTW Isn't it ever-so-slightly dodgy modifying the static
> 
> Very.
> 
> > operations in exactly the same way as the ad1848_audio_driver
> > structure, but doesn't this mean that the ad1848_init() function now
> > "remembers" the owner from the previous call?
> 
> Yeah
> 
> > Or maybe the sound_install_XXXX() functions should accept "owner"
> > parameters, so that the static structs could become "const"?
> 
> I think you either need owner as a parameter or to make a copy of the
> ad1848_mixer_operations in your sscape driver and pass that ?

I thought about both of these, but the impact of adding an owner
parameter to sound_install_mixer() was too great, and the
ad1848_mixer_operations structure was declared static rather than
extern in ad1848.c. (Probably rightly so, too). Fortunately, I found
alternative inspiration in mpu401.c.

It might be "interesting" to redeclare all the static struct
mixer_operations as "const", along with the argument in
sound_install_mixer(), and see exactly how many sound modules scream
in pain. Maybe too interesting for 2.4.1... :-) ?

Chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
