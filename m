Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751924AbWJMVIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbWJMVIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWJMVIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:08:41 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:62701 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751924AbWJMVIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:08:38 -0400
Message-id: <25675166591167810097@wsc.cz>
Subject: [PATCH 5/7] Char: stallion, uninline functions
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri, 13 Oct 2006 23:08:50 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, uninline functions

- Do not inline such long functions, it won't speed up anything.
- Remove prototypes of these functions.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 76e0df22163abb8b552f6e77652839b40a76752d
tree a3e6f544b25acf72fdd58d48c742743accc31cd9
parent 519ee9839cb1a759f701c0ab97e52f4199d93914
author Jiri Slaby <jirislaby@gmail.com> Fri, 13 Oct 2006 00:06:25 +0200
committer Jiri Slaby <jirislaby@gmail.com> Fri, 13 Oct 2006 00:06:25 +0200

 drivers/char/stallion.c |   28 +++++++++-------------------
 1 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 48db973..02bd0ba 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -496,16 +496,6 @@ static void	stl_offintr(void *private);
 static struct stlbrd *stl_allocbrd(void);
 static struct stlport *stl_getport(int brdnr, int panelnr, int portnr);
 
-static inline int	stl_initbrds(void);
-static inline int	stl_initeio(struct stlbrd *brdp);
-static inline int	stl_initech(struct stlbrd *brdp);
-static inline int	stl_getbrdnr(void);
-
-#ifdef	CONFIG_PCI
-static inline int	stl_findpcibrds(void);
-static inline int	stl_initpcibrd(int brdtype, struct pci_dev *devp);
-#endif
-
 /*
  *	CD1400 uart specific handling functions.
  */
@@ -2026,7 +2016,7 @@ static int __init stl_initports(struct s
  *	Try to find and initialize an EasyIO board.
  */
 
-static inline int stl_initeio(struct stlbrd *brdp)
+static int stl_initeio(struct stlbrd *brdp)
 {
 	struct stlpanel	*panelp;
 	unsigned int	status;
@@ -2167,7 +2157,7 @@ static inline int stl_initeio(struct stl
  *	dealing with all types of ECH board.
  */
 
-static inline int stl_initech(struct stlbrd *brdp)
+static int stl_initech(struct stlbrd *brdp)
 {
 	struct stlpanel	*panelp;
 	unsigned int	status, nxtid, ioaddr, conflict;
@@ -2426,7 +2416,7 @@ static int __init stl_brdinit(struct stl
  *	Find the next available board number that is free.
  */
 
-static inline int stl_getbrdnr(void)
+static int stl_getbrdnr(void)
 {
 	int	i;
 
@@ -2450,7 +2440,7 @@ #ifdef	CONFIG_PCI
  *	configuration space.
  */
 
-static inline int stl_initpcibrd(int brdtype, struct pci_dev *devp)
+static int stl_initpcibrd(int brdtype, struct pci_dev *devp)
 {
 	struct stlbrd	*brdp;
 
@@ -2512,7 +2502,7 @@ static inline int stl_initpcibrd(int brd
  */
 
 
-static inline int stl_findpcibrds(void)
+static int stl_findpcibrds(void)
 {
 	struct pci_dev	*dev = NULL;
 	int		i, rc;
@@ -2548,7 +2538,7 @@ #endif
  *	since the initial search and setup is too different.
  */
 
-static inline int stl_initbrds(void)
+static int stl_initbrds(void)
 {
 	struct stlbrd	*brdp;
 	struct stlconf	*confp;
@@ -3598,7 +3588,7 @@ static void stl_cd1400echintr(struct stl
  *	this is the only way to generate them on the cd1400.
  */
 
-static inline int stl_cd1400breakisr(struct stlport *portp, int ioaddr)
+static int stl_cd1400breakisr(struct stlport *portp, int ioaddr)
 {
 	if (portp->brklen == 1) {
 		outb((COR2 + portp->uartaddr), ioaddr);
@@ -4522,7 +4512,7 @@ static void stl_sc26198wait(struct stlpo
  *	automatic flow control modes of the sc26198.
  */
 
-static inline void stl_sc26198txunflow(struct stlport *portp, struct tty_struct *tty)
+static void stl_sc26198txunflow(struct stlport *portp, struct tty_struct *tty)
 {
 	unsigned char	mr0;
 
@@ -4693,7 +4683,7 @@ static void stl_sc26198rxisr(struct stlp
  *	Process an RX bad character.
  */
 
-static inline void stl_sc26198rxbadch(struct stlport *portp, unsigned char status, char ch)
+static void stl_sc26198rxbadch(struct stlport *portp, unsigned char status, char ch)
 {
 	struct tty_struct	*tty;
 	unsigned int		ioaddr;
