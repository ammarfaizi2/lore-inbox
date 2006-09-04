Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWIDHIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWIDHIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWIDHIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:08:22 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:47771 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932402AbWIDHIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:08:20 -0400
Date: Mon, 4 Sep 2006 09:04:21 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 06/22][RFC] Unionfs: Dentry operations
In-Reply-To: <20060901014414.GG5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040859140.9108@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014414.GG5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+/*
>+ * THIS IS A BOOLEAN FUNCTION: returns 1 if valid, 0 otherwise.
>+ */

Candiate for "generic boolean patch"!

>+		if (!restart && (pdgen != sbgen)) {
()

>+	} else if (dbstart(dentry) < 0) {
>+		/* this is due to a failed lookup */
>+		/* the failed lookup has a dtohd_ptr set to null,
>+		   but this is a better check */
>+		printk(KERN_DEBUG "dentry without hidden dentries : %*s",
>+		       dentry->d_name.len, dentry->d_name.name);

I think you want %.*s

>+out_free:
>+	/* No need to unlock it, because it is disappeared. */
>+	free_dentry_private_data(dtopd(dentry));
>+	dtopd_lhs(dentry) = NULL;	/* just to be safe */

Things like this NULLing could be removed. It if then oopses somewhere,
you either

   (a) needed this =NULL indeed (because some other function depends
       on it being NULL)

or (b) found a bug elsewhere (more likely, since you write "just to be safe")


The (a) case is needed if you wanted to kfree(dtopd_lhs(dentry))
elsewhere it.


Jan Engelhardt
-- 

-- 
VGER BF report: H 0.00065657
