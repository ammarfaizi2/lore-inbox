Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVF2QKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVF2QKQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVF2QH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:07:57 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:2359 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S261543AbVF2QGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:06:22 -0400
X-IronPort-AV: i="3.93,242,1115017200"; 
   d="scan'208"; a="284267492:sNHT28748864"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 11/16] IB uverbs: add mthca mmap support
X-Message-Flag: Warning: May contain useful information
References: <2005628163.o84QGfsM7oMSy0oU@cisco.com>
	<2005628163.gtJFW6uLUrGQteys@cisco.com>
	<20050628170553.00a14a29.akpm@osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 29 Jun 2005 09:06:20 -0700
Message-ID: <52y88tf8qr.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> What's the thinking behind the VM_DONTCOPY there?

I think that was my paranoia about something like a process doing a
fork, the original process exiting, and the new process having page
still mapped even though the file has been released.  This is bad
because then we could map the same page to a different process and
have them collide.  But it seems that there will always be a reference
to the underlying struct file as long as someone has this mapping, so
I don't really need to worry about this and the VM_DONTCOPY can go.

    Andrew> What's actually being mapped here?  Hardware?  If so, is
    Andrew> VM_IO not needed?

Yes, this is a page from a PCI BAR.  However, we use remap_pfn_range()
to map the page, which sets VM_IO already.

 - R.
