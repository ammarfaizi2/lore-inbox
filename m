Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263922AbTCWV3c>; Sun, 23 Mar 2003 16:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263926AbTCWV3b>; Sun, 23 Mar 2003 16:29:31 -0500
Received: from dp.samba.org ([66.70.73.150]:15045 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263922AbTCWV3a>;
	Sun, 23 Mar 2003 16:29:30 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15998.10367.608276.488022@nanango.paulus.ozlabs.org>
Date: Mon, 24 Mar 2003 08:34:55 +1100 (EST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] fix powerbook media bay
In-Reply-To: <1048433932.10727.18.camel@irongate.swansea.linux.org.uk>
References: <15997.17378.538276.91950@nanango.paulus.ozlabs.org>
	<1048433932.10727.18.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> IDE supports dynamic addition of interfaces so it should be possible
> to make this work either way around.

Yes, it should be possible with some tweaks to the media bay driver.

It gets a bit complicated though because at the moment there is no way
to say "here's a new interface and by the way it's a pmac IDE
interface so please use the pmac driver on it".  (Come to that there
doesn't appear to be any way to dynamically add an interface that uses
MMIO.)

Consequently the pmac IDE driver needs to know about the mediabay IDE
interface at pmac_ide_probe time and reserve a slot for it (which it
does).  At that point the pmac IDE driver tells the mediabay driver
the ioremapped base address of the interface so that the mediabay
driver can pass that back in to ide_register_hw.  Which is all a bit
backwards.

Of course, if you happened to plug in a CF card while you didn't have
the CD drive in the media bay, the CF card would get the media bay's
hwif structure and it would blow up in your face.

Is the IDE stuff still in the middle of open-heart surgery?  I'm happy
to hack on it and send you patches if it isn't all going to change
dramatically in the next week anyway.

Paul.
