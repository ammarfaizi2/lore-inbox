Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbUKDN3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbUKDN3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 08:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbUKDN3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 08:29:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25757 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262222AbUKDN2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 08:28:51 -0500
Date: Thu, 4 Nov 2004 08:25:05 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Germano <germano.barreiro@cyclades.com>
Cc: greg@kroah.com, Scott_Kilau@digi.com, linux-kernel@vger.kernel.org
Subject: Re: patch for sysfs in the cyclades driver
Message-ID: <20041104102505.GA8379@logos.cnet>
References: <1099487348.1428.16.camel@tsthost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099487348.1428.16.camel@tsthost>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 11:09:08AM -0200, Germano wrote:
> Hi
> 
> I will have to study again the code I tried first (it was long ago), but
> the main problem was that due to that class be (somehow) derived from
> class_simple, I can one export using it the major and minor numbers for
> the device. Tosatti, maybe you can complete my answer with details,
> since it was you that advised me about this limitation.
> However, this was some time ago (kernel 2.6.7 was going to be released),
> and I didn't check how much sysfs for the tty drivers has changed since
> them. If I can attach this data (signalling states) to the port, it
> would be very preferable than attaching to the board as me and Scott are
> trying. Even because his advise about the possibility of my patch be
> overwritting one channel data with other's make a lot of sense and I
> will have to test it (I'm grateful for you, Scott).

The problem was class_simple only contains the "dev" attribute. You can't
add other attributes to it.

The correct thing should be to create "class_tty" with all necessary attributes 
(speed, data transferred, etc).  

But thats not a v2.6 thing I believe.  

I talked to Greg about this at the time and he agreed we need a "class_tty"
type.

> Cheers :)
> Germano
> 
> On Tue, Nov 02, 2004 at 02:51:33PM -0600, Kilau, Scott wrote:
> > > I know you have done work on USB serial drivers with devices with
> > > multiple ports...
> > > Is there any way to create a file in sys that can point back to a port,
> > > and NOT the port's
> > > parent (ie, the board) WITHOUT having to create a new kobject per port?
> What's wrong with the kobject in /sys/class/tty/ which has one object
> per port?  I think we might not be exporting that class_device
> structure, but I would not have a problem with doing that.
