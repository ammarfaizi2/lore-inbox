Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269346AbUJKXMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269346AbUJKXMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 19:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269357AbUJKXML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 19:12:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:18627 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269346AbUJKXJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 19:09:32 -0400
Subject: Re: Totally broken PCI PM calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200410111758.48441.dtor_core@ameritech.net>
References: <1097455528.25489.9.camel@gaston>
	 <200410110947.38730.david-b@pacbell.net> <1097533687.13642.30.camel@gaston>
	 <200410111758.48441.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1097536131.13795.40.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 09:08:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 08:58, Dmitry Torokhov wrote:

> Yes, I think that devices that failed to resume (and all their children)
> have to be moved by the core resume function into a separate list and
> then destroyed (again by the driver core). For that we might need to add
> bus_type->remove_device() handler as it seems that all buses do alot
> of work outside of driver->remove handlers. The remove_device should
> accept additional argument - something like dead_device that would
> suggest that driver should not be alarmed by any errors during unbind/
> removal process as the device (or rather usually its parent) is simply
> not there anynore.

They already do... think USB...

It's really only a locking problem within the PM core, that's getting
OT at the moment. I'll see if I can come up with something later.

Ben.


