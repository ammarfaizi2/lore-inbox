Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265879AbUHALy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUHALy4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 07:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbUHALyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 07:54:55 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:33763 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S265879AbUHALyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 07:54:51 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: =?ISO-8859-1?Q?Xu=E2n_Baldauf?= 
	<xuan--2004.08.01--linux-kernel--vger.kernel.org@baldauf.org>
Date: Sun, 1 Aug 2004 21:54:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16652.55805.900685.826943@cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software RAID 5 and crashes
In-Reply-To: message from  =?ISO-8859-1?Q?=20Xu=E2n?= Baldauf on Sunday August 1
References: <410CC397.6010509@baldauf.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday August 1, xuan--2004.08.01--linux-kernel--vger.kernel.org@baldauf.org wrote:
> Hello,
> 
> I have been extensively searching for documentation and mailing lists, 
> but was yet unable to answer this question:
> 
> Does Linux software RAID 5 (or RAID 4) do ordered writes? (data stripes 
> first, then parity stripes)

No, it doesn't impose any ordering between writes of parity and data
in the same stripe, and it would not have any material effect on any
outcomes if it did.

> 
> Because if the writes are not ordered, parity stripes could be written 
> before data stripes. If the system crashes at this time, reconstruction 
> will  try to reconstruct the parity stripes by using the wrong (old) 
> data stripes.
> 
> If the writes are ordered, crashes after the write of the data stripe 
> but before the write to the parity stripe do not harm.

When the system crashes, the RAID5 manager assume that all data blocks
are correct and all parity blocks are suspect.  It checks all parity
blocks against corresponding data and corrects  those that don't
match.
If a write is "in progress" - i.e. it has started but not all data and
parity has been written, then either the "old" data or the "new" data
are equally correct.  The only thing that needs to be guaranteed after
a crash, and the only thing that can be guaranteed, is that any data
that has been reported as "safe-in-storage" really is safe.  That is
all journalling filesystems, or anything else, assume.

Hope that helps.

NeilBrown

