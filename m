Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUI0ObW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUI0ObW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 10:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUI0ObW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 10:31:22 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:25256 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S266271AbUI0ObU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 10:31:20 -0400
Date: Mon, 27 Sep 2004 16:29:46 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Stefan Seyfried <seife@suse.de>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040927142946.GG28865@dualathlon.random>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net> <1096071873.3591.54.camel@desktop.cunninghams> <20040925011800.GB3309@dualathlon.random> <4157B04B.2000306@suse.de> <1096281162.6485.19.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096281162.6485.19.camel@laptop.cunninghams>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 08:32:43PM +1000, Nigel Cunningham wrote:
> I loved Andrea's compare-the-checksum idea, but don't see why the
> passphrase is needed both times either. Then again I have zero
> experience with encryption. In fact, I care so much about security that
> I don't have a root password and have sudo without a password :>

I also have sudo without password of course, the issue here is only
about somebody stoling your harddisk. I'm fine about having zero local
security and blocking everything with the firewall as far as it's me
owning the machine ;).

I have encrypted data in my harddisk, and I simply cannot use suspend
that would dump into the swap partition the cleartext password making my
encryption void (plus it increases the probability to dump credit card
numbers or kwallet entries into the swap, but that's a separate problem
not really related to suspend).

Basically to avoid to type the password during suspend, we'd need an
algorihtm that encrypts with a public key stored on the harddisk and
restore with the private key that sits only on a human brain.  The
public key would be stored on the harddisk and it would be used by
suspend to write to the swap partition. the resume password would be
asked to the user and used to decrypt the data. I think it should work
fine in theory.

However AFIK those public/private key algorithms only works securely with tons of
bits (a lot more than with a symmetic encryption), so I don't see how
can an human could possibly remeber such a long private key by memory. I
guess to make it work you'd need an USB pen to store it and unplug it
(then you'd have to be careful not to lose the USB pen). So I think it's
much simpler to use symmetric crypto (like cryptoloop) and to ask the
password during suspend too.
