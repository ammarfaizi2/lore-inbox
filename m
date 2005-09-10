Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbVIJOgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVIJOgx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 10:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbVIJOgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 10:36:53 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:64186 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750959AbVIJOgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 10:36:52 -0400
Date: Sat, 10 Sep 2005 23:36:04 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com,
       ext3-users@redhat.com
Subject: Re: [PATCH 1/6] jbd: remove duplicated debug print
Message-ID: <20050910143604.GA7593@miraclelinux.com>
References: <20050909084214.GB14205@miraclelinux.com> <20050909084342.GC14205@miraclelinux.com> <20050909181649.GC24228@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909181649.GC24228@thunk.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 02:16:49PM -0400, Theodore Ts'o wrote:
> On Fri, Sep 09, 2005 at 05:43:42PM +0900, Akinobu Mita wrote:
> > remove duplicated debug print
> 
> > -	jbd_debug(3, "JBD: commit phase 2\n");
> > -
> 
> If you're going to do this, please renumber the rest of the "commit
> phase n" messages.  Or the debugging messages will look very funny.

The second duplicated "commit phase 2" only does:

 	J_ASSERT (commit_transaction->t_sync_datalist == NULL);

So I thought it might be accidentaly inserted.
diff -U 9 :

--- ./fs/jbd/commit.c.orig	2005-09-10 22:09:05.000000000 +0900
+++ ./fs/jbd/commit.c	2005-09-10 22:09:25.000000000 +0900
@@ -419,20 +419,18 @@ write_out_data:
 		cond_resched_lock(&journal->j_list_lock);
 	}
 	spin_unlock(&journal->j_list_lock);
 
 	if (err)
 		__journal_abort_hard(journal);
 
 	journal_write_revoke_records(journal, commit_transaction);
 
-	jbd_debug(3, "JBD: commit phase 2\n");
-
 	/*
 	 * If we found any dirty or locked buffers, then we should have
 	 * looped back up to the write_out_data label.  If there weren't
 	 * any then journal_clean_data_list should have wiped the list
 	 * clean by now, so check that it is in fact empty.
 	 */
 	J_ASSERT (commit_transaction->t_sync_datalist == NULL);
 
 	jbd_debug (3, "JBD: commit phase 3\n");
