Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUDNPkH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUDNPkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:40:07 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:6041 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261389AbUDNPkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:40:00 -0400
From: Duncan Sands <baldrick@free.fr>
To: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs only on the disconnected interface
Date: Wed, 14 Apr 2004 17:39:56 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141245.37101.baldrick@free.fr> <200404141700.43087.baldrick@free.fr> <200404141733.11599.oliver@neukum.org>
In-Reply-To: <200404141733.11599.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404141739.56829.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 April 2004 17:33, Oliver Neukum wrote:
> > > Well, I don't. If you care about it, add a WARN_ON().
> > > Checking without consequences is bad.
> >
> > Hi Oliver, how about this instead?
>
> [..]
>
> > -	clear_bit(intf->cur_altsetting->desc.bInterfaceNumber, &ps->ifclaimed);
> > +	if (ifnum < 8*sizeof(ps->ifclaimed))
> > +		clear_bit(ifnum, &ps->ifclaimed);
> > +	else
> > +		warn("interface number %u out of range", ifnum);
> > +
>
> I would prefer a real WARN_ON() so that the imbedded people compiling
> for size are not affected.

What do you mean?  How is a real WARN_ON() better?

Duncan.
