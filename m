Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVBJPkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVBJPkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVBJPkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:40:42 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:11937 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262143AbVBJPke
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:40:34 -0500
Subject: Re: [tpmdd-devel] Re: [PATCH 1/1] tpm: update tpm sysfs file
	ownership - updated version
From: Kylene Hall <kjhall@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Emily Ratliff <emilyr@us.ibm.com>, Tom Lendacky <toml@us.ibm.com>,
       tpmdd-devel@lists.sourceforge.net
In-Reply-To: <20050209140440.J469@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0501281539340.6360@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0501311322380.9872@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0502031034290.18135@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0502041405230.22211@jo.austin.ibm.com>
	 <20050204205226.GA26780@kroah.com>
	 <1107553040.22140.30.camel@jo.austin.ibm.com>
	 <20050204215134.GA27433@kroah.com>
	 <Pine.LNX.4.58.0502091201110.3969@jo.austin.ibm.com>
	 <20050209181736.GA23422@kroah.com>
	 <Pine.LNX.4.58.0502091431160.4398@jo.austin.ibm.com>
	 <20050209140440.J469@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1108050019.22140.93.camel@jo.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 10 Feb 2005 09:40:19 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-09 at 16:04, Chris Wright wrote:
> > +#define TPM_DEVICE_ATTRS { \
> > +	__ATTR(pubek, S_IRUGO, show_pubek, NULL), \
> > +	__ATTR(pcrs, S_IRUGO, show_pcrs, NULL), \
> > +	__ATTR(caps, S_IRUGO, show_caps, NULL), \
> > +	__ATTR(cancel, S_IWUSR | S_IWGRP, NULL, store_cancel) }
> 
> This doesn't look like the right way to go.  
> 
> > +
> >  struct tpm_chip;
> >  
> >  struct tpm_vendor_specific {
> > @@ -42,6 +54,7 @@ struct tpm_vendor_specific {
> >  	void (*cancel) (struct tpm_chip *);
> >  	u8 (*status) (struct tpm_chip *);
> >  	struct miscdevice miscdev;
> > +	struct device_attribute attr[TPM_NUM_ATTR];
> 
> So every device will have the same attrs?  If so, make that whole struct
> exported (not the individual show/store methods) and reference that in
> each driver.
> 
They are all the same except they have a different owner.  What I was
trying to do was have them initialized in the tpm specific drivers so
that the attribute ownership would be correct but then create them in
the generic driver since that was common to all the specific drivers.  I
could have one copy of the attributes like the one in the mm tree now
and change the owner when ever I want to add or remove the attribute. 
Would that be correct?

Thanks,
Kylie

> thanks,
> -chris

