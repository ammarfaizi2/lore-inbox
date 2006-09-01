Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWIAEkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWIAEkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWIAEkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:40:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:30891 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932159AbWIAEju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:39:50 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:39:43 +1000
Message-Id: <1060901043943.27665@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 018 of 19] knfsd: lockd: fix use of h_nextrebind
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

  nlmclnt_recovery would try to force a portmap rebind by setting
  host->h_nextrebind to 0. The right thing to do here is to set it
  to the current time.

Signed-off-by: okir@suse.de
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/clntlock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/fs/lockd/clntlock.c ./fs/lockd/clntlock.c
--- .prev/fs/lockd/clntlock.c	2006-08-31 17:02:23.000000000 +1000
+++ ./fs/lockd/clntlock.c	2006-09-01 12:19:55.000000000 +1000
@@ -184,7 +184,7 @@ restart:
 	/* Force a portmap getport - the peer's lockd will
 	 * most likely end up on a different port.
 	 */
-	host->h_nextrebind = 0;
+	host->h_nextrebind = jiffies;
 	nlm_rebind_host(host);
 
 	/* First, reclaim all locks that have been granted. */
