Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWFSRUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWFSRUp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWFSRUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:20:45 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:48003 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964816AbWFSRUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:20:43 -0400
Date: Mon, 19 Jun 2006 19:20:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Theodore Tso <tytso@thunk.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 4/8] inode-diet: Move i_cdev into a union
In-Reply-To: <20060619153109.539332000@candygram.thunk.org>
Message-ID: <Pine.LNX.4.61.0606191919590.23792@yvahk01.tjqt.qr>
References: <20060619152003.830437000@candygram.thunk.org>
 <20060619153109.539332000@candygram.thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>===================================================================
>--- linux-2.6.17.orig/fs/file_table.c	2006-06-18 19:37:14.000000000 -0400
>+++ linux-2.6.17/fs/file_table.c	2006-06-18 19:50:56.000000000 -0400
>@@ -170,7 +170,7 @@
> 	if (file->f_op && file->f_op->release)
> 		file->f_op->release(inode, file);
> 	security_file_free(file);
>-	if (unlikely(inode->i_cdev != NULL))
>+	if (unlikely(S_ISCHR(inode->i_mode) && (inode->i_cdev != NULL)))

Am I allowed to be nitpicky? If so, drop the () around inode->i_cdev != 
NULL. :)



Jan Engelhardt
-- 
