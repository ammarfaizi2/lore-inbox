Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758135AbWK2VW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758135AbWK2VW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 16:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758130AbWK2VW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 16:22:57 -0500
Received: from mga06.intel.com ([134.134.136.21]:36925 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1758135AbWK2VW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 16:22:57 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,476,1157353200"; 
   d="scan'208"; a="168085693:sNHT18790583"
Date: Wed, 29 Nov 2006 13:17:57 -0800
From: Mark Gross <mgross@linux.intel.com>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Sebastien Bouchard <sebastien.bouchard@ca.kontron.com>, akpm@osdl.org
Subject: Re: [PATCH] tlclk: fix platform_device_register_simple() error check
Message-ID: <20061129211757.GB5267@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20061122184111.GC2985@APFDCB5C> <20061127203452.GA12279@linux.intel.com> <20061128060830.GA28689@APFDCB5C>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128060830.GA28689@APFDCB5C>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 03:08:30PM +0900, Akinobu Mita wrote:
> On Mon, Nov 27, 2006 at 12:34:52PM -0800, Mark Gross wrote:
> > >  
> > >  	tlclk_device = platform_device_register_simple("telco_clock",
> > >  				-1, NULL, 0);
> > > -	if (!tlclk_device) {
> > > +	if (IS_ERR(tlclk_device)) {
> > ok
> > 
> > >  		printk(KERN_ERR "tlclk: platform_device_register failed.\n");
> > > -		ret = -EBUSY;
> > > +		ret = PTR_ERR(tlclk_device);
> > 
> > I don't know about this but I could be wrong.  Please convince me.
> 
> We expect platform_device_register_simple() returns proper errno as pointer
> when it fails.

What's wrong with EBUSY?

--mgross
