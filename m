Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbTIBPJD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 11:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbTIBPJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 11:09:03 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:47005
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263831AbTIBPHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 11:07:22 -0400
Date: Tue, 2 Sep 2003 17:07:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22aa1 - unresolved
Message-ID: <20030902150707.GZ1599@dualathlon.random>
References: <20030902020218.GB1599@dualathlon.random> <3F548543.D5888E3B@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F548543.D5888E3B@eyal.emu.id.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 09:55:47PM +1000, Eyal Lebedinsky wrote:
> practically everything is a module.
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.22-aa1/kernel/drivers/scsi/scsi_mod.o
> depmod:         open_softirq
> 

this will fix it for now, I'll upload an update shortly.

diff -urNp --exclude CVS --exclude BitKeeper x/kernel/ksyms.c x-new/kernel/ksyms.c
--- x/kernel/ksyms.c	2003-09-02 16:43:44.000000000 +0200
+++ x-new/kernel/ksyms.c	2003-09-02 17:06:03.000000000 +0200
@@ -625,6 +625,7 @@ EXPORT_SYMBOL(remove_bh);
 EXPORT_SYMBOL(tasklet_init);
 EXPORT_SYMBOL(tasklet_kill);
 EXPORT_SYMBOL(__run_task_queue);
+EXPORT_SYMBOL(open_softirq);
 EXPORT_SYMBOL(do_softirq);
 EXPORT_SYMBOL(raise_softirq);
 EXPORT_SYMBOL(cpu_raise_softirq);

thanks (as usual ;)

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, Sep 02, 2003 at 09:55:47PM +1000, Eyal Lebedinsky wrote:
> practically everything is a module.
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.22-aa1/kernel/drivers/scsi/scsi_mod.o
> depmod:         open_softirq
> 

this will fix it for now, I'll upload an update shortly.

diff -urNp --exclude CVS --exclude BitKeeper x/kernel/ksyms.c x-new/kernel/ksyms.c
--- x/kernel/ksyms.c	2003-09-02 16:43:44.000000000 +0200
+++ x-new/kernel/ksyms.c	2003-09-02 17:06:03.000000000 +0200
@@ -625,6 +625,7 @@ EXPORT_SYMBOL(remove_bh);
 EXPORT_SYMBOL(tasklet_init);
 EXPORT_SYMBOL(tasklet_kill);
 EXPORT_SYMBOL(__run_task_queue);
+EXPORT_SYMBOL(open_softirq);
 EXPORT_SYMBOL(do_softirq);
 EXPORT_SYMBOL(raise_softirq);
 EXPORT_SYMBOL(cpu_raise_softirq);

thanks (as usual ;)

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
