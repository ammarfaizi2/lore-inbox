Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUF1PlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUF1PlR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUF1PlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:41:17 -0400
Received: from ida.rowland.org ([192.131.102.52]:9732 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265041AbUF1PlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:41:01 -0400
Date: Mon, 28 Jun 2004 11:40:58 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Greg KH <greg@kroah.com>, <arjanv@redhat.com>, <jgarzik@redhat.com>,
       <tburke@redhat.com>, <linux-kernel@vger.kernel.org>,
       <mdharm-usb@one-eyed-alien.net>, <david-b@pacbell.net>,
       <oliver@neukum.org>
Subject: Re: drivers/block/ub.c
In-Reply-To: <20040627132945.70350f2a@lembas.zaitcev.lan>
Message-ID: <Pine.LNX.4.44L0.0406281133360.1598-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004, Pete Zaitcev wrote:

> On Sun, 27 Jun 2004 11:23:10 -0400 (EDT)
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > + * -- use serial numbers to hook onto same hosts (same minor) after
> > disconnect
> 
> It was a poor wording by me. It refers to the drift of naming due to
> increments in usb_host_id. After a disconnect and reconnect, /dev/uba1
> refers to the device, but /proc/partitions says "ubb".
> 
> To correct this, I have to set gendisk->fist_minor before calling
> add_disk(), but in order to do that, a driver has to track devices
> somehow. A serial number looks like an obvious candidate for a key.

I don't fully understand the nature of this problem.  Is it that ub always
assigns the _first_ available minor number whereas add_disk() tries to
assign the _next_ available?  If so, how does tracking devices help?  
Shouldn't you just always want add_disk() to use the same minor number as 
ub?

Or maybe I've misunderstood completely, not just partially.  In any case,
are you sure you will want to do this?  The directive for not tracking 
serial numbers or trying in some other way to make devices appear to be 
persistent across reconnects came directly from Linus.

Alan Stern

