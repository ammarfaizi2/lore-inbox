Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWGDNHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWGDNHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 09:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWGDNHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 09:07:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:37639 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932144AbWGDNHg convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 09:07:36 -0400
X-IronPort-AV: i="4.06,204,1149490800"; 
   d="scan'208"; a="93041613:sNHT18913748"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Date: Tue, 4 Jul 2006 17:07:21 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC0541F7@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
Thread-Index: AcafYYOHQnPXIiwHTIKgRBTi8xxa8AACTYPw
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Jul 2006 13:07:33.0667 (UTC) FILETIME=[D04C9F30:01C69F6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov writes:

> With your patch, this work is done from
> pdflush, and won't be throttled by may_write_to_queue() check, thus
> increasing a risk of allocation failure.
....
After Nikita Danilov agrees that
> pdflush is throttled through blk_congestion_wait(), but it is not
> throttled by writing dirty from the tail of inactive list

The 'writing dirty from the tail of inactive list' is asynchronous
writing and it is not applicable for throttling.

Leonid 
 

-----Original Message-----
From: Nikita Danilov [mailto:nikita@clusterfs.com] 
Sent: Tuesday, July 04, 2006 3:56 PM
To: Ananiev, Leonid I
Cc: Linux Kernel Mailing List
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh
entirely

Ananiev, Leonid I writes:
 > Nikita Danilov wtites:
 > >> Pdflush thread functions as before patching. Pdflush tends to make
 > pages
 > >> un-dirty without overload memory or IO and it is not need to let
 > pdflush
 > 
 > > This assumption is valid for ext2
 > 
 > The assumption that pdflush should to make pages un-dirty without
 > overload memory or IO is not for ext2 but for it sense. I'm working
with

I am not sure what "sense" is being referred to. Some file systems do
allocate a lot of memory in ->writepages().

ext3 is still in the same ball-park as ext2.

 > ext3. A lot of work it does while writepages(). pdflush is throttled:
 > while vmscan have sorted 32 page for paging-out it calls
 > blk_congestion_wait() nevertheless had it put one of 32 page into
 > congested queue or had not. pdflush is throttled.

pdflush is throttled through blk_congestion_wait(), but it is not
throttled by writing dirty from the tail of inactive list, while
scanning for memory. This destroys LRU ordering.

 > 
 > Leonid
 >  

Nikita.
