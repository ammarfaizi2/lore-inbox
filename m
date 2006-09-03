Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWICWwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWICWwY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWICWwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:52:24 -0400
Received: from cantor2.suse.de ([195.135.220.15]:58855 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751031AbWICWwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:52:22 -0400
From: Neil Brown <neilb@suse.de>
To: Bernd Eckenfels <ecki@lina.inka.de>
Date: Mon, 4 Sep 2006 08:52:15 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17659.23711.76512.260561@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: in-kernel rpc.statd
In-Reply-To: message from Bernd Eckenfels on Sunday September 3
References: <Pine.LNX.4.61.0609032255010.6844@yvahk01.tjqt.qr>
	<E1GJzw4-0002ti-00@calista.eckenfels.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday September 3, ecki@lina.inka.de wrote:
> In article <Pine.LNX.4.61.0609032255010.6844@yvahk01.tjqt.qr> you wrote:
> > Hm. I do not have a rpc.statd userspace program nor kernel daemon (running 
> > on 2.6.17-vanilla). Yet everything is working. Is there a specific need for 
> > statd?
> 
> It is more or less an uptime notification protocol for NFS locks. I think
> NFS clients can recover from a reboot without the help of the statd in most
> situations.

No.

If a client has a lock and the server reboots, then the client loses
the lock and must recovery it during the grace period (first 45
seconds while the server is running again).
Without statd it doesn't know to do this, and it certainly doesn't
know when to do it.  So there is a chance that the server will give
the lock to some other client. Bad.

On the flip side, when a client reboots, the server is left holding
the lock and will not drop it until it discovers that the client has
rebooted, and this can only be discovered via statd.  So without statd
you end up with locks that can only be removed by the sysadmin (or a
server reboot).
In early days when lockd/statd implementations (not necessarily linux)
were even more clunky than they are today, stale locks were not
particularly uncommon.

NeilBrown

-- 
VGER BF report: H 0.018873
