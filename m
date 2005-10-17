Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVJQUju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVJQUju (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVJQUju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:39:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932142AbVJQUjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:39:49 -0400
Date: Mon, 17 Oct 2005 13:38:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christopher Friesen <cfriesen@nortel.com>
cc: Eric Dumazet <dada1@cosmosbay.com>, dipankar@in.ibm.com,
       Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
In-Reply-To: <435408AD.4060505@nortel.com>
Message-ID: <Pine.LNX.4.64.0510171334581.3369@g5.osdl.org>
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org>
 <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com>
 <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com>
 <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com>
 <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com>
 <4353E6F1.8030206@cosmosbay.com> <Pine.LNX.4.64.0510171112040.3369@g5.osdl.org>
 <4353F7B5.1040101@cosmosbay.com> <Pine.LNX.4.64.0510171218490.3369@g5.osdl.org>
 <4353FDE8.8070909@cosmosbay.com> <Pine.LNX.4.64.0510171304580.3369@g5.osdl.org>
 <435408AD.4060505@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Christopher Friesen wrote:
> 
> Could this be related to the "rename14 LTP test with /tmp as tmpfs and HIGHMEM
> causes OOM-killer invocation due to zone normal exhaustion" issue?

Yes. 

You can try the current git tree, or just change "maxbatch" from 10 to 
10000 in your own tree, and see if it makes a difference.

I would not be surprised at all if this turns out to be the exact same 
issue, for the exact same reason.

Eric's patch is also likely to fix it (if the "maxbatch" change fixes it), 
since I suspect that under _practical_ load Eric's patch works fine.

The advantage of Eric's patch is that it shouldn't have any latency 
downsides, so Eric's is in many ways preferable to just increasing 
maxbatch. I just can't convince myself that it's really always going to 
fix the problem.

If somebody else can, holler.

		Linus
