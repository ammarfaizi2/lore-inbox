Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWIDHlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWIDHlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWIDHlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:41:08 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:14723 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932454AbWIDHlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:41:04 -0400
Date: Mon, 4 Sep 2006 09:37:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 15/22][RFC] Unionfs: Privileged operations workqueue
In-Reply-To: <20060901015539.GP5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040935070.9108@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901015539.GP5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+void __unionfs_create(void *data)
>+{
>+	struct sioq_args *args = data;
>+
>+	args->err = vfs_create(args->u.create.parent, args->u.create.dentry,
>+				args->u.create.mode, args->u.create.nd);
>+	complete(&args->comp);
>+}

Suggestion

{
	struct sioq_args *args = data;
	struct create_args *c = &args->u.create;
	args->err = vfs_create(c->parent, c->dentry, c->mode, c->nd);
	complete(&args->comp);
}

Similar for others.

>+	union {
>+		struct deletewh_args deletewh;
>+		struct isopaque_args isopaque;
>+		struct create_args create;
>+		struct mkdir_args mkdir;
>+		struct mknod_args mknod;
>+		struct symlink_args symlink;
>+		struct unlink_args unlink;
>+	} u;

Anonymous unions (and structs) are allowed, use them if you think they sound
cool.


Jan Engelhardt
-- 

-- 
VGER BF report: H 0.127232
