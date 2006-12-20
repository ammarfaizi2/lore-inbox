Return-Path: <linux-kernel-owner+w=401wt.eu-S965102AbWLTPRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWLTPRJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 10:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbWLTPRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 10:17:09 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:45475 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965102AbWLTPRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 10:17:08 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 10:17:08 EST
Date: Wed, 20 Dec 2006 10:10:26 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: J <jhnlmn@yahoo.com>, <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <gregkh@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Possible race condition in usb-serial.c
In-Reply-To: <200612201047.20842.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0612201009580.3072-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006, Oliver Neukum wrote:

> The data structure to protect is serial_table. Everything else is
> protected by refcounts. Therefore the interesting race is between
> open and disconnect. Open is called with BKL (fs/char_dev.c::chrdev_open)
> 
> Now, regarding disconnect. It used to be called with BKL held. I haven't been
> able to verify that this is still the case. If not, then there's a race.
> 
> In addition usb_serial_probe() uses get_free_serial() early in the process
> before the device is ready. Without BKL, this too, races with open.
> 
> People, do we take BKL in khubd?

Nope.

Alan Stern

