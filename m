Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUJETRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUJETRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUJETRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:17:17 -0400
Received: from fmr12.intel.com ([134.134.136.15]:8578 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S263664AbUJETRA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:17:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] 2.6 SGI Altix I/O code reorganization
Date: Tue, 5 Oct 2004 12:16:42 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0221C900@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6 SGI Altix I/O code reorganization
Thread-Index: AcSrDa4sRPSz/7svTcGIlp5qXrmJWwAADz4w
From: "Luck, Tony" <tony.luck@intel.com>
To: <cngam@sgi.com>, "Matthew Wilcox" <matthew@wil.cx>,
       "Grant Grundler" <iod00d@hp.com>
Cc: "Jesse Barnes" <jbarnes@engr.sgi.com>, "Pat Gefre" <pfg@sgi.com>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 05 Oct 2004 19:16:43.0102 (UTC) FILETIME=[D9416FE0:01C4AB0F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Yes, after looking at Grant's review/suggestion, we found that we can 
>actually just use raw_pci_ops.  This will work well for us.  We have 
>incoorporated this change.  No changes in pci/pci.c needed.

Good.  Let's try to make some forward progress here.  I'd like
to see the patches broken into a sequence something like this:

1) Add new interfaces to header files to support any new API
   needed by new files
2) Create all the new files (plain copies of old files where
   a move is involved).
3) Functional changes to copied files.
4) Whitespace cleanup of copied files.
5) Point Makefiles to new files
6) Delete all the old/unused files.
7) Delete any API in headers that were only used by old files.

We'll need to coordinate with some other maintainrs for
drivers/pci/hotplug/Kconfig and drivers/scsi/qla1280.c,
but I'm ok with running all the other parts through the
ia64 tree.

This follows the usual guidelines of a sequence of steps where
the system is buildable+usable at each stage.

-Tony
