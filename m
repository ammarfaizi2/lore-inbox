Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTFFPsq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTFFPsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:48:46 -0400
Received: from angband.namesys.com ([212.16.7.85]:64403 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261919AbTFFPsp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:48:45 -0400
Date: Fri, 6 Jun 2003 20:02:17 +0400
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: short freezing while file re-creation
Message-ID: <20030606160217.GE6455@namesys.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com> <20030606091759.GC23608@namesys.com> <20030606172454.6f3cbeed.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606172454.6f3cbeed.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jun 06, 2003 at 05:24:54PM +0200, Stephan von Krawczynski wrote:

> while experimenting around my other problem I noticed my box freezes for some
> seconds while tar is re-creating an archive of around 70 GB size on a reiserfs
> with 3ware-connected device.
> This is experienced with 2.4.21-rc7. Reproducable via:
> create BIG tar archive file (my size 70 GB) on a reiserfs
> re-create same archive and watch box gone dead while the old archive is zapped.
> (Gone dead means: mouse froze, keyboard froze, X froze)

Hm, I will try .

Wild guess: does this patch helps? (untessted, not even compiled, but should be safe )

Bye,
    Oleg
===== stree.c 1.21 vs edited =====
--- 1.21/fs/reiserfs/stree.c	Tue Mar  4 19:48:52 2003
+++ edited/fs/reiserfs/stree.c	Fri Jun  6 20:01:29 2003
@@ -1773,6 +1773,8 @@
 	  journal_begin(th, p_s_inode->i_sb, orig_len_alloc) ;
 	  reiserfs_update_inode_transaction(p_s_inode) ;
 	}
+	if (current->need_resched)
+	  schedule() ;
     } while ( n_file_size > ROUND_UP (n_new_file_size) &&
 	      search_for_position_by_key(p_s_inode->i_sb, &s_item_key, &s_search_path) == POSITION_FOUND )  ;
 
