Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263392AbREXH0y>; Thu, 24 May 2001 03:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263393AbREXH0o>; Thu, 24 May 2001 03:26:44 -0400
Received: from smtp2.Stanford.EDU ([171.64.14.116]:49135 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263392AbREXH0d>; Thu, 24 May 2001 03:26:33 -0400
Message-Id: <200105240726.f4O7QNH22947@smtp2.Stanford.EDU>
Content-Type: text/plain; charset=US-ASCII
From: Praveen Srinivasan <praveens@stanford.edu>
Organization: Stanford University
To: torvalds@tranmeta.com
Subject: [PATCH] fsm.c - null ptr fixes for 2.4.4
Date: Thu, 24 May 2001 00:27:29 -0700
X-Mailer: KMail [version 1.2.2]
Cc: kkeil@suse.de, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Using the Stanford checker, we searched for null-pointer bugs in the linux
kernel code. This patch fixes numerous unchecked pointers in the ISDN hisax 
card driver (fsm.c).


Praveen Srinivasan and Frederick Akalin

--- ../linux/./drivers/isdn/hisax/fsm.c	Fri Mar  2 11:12:08 2001
+++ ./drivers/isdn/hisax/fsm.c	Mon May  7 21:58:38 2001
@@ -22,6 +22,10 @@
 
 	fsm->jumpmatrix = (FSMFNPTR *)
 		kmalloc(sizeof (FSMFNPTR) * fsm->state_count * fsm->event_count, 
GFP_KERNEL);
+	if(fsm->jumpmatrix == NULL) {
+	  return;
+	}
+
 	memset(fsm->jumpmatrix, 0, sizeof (FSMFNPTR) * fsm->state_count * 
fsm->event_count);
 
 	for (i = 0; i < fncount; i++
