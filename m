Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUIVUvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUIVUvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUIVUvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:51:40 -0400
Received: from ida.rowland.org ([192.131.102.52]:55812 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265970AbUIVUvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:51:37 -0400
Date: Wed, 22 Sep 2004 16:51:37 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Florian Weimer <fw@deneb.enyo.de>
cc: Hisaaki Shibata <shibata@luky.org>,
       USB users list <linux-usb-users@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Genesys and IEEE 1394 (was: Re: Genesys Logic and Kernel 2.4)
In-Reply-To: <87d60eqcvu.fsf_-_@deneb.enyo.de>
Message-ID: <Pine.LNX.4.44L0.0409221648410.2089-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004, Florian Weimer wrote:

> * Hisaaki Shibata:
> 
> >> +		/* According to the technical support people at Genesys Logic,
> >> +		 * devices using their chips have problems transferring more
> >> +		 * than 32 KB at a time.  In practice people have found that
> >> +		 * 64 KB works okay and that's what Windows does.  But we'll
> >> +		 * be conservative.
> >> +		 */
> >> +		if (ss->pusb_dev->descriptor.idVendor == USB_VENDOR_ID_GENESYS)
> >> +			ss->htmplt->max_sectors = 64;
> >
> > +			ss->htmplt.max_sectors = 64;
> >
> >> +
> 
> Christoph Biedl discovered that it's likely that a a similar
> workaround is needed in the IEEE 1394 code:
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=5128811&forum_id=5389

That change was not the important one.  The important part of the patch 
was this:

+               /* Genesys Logic interface chips need a 100us delay between
+                * the command phase and the data phase */
+               if (us->pusb_dev->descriptor.idVendor == USB_VENDOR_ID_GENESYS)
+                       udelay(100);

This is what affects the timing problem, by adding a 100-microsecond 
delay.

Alan Stern

