Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUHBGOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUHBGOI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 02:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUHBGOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 02:14:08 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:43153 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S266291AbUHBGOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 02:14:02 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: =?ISO-8859-1?Q?Xu=E2n_Baldauf?= 
	<xuan--2004.08.01--linux-kernel--vger.kernel.org@baldauf.org>
Date: Mon, 2 Aug 2004 16:13:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16653.56223.866544.192240@cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software RAID 5 and crashes
In-Reply-To: message from  =?ISO-8859-1?Q?=20Xu=E2n?= Baldauf on Sunday August 1
References: <410CC397.6010509@baldauf.org>
	<16652.55805.900685.826943@cse.unsw.edu.au>
	<410CF7AA.2020604@baldauf.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday August 1, xuan--2004.08.01--linux-kernel--vger.kernel.org@baldauf.org wrote:
> 
> Unfortunately, it still does not make me satisfied, because: The 
> asymmetry of "all data blocks are correct, all parity blocks are 
> suspect" should be exploited.
> Consider 4 disks joined as RAID 5. There are 4 stripes (s0, s1, s2, s3), 
> where s3 is the parity stripe.
> 
>     * <>Example 0: s3,s2,s1 are written to disk, while s0 is not written
>       to disk for some reason. The system crashes. What happens at
>       reconstruction? s3 gets replaced by s0 XOR s1 XOR s2. s0 contains
>       old (read: wrong) data.

Define "wrong"....

Supposing it had actually crashed a couple of milliseconds earlier,
when none of the blocks had been written.  Is that any more wrong? or
less? 

When ever a machine crashes, it is wrong.  Whenever a machine crashes
you lose data.   A little more or a little bit less data being "lost"
in neither here nor there.  The only thing that it really makes sense
to worry about is consistency.  RAID5 provides all the consistency it
can, and leaves the rest up to higher layers.


>     * Example 1: s0,s1,s2 are written to disk, while s3 is not written
>       to disk for some reason. The system crashes. What happens at
>       reconstruction? s3 gets replaced by s0 XOR s1 XOR s2. s0 does not
>       contain old data. The stripe which contains the old data (s3) is
>       replaced anyway during reconstruction.
> 
> If we now consider, that for each disk (as member of a RAID 5), there 
> are parity stripes and there are data stripes. Doesn't it make sense to 
> prefer data blocks over partiy blocks when writing, just to get more 
> cases of "example 1" against "example 0" than without this
> preference?

No, and definitely not at the cost of delaying any writes or
complicating the code at all.

NeilBrown
