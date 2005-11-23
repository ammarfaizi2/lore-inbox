Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965206AbVKWCHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965206AbVKWCHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbVKWCHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:07:37 -0500
Received: from ns.suse.de ([195.135.220.2]:23276 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965206AbVKWCHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:07:37 -0500
From: Neil Brown <neilb@suse.de>
To: linux-kernel@vger.kernel.org
Date: Wed, 23 Nov 2005 13:07:28 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17283.52960.913712.454816@cse.unsw.edu.au>
Cc: Al Viro <viro@ftp.linux.org.uk>
Subject: pivot_root broken in 2.6.15-rc1-mm2
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pivot_root seems to be broken in 2.6.15-rc1-mm2.

I havea initramfs filesystem, mount a ext3 filesystem (which has /mnt)
at '/root' and

  cd /root
  pivot . mnt

and it says -EINVAL.

After putting in copious tracing printk, the offending test is:

	if (user_nd.mnt->mnt_parent == user_nd.mnt)
		goto out2; /* not attached */

If I remove this, it works (or seems to).
Presumably the initial root file system is 'not attached'.  But that
shouldn't be a problem, should it?

Could this be related to the new shared mounts stuff???

NeilBrown
