Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVJRP4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVJRP4c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 11:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVJRP4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 11:56:32 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:44980 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1750853AbVJRP4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 11:56:31 -0400
Message-ID: <43551B07.6020907@nortel.com>
Date: Tue, 18 Oct 2005 09:55:51 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Linus Torvalds <torvalds@osdl.org>, Eric Dumazet <dada1@cosmosbay.com>,
       Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
References: <4353CADB.8050709@cosmosbay.com> <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com> <4353E6F1.8030206@cosmosbay.com> <Pine.LNX.4.64.0510171112040.3369@g5.osdl.org> <4353F7B5.1040101@cosmosbay.com> <Pine.LNX.4.64.0510171218490.3369@g5.osdl.org> <4353FDE8.8070909@cosmosbay.com> <Pine.LNX.4.64.0510171304580.3369@g5.osdl.org> <435408AD.4060505@nortel.com> <20051017202419.GG13665@in.ibm.com>
In-Reply-To: <20051017202419.GG13665@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Oct 2005 15:55:54.0697 (UTC) FILETIME=[6BFE3B90:01C5D3FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> On Mon, Oct 17, 2005 at 02:25:17PM -0600, Christopher Friesen wrote:

>>Could this be related to the "rename14 LTP test with /tmp as tmpfs and 
>>HIGHMEM causes OOM-killer invocation due to zone normal exhaustion" issue?

> Could very well be. Chris, could you please try booting
> with rcupdate.maxbatch=10000 and see if the problem goes away ?

And sure enough, that fixes it.  The dcache slab usage maxes out at 
around 11MB rather than consuming all of zone normal.

Is there any downside to this option?

Chris
