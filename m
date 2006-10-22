Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWJVPth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWJVPth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 11:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWJVPth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 11:49:37 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:53652 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751108AbWJVPtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 11:49:36 -0400
Message-id: <2849823933189348737@wsc.cz>
Subject: [PATCH 4/4] Char: stallion, correct __init macros
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 22 Oct 2006 17:49:44 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, correct __init macros

Some functions are now called from pci probing functiuon which is __devinit,
not __init, correct this to not free functions after init if hotplug
enabled.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit a3d771ef92954ce81363af9e0252490e2741fc21
tree 050ba1de2cddfe4a8a83ff084022d610c0580df0
parent 193f82ab45ee71c37cac356fd1afed8295d80b1e
author Jiri Slaby <ku@bellona.localdomain> Sun, 22 Oct 2006 17:22:09 +0159
committer Jiri Slaby <ku@bellona.localdomain> Sun, 22 Oct 2006 17:22:09 +0159

 drivers/char/stallion.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 73312c3..7ab9cee 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -1925,7 +1925,7 @@ static void stl_offintr(void *private)
  *	Initialize all the ports on a panel.
  */
 
-static int __init stl_initports(struct stlbrd *brdp, struct stlpanel *panelp)
+static int __devinit stl_initports(struct stlbrd *brdp, struct stlpanel *panelp)
 {
 	struct stlport	*portp;
 	int		chipmask, i;
@@ -1997,7 +1997,7 @@ static void stl_cleanup_panels(struct st
  *	Try to find and initialize an EasyIO board.
  */
 
-static int __init stl_initeio(struct stlbrd *brdp)
+static int __devinit stl_initeio(struct stlbrd *brdp)
 {
 	struct stlpanel	*panelp;
 	unsigned int	status;
@@ -2150,7 +2150,7 @@ err:
  *	dealing with all types of ECH board.
  */
 
-static int __init stl_initech(struct stlbrd *brdp)
+static int __devinit stl_initech(struct stlbrd *brdp)
 {
 	struct stlpanel	*panelp;
 	unsigned int	status, nxtid, ioaddr, conflict;
@@ -2374,7 +2374,7 @@ err:
  *	since the initial search and setup is very different.
  */
 
-static int __init stl_brdinit(struct stlbrd *brdp)
+static int __devinit stl_brdinit(struct stlbrd *brdp)
 {
 	int i, retval;
 
@@ -2440,7 +2440,7 @@ err:
  *	Find the next available board number that is free.
  */
 
-static int __init stl_getbrdnr(void)
+static int __devinit stl_getbrdnr(void)
 {
 	int	i;
 
