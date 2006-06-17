Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWFQAjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWFQAjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 20:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWFQAjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 20:39:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52649 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751574AbWFQAjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 20:39:21 -0400
Date: Fri, 16 Jun 2006 17:39:07 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, viro@www.linux.org.uk, axboe@suse.de,
       zaitcev@redhat.com
Subject: Re: Sparse minor space in ub
Message-Id: <20060616173907.eaed13ae.zaitcev@redhat.com>
In-Reply-To: <20060616230929.GB31626@kroah.com>
References: <20060614235404.31b70e00.zaitcev@redhat.com>
	<20060616230929.GB31626@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006 16:09:29 -0700, Greg KH <greg@kroah.com> wrote:

> > -		8 = /dev/ubb		Second USB block device
> > +		 16 = /dev/ubb		Second USB block device

> I don't think that distros that have a static /dev will like this change
> at all :(

That was an erroneous change in the documentation, I'm sorry.
In reality, everything is fully compatible. This is with the new
driver:

[zaitcev@lembas ~]$ ls -l /dev/ub*
brw-r----- 1 root disk 180,   0 Jun 14 23:18 /dev/uba
brw-r----- 1 root disk 180,   1 Jun 14 23:18 /dev/uba1
brw-r----- 1 root disk 180,   8 Jun 14 23:18 /dev/ubb
brw-r----- 1 root disk 180,   9 Jun 14 23:18 /dev/ubb1
brw-r----- 1 root disk 180,  10 Jun 14 23:18 /dev/ubb2
brw-r----- 1 root disk 180,  13 Jun 14 23:18 /dev/ubb5
brw-r----- 1 root disk 180,  14 Jun 14 23:18 /dev/ubb6
brw-r----- 1 root disk 180,  15 Jun 14 23:18 /dev/ubb7
brw-r----- 1 root disk 180, 264 Jun 14 23:18 /dev/ubb8
brw-r----- 1 root disk 180, 265 Jun 14 23:18 /dev/ubb9
[zaitcev@lembas ~]$

 /*
- */
+ * The minor layout is:
+ *   19 - 11  0xFF800
+ *   10 -  8    0x700   Upper 3 bits of partition number
+ *    7 -  3     0xF8   Host index, or same as "id". UB_MAX_HOSTS fit here.
+ *    2 -  0      0x7   Lower 3 bits of partition number
+ */

-- Pete
