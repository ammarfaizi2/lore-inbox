Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWGEO2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWGEO2v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 10:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWGEO2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 10:28:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:34468 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964883AbWGEO2u convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 10:28:50 -0400
X-IronPort-AV: i="4.06,209,1149490800"; 
   d="scan'208"; a="60778867:sNHT54158013"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Date: Wed, 5 Jul 2006 18:28:47 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC06CF51@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcagHOJ13gdZQaZJSBWVbl2h+I6wNQAF7Rvg
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Jul 2006 14:28:44.0284 (UTC) FILETIME=[51D38BC0:01C6A03F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov writes:
> suppose you have more than MAX_PDFLUSH_THREADS
Do you consider that the drawback of the patch is in that the value
MAX_PDFLUSH_THREADS is not well known high or this limit is not deleted
at all? The limit could be deleted after patching because the line 
+	if (writeback_in_progress(bdi)) {
keeps off creating extra pdflush threads.

Leonid
-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com] 
Sent: Wednesday, July 05, 2006 2:17 PM
To: Ananiev, Leonid I
Cc: Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

Ananiev, Leonid I writes:
 > 
 > 
 > Nikita Danilov writes:
 > > Doing large amounts of writeback from pdflush threads makes
situation
 > > only worse: suppose you have more than MAX_PDFLUSH_THREADS devices
on
 > > the system, and large number of writing threads. If some devices
 > become
 > > congested, then *all* pdflush threads may easily stuck waiting on
 > queue
 > > congestion and there will be no IO going on against other devices.
 > This
 > > would be especially bad, if system is a mix of slow and fast
devices.
 > 
 > *all* pdflush threads may NOT waiting on single queue because
function

I specifically mentioned that multiple deviceS become congested: each
pdlush thread stuck on its own congested device, the rest of devices is
idle.

 > balance_dirty_pages() tests it:
 > 
 > 	if (writeback_in_progress(bdi))
 > 		return;		/* pdflush is already working this queue
 > */
 > 
 > > Yes, that was silly proposal. I think your patch contains very
useful
 > > idea, but it cannot be applied to all file systems. Maybe
 > > wait-for-pdflush can be made optional, depending on the file system
 > > type?
 > 
 > I suppose MS DOS was the last operating system which had considered
 > that parallelism is not applicable.

It also was the last file system that supported the only type of file
system, with asumptions about file system behaviour hard coded into its
design. :-)

 > 
 > Leonid

Nikita.
