Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVC0IDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVC0IDq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 03:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVC0IDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 03:03:46 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:29088 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261442AbVC0IDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 03:03:06 -0500
Date: Sun, 27 Mar 2005 09:03:04 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bk pull] DRM tree for 2.6.12 - fixes
Message-ID: <Pine.LNX.4.58.0503270900160.4567@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
	The latest DRM bitkeeper tree with any patches necessary for
2.6.12 is available.
	This fixes 2 big bugs introduced since 2.6.11 - one in AGP bridge
handling and the other for XFree86 4.3 users.. it also has an updated
radeon driver and some minor cleanups/fixes..

Please do a

	bk pull bk://drm.bkbits.net/drm-linus

This will include the latest DRM changes and will update the following files:

 drivers/char/agp/backend.c        |    1 +
 drivers/char/drm/drm_agpsupport.c |   15 ++++++++++-----
 drivers/char/drm/drm_core.h       |   14 +++++++-------
 drivers/char/drm/drm_drv.c        |   18 ++++++++----------
 drivers/char/drm/drm_os_linux.h   |    2 +-
 drivers/char/drm/drm_pciids.h     |    3 ++-
 drivers/char/drm/drm_stub.c       |    8 ++++----
 drivers/char/drm/drm_sysfs.c      |    4 ++--
 drivers/char/drm/radeon_drm.h     |    3 ++-
 drivers/char/drm/radeon_drv.h     |   10 ++++++++--
 drivers/char/drm/radeon_state.c   |   17 +++++++++++++++--
 11 files changed, 60 insertions(+), 35 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (05/03/27 1.2231)
   drm: free kbuf if copy from user fails..

   From: Eric Anholt <anholt@freebsd.org>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/27 1.2230)
   drm: radeon idct defines

   Add some type 3 idct packets for reference.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/27 1.2229)
   drm: radeon driver update 1.16

   add R200_EMIT_PP_TRI_PERF_CNTL packet to support brilinear filtering on r200
   fix a bug in the 1.15 merge also.

   From: Roland Scheidegger <rscheidegger_lists@hispeed.ch>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/27 1.2199.17.8)
   drm: change DRIVER_ to CORE_

   Change some defines to better naming.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/27 1.2199.17.7)
   Fix sparse NULL/0 warning:
   drivers/char/drm/radeon_state.c:1845:15: warning: Using plain integer as NULL
   pointer

   Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/27 1.2199.17.6)
   drm: Remove incorrect "drm_"-prefix from parameter description.

   Signed-off-by: Magnus Damm <damm@opensource.se>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/26 1.2199.17.5)
   drm: fixup pci ids

   Add new ATI PCI ID, and fixup i915GM one...

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/24 1.2199.17.4)
   agp: export agp_find_bridge for drm

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/24 1.2199.17.3)
   drm: fix issue where agp is acquired before agp_init

   With integrated chipsets ala i865 the X server acquires the bridge
   for 2D operations then the DRM acquires it for 3D kaboom..

   Based on patch from Brice Goglin <Brice.Goglin@ens-lyon.org> but I
   think this patch is safer if it can't find a bridge it acquires it.

   Tested on i865 (i830/i915) and Radeon on Xorg CVS and XFree86 4.3.0

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/24 1.2199.17.2)
   drm: issue with unique for XFree86 4.3 backwards compatibility

   This got broken at some stage not sure when exactly... but it caused
   XFree86 4.3 issues and I had to install sarge...

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (05/03/24 1.2199.17.1)
   verify_area is deprecated, replaced by access_ok.
   Seems I missed this one when I did the big overall conversion.


   Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/agp/backend.c b/drivers/char/agp/backend.c
--- a/drivers/char/agp/backend.c	2005-03-27 17:57:24 +10:00
+++ b/drivers/char/agp/backend.c	2005-03-27 17:57:24 +10:00
@@ -57,6 +57,7 @@
 LIST_HEAD(agp_bridges);
 EXPORT_SYMBOL(agp_bridge);
 EXPORT_SYMBOL(agp_bridges);
+EXPORT_SYMBOL(agp_find_bridge);

 /**
  *	agp_backend_acquire  -  attempt to acquire an agp backend.
diff -Nru a/drivers/char/drm/drm_agpsupport.c b/drivers/char/drm/drm_agpsupport.c
--- a/drivers/char/drm/drm_agpsupport.c	2005-03-27 17:57:24 +10:00
+++ b/drivers/char/drm/drm_agpsupport.c	2005-03-27 17:57:24 +10:00
@@ -387,12 +387,17 @@
 	if (!(head = drm_alloc(sizeof(*head), DRM_MEM_AGPLISTS)))
 		return NULL;
 	memset((void *)head, 0, sizeof(*head));
-	if (!(head->bridge = agp_backend_acquire(dev->pdev))) {
-		drm_free(head, sizeof(*head), DRM_MEM_AGPLISTS);
-		return NULL;
+	head->bridge = agp_find_bridge(dev->pdev);
+	if (!head->bridge) {
+		if (!(head->bridge = agp_backend_acquire(dev->pdev))) {
+			drm_free(head, sizeof(*head), DRM_MEM_AGPLISTS);
+			return NULL;
+		}
+		agp_copy_info(head->bridge, &head->agp_info);
+		agp_backend_release(head->bridge);
+	} else {
+		agp_copy_info(head->bridge, &head->agp_info);
 	}
-	agp_copy_info(head->bridge, &head->agp_info);
-	agp_backend_release(head->bridge);
 	if (head->agp_info.chipset == NOT_SUPPORTED) {
 		drm_free(head, sizeof(*head), DRM_MEM_AGPLISTS);
 		return NULL;
diff -Nru a/drivers/char/drm/drm_core.h b/drivers/char/drm/drm_core.h
--- a/drivers/char/drm/drm_core.h	2005-03-27 17:57:24 +10:00
+++ b/drivers/char/drm/drm_core.h	2005-03-27 17:57:24 +10:00
@@ -20,15 +20,15 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  * DEALINGS IN THE SOFTWARE.
  */
-#define DRIVER_AUTHOR		"Gareth Hughes, Leif Delgass, José Fonseca, Jon Smirl"
+#define CORE_AUTHOR		"Gareth Hughes, Leif Delgass, José Fonseca, Jon Smirl"

-#define DRIVER_NAME		"drm"
-#define DRIVER_DESC		"DRM shared core routines"
-#define DRIVER_DATE		"20040925"
+#define CORE_NAME		"drm"
+#define CORE_DESC		"DRM shared core routines"
+#define CORE_DATE		"20040925"

 #define DRM_IF_MAJOR	1
 #define DRM_IF_MINOR	2

-#define DRIVER_MAJOR	1
-#define DRIVER_MINOR	0
-#define DRIVER_PATCHLEVEL 0
+#define CORE_MAJOR	1
+#define CORE_MINOR	0
+#define CORE_PATCHLEVEL 0
diff -Nru a/drivers/char/drm/drm_drv.c b/drivers/char/drm/drm_drv.c
--- a/drivers/char/drm/drm_drv.c	2005-03-27 17:57:24 +10:00
+++ b/drivers/char/drm/drm_drv.c	2005-03-27 17:57:24 +10:00
@@ -15,10 +15,6 @@
  * #define DRIVER_DESC		"Matrox G200/G400"
  * #define DRIVER_DATE		"20001127"
  *
- * #define DRIVER_MAJOR		2
- * #define DRIVER_MINOR		0
- * #define DRIVER_PATCHLEVEL	2
- *
  * #define DRIVER_IOCTL_COUNT	DRM_ARRAY_SIZE( mga_ioctls )
  *
  * #define drm_x		mga_##x
@@ -144,6 +140,12 @@
 	if (dev->driver->pretakedown)
 	  dev->driver->pretakedown(dev);

+	if (dev->unique) {
+		drm_free(dev->unique, strlen(dev->unique) + 1, DRM_MEM_DRIVER);
+		dev->unique = NULL;
+		dev->unique_len = 0;
+	}
+
 	if ( dev->irq_enabled ) drm_irq_uninstall( dev );

 	down( &dev->struct_sem );
@@ -406,12 +408,8 @@
 	}

 	DRM_INFO( "Initialized %s %d.%d.%d %s\n",
-		DRIVER_NAME,
-		DRIVER_MAJOR,
-		DRIVER_MINOR,
-		DRIVER_PATCHLEVEL,
-		DRIVER_DATE
-		);
+		CORE_NAME, CORE_MAJOR, CORE_MINOR, CORE_PATCHLEVEL,
+		CORE_DATE);
 	return 0;
 err_p3:
 	drm_sysfs_destroy(drm_class);
diff -Nru a/drivers/char/drm/drm_os_linux.h b/drivers/char/drm/drm_os_linux.h
--- a/drivers/char/drm/drm_os_linux.h	2005-03-27 17:57:24 +10:00
+++ b/drivers/char/drm/drm_os_linux.h	2005-03-27 17:57:24 +10:00
@@ -89,7 +89,7 @@
 	copy_to_user(arg1, arg2, arg3)
 /* Macros for copyfrom user, but checking readability only once */
 #define DRM_VERIFYAREA_READ( uaddr, size ) 		\
-	verify_area( VERIFY_READ, uaddr, size )
+	(access_ok( VERIFY_READ, uaddr, size ) ? 0 : -EFAULT)
 #define DRM_COPY_FROM_USER_UNCHECKED(arg1, arg2, arg3) 	\
 	__copy_from_user(arg1, arg2, arg3)
 #define DRM_COPY_TO_USER_UNCHECKED(arg1, arg2, arg3)	\
diff -Nru a/drivers/char/drm/drm_pciids.h b/drivers/char/drm/drm_pciids.h
--- a/drivers/char/drm/drm_pciids.h	2005-03-27 17:57:24 +10:00
+++ b/drivers/char/drm/drm_pciids.h	2005-03-27 17:57:24 +10:00
@@ -50,6 +50,7 @@
 	{0x1002, 0x5158, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV200}, \
 	{0x1002, 0x5159, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV100}, \
 	{0x1002, 0x515A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV100}, \
+	{0x1002, 0x515E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV100}, \
 	{0x1002, 0x5168, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R200}, \
 	{0x1002, 0x5169, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R200}, \
 	{0x1002, 0x516A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R200}, \
@@ -218,6 +219,6 @@
 	{0x8086, 0x3582, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x8086, 0x2572, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x8086, 0x2582, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
-	{0x8086, 0x2982, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
+	{0x8086, 0x2592, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0, 0, 0}

diff -Nru a/drivers/char/drm/drm_stub.c b/drivers/char/drm/drm_stub.c
--- a/drivers/char/drm/drm_stub.c	2005-03-27 17:57:24 +10:00
+++ b/drivers/char/drm/drm_stub.c	2005-03-27 17:57:24 +10:00
@@ -40,11 +40,11 @@
 unsigned int drm_debug = 0;		/* 1 to enable debug output */
 EXPORT_SYMBOL(drm_debug);

-MODULE_AUTHOR( DRIVER_AUTHOR );
-MODULE_DESCRIPTION( DRIVER_DESC );
+MODULE_AUTHOR( CORE_AUTHOR );
+MODULE_DESCRIPTION( CORE_DESC );
 MODULE_LICENSE("GPL and additional rights");
-MODULE_PARM_DESC(drm_cards_limit, "Maximum number of graphics cards");
-MODULE_PARM_DESC(drm_debug, "Enable debug output");
+MODULE_PARM_DESC(cards_limit, "Maximum number of graphics cards");
+MODULE_PARM_DESC(debug, "Enable debug output");

 module_param_named(cards_limit, drm_cards_limit, int, 0444);
 module_param_named(debug, drm_debug, int, 0666);
diff -Nru a/drivers/char/drm/drm_sysfs.c b/drivers/char/drm/drm_sysfs.c
--- a/drivers/char/drm/drm_sysfs.c	2005-03-27 17:57:24 +10:00
+++ b/drivers/char/drm/drm_sysfs.c	2005-03-27 17:57:24 +10:00
@@ -55,8 +55,8 @@
 /* Display the version of drm_core. This doesn't work right in current design */
 static ssize_t version_show(struct class *dev, char *buf)
 {
-	return sprintf(buf, "%s %d.%d.%d %s\n", DRIVER_NAME, DRIVER_MAJOR,
-		       DRIVER_MINOR, DRIVER_PATCHLEVEL, DRIVER_DATE);
+	return sprintf(buf, "%s %d.%d.%d %s\n", CORE_NAME, CORE_MAJOR,
+		       CORE_MINOR, CORE_PATCHLEVEL, CORE_DATE);
 }

 static CLASS_ATTR(version, S_IRUGO, version_show, NULL);
diff -Nru a/drivers/char/drm/radeon_drm.h b/drivers/char/drm/radeon_drm.h
--- a/drivers/char/drm/radeon_drm.h	2005-03-27 17:57:24 +10:00
+++ b/drivers/char/drm/radeon_drm.h	2005-03-27 17:57:24 +10:00
@@ -152,7 +152,8 @@
 #define RADEON_EMIT_PP_CUBIC_OFFSETS_T1             81
 #define RADEON_EMIT_PP_CUBIC_FACES_2                82
 #define RADEON_EMIT_PP_CUBIC_OFFSETS_T2             83
-#define RADEON_MAX_STATE_PACKETS                    84
+#define R200_EMIT_PP_TRI_PERF_CNTL                  84
+#define RADEON_MAX_STATE_PACKETS                    85

 /* Commands understood by cmd_buffer ioctl.  More can be added but
  * obviously these can't be removed or changed:
diff -Nru a/drivers/char/drm/radeon_drv.h b/drivers/char/drm/radeon_drv.h
--- a/drivers/char/drm/radeon_drv.h	2005-03-27 17:57:24 +10:00
+++ b/drivers/char/drm/radeon_drv.h	2005-03-27 17:57:24 +10:00
@@ -38,7 +38,7 @@

 #define DRIVER_NAME		"radeon"
 #define DRIVER_DESC		"ATI Radeon"
-#define DRIVER_DATE		"20050125"
+#define DRIVER_DATE		"20050311"

 /* Interface history:
  *
@@ -80,9 +80,11 @@
  *     - Add R100/R200 surface allocation/free support
  * 1.15- Add support for texture micro tiling
  *     - Add support for r100 cube maps
+ * 1.16- Add R200_EMIT_PP_TRI_PERF_CNTL packet to support brilinear
+ *       texture filtering on r200
  */
 #define DRIVER_MAJOR		1
-#define DRIVER_MINOR		15
+#define DRIVER_MINOR		16
 #define DRIVER_PATCHLEVEL	0

 #define GET_RING_HEAD(dev_priv)		DRM_READ32(  (dev_priv)->ring_rptr, 0 )
@@ -652,6 +654,8 @@
 #	define RADEON_3D_DRAW_IMMD		0x00002900
 #	define RADEON_3D_DRAW_INDX		0x00002A00
 #	define RADEON_3D_LOAD_VBPNTR		0x00002F00
+#	define RADEON_MPEG_IDCT_MACROBLOCK	0x00003000
+#	define RADEON_MPEG_IDCT_MACROBLOCK_REV	0x00003100
 #	define RADEON_3D_CLEAR_ZMASK		0x00003200
 #	define RADEON_3D_CLEAR_HIZ		0x00003700
 #	define RADEON_CNTL_HOSTDATA_BLT		0x00009400
@@ -819,6 +823,8 @@
 #define R200_RB3D_BLENDCOLOR              0x3218

 #define R200_SE_TCL_POINT_SPRITE_CNTL     0x22c4
+
+#define R200_PP_TRI_PERF 0x2cf8

 /* Constants */
 #define RADEON_MAX_USEC_TIMEOUT		100000	/* 100 ms */
diff -Nru a/drivers/char/drm/radeon_state.c b/drivers/char/drm/radeon_state.c
--- a/drivers/char/drm/radeon_state.c	2005-03-27 17:57:24 +10:00
+++ b/drivers/char/drm/radeon_state.c	2005-03-27 17:57:24 +10:00
@@ -203,6 +203,10 @@
 	case RADEON_EMIT_PP_TEX_SIZE_2:
 	case R200_EMIT_RB3D_BLENDCOLOR:
 	case R200_EMIT_TCL_POINT_SPRITE_CNTL:
+	case RADEON_EMIT_PP_CUBIC_FACES_0:
+	case RADEON_EMIT_PP_CUBIC_FACES_1:
+	case RADEON_EMIT_PP_CUBIC_FACES_2:
+	case R200_EMIT_PP_TRI_PERF_CNTL:
 		/* These packets don't contain memory offsets */
 		break;

@@ -557,6 +561,13 @@
 	{ RADEON_PP_TEX_SIZE_2, 2, "RADEON_PP_TEX_SIZE_2" },
 	{ R200_RB3D_BLENDCOLOR, 3, "R200_RB3D_BLENDCOLOR" },
 	{ R200_SE_TCL_POINT_SPRITE_CNTL, 1, "R200_SE_TCL_POINT_SPRITE_CNTL" },
+	{ RADEON_PP_CUBIC_FACES_0, 1, "RADEON_PP_CUBIC_FACES_0"},
+	{ RADEON_PP_CUBIC_OFFSET_T0_0, 5, "RADEON_PP_CUBIC_OFFSET_T0_0"},
+	{ RADEON_PP_CUBIC_FACES_1, 1, "RADEON_PP_CUBIC_FACES_1"},
+	{ RADEON_PP_CUBIC_OFFSET_T1_0, 5, "RADEON_PP_CUBIC_OFFSET_T1_0"},
+	{ RADEON_PP_CUBIC_FACES_2, 1, "RADEON_PP_CUBIC_FACES_2"},
+	{ RADEON_PP_CUBIC_OFFSET_T2_0, 5, "RADEON_PP_CUBIC_OFFSET_T2_0"},
+	{ R200_PP_TRI_PERF, 2, "R200_PP_TRI_PERF"},
 };


@@ -1917,7 +1928,7 @@
 				dev_priv->surfaces[s->surface_index].refcount--;
 				if (dev_priv->surfaces[s->surface_index].refcount == 0)
 					dev_priv->surfaces[s->surface_index].flags = 0;
-				s->filp = 0;
+				s->filp = NULL;
 				radeon_apply_surface_regs(s->surface_index, dev_priv);
 				return 0;
 			}
@@ -2777,8 +2788,10 @@
 		kbuf = drm_alloc(cmdbuf.bufsz, DRM_MEM_DRIVER);
 		if (kbuf == NULL)
 			return DRM_ERR(ENOMEM);
-		if (DRM_COPY_FROM_USER(kbuf, cmdbuf.buf, cmdbuf.bufsz))
+		if (DRM_COPY_FROM_USER(kbuf, cmdbuf.buf, cmdbuf.bufsz)) {
+			drm_free(kbuf, orig_bufsz, DRM_MEM_DRIVER);
 			return DRM_ERR(EFAULT);
+		}
 		cmdbuf.buf = kbuf;
 	}

