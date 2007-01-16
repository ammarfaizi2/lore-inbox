Return-Path: <linux-kernel-owner+w=401wt.eu-S1751460AbXAPDTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXAPDTM (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 22:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXAPDTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 22:19:12 -0500
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:46067 "EHLO
	ppsw-3.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbXAPDTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 22:19:11 -0500
X-Greylist: delayed 1467 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 22:19:11 EST
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
To: xen-devel@lists.xensource.com
Subject: Re: [Xen-devel] Re: [patch 20/20] XEN-paravirt: Add Xen virtual block device driver.
Date: Tue, 16 Jan 2007 02:53:42 +0000
User-Agent: KMail/1.9.5
Cc: Arjan van de Ven <arjan@infradead.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
References: <20070113014539.408244126@goop.org> <20070113014649.256179743@goop.org> <1168736848.3123.352.camel@laptopd505.fenrus.org>
In-Reply-To: <1168736848.3123.352.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701160253.43218.mark.williamson@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +	err = xenbus_printf(xbt, dev->nodename,
> > +			    "ring-ref","%u", info->ring_ref);
>
> why do you need your own printf?

xenbus_printf isn't a printf replacement - it is used for writing a formatted 
string into XenStore (which contains  VM configuration data in a 
human-readable form).

Internally it does a vsnprintf into a buffer and writes the resulting string 
to the XenStore.

Cheers,
Mark

> > +static inline int GET_ID_FROM_FREELIST(
>
> does this really need screaming?
>
> > +
> > +int blkif_ioctl(struct inode *inode, struct file *filep,
> > +		unsigned command, unsigned long argument)
> > +{
> > +	int i;
> > +
> > +	DPRINTK_IOCTL("command: 0x%x, argument: 0x%lx, dev: 0x%04x\n",
> > +		      command, (long)argument, inode->i_rdev);
> > +
> > +	switch (command) {
> > +	case CDROMMULTISESSION:
> > +		DPRINTK("FIXME: support multisession CDs later\n");
> > +		for (i = 0; i < sizeof(struct cdrom_multisession); i++)
> > +			if (put_user(0, (char __user *)(argument + i)))
> > +				return -EFAULT;
> > +		return 0;
> > +
> > +	default:
> > +		/*printk(KERN_ALERT "ioctl %08x not supported by Xen blkdev\n",
> > +		  command);*/
> > +		return -EINVAL; /* same return as native Linux */
> > +	}
>
> eh so you implement no ioctls.. why then implement the ioctl method at
> all?

I'm not familiar with this code...  but perhaps the (fake) multisession 
handling is to keep userspace that queries this happy?  I can't really think 
of anywhere this would apply off the top of my head, though.

Cheers,
Mark

> > +static struct xenbus_driver blkfront = {
> > +	.name = "vbd",
> > +	.owner = THIS_MODULE,
> > +	.ids = blkfront_ids,
> > +	.probe = blkfront_probe,
> > +	.remove = blkfront_remove,
> > +	.resume = blkfront_resume,
> > +	.otherend_changed = backend_changed,
> > +};
>
> this can be const
>
> > +
> > +#define DPRINTK(_f, _a...) pr_debug(_f, ## _a)
>
> why this silly abstraction? Just use pr_debug in the code directly
>
>
>
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel

-- 
Dave: Just a question. What use is a unicyle with no seat?  And no pedals!
Mark: To answer a question with a question: What use is a skateboard?
Dave: Skateboards have wheels.
Mark: My wheel has a wheel!
