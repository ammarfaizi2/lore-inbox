Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUI0WpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUI0WpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 18:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUI0WpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 18:45:14 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:27812 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S267404AbUI0WpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:45:06 -0400
Date: Tue, 28 Sep 2004 00:43:45 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Stefan Seyfried <seife@suse.de>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040927224345.GB2412@dualathlon.random>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net> <1096071873.3591.54.camel@desktop.cunninghams> <20040925011800.GB3309@dualathlon.random> <4157B04B.2000306@suse.de> <20040927141652.GF28865@dualathlon.random> <1096323761.3606.3.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096323761.3606.3.camel@desktop.cunninghams>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 08:22:41AM +1000, Nigel Cunningham wrote:
> > because I never use suspend/resume on my desktop, I never shutdown my
> > desktop. I don't see why should I spend time typing a password when
> > there's no need to. Every single guy out there will complain at linux
> > hanging during boot asking for password before reaching kdm.
> > 
> > I figured out how to make the swap encryption completely transparent to
> > userspace, and even to swap suspend, so I think it's much better than
> > having userspace asking the user for a password, or userspace choosing a
> > random password.
> 
> The public/private key idea makes good sense to me.

yes for suspend/resume it should work. it will have the only advantage
of not having to ask the password during suspend or during boot, it will
only ask the "resueme" password during resume and the first time you
create the public key for resume to write it in the harddisk encrypted
with such passphrase as . as usual it'll be as Wolfgang suggested.

But why did you quote the above? for cryptoswap it cannot work, for
cryptoswap there's no reason to ever ask the user to anything and it
must read and write all the time anyways, it's not like suspend
write-only and resume read-only, a problem where public/private
encryption can fit.

> > yes, but the bootloader passes the paramters via /proc/cmdline, and it's
> > not nice to show the password in cleartext there.
> 
> If this password is only needed when resuming, that's not an issue
> because the command line given when resuming will be lost when the
> original kernel data is copied back.

my point is that you would not be allowed to give anyone ssh access to
your machine (assuming you trust local security). If he gets ssh access,
then he could as well stole the laptop and read the encrypted data.

But if calling set_fs(KERNEL_DS); sys_read(0) sounds troublesome, you
could also erase the password from the cmdline, and you would still
pass the passphrase via bootloader. I'd recommend not to make it visible
to userspace.

> There's already compression support. It's simpler to reverse, of course,
> but it doesn't help?

that should be trivial to reverse, no?
