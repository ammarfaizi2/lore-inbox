Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTDHNG5 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 09:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbTDHNG5 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 09:06:57 -0400
Received: from angband.namesys.com ([212.16.7.85]:48271 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP id S261364AbTDHNGz (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 09:06:55 -0400
Date: Tue, 8 Apr 2003 17:18:32 +0400
From: Oleg Drokin <green@namesys.com>
To: venom@sns.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserFS problem switching from 2.5.66/67 to 2.4.20
Message-ID: <20030408171832.A12020@namesys.com>
References: <Pine.LNX.4.43.0304081142480.8816-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0304081142480.8816-100000@cibs9.sns.it>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Apr 08, 2003 at 11:48:55AM +0200, venom@sns.it wrote:

> After running for a while kernel 2.5.66 and then for some hour 2.5.67
> I rebboted my desktop with kernel 2.4.20.
> during mount of reiserFS filesystem i GOT those messages:
> Apr  8 11:40:07 Blackdeath kernel: transaction
> Apr  8 11:40:07 Blackdeath kernel: journal-2018: Bad transaction length 4
> encountered, ignoring transaction
> Apr  8 11:40:07 Blackdeath kernel: journal-2018: Bad transaction length 11
> encountered, ignoring transaction
> Apr  8 11:40:07 Blackdeath kernel: journal-2018: Bad transaction length 4
> encountered, ignoring transaction
> Apr  8 11:40:07 Blackdeath kernel: journal-2018: Bad transaction length 4
> encountered, ignoring transaction
> Apr  8 11:40:07 Blackdeath kernel: journal-2018: Bad transaction length 11
> encountered, ignoring transaction
> this is just a few, I got hundreds of them.

Well, seems that you are runninf 2.4.21-pre7 or pre6, not vanilla 2.4.20.

Following patch should help.

Bye,
    Oleg
===== fs/reiserfs/journal.c 1.26 vs edited =====
--- 1.26/fs/reiserfs/journal.c	Thu Mar 13 14:52:15 2003
+++ edited/fs/reiserfs/journal.c	Tue Mar 25 16:38:55 2003
@@ -1401,7 +1401,7 @@
 		     *newest_mount_id) ;
       return -1 ;
     }
-    if ( le32_to_cpu(desc->j_len) > sb_journal_trans_max(SB_DISK_SUPER_BLOCK(p_s_sb)) ) {
+    if ( le32_to_cpu(desc->j_len) > JOURNAL_TRANS_MAX ) {
       reiserfs_warning("journal-2018: Bad transaction length %d encountered, ignoring transaction\n", le32_to_cpu(desc->j_len));
       return -1 ;
     }
