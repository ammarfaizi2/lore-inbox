Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUAaDQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 22:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbUAaDQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 22:16:55 -0500
Received: from buerotecgmbh.de ([217.160.181.99]:1411 "EHLO buerotecgmbh.de")
	by vger.kernel.org with ESMTP id S261973AbUAaDQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 22:16:54 -0500
Date: Sat, 31 Jan 2004 04:17:18 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] udev 015 release
Message-ID: <20040131031718.GA21129@vrfy.org>
References: <20040126215036.GA6906@kroah.com> <1075395125.7680.21.camel@nosferatu.lan> <20040129215529.GB9610@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129215529.GB9610@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 01:55:29PM -0800, Greg KH wrote:
> On Thu, Jan 29, 2004 at 06:52:05PM +0200, Martin Schlemmer wrote:
> > On Mon, 2004-01-26 at 23:50, Greg KH wrote:
> > 
> > Is there a known issue that the daemon do not spawn?
> 
> Hm, I don't know.  This code is under major flux right now...

Hi Martin,
sorry, the code in the tree doesn't work.
I decided to try pthreads, cause I gave up with the I/O multiplexing,
forking and earning SIGCHLDS for manipulating the global lists.

The multithreaded udevd takes multiple events at the same time on a unix
domain socket, sorts it in a linked list and handles the timeouts if
events are missing.
It executes our current udev in the background and delays the execution
for events with the same DEVPATH. So we serialize the events only for
different devices.

I've posted the latest patch to the list a few minutes ago.
If you like, I'm happy to hear from your testing :)

If we decide not to stay with the threads model, cause klibc doesn't
support it now and ..., we at least have a working model to implement
in a different way.

thanks,
Kay

