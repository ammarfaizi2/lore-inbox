Return-Path: <linux-kernel-owner+w=401wt.eu-S1750896AbWLMXAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWLMXAG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWLMXAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:00:06 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:50965 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbWLMXAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:00:04 -0500
Date: Wed, 13 Dec 2006 15:00:03 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Chris Wright <chrisw@sous-sol.org>
cc: Jan Beulich <jbeulich@novell.com>, Dave Jones <davej@redhat.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Michael Buesch <mb@bu3sch.de>,
       Metathronius Galabant <m.galabant@googlemail.com>, stable@kernel.org,
       Michael Krufky <mkrufky@linuxtv.org>,
       Justin Forbes <jmforbes@linuxtx.org>, alan@lxorguk.ukuu.org.uk,
       "Theodore Ts'o" <tytso@mit.edu>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       torvalds@osdl.org, Chuck Wolber <chuckw@quantumlinux.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [stable] [PATCH 46/61] fix Intel RNG detection
In-Reply-To: <20061213203325.GL10475@sequoia.sous-sol.org>
Message-ID: <Pine.LNX.4.64.0612131458510.16018@twinlark.arctic.org>
References: <20061101053340.305569000@sous-sol.org> <20061101054343.623157000@sous-sol.org>
 <20061120234535.GD17736@redhat.com> <20061121022109.GF1397@sequoia.sous-sol.org>
 <4562D5DA.76E4.0078.0@novell.com> <20061122015046.GI1397@sequoia.sous-sol.org>
 <45640FF4.76E4.0078.0@novell.com> <20061124202729.GC29264@redhat.com>
 <456D56E7.76E4.0078.0@novell.com> <Pine.LNX.4.64.0612131145460.14936@twinlark.arctic.org>
 <20061213203325.GL10475@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006, Chris Wright wrote:

> * dean gaudet (dean@arctic.org) wrote:
> > just for the public record (i already communicated with Jan in private 
> > mail on this one)... i have a box which hangs hard starting at 2.6.18.2 
> > and 2.6.19 -- hangs hard during the intel hw rng tests (no sysrq 
> > response).  and the hang occurs prior to the printk so it took some 
> > digging to figure out which module was taking out the system.
> > 
> > Jan's patch gets the box past the hang... it seems like this should be in 
> > at least the next 2.6.19.x stable (and if there's going to be another 
> > 2.6.18.x stable then it should be included there as well).
> 
> Thanks for the data point.  I wonder if you get SMI and never come back.
> Do you boot with no_fwh_detect=1 or -1?

with the patch it boots perfectly without any command-line args.

without the patch it crashes after the "4" and before the "5" in this 
hacked up segment of the code:

        if (!(fwh_dec_en1_val & FWH_F8_EN_MASK))
                pci_write_config_byte(dev,
                                      fwh_dec_en1_off,
                                      fwh_dec_en1_val | FWH_F8_EN_MASK);
        if (!(bios_cntl_val &
              (BIOS_CNTL_LOCK_ENABLE_MASK|BIOS_CNTL_WRITE_ENABLE_MASK)))
                pci_write_config_byte(dev,
                                      bios_cntl_off,
                                      bios_cntl_val | BIOS_CNTL_WRITE_ENABLE_MASK);

        printk(KERN_INFO "intel-rng: 4\n");
        writeb(INTEL_FWH_RESET_CMD, mem);
        printk(KERN_INFO "intel-rng: 5\n");

-dean
