Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266071AbTGISfl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266077AbTGISfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:35:41 -0400
Received: from granite.he.net ([216.218.226.66]:53514 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S266071AbTGISfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:35:33 -0400
Date: Wed, 9 Jul 2003 11:49:44 -0700
From: Greg KH <greg@kroah.com>
To: Disconnect <lkml@sigkill.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG][USB] 2.4.22-pre2
Message-ID: <20030709184943.GC18240@kroah.com>
References: <1057769826.8465.30.camel@slappy> <20030709173816.GA17421@kroah.com> <1057776185.8464.66.camel@slappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057776185.8464.66.camel@slappy>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 02:43:06PM -0400, Disconnect wrote:
> On Wed, 2003-07-09 at 13:38, Greg KH wrote:
> > On Wed, Jul 09, 2003 at 12:57:06PM -0400, Disconnect wrote:
> > > Its dead simple to reproduce - plug a pl2303 in, open /dev/ttyUSB0 with
> > > (eg) minicom or pppd, close it, check logs.
> > 
> > Known bug, search the archives :)
> > 
> > It's fixed in 2.5.
> > 
> > Someone needs to backport the 2.5 changes to 2.4 to fix this issue, as
> > I'm getting tired of repeating myself...
> 
> Most of the archives seem to be unrelated issues ~2.4.20-pre; I found a
> couple of places where you got to repeat yourself, but I'm not finding
> info on whats actually triggering it and which changes in 2.5 need
> backporting.  (I'm quite interested in getting this working, so I'm
> perfectly willing to give the backport a shot.)

I've said it before on this list, and on the linux-usb-devel list, but
here it is again for people to refer to in the future.

The locking and reference counting logic changes in the usb-serial
drivers needs to be backported to the 2.4 kernel to fix this problem.
The changes were spread out over a wide range of time during the 2.5
development process, so I can't point to a single changeset, sorry.  It
also requires changing all usb-serial drivers to do this properly.

If you do a diff of the two trees, you should see the major changes.

Good luck,

greg k-h
