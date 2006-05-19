Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWESTgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWESTgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 15:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWESTgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 15:36:47 -0400
Received: from citi.umich.edu ([141.211.133.111]:38290 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932260AbWESTgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 15:36:46 -0400
Message-ID: <446E1E4D.7050800@citi.umich.edu>
Date: Fri, 19 May 2006 15:36:45 -0400
From: Chuck Lever <cel@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Organization: Center for Information Technology Integration
User-Agent: Thunderbird 1.5.0.2 (Macintosh/20060308)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: cel@netapp.com, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH 5/6] nfs: check all iov segments for correct memory access
 rights
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>	<20060519180036.3244.70897.stgit@brahms.dsl.sfldmi.ameritech.net> <20060519112231.5ed3d565.akpm@osdl.org>
In-Reply-To: <20060519112231.5ed3d565.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> +		if (unlikely(!access_ok(type, buf, len))) {
>> +			retval = -EFAULT;
>> +			goto out;
>> +		}
> 
> Now what's up here?  Why does NFS, at this level, care about the page's
> virtual address?  get_user_pages() will handle that?

I guess I'm not clear on what behavior is desired for scatter/gather if 
one of the segments in an iov fails.

If one of the iov's will cause an EFAULT, how is that reported back to 
the application, and what happens to the I/O being requested in the 
other segments of the vector?  When do we use an "all or nothing" 
semantic, and when is it OK for some segments to fail?

-- 
corporate:	cel at netapp dot com
personal:	chucklever at bigfoot dot com
