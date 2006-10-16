Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422853AbWJPTdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422853AbWJPTdq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422855AbWJPTdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:33:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:8672 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422853AbWJPTdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:33:45 -0400
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
	configfs
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Matt Helsley <matthltc@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <20061014000951.GC2747@ca-server1.us.oracle.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	 <20061010215808.GK7911@ca-server1.us.oracle.com>
	 <1160527799.1674.91.camel@localhost.localdomain>
	 <20061011012851.GR7911@ca-server1.us.oracle.com>
	 <20061011220619.GB7911@ca-server1.us.oracle.com>
	 <1160619516.18766.209.camel@localhost.localdomain>
	 <20061012070826.GO7911@ca-server1.us.oracle.com>
	 <1160782659.18766.549.camel@localhost.localdomain>
	 <20061014000951.GC2747@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 16 Oct 2006 12:33:41 -0700
Message-Id: <1161027221.6389.135.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 17:09 -0700, Joel Becker wrote:
> On Fri, Oct 13, 2006 at 04:37:38PM -0700, Matt Helsley wrote:
> > > 	Sure it works.  You have one per resource group.  In
> > > resource_group_make_object(), you sysfs_mkdir() the sysfs file.  There
> > 
> > 	That's the easy part. Next we need to make the pid attribute whenever a
> > new task is created. And delete it when the task dies. And move it
> > around whenever it changes groups. Is there rename() support in /sys? If
> > not, would changes to allow rename() be acceptable (I'm worried it would
> > impact alot of assumptions made in the existing code)?
> 
> 	No, you don't create a pid attribute per task.  The sysfs file
> is literally your large attribute.  So, instead of echoing a new pid to
> "/sys/kernel/config/ckrm/group1/pids", you echo to
> "/sys/ckrm/group1/pids".  To display them all, you just cat
> "/sys/ckrm/group1/pids".  It's exactly like the file you want in
> configfs, just located in a place where it is allowed.

>From what I see, sysfs also has the PAGESIZE limitation. If that _is_
the case, then moving to sysfs does not help us any. Correct me if I am
wrong.

Won't we have the same arguments that we have now ?

<snip>

> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


