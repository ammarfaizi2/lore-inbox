Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbUCMDj0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 22:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbUCMDj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 22:39:26 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:2007 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262821AbUCMDjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 22:39:23 -0500
Message-ID: <40528383.10305@sgi.com>
Date: Fri, 12 Mar 2004 21:44:03 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lse-tech@lists.sourceforge.net,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Hugetlbpages in very large memory machines.......
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've run into a scaling problem using hugetlbpages in very large memory machines, e. g. machines 
with 1TB or more of main memory.  The problem is that hugetlbpage pages are not faulted in, rather 
they are zeroed and mapped in in by hugetlb_prefault() (at least on ia64), which is called in 
response to the user's mmap() request.  The net is that all of the hugetlb pages end up being 
allocated and zeroed by a single thread, and if most of the machine's memory is allocated to hugetlb 
pages, and there is 1 TB or more of main memory, zeroing and allocating all of those pages can take 
a long time (500 s or more).

We've looked at allocating and zeroing hugetlbpages at fault time, which would at least allow 
multiple processors to be thrown at the problem.  Question is, has anyone else been working on
this problem and might they have prototype code they could share with us?

Thanks,
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

