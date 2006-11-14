Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933429AbWKNNBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933429AbWKNNBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 08:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965594AbWKNNB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 08:01:26 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:2787 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S965585AbWKNNBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 08:01:10 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Vivek Goyal <vgoyal@in.ibm.com>,
       magnus.damm@gmail.com, Horms <horms@verge.net.au>,
       Magnus Damm <magnus@valinux.co.jp>, Dave Anderson <anderson@redhat.com>,
       ebiederm@xmission.com, Jakub Jelinek <jakub@redhat.com>,
       David Miller <davem@davemloft.net>
Date: Tue, 14 Nov 2006 22:01:09 +0900
Message-Id: <20061114130109.24180.97758.sendpatchset@localhost>
In-Reply-To: <20061114130057.24180.34095.sendpatchset@localhost>
References: <20061114130057.24180.34095.sendpatchset@localhost>
Subject: [PATCH 02/03] Elf: Include terminating zero in n_namesz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elf: Include terminating zero in n_namesz

The ELF32 spec says we should plus we include the zero on other platforms.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 arch/mips/kernel/irixelf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0003/arch/mips/kernel/irixelf.c
+++ work/arch/mips/kernel/irixelf.c	2006-11-14 20:56:54.000000000 +0900
@@ -1009,7 +1009,7 @@ static int notesize(struct memelfnote *e
 	int sz;
 
 	sz = sizeof(struct elf_note);
-	sz += roundup(strlen(en->name), 4);
+	sz += roundup(strlen(en->name) + 1, 4);
 	sz += roundup(en->datasz, 4);
 
 	return sz;
@@ -1028,7 +1028,7 @@ static int writenote(struct memelfnote *
 {
 	struct elf_note en;
 
-	en.n_namesz = strlen(men->name);
+	en.n_namesz = strlen(men->name) + 1;
 	en.n_descsz = men->datasz;
 	en.n_type = men->type;
 
