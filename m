Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269801AbUICXoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269801AbUICXoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 19:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269983AbUICXoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 19:44:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:45746 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269801AbUICXom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 19:44:42 -0400
Date: Fri, 3 Sep 2004 16:48:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2 - 'journal block not found' - ext3 on crack?
Message-Id: <20040903164824.4a3b0ee1.akpm@osdl.org>
In-Reply-To: <200409021815.i82IFpLT022145@turing-police.cc.vt.edu>
References: <200409021815.i82IFpLT022145@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> I built 2.6.9-rc1-mm2 last night, and I've had this happen on 2 separate file systems today:
> 
> Sep  2 12:42:50 turing-police kernel: journal_bmap: journal block not found at offset 2316 on dm-6
> Sep  2 12:42:52 turing-police kernel: Aborting journal on device dm-6.
> Sep  2 12:42:52 turing-police kernel: ext3_abort called.
> Sep  2 12:42:53 turing-police kernel: EXT3-fs error (device dm-6): ext3_journal_start: Detected aborted journal
> Sep  2 12:42:53 turing-police kernel: Remounting filesystem read-only
> Sep  2 12:42:54 turing-police kernel: EXT3-fs error (device dm-6) in start_transaction: Journal has aborted
> Sep  2 12:42:54 turing-police kernel: EXT3-fs error (device dm-6) in start_transaction: Journal has aborted
> Sep  2 12:42:54 turing-police kernel: journal commit I/O error
> Sep  2 12:42:54 turing-police kernel: EXT3-fs error (device dm-6) in start_transaction: Journal has aborted
> Sep  2 12:42:57 turing-police last message repeated 15 times
> 
> (This one was /home - I'd paste the other one, but it happened on /var so
> it didn't get logged because /var/adm/messages went R/O..)

Probably caused by an I/O error (or data loss) performing metadata reads.

> Of interest:
> 
> 1) Didn't see this under 2.6.8-mm4.
> 2) Neither time had any actual disk I/O error messages...
> 3) I'm using ext3-on-LVM, if that matters...

Let me guess: raid5?

We've had a steady stream of heisenbugreports for ext3-on-raid5
for several years.
