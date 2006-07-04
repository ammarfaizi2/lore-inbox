Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWGDNRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWGDNRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 09:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWGDNRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 09:17:16 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:19101 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932199AbWGDNRP
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 4 Jul 2006 09:17:15 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17578.26938.966185.725940@gargle.gargle.HOWL>
Date: Tue, 4 Jul 2006 17:12:26 +0400
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC0541F6@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC0541F6@mssmsx411>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > 
 > > With your patch, this work is done from
 > > pdflush, and won't be throttled by may_write_to_queue() check, thus
 > > increasing a risk of allocation failure.
 > ....
 > After Nikita Danilov agrees that
 > > pdflush is throttled through blk_congestion_wait(), but it is not
 > > throttled by writing dirty from the tail of inactive list
 > 
 > The 'writing dirty from the tail of inactive list' is asynchronous
 > writing and it is not applicable for throttling.

When queue is congested---it is, because meta-data (indirect blocks in
ext[23] case) have to be read in synchronously before page can be paged
out (see comment in mm/vmscan.c:pageout()).

But much more importantly: when direct reclaim skips writing dirty pages
from tail of the inactive list, it instead moves these pages to the head
of this list, and reclaims clean pages instead. These clean pages are
"hotter" than skipped dirty pages, and as has been checked many times
already, this is bad, because doing reclaim in LRU order is important.

 > 
 > Leonid

Nikita.
