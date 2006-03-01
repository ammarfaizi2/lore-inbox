Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751948AbWCAXh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbWCAXh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWCAXh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:37:29 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:59871
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751948AbWCAXh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:37:28 -0500
Date: Wed, 1 Mar 2006 15:37:29 -0800
From: Greg KH <greg@kroah.com>
To: Olivier Galibert <galibert@pobox.com>, Ren? Rebe <rene@exactcode.de>,
       linux-kernel@vger.kernel.org
Subject: Re: MAX_USBFS_BUFFER_SIZE
Message-ID: <20060301233729.GA25356@kroah.com>
References: <200603012116.25869.rene@exactcode.de> <20060301213223.GA17270@kroah.com> <200603012242.35633.rene@exactcode.de> <20060301215423.GA17825@kroah.com> <20060301223430.GA9159@dspnet.fr.eu.org> <20060301224123.GA10422@kroah.com> <20060301232535.GA13225@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301232535.GA13225@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 12:25:35AM +0100, Olivier Galibert wrote:
> On Wed, Mar 01, 2006 at 02:41:23PM -0800, Greg KH wrote:
> > On Wed, Mar 01, 2006 at 11:34:30PM +0100, Olivier Galibert wrote:
> > > As a data point, I have traces of a scanner session including a
> > > download of a 26Mb binary image using 524288 bytes logical blocks
> > > physically transferred with 61440 bytes bulk_in frames.  Seems stable
> > > enough.  IIRC the scanner-side controller chip has some advanced
> > > buffering just to handle that kind of bandwidth.
> > 
> > That's impressive.  What are the endpoint sizes on the device that did
> > this?
> 
> Hmmm, the chip is a Genesys gl841, on a canonscan lide 35.  And it
> advertises a 64 bytes wMaxPacketSize on both in and out bulk
> interfaces.  Go figure.
> 
> Want the log and/or the lsusb -v?

Nah, I was just curious.

Now notice that the max the device can take for a single USB frame is 64
bytes.  So if you send one urb at 16K, you should have plenty of cpu
time to queue up another one of the same size before that one flushes
out to the device, even if it is a high speed device.

That's the reason upping the size of this buffer will not really help
anyone out, except lazy userspace programmers :)

thanks,

greg k-h
