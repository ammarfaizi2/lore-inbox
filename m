Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTI3JZt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbTI3JZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:25:49 -0400
Received: from [62.197.173.195] ([62.197.173.195]:43911 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261262AbTI3JZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:25:44 -0400
Date: Tue, 30 Sep 2003 12:25:42 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: kartikey bhatt <kartik_me@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't X be elemenated?
Message-ID: <20030930092542.GI1058@mea-ext.zmailer.org>
References: <Law11-F60EhrkMNYwoy0001cb7a@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law11-F60EhrkMNYwoy0001cb7a@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 01:39:22PM +0530, kartikey bhatt wrote:
> your graphics card (hw) is resource that needs to be managed by OS.
> leaving it to 3rd party developers is an *adhoc* solution, *a stark immoral 
> choice*.

But there is an API to manage cards,  that is called Kernel-DRM.

> my friend gotta new AMD athlon with nvidia gforce 32mb shared memory,
> but he is on the mercy of X people to get full support for it.
> for now he has to do with generic i810 driver?
> any answer for that.
> my question is can't X be eleminated by providing support for
> graphics drivers and other routines at kernel  level?

In the X 4.2+ there is ABI to support BINARY drivers for cards without
vendors needing to provide sources for those drivers.  Those drivers
are presumably binary compatible at least upwards, e.g. driver done
for 4.2.1 should work at 4.3.0.   That is XFree86's chosen way.

In Linux kernel there is really no "guaranteed to work" way to have
binary driver modules even in between two vendors with same source.
Vendors do tend to add patches, which may (or may not) modify critical
datastructures.  A driver for 2.4.21 may or may not work on 2.4.22
kernel.  A driver for non-SMP configured kernel is very nearly guaranteed 
not to work on SMP configured kernel.

Often I could care less of receiving a binary-only driver for e.g. some
hardware driver, if it only would work at all of my kernels, and not only
at some year old version.

Presumably this should be possible in stable series of kernels
( the second value in kernel version number being even: 2.4.* )
but practice hasn't always been so.

Kartik, I presume you haven't been following linux lists for very long ?
Folks using hotmail and Yahoo do tend to drop their subscriptions rather
quickly mainly because of the very high volume of things at linux-kernel 
list.

Look into archives about NVidian kernel drivers, and the troubles
around those.  The issues being in essence that that particular
binary only driver is munging kernel memory map data thru manipulating
link chains, and what not, for which there is no internal API, and
doing all that in binary-only driver.  (I have to admit my ignorance
about all details, but in essence it has scared me away from things
with NVidia cards.)

I am quite sure, that there would be a lot less furor about the issue,
if only things manipulating card were binary only, and things working
on kernel data structures were available in source.  Possibly with
driver internal API and definitely stable datastructures.
Consider it like some card with binary only firmware for its internal
processor, which does have known interface data-structures.  To activate 
the firmware about some aspects of the new entry data, instead of poking
some IO or MMIO location, system main processor does execute that
"firmware".

The sad part, of course, is that it in essence does lock the driver
for i386, and Linux at other processors can't use the card.
On the other hand, 99%+ of Linuxes does run at i386.

/Matti Aarnio
