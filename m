Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268511AbUJPFSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268511AbUJPFSv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 01:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268520AbUJPFSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 01:18:51 -0400
Received: from services.exanet.com ([212.143.73.102]:18051 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S268511AbUJPFSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 01:18:49 -0400
Message-ID: <4170AF35.7030806@exanet.com>
Date: Sat, 16 Oct 2004 07:18:45 +0200
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040930
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Becker <jlbec@evilplan.org>
CC: Yasushi Saito <ysaito@hpl.hp.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com,
       Janet Morgan <janetmor@us.ibm.com>
Subject: Re: [PATCH 1/2]  aio: add vectored I/O support
References: <416EDD19.3010200@hpl.hp.com> <20041016031301.GC17142@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041016031301.GC17142@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2004 05:18:48.0109 (UTC) FILETIME=[9D918DD0:01C4B33F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:

>On Thu, Oct 14, 2004 at 01:10:01PM -0700, Yasushi Saito wrote:
>  
>
>>This is a patch against 2.6.9-rc3-mm3 that add supports for vectored 
>>async I/O.  It adds two additional commands, IO_CMD_PREADV and 
>>IO_CMD_PWRITEV to libaio.h. The below is roughly what I did:
>>    
>>
>
>	How does this differ substantially from lio_listio() of each I/O
>range?  Does it have some significant performance win, or is it just
>aiming for a completeness that POSIX doesn't (to my knowledge) specify?
>
>  
>
It is a huge performance win, at least on the 2.4-based RHEL kernel. 
Large reads (~256K) using 4K iocbs are very slow on a large RAID, while 
after I coded a similar patch I got a substantial speedup.

I don't know the cause for the slowdown; maybe request merging only 
works for queued requests, and as the RAID has a large TCQ depth, 
requests didn't have much of a chance to queue in the kernel.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

