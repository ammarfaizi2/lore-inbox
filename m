Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTEMA4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 20:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTEMA4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 20:56:37 -0400
Received: from palrel10.hp.com ([156.153.255.245]:1252 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263077AbTEMA4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 20:56:36 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16064.17852.647605.663544@napali.hpl.hp.com>
Date: Mon, 12 May 2003 18:09:16 -0700
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: davidm@hpl.hp.com, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: Improved DRM support for cant_use_aperture platforms
In-Reply-To: <1052786080.10763.310.camel@thor>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	<1052653415.12338.159.camel@thor>
	<16062.37308.611438.5934@napali.hpl.hp.com>
	<20030511195543.GA15528@suse.de>
	<1052690133.10752.176.camel@thor>
	<16063.60859.712283.537570@napali.hpl.hp.com>
	<1052768911.10752.268.camel@thor>
	<16064.453.497373.127754@napali.hpl.hp.com>
	<1052774487.10750.294.camel@thor>
	<16064.5964.342357.501507@napali.hpl.hp.com>
	<1052786080.10763.310.camel@thor>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Michel> There are a couple more, like pte_offset_kernel(),
  Michel> pte_pfn(), pfn_to_page() and
  Michel> flush_tlb_kernel_range(). Getting this working with 2.4
  Michel> seems like a lot of work and/or ugly. :\

Just goes to show how quickly one gets used to 2.5... ;-)

Let me take a look at these.

  >> (apart from PAGE_AGP, which is taken care of by the latest
  >> patch).

  Michel> Not quite, PAGE_KERNEL_NOCACHE isn't defined on all
  Michel> architectures either.

OK, I believe the only other architecture that sets
"cant_use_aperture" is Alpha.  I asked some Alpha folks several months
ago about my patch, but never got a conclusive answer.  IIRC, on Alpha
the physical address itself determines cacheablity.  If so, we can use
PAGE_KERNEL (which is universal) instead of PAGE_KERNEL_NOCACHE.

Clearly the patch needs to be tested on Alpha.  The upside is that it
should let the Alpha folks get rid of a lot of ugliness in the
ioremap() code.

	--david
