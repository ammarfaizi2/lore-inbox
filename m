Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270681AbTG0GK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 02:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270685AbTG0GK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 02:10:26 -0400
Received: from mail1.kontent.de ([81.88.34.36]:53131 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S270681AbTG0GKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 02:10:23 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] System stalls using usb-storage
Date: Sun, 27 Jul 2003 08:24:44 +0200
User-Agent: KMail/1.5.1
References: <20030723200051.C18354@one-eyed-alien.net>
In-Reply-To: <20030723200051.C18354@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307270824.44851.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 24. Juli 2003 05:00 schrieb Matthew Dharm:
> Many people, including myself, have observed system stalls when using
> usb-storage.  It happens when copying large amounts of data to a USB device
> -- everything (except the USB access) just stops for a little while.  My
> best guess is that the block cache is filling up (easy since USB is so
> slow).

Can you do a vmstat run? That should provide conclusive data.
If so, write throteling is failing.

> The question is, what is the best way to handle this.  I'm guessing that
> increasing the priority of the usb-storage control thread will help, but
> that's just a guess.  I'm not even sure how to go about doing that, tho...

A kernel thread in the block io path has to have a higher priority than
any user task. Otherwise a priority inversion is possible.

	Regards
		Oliver

