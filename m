Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbUKIOSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbUKIOSs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUKIOSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:18:48 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:17933 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S261471AbUKIORs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:17:48 -0500
Date: Tue, 9 Nov 2004 15:10:52 +0100 (CET)
To: arjan@infradead.org
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <PRtWemOI.1100009451.9555870.khali@gcu.info>
In-Reply-To: <1099998753.3989.10.camel@laptop.fenrus.org>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Arjan,

> On Tue, 2004-11-09 at 11:17 +0100, Jean Delvare wrote:
> > These functions are part of the SMBus specs. The fact that no client uses
> > them for now doesn't mean that they will never be used.

On 2004-11-09, Arjan van de Ven wrote:
> yet at the same time they bloat the kernel for everyone NOW.
> If a driver magically appears that wants to use them, it's trivial to
> put these in, but I see absolutely no excuse for having them in all
> kernel binaries without users. This is how the kernel grows and grows
> for no good reason. There's dozens of such functions all over the
> kernel, and they take up unswappable memory all over.

I am sorry if my original point was misunderstood. I saw the various
posts on the LKML these days about code unbloating all around the kernel
tree, and agree it is a sane thing to do. I do not object to the removal
(binary-wise) of unused functions. I were merely suggesting that a
discussion would have been welcome, about which unused functions of
i2c-core should actually be removed and how they should be removed. As a
matter of fact and as I underlined in my previous post, the patch you
sent to Greg wasn't consistent (IMHO at least), and this could have
been avoided. Removing code we know will be needed within a few months
could have been avoided as well, which would mean less work for Greg and
others.

Anyway, no need to panic, no irreparable harm was done and it's not
2.6.10 yet. I simply, kindly ask for more cooperation with us
i2c/lm_sensors folks next time.

For now, I suggest that we finish what you started by removing the now
irrelevant function declarations in linux/i2c.h. As for the various
constants, we can leave them in place. They don't waste memory as far
as I can see, and the fact that a given SMBus command isn't supported
anymore for kernel clients doesn't prevent busses to declare that they
would support them [1]. If nothing else, it lets userspace use them
(through i2c-dev), even though I doubt there are that many users here
either.

I may propose a simple patch that does this, unless you want to care
about it yourself.

Thanks,
Jean

[1] In fact it looks like most bus drivers don't properly implement
these anyway, because there are no users at the moment, as you noticed.
