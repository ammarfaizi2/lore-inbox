Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269066AbUJQGZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269066AbUJQGZj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 02:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269068AbUJQGZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 02:25:39 -0400
Received: from services.exanet.com ([212.143.73.102]:56547 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S269066AbUJQGZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 02:25:37 -0400
Message-ID: <4172105D.3020707@exanet.com>
Date: Sun, 17 Oct 2004 08:25:33 +0200
From: Avi Kivity <avi@exanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Becker <jlbec@evilplan.org>
CC: Yasushi Saito <ysaito@hpl.hp.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com,
       Janet Morgan <janetmor@us.ibm.com>
Subject: Re: [PATCH 1/2]  aio: add vectored I/O support
References: <416EDD19.3010200@hpl.hp.com> <20041016031301.GC17142@parcelfarce.linux.theplanet.co.uk> <4170AF35.7030806@exanet.com> <20041016053721.GD17142@parcelfarce.linux.theplanet.co.uk> <4170DF18.50004@exanet.com> <20041016162836.GG17142@parcelfarce.linux.theplanet.co.uk> <41715A5F.2060006@exanet.com> <20041017001409.GH17142@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041017001409.GH17142@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2004 06:25:36.0054 (UTC) FILETIME=[1CE72D60:01C4B412]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:

>>I think what happened was that the number of iocbs submitted (64 iocbs 
>>of 4K each) did not merge because the device queue depth was very large; 
>>no queuing occured because (I imagine) merging happens while a request 
>>is waiting for disk readiness.
>>    
>>
>
>	Why did you submit 64 iocbs of 4K?  Was every page virtually
>discontiguous, or did you arbitrarily decide to create a worst-case?
>  
>
The application (a userspace filesystem with its own cache) manages 
memory in 4K pages, but can perform much larger I/Os, for example during 
readahead and after merging writes. After a very short while memory is 
completely fragmented.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

