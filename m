Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968665AbWLETfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968665AbWLETfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968666AbWLETfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:35:13 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:47898 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968664AbWLETfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:35:10 -0500
Date: Tue, 5 Dec 2006 20:27:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 26/35] Unionfs: Privileged operations workqueue
In-Reply-To: <1165235471170-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612052020420.18570@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <1165235471170-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 4 2006 07:30, Josef 'Jeff' Sipek wrote:
>+#include "union.h"
>+
>+struct workqueue_struct *sioq;
>+
>+int __init init_sioq(void)

Although it's just me, I'd prefer sioq_init(), sioq_exit(),
sioq_run(), etc. to go in hand with what most drivers use as naming
(i.e. <modulename> "_" <function>).

>+	sioq = create_workqueue("unionfs_siod");

Beat me: what does SIO stand for?

>+void fin_sioq(void)

No __exit tag?

>+void __unionfs_mknod(void *data)
>+{
>+	struct sioq_args *args = data;
>+	struct mknod_args *m = &args->mknod;

Care to make that: const struct mknod_args *m = &args->mknod;?
(Same for other places)

>+
>+	args->err = vfs_mknod(m->parent, m->dentry, m->mode, m->dev);
>+	complete(&args->comp);
>+}
>+void __unionfs_symlink(void *data)
>+{

Hah, missing free line :^)

>+	struct sioq_args *args = data;
>+	struct symlink_args *s = &args->symlink;
>+
>+	args->err = vfs_symlink(s->parent, s->dentry, s->symbuf, s->mode);
>+	complete(&args->comp);
>+}
>+

>+++ b/fs/unionfs/sioq.h
>+struct isopaque_args {
>+	struct dentry *dentry;
>+};

This name puzzled me at first. iso - paque - "same (o)paque"?
Try is_opaque_args.

>+/* Extern definitions for our privledge escalation helpers */

-> privilege


	-`J'
-- 
