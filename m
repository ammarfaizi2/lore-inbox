Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264205AbRFLGH4>; Tue, 12 Jun 2001 02:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264202AbRFLGHq>; Tue, 12 Jun 2001 02:07:46 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:32507 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S264200AbRFLGH3>; Tue, 12 Jun 2001 02:07:29 -0400
Message-Id: <200106120607.f5C67A402277@smtp1.Stanford.EDU>
Content-Type: text/plain; charset=US-ASCII
From: Praveen Srinivasan <praveens@stanford.edu>
Organization: Stanford University
To: linux-kernel@vger.kernel.org
Subject: [PATCH] riocmd.c
Date: Mon, 11 Jun 2001 23:07:25 -0700
X-Mailer: KMail [version 1.2.2]
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes an instance where a pointer is not checked after allocation.

Praveen Srinivasan

--- ../linux-fresh/./drivers/char/rio/riocmd.c  Fri Feb  9 11:30:23 2001
+++ ./drivers/char/rio/riocmd.c Wed May 23 12:31:01 2001
@@ -623,6 +623,9 @@
        struct CmdBlk *CmdBlkP;
 
        CmdBlkP = (struct CmdBlk *)sysbrk(sizeof(struct CmdBlk));
+       if(CmdBlkP == NULL){
+         return NULL;
+       }
        bzero(CmdBlkP, sizeof(struct CmdBlk));
 
        return CmdBlkP;
