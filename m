Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUHEBk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUHEBk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 21:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267470AbUHEBk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 21:40:59 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:59571 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S267464AbUHEBkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 21:40:55 -0400
From: David Brownell <david-b@pacbell.net>
To: ncunningham@linuxmail.org
Subject: Re: Solving suspend-level confusion
Date: Wed, 4 Aug 2004 18:29:45 -0700
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <200408031928.08475.david-b@pacbell.net> <1091586381.3189.14.camel@laptop.cunninghams>
In-Reply-To: <1091586381.3189.14.camel@laptop.cunninghams>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408041829.45298.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 August 2004 19:26, Nigel Cunningham wrote:

> > There's now some partial-tree code in CONFIG_USB_SUSPEND (for
> > developers only), but jumping from USB into the next level driver
> > (SCSI, video, etc) raises questions.
> 
> I've also done partial-tree support for suspend2 by making a new list
> (along side the active, off and off_irq lists) and simply moving devices
> I want to keep on (plus their parents) to this list prior to calling
> device_suspend. Works well for keeping alive the ide devices being used
> write the image.

What I'd need out of the PM framework would be "suspend this subtree",
and its cousin "resume this subtree".  Where the subtree starts with a
given device ... and, if it's got a driver, any abstract devices created
by that driver.  (And their children, etc.)

I'm not sure what to think about the desire of "suspend2" to prevent
a subtree from suspending.  In fact, I'm not at all sure how to even
interpret a "can't suspend" failure code... device in trouble, likely.

- Dave

