Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUAPBHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 20:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbUAPBGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 20:06:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:39113 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263564AbUAPBGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 20:06:21 -0500
Date: Thu, 15 Jan 2004 16:32:25 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, jeremy@sgi.com
Subject: Re: [PATCH] readX_relaxed interface
Message-ID: <20040116003224.GF23253@kroah.com>
References: <20040115204913.GA8172@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115204913.GA8172@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 12:49:13PM -0800, Jesse Barnes wrote:
> Based on the PIO ordering disucssion, I've come up with the following
> patch.  It has the potential to help any platform that has seperate PIO
> and DMA channels, and allows them to be reorderd wrt each other.  Some
> SGI MIPS platforms, as well as the SGI Altix (aka sn2) platform behave
> this way, and will thus benefit from this patch.
> 
> It adds a new PIO read routine for PIOs that don't have to be ordered
> wrt DMA on the system.
> 
> If it looks ok, I'll add in macros for the other arches and send it out
> for inclusion.

It looks ok, but it would really be good if we could indicate if the
read actually was successful.  Right now some platforms can detect
faults and do not have a way to get that error back to the driver in a
sane manner.  If we were to change the read* functions to look something
like:
	int readb(void *addr, u8 *data);
it would be a world easier.

Now I'm not saying I want to change the existing interfaces to support
this, that's too much code to change for even me (and is a 2.7 thing.)

Just wanted to put this idea in people's heads that we need to start
planning for something like it.

thanks,

greg k-h
