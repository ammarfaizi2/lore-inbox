Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSGIGX3>; Tue, 9 Jul 2002 02:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317314AbSGIGX2>; Tue, 9 Jul 2002 02:23:28 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:23059 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317312AbSGIGX1>; Tue, 9 Jul 2002 02:23:27 -0400
Date: Tue, 9 Jul 2002 08:25:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal 
In-Reply-To: <22226.1026174466@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0207090744180.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 9 Jul 2002, Keith Owens wrote:

>   Check use count.
>   Unregister.
>   Ensure that all code that had a reference to the module has either
>   dropped that reference or bumped the use count.
>   Check use count again, it may have been bumped above.
>   If use count is still 0, there are no stale references left.  It is
>   now safe to unload, call the module unallocate routine then free its
>   area.
>   If use count != 0, either schedule for removal when the count goes to
>   0 or reregister.  I prefer reregister, Rusty prefers delayed removal.
>
> Ensuring that all code has either dropped stale references or bumped
> the use count means that all processes that were not sleeping when
> rmmod was started must proceed to a sync point.  It is (and always has
> been) illegal to sleep while using module code/data (note: using, not
> referencing).

Who is changing the use count? How do you ensure that someone doesn't
cache a reference past that magic sync point?
IMO the real problem is that cleanup_module() can't fail. If modules
already do proper data acounting, it's not too difficult to detect if
there still exists a reference. In the driverfs example the problem is
that remove_driver() returns void instead of int, so it can't fail.

bye, Roman

