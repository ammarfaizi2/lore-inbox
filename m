Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUEWFgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUEWFgs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 01:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUEWFgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 01:36:47 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:41875 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262279AbUEWFgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 01:36:36 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Jim Gifford" <maillist@jg555.com>
Date: Sun, 23 May 2004 15:36:22 +1000
Message-ID: <16560.14422.781355.747127@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Trouble with NFS with -mm3, -mm4, and -mm5
In-Reply-To: message from Jim Gifford on Saturday May 22
References: <01ef01c44027$7cb90920$d100a8c0@W2RZ8L4S02>
	<16559.51530.676312.49328@cse.unsw.edu.au>
	<047001c4407b$b358c1b0$d100a8c0@W2RZ8L4S02>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday May 22, maillist@jg555.com wrote:
> ext3. It works under the standard 2.6.6 without the mm patches

Hmmm.... I hit the exact same BUG in dcache.h in a completely
different circumstance (during readlink("/proc/self/exe") in perl).
It was on ext3 in a recent -mm, but had no connection with nfs.


I'm wondering if something in recent dcache or ext3 patches have
caused us to end up with negative d_count on a dentry.  This could
cause the line 276 BUG_ON to happen at weird places.

Could you try changing that line from

		BUG_ON(!atomic_read(&dentry->d_count));

to

		BUG_ON(atomic_read(&dentry->d_count) <= 0);

and see if that make it fall over more quickly?

NeilBrown
