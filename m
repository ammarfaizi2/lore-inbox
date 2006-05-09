Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWEIPqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWEIPqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWEIPqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:46:13 -0400
Received: from palrel11.hp.com ([156.153.255.246]:59544 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S1750837AbWEIPqM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:46:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH 01/35] Add XEN config options and disableunsupported config options.
Date: Tue, 9 May 2006 08:46:10 -0700
Message-ID: <516F50407E01324991DD6D07B0531AD5B249FE@cacexc12.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 01/35] Add XEN config options and disableunsupported config options.
Thread-Index: AcZzaFckWAJUIlQ9S0mJTyReIA0WjgAFogaQ
From: "Magenheimer, Dan (HP Labs Fort Collins)" <dan.magenheimer@hp.com>
To: "Christian Limpach" <Christian.Limpach@cl.cam.ac.uk>,
       "Adrian Bunk" <bunk@stusta.de>
Cc: "Chris Wright" <chrisw@sous-sol.org>, <virtualization@lists.osdl.org>,
       <xen-devel@lists.xensource.com>, <linux-kernel@vger.kernel.org>,
       "Ian Pratt" <ian.pratt@xensource.com>
X-OriginalArrivalTime: 09 May 2006 15:46:11.0356 (UTC) FILETIME=[B226B5C0:01C6737F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  config HZ
> > >  	int
> > > -	default 100 if HZ_100
> > > +	default 100 if HZ_100 || XEN
> > >  	default 250 if HZ_250
> > >  	default 1000 if HZ_1000
> > >...
> > 
> > Why?
> 
> Because the hypervisor sends timer interrupts to the guest at a rate
> of 100 Hz while the guest is running.  We might add support to have
> an adjustable rate in the future but so far 100 Hz has worked quite
> well for us.

It seems to me that a guest should be telling a hypervisor how
frequently it needs a timer interrupt, not vice versa.  And
it should be possible for different guests to have different HZ.

Given all the lkml debate on HZ over the last few years
and the compromise solution (configurable HZ_nnn), forcing
100 Hz on the guest appears to be a step backwards.

(BTW, Xen/ia64 honors all guest's configured HZ.)
