Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266691AbUHDFBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266691AbUHDFBg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 01:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266846AbUHDFBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 01:01:35 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:38020 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S266691AbUHDFBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 01:01:34 -0400
Subject: Re: What PM should be and do (Was Re: Solving suspend-level
	confusion)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <1091595224.1899.99.camel@gaston>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408031928.08475.david-b@pacbell.net> <1091588163.5225.77.camel@gaston>
	 <200408032030.41410.david-b@pacbell.net>
	 <1091594872.3191.71.camel@laptop.cunninghams>
	 <1091595224.1899.99.camel@gaston>
Content-Type: text/plain
Message-Id: <1091595545.3303.80.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 04 Aug 2004 14:59:06 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-08-04 at 14:53, Benjamin Herrenschmidt wrote:
> > I really want the core PM code to provide:
> > 
> > - support for telling what class of device a driver is handling (I'm
> > particularly interested in keeping the keyboard, screen and storage
> > devices alive while suspending).
> 
> Well, they have to be suspended some way to keep a consistent state in
> the suspend image, at least until the pages are snapshoted... Unless
> the driver knows how to deal with an inconsistent state (I'm toying
> with that for fbdev at least right now)

Yes. I'm not trying to give drivers an inconsistent state, just delaying
suspending some until the last minute....

Suspend 2 algorithm:

1. Prepare image (freeze processes, allocate memory, eat memory etc)
2. Power down all drivers not used while writing image
3. Write LRU pages. ('pageset 2')
4. Quiesce remaining drivers, save CPU state, to atomic copy of
remaining ram.
5. Resume quiesced drivers.
6. Write atomic copy.
7. Power down used drivers.
8. Enter S4 if ACPI enabled; otherwise reboot or power down.

Nigel

