Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUI0OTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUI0OTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 10:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUI0OTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 10:19:46 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:60610 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S266128AbUI0OTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 10:19:43 -0400
Date: Mon, 27 Sep 2004 16:16:52 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Stefan Seyfried <seife@suse.de>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: mlock(1)
Message-ID: <20040927141652.GF28865@dualathlon.random>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net> <1096071873.3591.54.camel@desktop.cunninghams> <20040925011800.GB3309@dualathlon.random> <4157B04B.2000306@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4157B04B.2000306@suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 08:16:43AM +0200, Stefan Seyfried wrote:
> Andrea Arcangeli wrote:
> 
> > random keys are exactly fine, but only for the swap usage on a desktop
> > machine (the one I mentioned above, where the user will not be asked for
> > a password), but it's not ok for suspend/resume, suspend/resume needs
> > a regular password asked to the user both at suspend time and at resume
> > time.
> 
> Why not ask on every boot? (and yes, the passphrase could be stored on a
> fixed disk location - hashed with a function of sufficient complexity
> and number of bits, just to warn the user if he does a typo, couldn't
> it?). If suspend is working, you basically never reboot. So why ask on
> suspend _and_ resume? This also solves the "suspend on lid close" issue.

because I never use suspend/resume on my desktop, I never shutdown my
desktop. I don't see why should I spend time typing a password when
there's no need to. Every single guy out there will complain at linux
hanging during boot asking for password before reaching kdm.

I figured out how to make the swap encryption completely transparent to
userspace, and even to swap suspend, so I think it's much better than
having userspace asking the user for a password, or userspace choosing a
random password.

> And a resume is - in the beginning - a boot, so just ask early enough
> (maybe the bootloader could do this?)

yes, but the bootloader passes the paramters via /proc/cmdline, and it's
not nice to show the password in cleartext there.

So I think it'd generally safer to have the kernel asking for a password
during resume.

You're right that if we'd be asking users for a password at every
swapon, we wouldn't need to ask the password during suspend, but then
every single machine would hang during boot asking for a password, I
much prefer the machine to hang in suspend and resume only and it looks
much nicer to do all swap encryption completely transparent to userspace.

Userspace/yast will only know how to turn it on/off via a sysctl.

userspace may also want to learn about suspend/resume encryption.

Keep in mind the password cannot be stored on the harddisk, or it would
be trivial to find it for an attacker stoling the laptop.

suspend/resume is just unusable for me on the laptop until we fix the
crypto issues.
