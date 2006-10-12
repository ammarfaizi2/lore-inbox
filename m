Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWJLVoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWJLVoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWJLVoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:44:34 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:40669 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751109AbWJLVod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:44:33 -0400
Date: Thu, 12 Oct 2006 14:44:20 -0700
From: Paul Jackson <pj@sgi.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: matthltc@us.ibm.com, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
 configfs
Message-Id: <20061012144420.089f3dce.pj@sgi.com>
In-Reply-To: <20061012070826.GO7911@ca-server1.us.oracle.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	<20061010203511.GF7911@ca-server1.us.oracle.com>
	<6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	<20061010215808.GK7911@ca-server1.us.oracle.com>
	<1160527799.1674.91.camel@localhost.localdomain>
	<20061011012851.GR7911@ca-server1.us.oracle.com>
	<20061011220619.GB7911@ca-server1.us.oracle.com>
	<1160619516.18766.209.camel@localhost.localdomain>
	<20061012070826.GO7911@ca-server1.us.oracle.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And what if you decide to
> change it from "<pid>\n" to "<pid> <tgid>\n" per line? 

I think that's a good argument for never changing the format of one
of these files, rather than a good argument for against a vector of
scalars of identical type and purpose.

And I'd agree that we should not use multiple values per file to
represent a structure either - so I'd agree that we should not allow
"<pid> <tgid>\n" in the first place.

In the cpuset file system:
 1) There is one value, or one vector of equivalent scalar values, per file.
 2) Once released into the wild, a file never changes what it does or how
    it looks.
 3) It's ok to add new files.
 4) But, at least in the case of cpusets, not ok to add directories, as
    the file system represents one directory per one cpuset.  No other
    directories not representing cpusets are allowed.

This configfs flap feels to me like someone slightly overgeneralized
the lesson to be learned from previous problems displaying entire,
evolving, structures in a single file, and then is being a bit over
zealous enforcing the resulting rule.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
