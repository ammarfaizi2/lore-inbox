Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWGYWP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWGYWP4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWGYWP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:15:56 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:23055 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1030183AbWGYWPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:15:55 -0400
Message-ID: <44C69819.8080908@superbug.co.uk>
Date: Tue, 25 Jul 2006 23:15:53 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.4 (X11/20060609)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC PATCH] Multi-threaded device probing
References: <20060725203028.GA1270@kroah.com>
In-Reply-To: <20060725203028.GA1270@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> During the kernel summit, I was reminded by the wish by some people to
> do device probing in parallel, so I created the following patch.  It
> offers up the ability for the driver core to create a new thread for
> every driver<->device probe call.  To enable this, the driver needs to
> have the multithread_probe flag set to 1, otherwise the "traditional"
> sequencial probe happens.
> 
> Note that this patch does not actually enable the threaded probe for any
> busses, as that's very dangerous at this point in time, without the
> different bus authors trying it out and verifying that it does work
> properly.
> 
> I did enable this for both USB and PCI and shaved .4 seconds off of the
> boot time of my tiny little single processor laptop.  The savings of my
> 4-way workstation is much greater, but things start to happen so fast we
> miss the root disk, as init starts before the disks are finished being
> initialized.  I have some hacks to work around this right now, but I'll
> hold off on posting them before I make sure they work properly (breaking
> booting of people's machines isn't the best way to get them to accept
> new features...)
> 
> Anyway, have fun playing around with this if you want, I'll be adding
> this to the next -mm, but you will have to enable the bit on your own if
> you want to see any speedups.
> 
> thanks,
> 
> greg k-h
> 

What happens about the logging?
Surely one would want the output from one probe to be output into the
log as a block, and not mix the output from multiple simultaneous probes.

James
