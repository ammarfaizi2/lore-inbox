Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVCOURs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVCOURs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVCOURI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:17:08 -0500
Received: from isilmar.linta.de ([213.239.214.66]:20956 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261874AbVCOUPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:15:04 -0500
Date: Tue, 15 Mar 2005 21:15:03 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Greg KH <greg@kroah.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Changes to the driver model class code.
Message-ID: <20050315201503.GA3591@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Greg KH <greg@kroah.com>, dtor_core@ameritech.net,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	Kay Sievers <kay.sievers@vrfy.org>
References: <20050315170834.GA25475@kroah.com> <d120d500050315094724938ffc@mail.gmail.com> <20050315193415.GA26299@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315193415.GA26299@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 11:34:15AM -0800, Greg KH wrote:
> > And what about device_driver and device structure? Are they going to
> > be changed over to be separately allocated linked objects?
> 
> The driver stuff probably will be, and the device stuff possibly.
> However, they are used by a very small ammount of core code (the bus
> drivers), so changing that interface is not that important at this time.

So this means every device will have yet another reference count, and you
need to be aware of _each_ lifetime to write correct code. And the 
_reference counting_ is the hard thing to get right, so we should make 
_that_ easier. The existing class API was a step towards this direction, and
with the changes you're suggesting here we'd do two jumps backwards.

> > If not then its enouther reason to keep original class interface -
> > uniformity of driver model interface.
> 
> Ease-of-use trumps uniformity

Ease-of-use, maybe. However, it also means
ease-of-getting-reference-counting-wrong. And reference counting trumps it
all :)

Thanks,
	Dominik
