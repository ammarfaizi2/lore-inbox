Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVHKSxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVHKSxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVHKSxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:53:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47785 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932359AbVHKSxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:53:38 -0400
Date: Thu, 11 Aug 2005 19:53:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't use a klist for drivers' set-of-devices
Message-ID: <20050811185332.GA6870@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0508101637360.4467-100000@iolanthe.rowland.org> <20050811182423.GC15803@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050811182423.GC15803@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 11:24:23AM -0700, Greg KH wrote:
> > This patch (as536) simplifies the driver-model core by replacing the klist 
> > used to store the set of devices bound to a driver with a regular list 
> > protected by a mutex.  It turns out that even with a klist, there are too 
> > many opportunities for races for the list to be used safely by more than 
> > one thread at a time.  And given that only one thread uses the list at any 
> > moment, there's no need to add all the extra overhead of making it a 
> > klist.
> 
> Hm, but that was the whole reason to go to a klist in the first place.

And shows once more that the klist approach was totally misguided.

