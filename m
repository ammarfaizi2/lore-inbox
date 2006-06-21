Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbWFUTGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbWFUTGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbWFUTGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:06:32 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:1030 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932670AbWFUTGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:06:31 -0400
Date: Wed, 21 Jun 2006 15:06:30 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: andi@lisas.de
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       <gregkh@suse.de>, <linux-kernel@vger.kernel.org>,
       <hal@lists.freedesktop.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner
 underruns, USB HDD hard resets)
In-Reply-To: <20060621164425.GB22736@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.44L0.0606211502510.8272-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Andreas Mohr wrote:

> > The real problem seems to be that the device is reachable in two different 
> > ways, and they don't implement proper mutual exclusion.  HAL (or your test 
> > program) is undoubtedly using /dev/sr0 or something similar, whereas 
> > cdrecord uses /dev/sg0.  Going through two different drivers, it's no 
> > surprise they wind up interfering with each other.
> 
> HAL is /dev/host0/.../cd

That goes through the sr driver.

> cdrecord is -dev=0,0,0 (whatever Linux device file this translates into)
> or a similar device ID as returned by -scanbus.

That goes through the sg driver.

> Probably (stating the obvious here, I'm afraid) we should only send
> non-ALLOW_MEDIUM_REMOVAL for the *very first* device open,
> and then send ALLOW_MEDIUM_REMOVAL after the *very last* device close only.
> 
> So you think that with sr and sg drivers both talking to the device,
> proper inter-driver device tracking is not doable or quite difficult
> to implement?

Well, it's not being done now.  I suspect it wouldn't be too difficult 
technically.  The hardest part might be to obtain the agreement of the 
SCSI and CDROM developers.  :-)

Alan Stern

