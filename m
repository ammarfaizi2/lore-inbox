Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030550AbWJJV41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030550AbWJJV41 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWJJVrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:47:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:27323 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030513AbWJJVr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:47:28 -0400
To: torvalds@osdl.org
Subject: [PATCH] trivial iomem annotations: istallion
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPRf-0007OS-C4@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:47:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/istallion.c  |   58 +++++++++++++++++++++++----------------------
 include/linux/istallion.h |    4 ++-
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index d6e0315..ffdf9df 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -686,37 +686,37 @@ static stlibrd_t *stli_allocbrd(void);
 static void	stli_ecpinit(stlibrd_t *brdp);
 static void	stli_ecpenable(stlibrd_t *brdp);
 static void	stli_ecpdisable(stlibrd_t *brdp);
-static char	*stli_ecpgetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
+static void __iomem *stli_ecpgetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
 static void	stli_ecpreset(stlibrd_t *brdp);
 static void	stli_ecpintr(stlibrd_t *brdp);
 static void	stli_ecpeiinit(stlibrd_t *brdp);
 static void	stli_ecpeienable(stlibrd_t *brdp);
 static void	stli_ecpeidisable(stlibrd_t *brdp);
-static char	*stli_ecpeigetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
+static void __iomem *stli_ecpeigetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
 static void	stli_ecpeireset(stlibrd_t *brdp);
 static void	stli_ecpmcenable(stlibrd_t *brdp);
 static void	stli_ecpmcdisable(stlibrd_t *brdp);
-static char	*stli_ecpmcgetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
+static void __iomem *stli_ecpmcgetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
 static void	stli_ecpmcreset(stlibrd_t *brdp);
 static void	stli_ecppciinit(stlibrd_t *brdp);
-static char	*stli_ecppcigetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
+static void __iomem *stli_ecppcigetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
 static void	stli_ecppcireset(stlibrd_t *brdp);
 
 static void	stli_onbinit(stlibrd_t *brdp);
 static void	stli_onbenable(stlibrd_t *brdp);
 static void	stli_onbdisable(stlibrd_t *brdp);
-static char	*stli_onbgetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
+static void __iomem *stli_onbgetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
 static void	stli_onbreset(stlibrd_t *brdp);
 static void	stli_onbeinit(stlibrd_t *brdp);
 static void	stli_onbeenable(stlibrd_t *brdp);
 static void	stli_onbedisable(stlibrd_t *brdp);
-static char	*stli_onbegetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
+static void __iomem *stli_onbegetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
 static void	stli_onbereset(stlibrd_t *brdp);
 static void	stli_bbyinit(stlibrd_t *brdp);
-static char	*stli_bbygetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
+static void __iomem *stli_bbygetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
 static void	stli_bbyreset(stlibrd_t *brdp);
 static void	stli_stalinit(stlibrd_t *brdp);
-static char	*stli_stalgetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
+static void __iomem *stli_stalgetmemptr(stlibrd_t *brdp, unsigned long offset, int line);
 static void	stli_stalreset(stlibrd_t *brdp);
 
 static stliport_t *stli_getport(int brdnr, int panelnr, int portnr);
@@ -1566,7 +1566,7 @@ static void stli_flushchars(struct tty_s
 
 	len = MIN(len, cooksize);
 	count = 0;
-	shbuf = (char *) EBRDGETMEMPTR(brdp, portp->txoffset);
+	shbuf = EBRDGETMEMPTR(brdp, portp->txoffset);
 	buf = stli_txcookbuf;
 
 	while (len > 0) {
@@ -2948,9 +2948,9 @@ static void stli_ecpdisable(stlibrd_t *b
 
 /*****************************************************************************/
 
-static char *stli_ecpgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_ecpgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
 {	
-	void *ptr;
+	void __iomem *ptr;
 	unsigned char val;
 
 	if (offset > brdp->memsize) {
@@ -3022,9 +3022,9 @@ static void stli_ecpeidisable(stlibrd_t 
 
 /*****************************************************************************/
 
-static char *stli_ecpeigetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_ecpeigetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
 {	
-	void		*ptr;
+	void __iomem *ptr;
 	unsigned char	val;
 
 	if (offset > brdp->memsize) {
@@ -3074,9 +3074,9 @@ static void stli_ecpmcdisable(stlibrd_t 
 
 /*****************************************************************************/
 
-static char *stli_ecpmcgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_ecpmcgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
 {	
-	void *ptr;
+	void __iomem *ptr;
 	unsigned char val;
 
 	if (offset > brdp->memsize) {
@@ -3119,9 +3119,9 @@ static void stli_ecppciinit(stlibrd_t *b
 
 /*****************************************************************************/
 
-static char *stli_ecppcigetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_ecppcigetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
 {	
-	void		*ptr;
+	void __iomem *ptr;
 	unsigned char	val;
 
 	if (offset > brdp->memsize) {
@@ -3185,9 +3185,9 @@ static void stli_onbdisable(stlibrd_t *b
 
 /*****************************************************************************/
 
-static char *stli_onbgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_onbgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
 {	
-	void	*ptr;
+	void __iomem *ptr;
 
 	if (offset > brdp->memsize) {
 		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
@@ -3250,9 +3250,9 @@ static void stli_onbedisable(stlibrd_t *
 
 /*****************************************************************************/
 
-static char *stli_onbegetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_onbegetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
 {	
-	void *ptr;
+	void __iomem *ptr;
 	unsigned char val;
 
 	if (offset > brdp->memsize) {
@@ -3300,9 +3300,9 @@ static void stli_bbyinit(stlibrd_t *brdp
 
 /*****************************************************************************/
 
-static char *stli_bbygetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_bbygetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
 {	
-	void *ptr;
+	void __iomem *ptr;
 	unsigned char val;
 
 	BUG_ON(offset > brdp->memsize);
@@ -3337,7 +3337,7 @@ static void stli_stalinit(stlibrd_t *brd
 
 /*****************************************************************************/
 
-static char *stli_stalgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
+static void __iomem *stli_stalgetmemptr(stlibrd_t *brdp, unsigned long offset, int line)
 {	
 	BUG_ON(offset > brdp->memsize);
 	return brdp->membase + (offset % STAL_PAGESIZE);
@@ -3876,7 +3876,7 @@ static int stli_eisamemprobe(stlibrd_t *
 			continue;
 
 		if (brdp->brdtype == BRD_ECPE) {
-			ecpsigp = (cdkecpsig_t __iomem *) stli_ecpeigetmemptr(brdp,
+			ecpsigp = stli_ecpeigetmemptr(brdp,
 				CDK_SIGADDR, __LINE__);
 			memcpy_fromio(&ecpsig, ecpsigp, sizeof(cdkecpsig_t));
 			if (ecpsig.magic == cpu_to_le32(ECP_MAGIC))
@@ -4184,7 +4184,7 @@ #endif
 static ssize_t stli_memread(struct file *fp, char __user *buf, size_t count, loff_t *offp)
 {
 	unsigned long flags;
-	void *memptr;
+	void __iomem *memptr;
 	stlibrd_t *brdp;
 	int brdnr, size, n;
 	void *p;
@@ -4214,7 +4214,7 @@ static ssize_t stli_memread(struct file 
 	while (size > 0) {
 		spin_lock_irqsave(&brd_lock, flags);
 		EBRDENABLE(brdp);
-		memptr = (void *) EBRDGETMEMPTR(brdp, off);
+		memptr = EBRDGETMEMPTR(brdp, off);
 		n = MIN(size, (brdp->pagesize - (((unsigned long) off) % brdp->pagesize)));
 		n = MIN(n, PAGE_SIZE);
 		memcpy_fromio(p, memptr, n);
@@ -4247,7 +4247,7 @@ out:
 static ssize_t stli_memwrite(struct file *fp, const char __user *buf, size_t count, loff_t *offp)
 {
 	unsigned long flags;
-	void *memptr;
+	void __iomem *memptr;
 	stlibrd_t *brdp;
 	char __user *chbuf;
 	int brdnr, size, n;
@@ -4287,7 +4287,7 @@ static ssize_t stli_memwrite(struct file
 		}
 		spin_lock_irqsave(&brd_lock, flags);
 		EBRDENABLE(brdp);
-		memptr = (void *) EBRDGETMEMPTR(brdp, off);
+		memptr = EBRDGETMEMPTR(brdp, off);
 		memcpy_toio(memptr, p, n);
 		EBRDDISABLE(brdp);
 		spin_unlock_irqrestore(&brd_lock, flags);
diff --git a/include/linux/istallion.h b/include/linux/istallion.h
index 1f99662..b55e2a0 100644
--- a/include/linux/istallion.h
+++ b/include/linux/istallion.h
@@ -100,7 +100,7 @@ typedef struct stlibrd {
 	unsigned int	iobase;
 	int		iosize;
 	unsigned long	memaddr;
-	void		*membase;
+	void		__iomem *membase;
 	int		memsize;
 	int		pagesize;
 	int		hostoffset;
@@ -113,7 +113,7 @@ typedef struct stlibrd {
 	void		(*enable)(struct stlibrd *brdp);
 	void		(*reenable)(struct stlibrd *brdp);
 	void		(*disable)(struct stlibrd *brdp);
-	char		*(*getmemptr)(struct stlibrd *brdp, unsigned long offset, int line);
+	void		__iomem *(*getmemptr)(struct stlibrd *brdp, unsigned long offset, int line);
 	void		(*intr)(struct stlibrd *brdp);
 	void		(*reset)(struct stlibrd *brdp);
 	stliport_t	*ports[STL_MAXPORTS];
-- 
1.4.2.GIT


