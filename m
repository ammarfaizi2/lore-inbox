Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTEEOa0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbTEEOa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:30:26 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:25473 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP id S262269AbTEEOaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:30:25 -0400
Date: Mon, 5 May 2003 21:29:51 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: viro@parcelfarce.linux.theplanet.co.uk
cc: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <20030505134516.GB10374@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.SGI.4.10.10305052053000.8200163-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Mon, May 05, 2003 at 08:30:38PM +0700, Dmitry A. Fedorov wrote:
> > I use the following calls:
> > 
> > sys_mknod
> > sys_chown
> > sys_umask
> > sys_unlink
> > 
> > for creating/deleting /dev entries dynamically on driver
> > loading/unloading. It allows me to acquire dynamic major
> > number without devfs and external utility of any kind.
> > And there is no risk of intersection with statically assigned major
> > numbers, as it is for many others third-party sources.
> 
> *yuck*
> 
> Do that from modprobe.  "No external utility" is not a virtue, especially
> when said utility is a trivial shell script.

What about modprobe? Dynamic major number can be acquired only by the
module itself. Only after that the appropriate /dev entry can be
created. External utility must get major number from the module
but without the /dev entry there is no communication end point with the
module.

Only two possibilities exists:

1. /dev entries created with statically assigned major/minor numbers.
It is inconvenient for third-party modules.

2. devfs or procfs (/dev entry is just a symlink to some /proc/ entry
which will be created with the device attributes later).

You should look at my approach as tiny portable private devfs library.
It would works with and without devfs, without procfs (stripped in
embedded environment), with old and new kernels.
There is no "illegal" kernel mechanisms used.

Only one thing required - availability of systems calls.

