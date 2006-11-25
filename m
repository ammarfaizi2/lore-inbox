Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757938AbWKYQIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938AbWKYQIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 11:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757940AbWKYQIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 11:08:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5865 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757938AbWKYQIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 11:08:15 -0500
Date: Sat, 25 Nov 2006 16:08:21 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       seife@suse.de
Subject: Re: [patch] PM: suspend/resume debugging should depend on
 SOFTWARE_SUSPEND
Message-ID: <20061125160821.1fd4f9c8@localhost.localdomain>
In-Reply-To: <20061124234015.GB4782@ucw.cz>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	<Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
	<20061122152328.GI5200@stusta.de>
	<20061122154230.74889e3d@localhost.localdomain>
	<20061124234015.GB4782@ucw.cz>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm... how common are these machines? We are using unpatched kernel
> for suse10.2... OTOH we only support machines from the whitelist, all

I've always said IDE and software suspend are unsafe. The more work I do
the more clearly this is/was the case.

The really nasty "resume eats your disk" cases I know about are
thankfully for older systems - VIA KT133 and similar era chipsets.
There is a recent nasty - Jmicron goes totally to **** on resume because
of resume quirks not being run but it goes so spectacularly wrong it
doesn't seem to get far enough to corrupt.

Lots of other controllers don't work correctly on resume but thats much
less of a problem and with UDMA misclocking generally turns into a CRC
error storm and stop.

Andrew has about 2/3rds of the bits I've done now, will push the rest
when I've done a little more testing/checking. At that point libata ought
to be resume safe. Someone who cares about drivers/ide legacy support can
then copy the work over.

Alan
