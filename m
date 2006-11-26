Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935402AbWKZOjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935402AbWKZOjk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 09:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935413AbWKZOjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 09:39:40 -0500
Received: from mout0.freenet.de ([194.97.50.131]:44442 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S935402AbWKZOjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 09:39:39 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.19-rc6-rt5
Date: Sun, 26 Nov 2006 15:39:47 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061120220230.GA30835@elte.hu>
In-Reply-To: <20061120220230.GA30835@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611261539.48105.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i've released the 2.6.19-rc6-rt5 tree, which can be downloaded from the 

Hi

this fixes issues like rmmod hanging and inodes leaking.

      Karsten

--- fs/dcache.c~	2006-11-21 11:25:11.000000000 +0100
+++ fs/dcache.c	2006-11-26 15:20:31.000000000 +0100
@@ -150,7 +150,7 @@ void dput(struct dentry *dentry)
 repeat:
 	if (atomic_read(&dentry->d_count) == 1)
 		might_sleep();
-	if (atomic_dec_and_test(&dentry->d_count))
+	if (!atomic_dec_and_test(&dentry->d_count))
 		return;
 
 	spin_lock(&dentry->d_lock);
