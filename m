Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbTKKXO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 18:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263822AbTKKXO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 18:14:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:26347 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263823AbTKKXOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 18:14:25 -0500
Date: Tue, 11 Nov 2003 15:08:15 -0800
From: "David S. Miller" <davem@redhat.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: milang@tal.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       greg@kroah.com
Subject: Re: Linux 2.4.23-rc1
Message-Id: <20031111150815.6a8aff01.davem@redhat.com>
In-Reply-To: <20031111231027.GC24159@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet>
	<009001c3a89a$af611130$54dc10c3@amos>
	<002701c3a8a1$b1ce6380$54dc10c3@amos>
	<20031111145734.46d19c87.davem@redhat.com>
	<20031111231027.GC24159@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003 23:10:27 +0000
viro@parcelfarce.linux.theplanet.co.uk wrote:

> > ir-usb.c should not assume all baud speed rate macros are
> > available on all platforms.
> 
> Umm...   Why are they defined in asm-*/* and not in linux/*?

Because each platform may wish to use different values
for these things as they are part of the user visible ABI.

For example, on Sparc we choose values which matched up closely
to what SunOS uses in order to make the compatability layer
for SunOS binaries easier to implement.

It just so happens that the bits are layed out on Sparc such
that we could only fit so many baud rate encodings, we didn't
have enough left to define one for B4000000.

You will notice that in the entire 2.6.x tree, ir-usb.c is the
only piece of code which makes reference to this value.
