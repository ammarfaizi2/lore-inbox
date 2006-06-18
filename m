Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWFRTXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWFRTXG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 15:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWFRTXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 15:23:06 -0400
Received: from mx2.mail.ru ([194.67.23.122]:28937 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S932300AbWFRTXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 15:23:04 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] 2.6.17: dmesg flooded with "ohci_hcd 0000:00:02.0: wakeup"
Date: Sun, 18 Jun 2006 23:22:49 +0400
User-Agent: KMail/1.9.3
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200606181919.51126.arvidjaar@mail.ru> <200606182129.15712.arvidjaar@mail.ru> <200606181116.20815.david-b@pacbell.net>
In-Reply-To: <200606181116.20815.david-b@pacbell.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606182323.02125.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 18 June 2006 22:16, David Brownell wrote:
> On Sunday 18 June 2006 10:29 am, Andrey Borzenkov wrote:
> > On Sunday 18 June 2006 20:29, David Brownell wrote:
> > > An alternative (but post-boot) workaround _should_ be
> > >
> > >     echo disabled > /sys/bus/pci/devices/0000:00:02.0/power/wakeup
>
> Did that work?
>

No. 

{pts/1}% LC_ALL=C sudo sh -c 'echo -n disabled 
> /sys/bus/pci/devices/0000:00:02.0/power/wakeup'
sh: line 0: echo: write error: Invalid argument

because "disabled" is apparently spelled right, this means it bails out at

        if (!device_can_wakeup(dev))
                return -EINVAL;

which is also confirmed by the fact that reading it returns nothing.

> > This is Tohiba Portege 4000 notebook. So far I did not have any USB
> > related issues at least since 2.6.12. And true, I do not have any devices
> > plugged in.
>
> It's the usual case of fixing one bug triggering another, in your case
> because the fix ran into a previously unseen hardware bug.  One other
> way to work around that bug would be disabling CONFIG_PM, but I suspect
> you don't want to go that route...
>

Well, after I have it doing STR just fine, I'd rather keep it :)

> > Here you are. I am still puzzled where all these "suspends" come from - I
> > did not try any suspend in the meantime ...
>
> It's the driver putting the controller into a low power state.  Your
> hardware seems to have a bug whereby that doesn't work correctly,
> making it immediately leave that state.  (And the driver messaging is
> fine for what should be an uncommon event; plus it highlighted your
> hardware bug.) Notice the "initreset quirk" message -- another bug 
> in that hardware.  Workarounds in both cases are simple.
>
> When I get a moment, I'll have a patch for you to try.  Meanwhile,
> either workaround I showed above should prevent the attempt to enter
> that low power mode.
>

Unfortunately one of them does not work and another is not really feasible :( 
I guess I run 2.6.16 for a while :)

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFElagVR6LMutpd94wRAkKvAJ9qZcf/fmo3lKAi3l/h0HtAYdVO7wCePfeM
kzJnCu8kzX5PjHFud837ShU=
=s5Wm
-----END PGP SIGNATURE-----
