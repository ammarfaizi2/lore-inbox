Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263403AbSJTSSj>; Sun, 20 Oct 2002 14:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSJTSSj>; Sun, 20 Oct 2002 14:18:39 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:13914 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S263403AbSJTSSi>;
	Sun, 20 Oct 2002 14:18:38 -0400
Date: Sun, 20 Oct 2002 20:24:36 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Container_of considered harmful - was Re: usb storage sddr09
Message-ID: <20021020182436.GA25975@win.tue.nl>
References: <200210172155.49349.tomlins@cam.org> <20021018193523.GA25316@win.tue.nl> <200210200952.23430.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210200952.23430.tomlins@cam.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Both of these are fixed with 2.4.44

Yes, there is progress. Not to say that there are no oopses left,
but with 2.5.44 the oopses are different.

Let me just report one, don't know whether I'll have time to track
what happens.

Insert and remove a usb-storage device while usb-storage
is not loaded. Now load usb-storage. Oops.

The oops is a dereference of fffffff0 in base/bus.c:driver_attach().
I have seen several such oopses lately, various places in the kernel.
The cause here is a NULL pointer that is turned into fffffff0 by
container_of() and then fed to get_device(). And get_device() tests
that it gets a non-NULL pointer, but that does not protect against
fffffff0.

Andries
