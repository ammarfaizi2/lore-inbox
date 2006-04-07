Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWDGOhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWDGOhc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWDGOhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:37:00 -0400
Received: from [151.97.230.9] ([151.97.230.9]:47836 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932353AbWDGOcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:24 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 01/17] uml: make 64-bit COW files compatible with 32-bit ones.
Date: Fri, 07 Apr 2006 16:30:48 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143048.19201.78081.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This is the minimal fix to make 64-bit UML binaries create 32-bit
compatible COW files and read them.
I've indeed tested that current code doesn't do this - the code gets SIGFPE for
a division by a value read at the wrong place, where 0 is found.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow_user.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index 61951b7..afdf1ea 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -75,7 +75,7 @@ struct cow_header_v3 {
 	__u32 alignment;
 	__u32 cow_format;
 	char backing_file[PATH_LEN_V3];
-};
+} __attribute__((packed));
 
 /* COW format definitions - for now, we have only the usual COW bitmap */
 #define COW_BITMAP 0
