Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264865AbTFQRVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 13:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTFQRVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 13:21:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:23769 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264865AbTFQRVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 13:21:36 -0400
Date: Tue, 17 Jun 2003 10:33:44 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrick Mochel <mochel@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Flaw in the driver-model implementation of attributes
Message-ID: <20030617173343.GB3841@kroah.com>
References: <20030616233651.GB27033@kroah.com> <Pine.LNX.4.44L0.0306171318090.621-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0306171318090.621-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 01:29:31PM -0400, Alan Stern wrote:
> On Mon, 16 Jun 2003, Greg KH wrote:
> 
> > All disk info is in the /sys/block directory, does that work for you?
> 
> Not scsi disk info.  (Or maybe it should be there but it isn't.)  And no,
> it doesn't work for me because it's owned by the scsi core, not my driver.
> 
> > I think the scsi core will create you a directory that you can use that
> > will have the proper lifetime that you are looking for.  If not, I can
> > look into doing something else for some of the other USB devices that
> > are not using the USB major.
> 
> I don't think it would be appropriate to use that directory, since my 
> driver wouldn't own it.
> 
> How about creating a /sys/class/usb/usb-storage/ directory, under which
> there could be a directory for each USB mass-storage device?  Or would it 
> be better to create a usb-storage.# directory under the interface's 
> directory in /sys/devices/ ?

class/usb-storage/ would be fine with me.

> It's worth pointing out that both the OHCI and EHCI drivers also do the
> same wrong thing.  They create their attribute files in a directory
> owned by the PCI driver.

Yup, you are correct, time to add class/usb-host/ :)

thanks,

greg k-h
