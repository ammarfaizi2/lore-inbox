Return-Path: <linux-kernel-owner+w=401wt.eu-S1751156AbWLMVmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWLMVmF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWLMVmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:42:05 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:34658 "EHLO
	straum.hexapodia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbWLMVmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:42:04 -0500
X-Greylist: delayed 1514 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 16:42:04 EST
Date: Wed, 13 Dec 2006 13:16:49 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Keiichi KII <k-keiichi@bx.jp.nec.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.19 2/6] support multiple logging agents
Message-ID: <20061213211649.GA6307@hexapodia.org>
References: <457E498C.1050806@bx.jp.nec.com> <457E4C65.6030802@bx.jp.nec.com> <20061212184250.GJ13687@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212184250.GJ13687@waste.org>
User-Agent: Mutt/1.4.2.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 12:42:50PM -0600, Matt Mackall wrote:
> > +	new_dev = (struct netconsole_device*)kmalloc(
> > +		sizeof(struct netconsole_device), GFP_ATOMIC);
> 
> Cast of void * is unnecessary.

Also,
1. use kzalloc rather than kmalloc+memset
2. use p = kzalloc(sizeof(*p) rather than p = kzalloc(sizeof(struct foo)
3. use goto to common error exit code rather than local return

> > +	if (!new_dev) {
> > +		printk(KERN_INFO "netconsole: kmalloc() failed!\n");
> > +		kfree(netcon_dev_config);
> > +		return -ENOMEM;
> > +	}
> > +	memset(new_dev, 0, sizeof(struct netconsole_device));

-andy
