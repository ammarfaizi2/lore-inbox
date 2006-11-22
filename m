Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966970AbWKVBvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966970AbWKVBvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 20:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967000AbWKVBvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 20:51:06 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52115 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S966970AbWKVBvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 20:51:02 -0500
Date: Tue, 21 Nov 2006 17:50:46 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Jan Beulich <jbeulich@novell.com>
Cc: Dave Jones <davej@redhat.com>, Chris Wright <chrisw@sous-sol.org>,
       akpm@osdl.org, Randy Dunlap <rdunlap@xenotime.net>,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Metathronius Galabant <m.galabant@googlemail.com>, torvalds@osdl.org,
       Michael Krufky <mkrufky@linuxtv.org>, Michael Buesch <mb@bu3sch.de>,
       Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [PATCH 46/61] fix Intel RNG detection
Message-ID: <20061122015046.GI1397@sequoia.sous-sol.org>
References: <20061101053340.305569000@sous-sol.org> <20061101054343.623157000@sous-sol.org> <20061120234535.GD17736@redhat.com> <20061121022109.GF1397@sequoia.sous-sol.org> <4562D5DA.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4562D5DA.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Beulich (jbeulich@novell.com) wrote:
> >>> Chris Wright <chrisw@sous-sol.org> 21.11.06 03:21 >>>
> >Hmm, I wonder if the report is valid?  Jan's patch would have the correct
> >side effect of disabling false positives (for RNG identification).
> >Be good to check that it actually used to work.
> 
> Indeed, that is quite significant to know here.

It does appear to work w/out the patch.  I've asked for a small bit
of diagnostics (below), perhaps you've got something you'd rather see?
I expect this to be a 24C0 LPC Bridge.


diff --git a/drivers/char/hw_random/intel-rng.c b/drivers/char/hw_random/intel-rng.c
index 8efbc9c..c655f57 100644
--- a/drivers/char/hw_random/intel-rng.c
+++ b/drivers/char/hw_random/intel-rng.c
@@ -304,6 +304,10 @@ #ifdef CONFIG_SMP
 	set_mb(waitflag, 0);
 #endif
 
+	printk(PFX "pci vendor:device %hx:%hx fwh_dec_en1 %x bios_cntl_val %x "
+	       "mfc %x dvc %x\n", dev->vendor, dev->device,
+	       fwh_dec_en1_val, bios_cntl_val, mfc, dvc);
+
 	iounmap(mem);
 	pci_dev_put(dev);
 
