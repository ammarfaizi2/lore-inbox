Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWGETMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWGETMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWGETMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:12:16 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:34273 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S964924AbWGETMP
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:12:15 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17580.3569.985455.96657@gargle.gargle.HOWL>
Date: Wed, 5 Jul 2006 23:07:29 +0400
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: "Bret Towe" <magnade@gmail.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: moving dirty pages balancing to pdfludh entirely
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC06CF96@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC06CF96@mssmsx411>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

 > thread writes 1 byte only to disk it could happen that one has to write
 > all pages dirtied by all threads in the system and wait for it. The

See how wbc.nr_to_write is set up by balance_dirty_pages().

 > patch is tested and gets real benefit on real systems. A common system
 > work is performed in common system thread but not in casual user thread.

To understand the problem I am trying to attract your attention to,
imagine that MAX_PDFLUSH_THREADS equals 1. See what you get? BSD
(pagedaemon everybody waits upon). But Linux is not BSD, thankfully.

 > 
 > The patch does not fix other (bazillion - 1) fictitious freezing causes
 > for imaginary configurations.

Yes, and all the world is VAX (var. "my benchmarking suite"), as they
used to say. :-)

 > 
 > Leonid

Nikita.
