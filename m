Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288767AbSANFBO>; Mon, 14 Jan 2002 00:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288768AbSANFBG>; Mon, 14 Jan 2002 00:01:06 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42394 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S288767AbSANFAq>;
	Mon, 14 Jan 2002 00:00:46 -0500
Date: Sun, 13 Jan 2002 20:42:51 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Ian Morgan <imorgan@webcon.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide.2.4.16.12102001 chokes on HPT366
In-Reply-To: <Pine.LNX.4.40.0201132231560.1753-100000@light.webcon.net>
Message-ID: <Pine.LNX.4.10.10201132041350.18708-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Quantum Fireball LM30 -- stuff it in a quirk list in the top of the file
and see if that fixes it.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

On Sun, 13 Jan 2002, Ian Morgan wrote:

> Andre (and the rest of the crowd),
> 
> I really hate to be one to provide some negative news of your IDE patch,
> but here goes:
> 
> I have been hearing very good things about your patch lately, so after
> having not tried it since the 2.4.1[0-3] days, I figured it was time for
> another round of testing. Specifically, some people, including Alan,
> mentioned the stability of the Highpoint drivers. Since I've had dismal luck
> with my HPT366 in the past, I was excited at the prospect of being able to
> use it without trashing my disks (again).
> 
> No such luck, I'm afraid. While my disks have survived seemingly unharmed,
> the system [1] barfed on speed tests.
> 
> I booted into multi-user (no X), but dhcpd hadn't started properly. After
> some investigation, I found it to be core-dumping as a result of a corrupted
> binary. Re-installing the RPM got it back up in a jiffy. While this could
> have been an unrelated anomaly, my suspicions were on the Highpoint driver.
> 
> Next, I set the drive for 32-bit IO...
> 
> 	hdparm -c1 /dev/hde
> 
> ... then switched to X (exec init 5).
> 
> The first real test, now, was to speed-test the drive:
> 
> 	hdparm -tT /dev/hde
> 
> This yielded practically no improvement over the PIIX4 (both averaged
> ~25 MiB/s). Of course the usual routine is to run the test 3 or 4 times and
> take an average. Well, lo and behold, the 2nd run of the speed test went as
> follows:
> 
> 	/dev/hda:
> 	Timing buffer-cache reads:   128 MB in  ~1.4 seconds = ~90 MB/s
> 	Timing buffered disk reads:
> 
> ... and nothing! The hdparm process went into D state, and everything else
> that tried to access the drive also locked.
> 
> I rebooted, into single-user mode this time, and tried the speed test again
> (after enabling 32-bit IO). This time it locked on the first test in the
> same way as above. At this point I gave up and returned the drive to the
> PIIX4 and prayed it was not completely fubared.
> 
> So, any ideas? Is you patch really supposed to work well on the HPT366, or
> am I dreaming in Technicolour? Interestingly, most everything on the system
> seemed to work OK. File access, loading apps, etc all seemed OK, but the
> lockup during speed test really worries me.
> 
> 
> [1] Abit BP6, 2x 400MHz Celeron, 384MB RAM
>     HPT 366 w/ Quantum Fireball LM30 (PM by CS)
>     PIIX4 w/ WDC AC33100H (SM), Mitsumi FX4820T (SS)
>     Linux 2.4.17 w/ ide.2.4.16.12102001 & freeswan-1.91
>     hdparm v4.4
> 
> Regards,
> Ian Morgan
> -- 
> -------------------------------------------------------------------
>  Ian E. Morgan        Vice President & C.O.O.         Webcon, Inc.
>  imorgan@webcon.net         PGP: #2DA40D07          www.webcon.net
> -------------------------------------------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

