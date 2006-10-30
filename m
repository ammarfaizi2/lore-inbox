Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422728AbWJ3Wqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbWJ3Wqs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWJ3Wqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:46:48 -0500
Received: from ns1.suse.de ([195.135.220.2]:43676 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422728AbWJ3Wqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:46:47 -0500
From: Neil Brown <neilb@suse.de>
To: "Andreas Paulsson" <andreas.paulsson@itgarden.se>
Date: Tue, 31 Oct 2006 09:46:42 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17734.32978.304514.114875@cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: SV: PROBLEM: raid5 just dies
In-Reply-To: message from Andreas Paulsson on Monday October 30
References: <6FDE26082D451C41BE1A3742966200B3B51C67@DR2EX01.hosting.itg>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 30, andreas.paulsson@itgarden.se wrote:
> >Exactly how are aes-loop and raid5 connected together?
> 
> We use 5x300gb drives in a raid5 array, which is then used as a physical
> disk in an lvm volume, with one logical volume. This logical volume is
> then encrypted with "losetup -e aes /dev/loop1 /dev/vg0/lv0", and then
> formatted with ReiserFS.

Thanks.

It could be a hardware problem....
The symptom is that we try to free some memory and a consistency check
tells us that the memory wasn't allocated.  So a single bit error in
the address could be the cause.  Running memtest86 for a while
wouldn't hurt if you haven't already done that.

You have three layers here: loop over dm over md/raid5.
So if it is a software problem it could be in any of these layers, or
in an interaction between two of them.

1/ how repeatable is this?
2/ how much room have you got to experiment?
 Could you remake the array without the loop/aes and see if you can
 reproduce the problem?
 Could you remake the array without the LVM layer and see if you can
 reproduce the problem?

Do you have CONFIG_DEBUG_PAGEALLOC and CONFIG_DEBUG_SLAB set?  If not
could you recompile with those set to see if they provide more helpful
information. 

I must admit I am somewhat at a loss.  I cannot see much room for
problems leading to that particular point in the code that would not
be seen by lots more people than just you.

NeilBrown
