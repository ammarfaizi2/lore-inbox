Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266544AbUF0EFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266544AbUF0EFa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 00:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUF0EFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 00:05:30 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54534 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S266544AbUF0EFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 00:05:23 -0400
Date: Sun, 27 Jun 2004 00:05:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Pete Zaitcev <zaitcev@redhat.com>
cc: greg@kroah.com, <arjanv@redhat.com>, <jgarzik@redhat.com>,
       <tburke@redhat.com>, <linux-kernel@vger.kernel.org>,
       <mdharm-usb@one-eyed-alien.net>, <david-b@pacbell.net>,
       <oliver@neukum.org>
Subject: Re: drivers/block/ub.c
In-Reply-To: <20040626130645.55be13ce@lembas.zaitcev.lan>
Message-ID: <Pine.LNX.4.44L0.0406262356110.30028-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2004, Pete Zaitcev wrote:

> Hi, guys,
> 
> I have drafted up an implementation of a USB storage driver as I wish
> it done (called "ub"). The main goal of the project is to produce a driver
> which never oopses, and above all, never locks up the machine. To this
> point I did all my debugging while running X11 and yapping on IRC. If this
> goal requires to sacrifice performance, so be it. This is how ub differs
> from the usb-storage.

I would say the major difference is that ub implements a block device 
interface directly whereas usb-storage relies on the SCSI layer for that 
purpose.  (Not to mention that usb-storage works with devices that aren't 
of the direct-access type...)

> The current usb-storage works quite well on servers where netdump can
> be brought to bear, but on desktop its debuggability leaves some room
> for improvement.

I agree that the debug logging in usb-storage is not good.  A worthwhile
improvement would be to log only commands that fail or get an error, with
the logging selected by the normal USB debugging (not usb-storage verbose
debugging) configuration option.  Matt, what do you think?

>  In all other respects, it is superior to ub. Since
> characteristics of usb-storage and ub are different I expect them to
> coexist potentially indefinitely (if ub finds any use at all).

It look like you are targeting ub for Linux 2.4.  Do you intend to use it 
with 2.6?  An important difference between the two kernel versions is that 
in 2.6 we do not try to make devices persistent across disconnections by 
recognizing some type of unique ID.

Alan Stern

