Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261776AbSJQEaG>; Thu, 17 Oct 2002 00:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261779AbSJQEaF>; Thu, 17 Oct 2002 00:30:05 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:17942 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261776AbSJQEaF>; Thu, 17 Oct 2002 00:30:05 -0400
Date: Thu, 17 Oct 2002 00:36:23 -0400
From: Doug Ledford <dledford@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: balance_dirty_pages broken
Message-ID: <20021017043623.GR8159@redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I don't know if it's balance_dirty_pages fault or some other
part of the kernel's fault, but it is broken here.  Failure mode is that
balance_dirty_pages would loop forever.  Reason it would loop forever is
because the ps struct had a negative entry for nr_dirty.  Breaking out of
the loop when ps.nr_dirty < 0 allows my machine to live.  Now, *why*
ps.nr_dirty is < 0 is another issue.  I have no clue.  Well, I have one 
clue, but no idea if it's valid or another red herring ;-)  Machine only 
has 256MB RAM, but has 4GB Highmem support enabled.  Don't know if that 
confuses the page counter stuff, having no actual highmem available.

If you need details about the machine, just ask.  This was easy for me to
trigger by running mke2fs on a scsi disk.  Would hit this every time.


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
