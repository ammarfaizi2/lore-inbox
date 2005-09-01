Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVIAPVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVIAPVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVIAPVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:21:21 -0400
Received: from fmr18.intel.com ([134.134.136.17]:30660 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932249AbVIAPVU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:21:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC/PATCH]reconfigure MSI registers after resume
Date: Thu, 1 Sep 2005 08:20:50 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502409A1201A@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH]reconfigure MSI registers after resume
thread-index: AcWui6U/IkAGxTgySmius/YA36ZZAwAeqAEQ
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>, "Li, Shaohua" <shaohua.li@intel.com>
Cc: "lkml" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>
X-OriginalArrivalTime: 01 Sep 2005 15:20:51.0794 (UTC) FILETIME=[BD267320:01C5AF08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 31, 2005 2:44 PM Greg KH wrote:
>>On Thu, Aug 18, 2005 at 01:35:46PM +0800, Shaohua Li wrote:
>> Hi,
>> It appears pci_enable_msi doesn't reconfigure msi registers if it
>> successfully look up a msi for a device. It assumes the data and
address
>> registers unchanged after calling pci_disable_msi. But this isn't
always
>> true, such as in a suspend/resume circle. In my test system, the
>> registers unsurprised become zero after a S3 resume. This patch fixes
my
>> problem, please look at it. MSIX might have the same issue, but I
>> haven't taken a close look.

> Tom, any comments on this?

In the cases of suspend/resume, a device driver needs to restore its PCI
configuration space registers, which include the MSI/MSI-X capability
structures if a device uses MSI/MSI-X. I think reconfiguring MSI
data/address each time a driver calls pci_enable_msi may not be
necessary.

Thanks,
Tom
