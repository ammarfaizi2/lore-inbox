Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbTISXHI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 19:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbTISXHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 19:07:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:10386 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261818AbTISXFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 19:05:43 -0400
Date: Fri, 19 Sep 2003 16:02:15 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 2.6] sysfs_remove_dir
In-Reply-To: <20030915102127.GA1387@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0309191556281.950-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> sysfs_remove_dir() does not remove the contents of subdirs corresponding
> to the attribute groups of a kobject. The following patch fixes this by first
> removing the subdir contents and then removing thus emptied subdirs along
> with the other attribute files of the kobject and plugs the memory
> leakage resulting from orphan dentries.
> 
> I tested it by inserting and removing "dummy.o" network module and verifying
> that dentires corresponding to "statistics" attribute group are removed.

Sorry it's taken a while to reply, but I even now haven't had a chance to 
look that deep into this problem. I will say that this is the wrong 
approach to the problem. 

Upon initial inspection, it looks like it will do the right thing in all 
cases, except when a parent is removed before a child is (but we don't 
technically support that now). 

However, I'd like to move away from the automatic cleanup that sysfs was 
doing. attribute groups make it easier to clean up all the files that are 
created for an object when the object is removed. I would like to see that 
removal call inserted where necessary, instead of adding this complication 
to the sysfs core.

I intend to remove the automatic cleanup in sysfs_remove_dir(), but 
haven't gotten around to it.. 

Thanks,



	Pat

