Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWGDMA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWGDMA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWGDMAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:00:55 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:59619 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932222AbWGDMAz
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 4 Jul 2006 08:00:55 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17578.22357.927206.189696@gargle.gargle.HOWL>
Date: Tue, 4 Jul 2006 15:56:05 +0400
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC0541AB@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC0541AB@mssmsx411>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
 > overload memory or IO is not for ext2 but for it sense. I'm working with

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
