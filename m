Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266675AbSKHAPb>; Thu, 7 Nov 2002 19:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266676AbSKHAPb>; Thu, 7 Nov 2002 19:15:31 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:25216 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S266675AbSKHAPa>;
	Thu, 7 Nov 2002 19:15:30 -0500
Date: Thu, 7 Nov 2002 19:25:51 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pnp.h changes - 2.5.46 (4/6)
Message-ID: <20021107192551.GB352@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20021106210639.GO316@neo.rr.com> <20021107060102.GB26821@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107060102.GB26821@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 10:01:02PM -0800, Greg KH wrote:
> On Wed, Nov 06, 2002 at 09:06:39PM +0000, Adam Belay wrote:
> >  
> > +static inline void *pnp_get_drvdata (struct pnp_dev *pdev)
> > +{
> > +	return pdev->dev.driver_data;
> > +}
> > +
> > +static inline void pnp_set_drvdata (struct pnp_dev *pdev, void *data)
> > +{
> > +	pdev->dev.driver_data = data;
> > +}
> > +
> > +static inline void *pnp_get_protodata (struct pnp_dev *pdev)
> > +{
> > +	return pdev->protocol_data;
> > +}
> > +
> > +static inline void pnp_set_protodata (struct pnp_dev *pdev, void *data)
> > +{
> > +	pdev->protocol_data = data;
> > +}
>
> Any reason for not just using dev_get_drvdata() and dev_set_drvdata() in
> the drivers?  Or at the least, use them within these functions, that's
> what they are there for :)
>
> thanks,
>
> greg k-h


Sure, here's a patch.  I think I'll use them within these functions.

Thanks,
Adam



Is this ok?



diff -ur a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Wed Nov  6 17:52:11 2002
+++ b/include/linux/pnp.h	Thu Nov  7 19:19:07 2002
@@ -75,12 +75,12 @@

 static inline void *pnp_get_drvdata (struct pnp_dev *pdev)
 {
-	return pdev->dev.driver_data;
+	return dev_get_drvdata(&pdev->dev);
 }

 static inline void pnp_set_drvdata (struct pnp_dev *pdev, void *data)
 {
-	pdev->dev.driver_data = data;
+	dev_set_drvdata(&pdev->dev, data);
 }

 static inline void *pnp_get_protodata (struct pnp_dev *pdev)
