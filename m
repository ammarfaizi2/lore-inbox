Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270816AbTHLRcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 13:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270818AbTHLRcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 13:32:43 -0400
Received: from fmr06.intel.com ([134.134.136.7]:58581 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S270816AbTHLRcm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 13:32:42 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Updated MSI Patches
Date: Tue, 12 Aug 2003 10:32:39 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024015416F6@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updated MSI Patches
Thread-Index: AcNgdINGIzr3UbJrQb6ybAY+0LD/YwAgq6Tw
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>, "Greg KH" <greg@kroah.com>
Cc: "long" <tlnguyen@snoqualmie.dp.intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Aug 2003 17:32:40.0087 (UTC) FILETIME=[BAA1F270:01C360F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There are two types of MSI capable devices: one supports the MSI 
> > capability structure and other supports the MSI-X capability structure.
> > The patches provide two APIs msix_alloc_vectors/msix_free_vectors for 
> > only devices, which support the MSI-X capability structure, to request
> > for additional messages. By default, each MSI/MSI-X capable device 
> > function is allocated with one vector for below reasons:
> > - To achieve a backward compatibility with existing drivers if possible.
> > - Due to the current implementation of vector assignment, all devices 
> >   that support the MSI-capability structure work with no more than one 
> >   allocated vector.
> > - The hardware devices, which support the MSI-X capability structure, 
> >   may indicate the maximum capable number of vectors supported (32 
> >   vectors as example). However, the device drivers may require only 
> >   four. With provided APIs, the optimization of MSI vector allocation 
> >   is achievable.

> IMO Multiplexing would be preferred, we can't be allocating that many 
> vectors for one device/device driver
All pre-assigned vectors to all enabled IOxAPIC(s) are reserved.
Allocating additional vectors to MSI-X driver is determined based on the
available vectors, which must be greater than the number of vectors requested
by MSI-X driver.

Thanks,
Long
