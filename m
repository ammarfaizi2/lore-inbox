Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWGFGjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWGFGjH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 02:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWGFGjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 02:39:07 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:11673 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030221AbWGFGjF
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 02:39:05 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17580.44771.974069.737756@gargle.gargle.HOWL>
Date: Thu, 6 Jul 2006 10:34:11 +0400
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: "Bret Towe" <magnade@gmail.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC06CFE8@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC06CFE8@mssmsx411>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > > Some people do, should they suffer? :-)
 > You - yes. You have used that example as an argument incorrectly.

You are inhumane. :-) What is incorrect in assuming people may have many
devices?

 > 
 > > Not _all_, only nr_to_write of them
 > 	Yes. User thread writes all dirty pages in the system calling

No. User thread will not write _all_ dirty pages (if it does---it's a
bug in the current code and should be fixed):

balance_dirty_pages():
			if (pages_written >= write_chunk)
				break;		/* We've done our duty */

writeback_inodes():
		if (wbc->nr_to_write <= 0)
			break;

sync_sb_inodes():
		if (wbc->nr_to_write <= 0)
			break;

mpage_writepages():
			if (ret || (--(wbc->nr_to_write) <= 0))
				done = 1;

Everywhere down call-chain ->nr_to_write is checked.

 > writeback_inodes() and after it tests
 > 			if (pages_written >= write_chunk)

[rants skipped.]

 > 
 > Leonid

Nikita.
