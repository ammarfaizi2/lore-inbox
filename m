Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUHWLrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUHWLrm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 07:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUHWLrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 07:47:41 -0400
Received: from [213.188.213.77] ([213.188.213.77]:44755 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S263640AbUHWLql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 07:46:41 -0400
From: "Massimo Cetra" <mcetra@navynet.it>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Production comparison between 2.4.27 and 2.6.8.1
Date: Mon, 23 Aug 2004 13:46:33 +0200
Message-ID: <000001c48906$d70bf270$0600640a@guendalin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <4127F7FD.5060804@yahoo.com.au>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> > #**********************************************
> > It is my first experience with 2.6 branch kernels, because 
> i am trying 
> > to figure out if the tree is performing well to switch 
> everithing in 
> > production, so my ideas may be wrong...
> > 
> > Raid tests may be faked because of the overhead caused by 
> md sync (and 
> > probably raid is better on 2.6). However it seems that libsata has 
> > better performance on 2.4 (hdparm) xfs tests shows that 2.4 
> has better 
> > performance if compared to 2.6 and the difference, in my 
> opinion, is 
> > not linked on libsata better performance.
> > 
> > What is your opinion ?
> > What can I try to improve performance ?
> > 
> 
> I wouldn't worry too much about hdparm measurements. If you 
> want to test the streaming throughput of the disk, run dd 
> if=big-file of=/dev/null or a large write+sync.
> 
> Regarding your worse non-RAID XFS database results, try 
> booting 2.6 with elevator=deadline and test again. If yes, 
> are you using queueing (TCQ) on your disks?


Tried even with 2.6.8.1-mm and 2.6.8.1-ck
No performance improvement.

>From Documentation/block/as-iosched.txt i read:

#--------------------------------------
Attention! Database servers, especially those using "TCQ" disks should
investigate performance with the 'deadline' IO scheduler. Any system
with high
disk performance requirements should do so, in fact.

If you see unusual performance characteristics of your disk systems, or
you
see big performance regressions versus the deadline scheduler, please
email
me. Database users don't bother unless you're willing to test a lot of
patches
from me ;) its a known issue.
#--------------------------------------

So it's probably known that 2.6 performance with databases and heavy HD
access is an issue.
I don't believe that 2.6.x tree is performing as well as 2.4.x(-lck) on
server tasks.

Is this issue being analyzed ?
Should we hope in an improvement sometime?
Or I'll have to use 2.4 to have good performance ?

Max




