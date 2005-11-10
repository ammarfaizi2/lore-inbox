Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVKJSgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVKJSgM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 13:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVKJSgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 13:36:12 -0500
Received: from smtp-out.google.com ([216.239.45.12]:22433 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932126AbVKJSgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 13:36:10 -0500
Message-ID: <43739302.1080404@google.com>
Date: Thu, 10 Nov 2005 10:35:46 -0800
From: Arun Sharma <arun.sharma@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rohit.seth@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Expose SHM_HUGETLB in shmctl(id, IPC_STAT, ...)
References: <20051109184623.GA21636@sharma-home.net> <20051109222223.538309e4.akpm@osdl.org>
In-Reply-To: <20051109222223.538309e4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>> +	shp->shm_flags = (shmflg & (S_IRWXUGO | SHM_HUGETLB));
> [...]
> I dunno.  The manpage says:
> 
>        The highlighted fields in the member shm_perm can be set:
> 
>            struct ipc_perm {
>        ...
>                ushort mode;  /* lower 9 bits of access modes */
>        ...
>            };
> 
> So if an application used to do:
> 
> 	if (perm.mode == 0666)
> 
> it will now break, because we've gone and set bit 9 on hugetlb segments.

The man page on my system says:

               unsigned short mode;  /* Permissions + SHM_DEST and
                                         SHM_LOCKED flags */

I looked for a precendent before sending the patch and thought that 
SHM_LOCKED was a good one.

	-Arun
