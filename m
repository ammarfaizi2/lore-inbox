Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWGEUKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWGEUKp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWGEUKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:10:44 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:19162 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S964977AbWGEUKo
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:10:44 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17580.7078.914228.48864@gargle.gargle.HOWL>
Date: Thu, 6 Jul 2006 00:05:58 +0400
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: "Bret Towe" <magnade@gmail.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC06CFA6@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC06CFA6@mssmsx411>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananiev, Leonid I writes:
 > Nikita Danilov writes:
 > > Exactly to the contrary: as I explained to you, if you have more
 > devices
 > > than pdflush threads
 > I do not believe that Bret Towe has more devices than
 > MAX_PDFLUSH_THREADS=8.

Some people do, should they suffer? :-)

 > 
 > > See how wbc.nr_to_write is set up by balance_dirty_pages().
 > It is number TO write but I said about number after what user has to
 > write-out all dirty pages. 

Not _all_, only nr_to_write of them:

			if (pages_written >= write_chunk)
				break;		/* We've done our duty */

 > 
 > > imagine that MAX_PDFLUSH_THREADS equals 1
 > Imagine that CONFIG_NR_CPUS=1 for smp.
 > Kernel has a lot of "big enough" constants.

Then why introduce more of them?

In current design each thread is responsible for write-out. This means
that write-out concurrency level scales together with the number of
writers. You propose to limit write-out concurrency by
MAX_PDFLUSH_THREADS. Obviously this is an artificial limit that will be
sub-optimal sometimes.

 > 
 > Leonid

Nikita.
