Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268064AbUI1X0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268064AbUI1X0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 19:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUI1X0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 19:26:39 -0400
Received: from mail.inter-page.com ([12.5.23.93]:43270 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S268064AbUI1X0e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 19:26:34 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Andrea Arcangeli'" <andrea@novell.com>
Cc: "'Nigel Cunningham'" <ncunningham@linuxmail.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Chris Wright'" <chrisw@osdl.org>, "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: mlock(1)
Date: Tue, 28 Sep 2004 16:26:16 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA1iD23Ya0SUu9c8LflyEkKQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20040928221520.GF4084@dualathlon.random>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
On Behalf Of Andrea Arcangeli
Sent: Tuesday, September 28, 2004 3:15 PM
To: Robert White
Cc: 'Nigel Cunningham'; 'Alan Cox'; 'Chris Wright'; 'Jeff Garzik'; 'Linux Kernel
Mailing List'; 'Andrew Morton'
Subject: Re: mlock(1)

> On Tue, Sep 28, 2004 at 03:03:44PM -0700, Robert White wrote:
> > (Stupid Idea Warning... 8-)
> > 
> > The top-n reasons (mentioned) to want to have your swap encrypted involve things
> > like
> > dealing with a stolen/sold drive or someone using a boot CD to peak into your 
> > swapped

> The stolen/sold drive is a subset of the stolen/sold laptop/desktop
> instead. In such case they would get access to all your hardware info.

If you are concerned about the stolen laptop scenario you would use the (theoretical)
boot block that required a boot/restore password, or read the password out of your
bios or something.  No zero-password/pass-device restore has any right to be expected
to be any more secure than walking away from a running console.  So if you suspend
your computer with you X sessions running and your screen unlocked, when you restore
you will be left just as exposed as if you just walked away from the running box
anyway.  If your X session (whtever) is smart enough to note the passage of time and
ask for a password then that is exactly how safe you will be, but the computer *was*
just restored.  [yes, I know I am missing part of your point in the above, hence the
below... 8-)]

As stated, the idea is pretty basic, but if you have a computer you are worried might
be stolen and compromised at this level, you presumably have set your bios passwords
and such.  If the "non-time" section of the bios config ram is one of the composition
key elements, the act of clearing the bios to clear the boot password would
invalidate the data that the key generation block uses to recreate the key.

If you use a restore-password block because you are even more paranoid, then they
would need that password.

A "normal" investigator using a normal level of attack would be thwarted.

It's like your house keys, you house is secure unless someone steals your keys...  So
sure, someone could prep a special program to compromise the default boot block by
siphoning out the meta-boot-block data, the bios config data, the CPU ID, and root
file system GUUID, the boot command line, and the clock serial number and recreate
the cryptoswap key and then rig up a special swap probe program or specialty kernel
to run the restore etc if they new to do this first-thing (e.g. if they stole the
laptop or computer with the express intent of doing this so they didn't even try to
boot it once before beginning the attempt) but if they did this, you have a bigger
problem than having your laptop stolen... 8-)

But for that "casually" stolen laptop or computer, if they boot from a CD (having
this mecanisim) or use alternate boot parameters, or restore once and the hit the
power switch because they couldn't trigger the suspend, the swap image is scrambled.
If they use the system "vergin", without changing a thing, then they will get your
normal boot, which is no more or less secure than you have set it up to be via the
front door services (login. FTP, etc).

If they steal your server computer (that never goes to suspend because it is your
server) and they can't trick it into suspending itself first (e.g. they pull the plug
and run with it) then the key generator block was never written from ram to swap, so
your swap was "completely encrypted" because, while they have all your static IDs and
configurations they *don't* have the entropy value that was used to write the swap
image because the meta-boot-block was never written to anything, and again you are
only as exposed as the rest of your security has left you.

I know it is all kinds of not-perfect, but it *is* extensible and it is pretty darn
good.

And being extensible, you could have your very-own secret, home-made
key-generation-block template that you wrote yourself that nobody else in the world
knows about and makes restore (swap decryption) predicate on anything your heart can
envision and you can provide in a timly manner during startup...  Like the
super-secret RFID tag in your favorite pair of wall-mart sneakers.

Also, the attacker gets only one chance not to screw up because the non-decrypt
startup sequence destroys the original key generation block and reinitializes the
swap headers.  (Yes, he could save the swap image and try again but that is a long
brute-force cycle. 8-)

So it is not perfect, and I suspect it could be rendered even better by the thoughts
of other/better crypto types than myself (e.g. most anybody 8-), but I think you will
find it a lot more secure than you might think after just one read.

Rob White,
Casabyte, Inc.




