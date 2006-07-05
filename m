Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWGEKWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWGEKWG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 06:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWGEKWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 06:22:06 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:2245 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S964791AbWGEKWF
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 5 Jul 2006 06:22:05 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17579.37291.562610.316072@gargle.gargle.HOWL>
Date: Wed, 5 Jul 2006 14:17:15 +0400
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH]  mm: moving dirty pages balancing to pdfludh entirely
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC06CD4C@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC06CD4C@mssmsx411>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananiev, Leonid I writes:
 > 
 > 
 > Nikita Danilov writes:
 > > Doing large amounts of writeback from pdflush threads makes situation
 > > only worse: suppose you have more than MAX_PDFLUSH_THREADS devices on
 > > the system, and large number of writing threads. If some devices
 > become
 > > congested, then *all* pdflush threads may easily stuck waiting on
 > queue
 > > congestion and there will be no IO going on against other devices.
 > This
 > > would be especially bad, if system is a mix of slow and fast devices.
 > 
 > *all* pdflush threads may NOT waiting on single queue because function

I specifically mentioned that multiple deviceS become congested: each
pdlush thread stuck on its own congested device, the rest of devices is
idle.

 > balance_dirty_pages() tests it:
 > 
 > 	if (writeback_in_progress(bdi))
 > 		return;		/* pdflush is already working this queue
 > */
 > 
 > > Yes, that was silly proposal. I think your patch contains very useful
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
