Return-Path: <linux-kernel-owner+w=401wt.eu-S932268AbXAIRRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbXAIRRc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbXAIRRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:17:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40175 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932268AbXAIRRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:17:30 -0500
Message-ID: <45A3CE24.7080706@sgi.com>
Date: Tue, 09 Jan 2007 11:17:24 -0600
From: Michael Reed <mdr@sgi.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: Peter Staubach <staubach@redhat.com>
CC: Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org,
       hugh@veritas.com, hch@infradead.com, kenneth.w.chen@intel.com,
       akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] support O_DIRECT in tmpfs/ramfs
References: <Pine.LNX.4.64.0701081729100.2747@localhost.localdomain> <45A3B529.80402@redhat.com>
In-Reply-To: <45A3B529.80402@redhat.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Staubach wrote:
> Hua Zhong wrote:
>> Hi,
>>
>> A while ago there was a discussion about supporting direct-io on tmpfs.
>>
>> Here is a simple patch that does it.
>>
>> 1. A new fs flag FS_RAM_BASED is added and the O_DIRECT flag is ignored
>>    if this flag is set (suggestions on a better name?)
>>
>> 2. Specify FS_RAM_BASED for tmpfs and ramfs.
>>
>> 3. When EINVAL is returned only a fput is done. I changed it to go
>>    through cleanup_all. But there is still a cleanup problem:
>>
>>   If a new file is created and then EINVAL is returned due to O_DIRECT,
>>   the file is still left on the disk. I am not exactly sure how to fix
>>   it other than adding another fs flag so we could check O_DIRECT
>>   support at a much earlier stage. Comments on how to fix it?
> 
> This would seem to create two different sets of O_DIRECT semantics,
> wouldn't it?  I think that it would be possible to develop an application
> using one of these FS_RAM_BASED file systems as the testbed, but then be
> surprised when the application failed to work on other file systems such
> as ext3.

As I'm ignorant with regard to what is needed for "compliant"
support of O_DIRECT on tmpfs, what are the issues with actually implementing
the proper semantics, including the alignment and any transfer length
restrictions?

My $.02 is that the implementation should be fully compliant with the
current semantics or it shouldn't be implemented.  And I think it should
be implemented.

Mike

> 
>       ps
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
