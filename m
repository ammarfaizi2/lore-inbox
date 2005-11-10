Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVKJVlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVKJVlv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVKJVlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:41:51 -0500
Received: from smtp-out.google.com ([216.239.45.12]:62393 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932159AbVKJVlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:41:50 -0500
Message-ID: <4373BE8D.2070104@google.com>
Date: Thu, 10 Nov 2005 13:41:33 -0800
From: Arun Sharma <arun.sharma@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rohit.seth@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Expose SHM_HUGETLB in shmctl(id, IPC_STAT, ...)
References: <20051109184623.GA21636@sharma-home.net>	<20051109222223.538309e4.akpm@osdl.org>	<43739302.1080404@google.com> <20051110115941.1cbe1ae7.akpm@osdl.org>
In-Reply-To: <20051110115941.1cbe1ae7.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>The man page on my system says:
>>
>>               unsigned short mode;  /* Permissions + SHM_DEST and
>>                                         SHM_LOCKED flags */
>>
>>I looked for a precendent before sending the patch and thought that 
>>SHM_LOCKED was a good one.
>>
> 
> 
> hm, OK.   But an app could still do
> 
> 	if (mode == 0666|SHM_LOCKED)
> 

I'd argue that the app should really be doing (perm.mode & 0777 = 0666)

> 
> How important is this feature?

Without this feature, an application has no way to figure out if a given 
segment is hugetlb or not. Applications need to know this to be able to 
handle alignment issues properly.

Also, if the flag is exported via ipcs, the system administrator would 
have a better idea about how the hugetlb pages she configured on the 
system are getting used.

	-Arun
