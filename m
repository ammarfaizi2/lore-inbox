Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUHDDMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUHDDMM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 23:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266691AbUHDDMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 23:12:12 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:25226 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S264937AbUHDDMI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 23:12:08 -0400
Subject: Re: Solving suspend-level confusion
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <1091587985.5226.74.camel@gaston>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston>
	 <200408031928.08475.david-b@pacbell.net>
	 <1091586381.3189.14.camel@laptop.cunninghams>
	 <1091587985.5226.74.camel@gaston>
Content-Type: text/plain
Message-Id: <1091587929.3303.38.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 04 Aug 2004 12:52:09 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-08-04 at 12:53, Benjamin Herrenschmidt wrote:
> > I've also done partial-tree support for suspend2 by making a new list
> > (along side the active, off and off_irq lists) and simply moving devices
> > I want to keep on (plus their parents) to this list prior to calling
> > device_suspend. Works well for keeping alive the ide devices being used
> > write the image.
> 
> How so ? By not calling suspend for it at all ? That's broken, the
> driver wants suspend to match the resume it will get when the image
> is reloaded, that's the only way the driver can guarantee a sane state
> saved in the suspend image.

Yes, I don't call suspend for it because I can be sure the drivers are
idle (before beginning to write the image, freeze all process, flush all
dirty buffers and suspend all other drivers, I then wait on my own I/O
until it is flushed too). I know it's broken to do so, but it was a good
work around for wearing out the thing by spinning it down and then
immediately spinning it back up, and I wasn't sure what the right state
to try to put it in is (sound familiar?!). If you want to tell me how I
could tell it to quiesce without spin down, I'll happily do that.

The sooner these issues get sorted, the better.

Regards,

Nigel

