Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVASPyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVASPyF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 10:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVASPyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 10:54:05 -0500
Received: from mail1.kontent.de ([81.88.34.36]:14282 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261727AbVASPyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 10:54:01 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: usbmon, usb core, ARM
Date: Wed, 19 Jan 2005 16:54:07 +0100
User-Agent: KMail/1.7.1
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       greg@kroah.com, linux-usb-devel@lists.sourceforge.net
References: <20050118212033.26e1b6f0@localhost.localdomain> <200501182214.25273.david-b@pacbell.net> <20050119074208.3bfa6458@localhost.localdomain>
In-Reply-To: <20050119074208.3bfa6458@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501191654.07619.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 19. Januar 2005 16:42 schrieb Pete Zaitcev:
> On Tue, 18 Jan 2005 22:14:24 -0800, David Brownell <david-b@pacbell.net> wrote:
> 
> > > > Also, I don't like the idea of scattering knowledge all over the place
> > > > that the root hub is always given address 1 ... 
> > 
> > which you didn't address yet.
> 
> Yes, I have to look why you do not like using the pipe. Relying on pipe makes
> tests dependant on URB only. No references to bus or HCD, therefore no
> extra refcounts or worries about oopses. Also, HC drivers zero out the
> urb->dev in giveback sequence which is a royal pain when trying to identify
> a root hub. I thought about adding an extra flag like URB_ROOT_HUB to split

That idea was good. It is simple and will simplify the code cleanly.

> this use from the abuse of URB_NO_TRANSFER_DMA_MAP, but pipe looks better
> all around. If you look at it from the angle I did, it stands to reason
> that excessive encapsulation only masks _why_ it was safer, e.g. if one sees
> something like urb_is_root_hub(urb), one must look up the implementation
> to know if it uses urb->dev or not. Relying on address 1 without any symbolic
> constant is obviously a bad idea though, I'll fix that.

True, but pipe must die. It has no real basis.

	Regards
		Oliver
