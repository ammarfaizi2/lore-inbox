Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269196AbUIYC7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269196AbUIYC7G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 22:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269197AbUIYC7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 22:59:06 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:32958 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S269196AbUIYC7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 22:59:01 -0400
Date: Sat, 25 Sep 2004 04:58:48 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Valdis.Kletnieks@vt.edu
Cc: David Lang <david.lang@digitalinsight.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040925025848.GG3309@dualathlon.random>
References: <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random> <Pine.LNX.4.60.0409241819580.1341@dlang.diginsite.com> <20040925013013.GD3309@dualathlon.random> <200409250147.i8P1kxtm016914@turing-police.cc.vt.edu> <20040925021501.GF3309@dualathlon.random> <200409250246.i8P2kWwx027390@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409250246.i8P2kWwx027390@turing-police.cc.vt.edu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 10:46:32PM -0400, Valdis.Kletnieks@vt.edu wrote:
> I think we're actually in what the IETF sometimes calls 'violent agreement' -
> what I meant was that if a misconfigured /etc/fstab marked a file system
> as 'swap', then even if it survived the 'mkswap', the subsequent swapping
> would finish the job...

indeed, I got it now ;)

> But as you noted in an earlier posting, having the metadata in cleartext
> so sys_swapon can tell what's going on and skipping the mkswap entirely is
> a better solution..

Yep.

> > or also if you mkswap on the whole device without partitions.
> 
> "Linux is designed to give you enough rope to shoot yourself in the foot with" ;)

eheh ;)

> Yes, that does sound like a sane idea, and also addresses at least *most* of
> the issues with swsusp and swap not stepping on each other's toes (as the

exactly ;)

> header is in cleartext so they both can read it). That still leaves the
> swsusp crew having to save their key securely - but that's easily done if
> you have cryptoapi handy.  Only ugly part is having to read a passphrase
> from the keyboard at suspend and resume (trying to implement "suspend on
> close lid" gets.. ummm.. interesting ;)

that's it yes.

I don't even think "save their key securely" (I mean saving anything
related to the swapsuspend encryption key on disk) is needed. A mixture
of a on-disk key + passphrase would not be more secure than a simple
"passphrase" alone, because the on-disk key would be in cleartext and
readable from the attacker. the only usable key is the one in the user memory,
it cannot be saved in the computer anywhere. Peraphs for additional
security (and to avoid having to type and remember it) one could use an
usb pen to store and fetch the key... but then I leave the fun to the
usb folks since to do that usb should kick off before resume overwrites
the kernel image ;)
