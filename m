Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268137AbUI2BQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268137AbUI2BQl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 21:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268139AbUI2BQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 21:16:41 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:29991 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268137AbUI2BQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 21:16:27 -0400
Message-ID: <35fb2e59040928181676b15c1b@mail.gmail.com>
Date: Wed, 29 Sep 2004 02:16:25 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Robert White <rwhite@casabyte.com>
Subject: Re: mlock(1)
Cc: Andrea Arcangeli <andrea@novell.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA1iD23Ya0SUu9c8LflyEkKQEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040928221520.GF4084@dualathlon.random>
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA1iD23Ya0SUu9c8LflyEkKQEAAAAA@casabyte.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004 16:26:16 -0700, Robert White <rwhite@casabyte.com> wrote:

> If you are concerned about the stolen laptop scenario you would use the (theoretical)
> boot block that required a boot/restore password

[ This is not a flame honestly. Just some points about your idea. ]

I don't see in your argument how this is meant to be cryptographically
secure. Nor do I see from any of the original mail an idea which does
anything more than offer a fake promise of security to those who are
willing to assume only dumb criminals steal their laptop. This is
worse than no security at all and renders the idea of encrypting swap
completely useless.

> or read the password out of your bios or something.

This assumes some kind of trusted BIOS running on the machine which
can obtain this password in some secure fashion - but we don't have
this on most laptops. You pointed out the idea of DRM and noted that
this is in fact quite horrible and I agree :-).

> No zero-password/pass-device restore has any right to be expected
> to be any more secure than walking away from a running console.

I fail to see anything wrong with the asking password approach - if I
use a Microsoft box of evil(TM) then it'll ask me for a password on
boot and on restore, most folks are happy to type their password in to
any box which asks for one (whether or not the actual password dialog
box) so they'll be happy to do so here. Just like having xscreensaver
or xlock come on when you resume your laptop.

> As stated, the idea is pretty basic, but if you have a computer you are worried might
> be stolen and compromised at this level, you presumably have set your bios passwords
> and such.  If the "non-time" section of the bios config ram is one of the composition
> key elements, the act of clearing the bios to clear the boot password would
> invalidate the data that the key generation block uses to recreate the key.

Yes great. But:

1). I open the laptop up (I'm allowed to do that if I've already nicked it :P).
2). I take a copy of the BIOS.
3). I replace the BIOS with a hardware configuration (however done -
perhaps hot swapping chips, perhaps some simple logic device helps me)
in which the original BIOS is available once booting begins.
4). That part of the security model was just destroyed.

You can't trust anything you read from hardware. Ever. Perhaps you
might choose to trust hardware containing burried memory under layers
of metal (thus introducing an expense element to obtaining it with a
tunneling electron microscope) which required some public key/other
mechanism for communication that didn't just allow raw access to it.

> A "normal" investigator using a normal level of attack would be thwarted.

That's not the point. Once a method exists for obtaining information
from stolen laptops, that ends up not far from a simple google search
near you.

> It's like your house keys, you house is secure unless someone steals your keys...

I think the difference here is that if your house is broken in to, you
presumably know what might have been stolen, but if your laptop is
stolen it might be harder to guess exactly what can be retreived from
it afterwards. Personally I'm not currently paranoid enough to use
encryption on the laptop but might do so when I have some free time to
get around to it.

When my laptop went back to Apple I didn't do anything more than a
simple delete on the files within it (so they could have grabbed bits
of data from it or troganed it - but I do have copies so I can create
checksums of the files which were on it), but I'm just not that
worried that they secretly have a super villan on their repair team
who'd try something on ;-).

The point is however - if I do decide to use encryption to protect
some of my personal data (and I don't care about credit cards - if my
laptop is nicked then I can cancel the card) then I want to be sure
that the mechanism is actually sound. There's no point to any system
which simply claims to be secure (like certain USB devices) but isn't.

> But for that "casually" stolen laptop or computer, if they boot from a CD (having
> this mecanisim) or use alternate boot parameters, or restore once and the hit the
> power switch because they couldn't trigger the suspend, the swap image is scrambled.
> If they use the system "vergin", without changing a thing, then they will get your
> normal boot, which is no more or less secure than you have set it up to be via the
> front door services (login. FTP, etc).

I see your point but don't think it's good to assume anything about an
attacker. While it's unlikely that someone is going to have the
technical expertise to thwart your model, I'd only want to use
something which relied on more than attacker knowledge. The reality is
however that someone stealing my laptop will see an xscreensaver,
reboot, possibly see Linux booting and then get really confused
because a). it's a Mac so it's not one of those PC things that you can
stick a bootleg Windows XP on. b). It's a Mac running something weird
so it'll need a copy of that Mac software thing to make it work. They
might be smart enough to visit a bookshop and read the page in the
Hayes Apple manual on removing the hard disk before flogging it on
ebay "for parts".

> And being extensible, you could have your very-own secret, home-made
> key-generation-block template that you wrote yourself that nobody else in the world
> knows about and makes restore (swap decryption) predicate on anything your heart can
> envision and you can provide in a timly manner during startup...  Like the
> super-secret RFID tag in your favorite pair of wall-mart sneakers.

...or my tux boxers. They'd have to be very determined to go there for
my passphrase.

> Also, the attacker gets only one chance not to screw up because the non-decrypt
> startup sequence destroys the original key generation block and reinitializes the
> swap headers.  (Yes, he could save the swap image and try again but that is a long
> brute-force cycle. 8-)

First thing I'd do when messing with a laptop would be to take a copy
of the disk.

> but I think you will find it a lot more secure than you might think after just one read.

I'll read it again and see what I missed then - you're probably right there.

Jon.
