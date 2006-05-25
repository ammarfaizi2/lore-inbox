Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWEYB1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWEYB1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWEYB1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:27:24 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29582 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964812AbWEYB1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:27:02 -0400
Message-Id: <20060525003419.840420000@linux-m68k.org>
References: <20060525002742.723577000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Thu, 25 May 2006 02:27:43 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH 01/11] completely initialize hw_regs_t in ide_setup_ports
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide_setup_ports does not completely initialize the hw_regs_t structure
which can cause random failures, as the structure is often on the stack.
None of the callers expect a partially initialized structure, i.e. none
of them do any setup of their own before calling ide_setup_ports().

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 drivers/ide/ide.c           |    1 +
 drivers/ide/legacy/q40ide.c |    1 +
 2 files changed, 2 insertions(+)

Index: linux-2.6-mm/drivers/ide/ide.c
===================================================================
--- linux-2.6-mm.orig/drivers/ide/ide.c
+++ linux-2.6-mm/drivers/ide/ide.c
@@ -730,6 +730,7 @@ void ide_setup_ports (	hw_regs_t *hw,
 {
 	int i;
 
+	memset(hw, 0, sizeof(hw_regs_t));
 	for (i = 0; i < IDE_NR_PORTS; i++) {
 		if (offsets[i] == -1) {
 			switch(i) {
Index: linux-2.6-mm/drivers/ide/legacy/q40ide.c
===================================================================
--- linux-2.6-mm.orig/drivers/ide/legacy/q40ide.c
+++ linux-2.6-mm/drivers/ide/legacy/q40ide.c
@@ -80,6 +80,7 @@ void q40_ide_setup_ports ( hw_regs_t *hw
 {
 	int i;
 
+	memset(hw, 0, sizeof(hw_regs_t));
 	for (i = 0; i < IDE_NR_PORTS; i++) {
 		/* BIG FAT WARNING: 
 		   assumption: only DATA port is ever used in 16 bit mode */

--

