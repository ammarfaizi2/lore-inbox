Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935645AbWK1GPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935645AbWK1GPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 01:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935646AbWK1GPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 01:15:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:60878 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S935645AbWK1GPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 01:15:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ZMsW212YiqSFCR+j09OIBF1HAi0bcJ3IvHDHNnr03HYPZL8XUGatD9kwVu3d90Mf63Bq8esQQQHvkqggjyODwgBdlY+vMh0x6xaNg6XOSzDUWQ7L1awa39PMxhI8nqTPt2IUUu+nBBgCqxgmUFKWNIfQg9u6t2Ms3fNAxsgtn7w=
Date: Tue, 28 Nov 2006 15:08:30 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Mark Gross <mgross@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
       Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>, akpm@osdl.org
Subject: Re: [PATCH] tlclk: fix platform_device_register_simple() error check
Message-ID: <20061128060830.GA28689@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Mark Gross <mgross@linux.intel.com>, linux-kernel@vger.kernel.org,
	Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>,
	akpm@osdl.org
References: <20061122184111.GC2985@APFDCB5C> <20061127203452.GA12279@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127203452.GA12279@linux.intel.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 12:34:52PM -0800, Mark Gross wrote:
> >  
> >  	tlclk_device = platform_device_register_simple("telco_clock",
> >  				-1, NULL, 0);
> > -	if (!tlclk_device) {
> > +	if (IS_ERR(tlclk_device)) {
> ok
> 
> >  		printk(KERN_ERR "tlclk: platform_device_register failed.\n");
> > -		ret = -EBUSY;
> > +		ret = PTR_ERR(tlclk_device);
> 
> I don't know about this but I could be wrong.  Please convince me.

We expect platform_device_register_simple() returns proper errno as pointer
when it fails.

