Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbVHJQ2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbVHJQ2v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 12:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbVHJQ2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 12:28:51 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:532 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965195AbVHJQ2u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 12:28:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ed7IPv4dUc1pSnKFm6iB9rHDm1NNrGfR0yYJGCG+lyEyB+5Wf5NSHWL8PWLB9djox5bCprxaCh/t+pJNIpc7xQNGnLAGkAAf9SYSmwOg9YJ0mP5dMBQGiFSBUEXvR9NmEwirPxSIIF3f/wh43Zc8xpCvXTdXHerGFYx38Y64xlo=
Message-ID: <9e473391050810092835b3ef27@mail.gmail.com>
Date: Wed, 10 Aug 2005 12:28:49 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Dave Airlie <airlied@linux.ie>
Subject: Reusing the slab allocator
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need a memory manager for the VRAM on video cards. The most common
video cards have been 2MB and 512MB memory. Is it possible to reuse
the kernel slab allocator for managing this memory?

There are a couple of other odd constraints.
1) Some objects need to be allocated on boundaries, like 64B or even
1KB divisible addresses.
2) It would be best if the allocation bookkeeping data structures were
kept in system RAM. It may not be simple to access VRAM for read/write
of bookkeeping info. VRAM  can require slow PCI cycles or need high
mem mappings to access.

If possible I'd rather reuse an existing manager than write a new one.

-- 
Jon Smirl
jonsmirl@gmail.com
