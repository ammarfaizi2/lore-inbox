Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVAUG2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVAUG2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVAUG2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:28:48 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:17848 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262280AbVAUG2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:28:37 -0500
From: David Brownell <david-b@pacbell.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: usbmon, usb core, ARM
Date: Thu, 20 Jan 2005 22:28:31 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
References: <20050118212033.26e1b6f0@localhost.localdomain> <200501190908.35210.david-b@pacbell.net> <20050120113545.58ce18a3@localhost.localdomain>
In-Reply-To: <20050120113545.58ce18a3@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501202228.31840.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 January 2005 11:35 am, Pete Zaitcev wrote:
> On Wed, 19 Jan 2005 09:08:34 -0800, David Brownell <david-b@pacbell.net> wrote:
> I do not like to refer to a dev because I do not quite understand where
> the necessary usb_dev_get/_put are now. But if you guarantee that the
> urb->dev is refcounted properly while urb is processed by usb_hcd_giveback_urb,
> I do not mind an extra indirection.

We have no reason to suspect bugs there; if there were any,
lots of things would have been breaking for a long time now.


> What would be the right test in usb_hcd_giveback_urb, then?
> It looks to me that you want me to use this:
> 
> urb_is_for_root_hub(urb) {

Actually it'd be more like dev_is_root_hub(dev, bus), since
both values are readily at hand -- you're basically just
wanting to wrap "dev == hcd->self.root_hub" in most cases.
Though I'm still not clear why you'd want to change that
working code; nothing's broken now, after all.


By the way ... on the topic of usbmon rather than changing
usbcore, is there a brief writeup of what you want this
new version to be doing -- and how?  Like, why put the
spy hooks in that location, rather than any of the other
choices.  (Many of them would be less surprising to me!)

- Dave


>      return urb->dev == urb->dev->bus->hcpriv->self.root_hub;
> }
> 
> This is just ... ewwwww. Can we use pipe for now or do you have
> a better idea?
> 
> -- Pete
> 
