Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269096AbUINBN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269096AbUINBN5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 21:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269098AbUINBN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 21:13:56 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:47302 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S269096AbUINBNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 21:13:54 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "J.A. Magallon" <jamagallon@able.es>
Date: Tue, 14 Sep 2004 11:13:45 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16710.17865.374399.841645@cse.unsw.edu.au>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems with raid in 2.6.9-rc1-mm4
In-Reply-To: message from J.A. Magallon on Monday September 13
References: <1095078447l.13111l.0l@werewolf.able.es>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday September 13, jamagallon@able.es wrote:
...
> As disks are of different sizes, I though about doing a volume with the small
> ones, and then a raid with the big.
> As stripping on two IDE disks on the same IDE bus is silly, I wanted to
> do a linear array. So this is what I would like:
> 
> /dev/md1 (raid0) -- /dev/hda1 (240Gb)
>                 \- /dev/md0 (raid linear) -- /dev/hdc1
>                                           \- /dev/hdd1
> 
....
> 
> What is the problem ? The kernel can't detect that md0 is part of an
> array ?

No, it cannot.

> Is this setup possible at all ?

Yes.  But don't use "autodetect" to start the array.  
Use "mdadm".   It is more flexible.

Or even, just use raid0 across all 3 drives.  raid0 copes quite
happily with drives of different sizes.

> Do I have to partition md0 and create a 'fd' partition ?

It might work, but I wouldn't suggest it.

> 
> Aside, I have thogut of this a a possible solution: split hda in two, and buid
> a raid0 with hda1,hdc1,hda2,hdd1 (hda is faster...). Is this so stupid as it
> looks to me (think of rplacinf hda2 when it fails....).

This would not be a clever idea for performance reasons.

If any drive fails you have lost all your data and will need to
restore from backups, so the possibility that hda2 dies is not
particularly interesting.

NeilBrown

