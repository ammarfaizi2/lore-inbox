Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268044AbUG2Pgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268044AbUG2Pgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268045AbUG2PNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:13:30 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17916 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263824AbUG2ONv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:13:51 -0400
Date: Thu, 29 Jul 2004 16:13:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] istallion: remove inlines (fwd)
Message-ID: <20040729141343.GX2349@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:
The patch forwarded below is still required in 2.6.8-rc2-mm1.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Tue, 13 Jul 2004 02:11:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: support@stallion.oz.au
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] istallion: remove inlines

Trying to compile drivers/char/istallion.c with gcc 3.4 and
  # define inline         __inline__ __attribute__((always_inline))
results in the following compile error:

<--  snip  -->

...
  CC      drivers/char/istallion.o
drivers/char/istallion.c: In function `stli_init':
drivers/char/istallion.c:4603: sorry, unimplemented: inlining failed in 
call to 'stli_getbrdnr': function not considered for inlining
drivers/char/istallion.c:4577: sorry, unimplemented: called from here
drivers/char/istallion.c: At top level:
drivers/char/istallion.c:422: warning: 'istallion_pci_tbl' defined but 
not used
make[2]: *** [drivers/char/istallion.o] Error 1

<--  snip  -->


The patch below removes all inlines from istallion.c .

An alternative approach to removing the inlines would be to keep all
inlines that are _really_ required and reorder the functions in the file
accordingly.


diffstat output:
 drivers/char/istallion.c |   44 +++++++++++++++++++--------------------
 1 files changed, 22 insertions(+), 22 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full-gcc3.4/drivers/char/istallion.c.old	2004-07-13 01:05:54.000000000 +0200
+++ linux-2.6.7-mm7-full-gcc3.4/drivers/char/istallion.c	2004-07-13 02:04:46.000000000 +0200
@@ -749,17 +749,17 @@
 
 static stliport_t *stli_getport(int brdnr, int panelnr, int portnr);
 
-static inline int	stli_initbrds(void);
-static inline int	stli_initecp(stlibrd_t *brdp);
-static inline int	stli_initonb(stlibrd_t *brdp);
-static inline int	stli_findeisabrds(void);
-static inline int	stli_eisamemprobe(stlibrd_t *brdp);
-static inline int	stli_initports(stlibrd_t *brdp);
-static inline int	stli_getbrdnr(void);
+static int	stli_initbrds(void);
+static int	stli_initecp(stlibrd_t *brdp);
+static int	stli_initonb(stlibrd_t *brdp);
+static int	stli_findeisabrds(void);
+static int	stli_eisamemprobe(stlibrd_t *brdp);
+static int	stli_initports(stlibrd_t *brdp);
+static int	stli_getbrdnr(void);
 
 #ifdef	CONFIG_PCI
-static inline int	stli_findpcibrds(void);
-static inline int	stli_initpcibrd(int brdtype, struct pci_dev *devp);
+static int	stli_findpcibrds(void);
+static int	stli_initpcibrd(int brdtype, struct pci_dev *devp);
 #endif
 
 /*****************************************************************************/
@@ -2758,7 +2758,7 @@
  *	more chars to unload.
  */
 
-static inline void stli_read(stlibrd_t *brdp, stliport_t *portp)
+static void stli_read(stlibrd_t *brdp, stliport_t *portp)
 {
 	volatile cdkasyrq_t	*rp;
 	volatile char		*shbuf;
@@ -2826,7 +2826,7 @@
  *	difficult to deal with them here.
  */
 
-static inline void stli_dodelaycmd(stliport_t *portp, volatile cdkctrl_t *cp)
+static void stli_dodelaycmd(stliport_t *portp, volatile cdkctrl_t *cp)
 {
 	int	cmd;
 
@@ -2874,7 +2874,7 @@
  *	then port is still busy, otherwise no longer busy.
  */
 
-static inline int stli_hostcmd(stlibrd_t *brdp, stliport_t *portp)
+static int stli_hostcmd(stlibrd_t *brdp, stliport_t *portp)
 {
 	volatile cdkasy_t	*ap;
 	volatile cdkctrl_t	*cp;
@@ -3033,7 +3033,7 @@
  *	at the cdk header structure.
  */
 
-static inline void stli_brdpoll(stlibrd_t *brdp, volatile cdkhdr_t *hdrp)
+static void stli_brdpoll(stlibrd_t *brdp, volatile cdkhdr_t *hdrp)
 {
 	stliport_t	*portp;
 	unsigned char	hostbits[(STL_MAXCHANS / 8) + 1];
@@ -3306,7 +3306,7 @@
  *	we need to do here is set up the appropriate per port data structures.
  */
 
-static inline int stli_initports(stlibrd_t *brdp)
+static int stli_initports(stlibrd_t *brdp)
 {
 	stliport_t	*portp;
 	int		i, panelnr, panelport;
@@ -3918,7 +3918,7 @@
  *	board types.
  */
 
-static inline int stli_initecp(stlibrd_t *brdp)
+static int stli_initecp(stlibrd_t *brdp)
 {
 	cdkecpsig_t	sig;
 	cdkecpsig_t	*sigsp;
@@ -4079,7 +4079,7 @@
  *	This handles only these board types.
  */
 
-static inline int stli_initonb(stlibrd_t *brdp)
+static int stli_initonb(stlibrd_t *brdp)
 {
 	cdkonbsig_t	sig;
 	cdkonbsig_t	*sigsp;
@@ -4421,7 +4421,7 @@
  *	might be. This is a bit if hack, but it is the best we can do.
  */
 
-static inline int stli_eisamemprobe(stlibrd_t *brdp)
+static int stli_eisamemprobe(stlibrd_t *brdp)
 {
 	cdkecpsig_t	ecpsig, *ecpsigp;
 	cdkonbsig_t	onbsig, *onbsigp;
@@ -4525,7 +4525,7 @@
  *	do is go probing around in the usual places hoping we can find it.
  */
 
-static inline int stli_findeisabrds()
+static int stli_findeisabrds()
 {
 	stlibrd_t	*brdp;
 	unsigned int	iobase, eid;
@@ -4599,7 +4599,7 @@
  *	Find the next available board number that is free.
  */
 
-static inline int stli_getbrdnr()
+static int stli_getbrdnr()
 {
 	int	i;
 
@@ -4623,7 +4623,7 @@
  *	configuration space.
  */
 
-static inline int stli_initpcibrd(int brdtype, struct pci_dev *devp)
+static int stli_initpcibrd(int brdtype, struct pci_dev *devp)
 {
 	stlibrd_t	*brdp;
 
@@ -4669,7 +4669,7 @@
  *	one as it is found.
  */
 
-static inline int stli_findpcibrds()
+static int stli_findpcibrds()
 {
 	struct pci_dev	*dev = NULL;
 	int		rc;
@@ -4718,7 +4718,7 @@
  *	can find.
  */
 
-static inline int stli_initbrds()
+static int stli_initbrds()
 {
 	stlibrd_t	*brdp, *nxtbrdp;
 	stlconf_t	*confp;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

