Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWGETu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWGETu6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWGETu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:50:57 -0400
Received: from mga03.intel.com ([143.182.124.21]:57744 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964986AbWGETu5 convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:50:57 -0400
X-IronPort-AV: i="4.06,210,1149490800"; 
   d="scan'208"; a="61659933:sNHT28291137"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Date: Wed, 5 Jul 2006 23:50:51 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC06CFA6@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcagZ7TgMuclfHi7Qxuc3JbdaqZlNQAAcUMg
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Bret Towe" <magnade@gmail.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Jul 2006 19:50:54.0823 (UTC) FILETIME=[53B9B770:01C6A06C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov writes:
> Exactly to the contrary: as I explained to you, if you have more
devices
> than pdflush threads
I do not believe that Bret Towe has more devices than
MAX_PDFLUSH_THREADS=8.

> See how wbc.nr_to_write is set up by balance_dirty_pages().
It is number TO write but I said about number after what user has to
write-out all dirty pages. 

> imagine that MAX_PDFLUSH_THREADS equals 1
Imagine that CONFIG_NR_CPUS=1 for smp.
Kernel has a lot of "big enough" constants.

Leonid
-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com] 
Sent: Wednesday, July 05, 2006 11:07 PM
To: Ananiev, Leonid I
Cc: Bret Towe; Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

Ananiev, Leonid I writes:
 > 
 > Bret Towe writes:
 > > if say some gtk app wants to write to disk it will freeze
 > > until the usb hd is completely done
 > 
 > The proposed patch fixes one real cause of long latency: if a user

Exactly to the contrary: as I explained to you, if you have more devices
than pdflush threads, your patch will result in all system doing IO as
slow as slowest devices in the system. In addition, if you have more
than MAX_PDFLUSH_THREADS processors, some of them cannot be used to
concurrently perform writeback.

 > thread writes 1 byte only to disk it could happen that one has to
write
 > all pages dirtied by all threads in the system and wait for it. The

See how wbc.nr_to_write is set up by balance_dirty_pages().

 > patch is tested and gets real benefit on real systems. A common
system
 > work is performed in common system thread but not in casual user
thread.

To understand the problem I am trying to attract your attention to,
imagine that MAX_PDFLUSH_THREADS equals 1. See what you get? BSD
(pagedaemon everybody waits upon). But Linux is not BSD, thankfully.

 > 
 > The patch does not fix other (bazillion - 1) fictitious freezing
causes
 > for imaginary configurations.

Yes, and all the world is VAX (var. "my benchmarking suite"), as they
used to say. :-)

 > 
 > Leonid

Nikita.
