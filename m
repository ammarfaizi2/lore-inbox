Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSKXNbO>; Sun, 24 Nov 2002 08:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbSKXNbO>; Sun, 24 Nov 2002 08:31:14 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:18131 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261295AbSKXNbK>;
	Sun, 24 Nov 2002 08:31:10 -0500
Date: Sun, 24 Nov 2002 08:38:22 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Werner Almesberger <wa@almesberger.net>
cc: Patrick Mochel <mochel@osdl.org>, Rusty Lynch <rusty@linux.co.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use
In-Reply-To: <20021124100445.Q1407@almesberger.net>
Message-ID: <Pine.GSO.4.21.0211240832460.9014-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Nov 2002, Werner Almesberger wrote:

> do you really need a "magic" file for this ? I don't know how
> well sysfs supports mkdir/rmdir (if at all), but they would
> seem to provide a much more natural interface. (VFS allows
> rmdir to remove non-empty directories, so you wouldn't have
> to rm -r.)

a) sysfs doesn't allow mkdir/rmdir and thus avoids an imperial buttload
of races - witness the crap in devfs.

b) rmdir of non-empty directory pretty much guarantees another buttload of
races.

c) mkdir creating non-empty directory or rmdir removing non-empty directory
is *ugly*.  BTW, Roman's "filesystem" for modules in its current form is
vetoed, as far as I'm concerned - this sort of magic is just plain wrong.

