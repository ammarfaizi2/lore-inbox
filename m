Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWHRRVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWHRRVq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWHRRVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:21:46 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:56510 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1030325AbWHRRVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:21:45 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] PCI: fix ICH6 quirks
Date: Fri, 18 Aug 2006 19:21:31 +0200
User-Agent: KMail/1.7.2
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-pci" <linux-pci@atrey.karlin.mff.cuni.cz>
References: <200608181650.41869.daniel.ritz-ml@swissonline.ch> <20060818185743.d16d2a98.khali@linux-fr.org>
In-Reply-To: <20060818185743.d16d2a98.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608181921.31798.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-08.tornado.cablecom.ch 1377;
	Body=5 Fuz1=5 Fuz2=5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 August 2006 18.57, Jean Delvare wrote:
> Hi Daniel,
> 
> > [PATCH] PCI: fix ICH6 quirks
> > 
> > - add the ICH6(R) LPC to the ICH6 ACPI quirks. currently only the ICH6-M is
> >   handled. [ PCI_DEVICE_ID_INTEL_ICH6_1 is the ICH6-M LPC, ICH6_0 is the ICH6(R) ]
> 
> No objection.
> 
> > - remove the wrong quirk calling asus_hides_smbus_lpc() for ICH6. the register
> >   modified in asus_hides_smbus_lpc() has a different meaning in ICH6.
> 
> My mistake :( Thanks for fixing it. Do you know if executing the old
> quirk on the ICH6 can cause trouble? In other words, should we backport
> this fix to 2.6.17.y?

the register it touches is part of the "root complex base address" register. so
changing it means the ICH6 decodes a different address range that could conflict
with something else...so yes, i think this is a 2.6.17.x candidate.

rgds
-daniel
