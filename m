Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSKXM5j>; Sun, 24 Nov 2002 07:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbSKXM5j>; Sun, 24 Nov 2002 07:57:39 -0500
Received: from almesberger.net ([63.105.73.239]:23813 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S261173AbSKXM5j>; Sun, 24 Nov 2002 07:57:39 -0500
Date: Sun, 24 Nov 2002 10:04:45 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Patrick Mochel <mochel@osdl.org>
Cc: Rusty Lynch <rusty@linux.co.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use
Message-ID: <20021124100445.Q1407@almesberger.net>
References: <003701c291aa$a3b28a10$94d40a0a@amr.corp.intel.com> <Pine.LNX.4.33.0211211637560.913-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211211637560.913-200000@localhost.localdomain>; from mochel@osdl.org on Thu, Nov 21, 2002 at 05:03:44PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
>  * This uses a sysfs control file to manage a list of probes. 
>  * The sysfs directory is at
>  *
>  * /sys/noisy/

I really like the idea of controlling kprobes through sysfs.
However, ...

>  * A Noisy Probe can be added by echoing into the file, like:
>  *
>  *	$ echo "add <address> <message>" > /sys/noisy/ctl

do you really need a "magic" file for this ? I don't know how
well sysfs supports mkdir/rmdir (if at all), but they would
seem to provide a much more natural interface. (VFS allows
rmdir to remove non-empty directories, so you wouldn't have
to rm -r.)

I don't think you need probe installation and message setting
to be atomic, so you could just assign a unique default
message, e.g. the probe address.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
