Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318885AbSH1PmM>; Wed, 28 Aug 2002 11:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318887AbSH1PlK>; Wed, 28 Aug 2002 11:41:10 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:3203 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318880AbSH1PlG>; Wed, 28 Aug 2002 11:41:06 -0400
Date: Wed, 28 Aug 2002 16:45:19 +0100
Message-Id: <200208281545.g7SFjJF14334@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 4/8] 2.4.20-pre4/ext3: Truncate leak fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix from Al Viro for a very, very rare buffer leak on a truncate allocation
collision.

--- linux-ext3-2.4merge/fs/ext3/inode.c.=K0005=.orig	Tue Aug 27 23:17:29 2002
+++ linux-ext3-2.4merge/fs/ext3/inode.c	Tue Aug 27 23:19:57 2002
@@ -412,6 +412,7 @@
 	return NULL;
 
 changed:
+	brelse(bh);
 	*err = -EAGAIN;
 	goto no_block;
 failure:
