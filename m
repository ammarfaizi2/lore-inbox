Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932847AbWJGUoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847AbWJGUoK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 16:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932843AbWJGUoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 16:44:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932844AbWJGUoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 16:44:06 -0400
Date: Sat, 7 Oct 2006 13:44:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] mm: fault vs invalidate/truncate race fix
Message-Id: <20061007134401.a28b7735.akpm@osdl.org>
In-Reply-To: <20061007105842.14024.85533.sendpatchset@linux.site>
References: <20061007105758.14024.70048.sendpatchset@linux.site>
	<20061007105842.14024.85533.sendpatchset@linux.site>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Oct 2006 15:06:21 +0200 (CEST)
Nick Piggin <npiggin@suse.de> wrote:

> Fix the race between invalidate_inode_pages and do_no_page.

- In do_no_page() there's a `goto retry' where we appear to have
  forgotten to (conditionally) unlock the page.

- In do_no_page() the COW-break code seem to have forgotten to
  (conditionally) unlock the page which it just COWed?

- In do_no_page(), the unlock_page() which _is_ there doesn't test
  VM_CAN_INVALIDATE before deciding to unlock the page.

I have a bad feeling that I'm not getting the point here...

<looks>

Ah, it appears you've fixed at least some of these things in the next
patch.  Tricky.

