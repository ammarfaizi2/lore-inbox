Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129109AbQKFWtH>; Mon, 6 Nov 2000 17:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQKFWs5>; Mon, 6 Nov 2000 17:48:57 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:27403 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S129109AbQKFWsn>; Mon, 6 Nov 2000 17:48:43 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jas88@cam.ac.uk (James A. Sutherland),
        dwmw2@infradead.org (David Woodhouse),
        jgarzik@mandrakesoft.com (Jeff Garzik), goemon@anime.net (Dan Hollis),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
Message-ID: <8625698F.007D39C7.00@smtpnotes.altec.com>
Date: Mon, 6 Nov 2000 16:48:36 -0600
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This sounds to me like the most flexible way to do it.  If the module accepts
parameters then those who want the sound card initialized at every load can put
the desired settings in modules.conf.  The rest of us can just initialize it
once at boot time and the rest of the time the settings will be left untouched.





James A.Sutherland <jas88@cam.ac.uk> on 11/06/2000 11:38:44 AM

To:   Alan Cox <alan@lxorguk.ukuu.org.uk>, jas88@cam.ac.uk (James A. Sutherland)
cc:   dwmw2@infradead.org (David Woodhouse), jgarzik@mandrakesoft.com (Jeff
      Garzik), goemon@anime.net (Dan Hollis), alan@lxorguk.ukuu.org.uk (Alan
      Cox), oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
      linux-kernel@vger.kernel.org (bcc: Wayne Brown/Corporate/Altec)

Subject:  Re: Persistent module storage [was Linux 2.4 Status / TODO page]



On Mon, 06 Nov 2000, Alan Cox wrote:
> > So autoload the module with a "dont_screw_with_mixer" option. When the
kernel
> > first boots, initialise the mixer to suitable settings (load the module with
> > "do_screw_with_mixer" or whatever); thereafter, the driver shouldn't change
> > the mixer settings on load.
>
> Which is part of what persistent module data lets you do. And without having
> to mess with dont_screw_with_mixer (which if you get it wrong btw can be
> fatal and hang the hardware)

Eh? You just load the driver once, probably on boot, to configure sane values.
This time round, you use an argument (or an ioctl or whatever) to specify the
values you want. (cat /etc/sysconfig/sound/defaultvolume > /dev/sound/mixer or
whatever). After that, the module can be unloaded and loaded as needed, without
any need to touch the mixer settings except in response to *explicit* "set
volume" commands from userspace.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
