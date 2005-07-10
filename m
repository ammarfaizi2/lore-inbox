Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVGJTka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVGJTka (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVGJTkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:40:24 -0400
Received: from ns2.suse.de ([195.135.220.15]:31708 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261565AbVGJTfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:34 -0400
Date: Sun, 10 Jul 2005 19:35:29 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: michael@mihu.de, kraxel@suse.de, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 21/82] remove linux/version.h from drivers/media/
Message-ID: <20050710193529.21.pUfAyp2837.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

remove code for obsolete kernels, drivers/media/video/bttvp.h has:
#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,15)

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/media/common/saa7146_fops.c     |    1 -
drivers/media/common/saa7146_i2c.c      |    5 -----
drivers/media/dvb/cinergyT2/cinergyT2.c |    1 -
drivers/media/dvb/dvb-core/dvb_net.c    |    5 -----
drivers/media/dvb/frontends/dib3000mb.c |    1 -
drivers/media/dvb/frontends/dib3000mc.c |    1 -
drivers/media/video/arv.c               |    1 -
drivers/media/video/bttv-cards.c        |   15 ---------------
drivers/media/video/zr36016.c           |    1 -
drivers/media/video/zr36050.c           |    1 -
drivers/media/video/zr36060.c           |    1 -
include/media/ir-common.h               |    1 -
include/media/saa7146.h                 |   10 ----------
13 files changed, 44 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/media/common/saa7146_fops.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/common/saa7146_fops.c
+++ linux-2.6.13-rc2-mm1/drivers/media/common/saa7146_fops.c
@@ -1,5 +1,4 @@
#include <media/saa7146_vv.h>
-#include <linux/version.h>

#define BOARD_CAN_DO_VBI(dev)   (dev->revision != 0 && dev->vv_data->vbi_minor != -1)

Index: linux-2.6.13-rc2-mm1/drivers/media/dvb/cinergyT2/cinergyT2.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/dvb/cinergyT2/cinergyT2.c
+++ linux-2.6.13-rc2-mm1/drivers/media/dvb/cinergyT2/cinergyT2.c
@@ -25,7 +25,6 @@
#include <linux/config.h>
#include <linux/init.h>
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/slab.h>
#include <linux/usb.h>
#include <linux/pci.h>
Index: linux-2.6.13-rc2-mm1/drivers/media/dvb/dvb-core/dvb_net.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/dvb/dvb-core/dvb_net.c
+++ linux-2.6.13-rc2-mm1/drivers/media/dvb/dvb-core/dvb_net.c
@@ -62,7 +62,6 @@
#include <linux/uio.h>
#include <asm/uaccess.h>
#include <linux/crc32.h>
-#include <linux/version.h>

#include "dvb_demux.h"
#include "dvb_net.h"
@@ -171,11 +170,7 @@ static unsigned short dvb_net_eth_type_t

skb->mac.raw=skb->data;
skb_pull(skb,dev->hard_header_len);
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,8)
-	eth = skb->mac.ethernet;
-#else
eth = eth_hdr(skb);
-#endif

if (*eth->h_dest & 1) {
if(memcmp(eth->h_dest,dev->broadcast, ETH_ALEN)==0)
Index: linux-2.6.13-rc2-mm1/drivers/media/dvb/frontends/dib3000mb.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/dvb/frontends/dib3000mb.c
+++ linux-2.6.13-rc2-mm1/drivers/media/dvb/frontends/dib3000mb.c
@@ -23,7 +23,6 @@

#include <linux/config.h>
#include <linux/kernel.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>
Index: linux-2.6.13-rc2-mm1/drivers/media/dvb/frontends/dib3000mc.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/dvb/frontends/dib3000mc.c
+++ linux-2.6.13-rc2-mm1/drivers/media/dvb/frontends/dib3000mc.c
@@ -22,7 +22,6 @@
*/
#include <linux/config.h>
#include <linux/kernel.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>
Index: linux-2.6.13-rc2-mm1/drivers/media/video/arv.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/video/arv.c
+++ linux-2.6.13-rc2-mm1/drivers/media/video/arv.c
@@ -22,7 +22,6 @@
#include <linux/init.h>
#include <linux/devfs_fs_kernel.h>
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/delay.h>
#include <linux/errno.h>
#include <linux/fs.h>
Index: linux-2.6.13-rc2-mm1/drivers/media/video/bttv-cards.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/video/bttv-cards.c
+++ linux-2.6.13-rc2-mm1/drivers/media/video/bttv-cards.c
@@ -3656,13 +3656,8 @@ gvbctv5pci_audio(struct bttv *btv, struc
{
unsigned int val, con;

-#if BTTV_VERSION_CODE > KERNEL_VERSION(0,8,0)
if (btv->radio_user)
return;
-#else
-	if (btv->radio)
-		return;
-#endif

val = gpio_read();
if (set) {
@@ -3851,13 +3846,8 @@ pvbt878p9b_audio(struct bttv *btv, struc
{
unsigned int val = 0;

-#if BTTV_VERSION_CODE > KERNEL_VERSION(0,8,0)
if (btv->radio_user)
return;
-#else
-	if (btv->radio)
-		return;
-#endif

if (set) {
if (v->mode & VIDEO_SOUND_MONO)	{
@@ -3888,13 +3878,8 @@ fv2000s_audio(struct bttv *btv, struct v
{
unsigned int val = 0xffff;

-#if BTTV_VERSION_CODE > KERNEL_VERSION(0,8,0)
if (btv->radio_user)
return;
-#else
-	if (btv->radio)
-		return;
-#endif
if (set) {
if (v->mode & VIDEO_SOUND_MONO)	{
val = 0x0000;
Index: linux-2.6.13-rc2-mm1/drivers/media/video/zr36016.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/video/zr36016.c
+++ linux-2.6.13-rc2-mm1/drivers/media/video/zr36016.c
@@ -26,7 +26,6 @@

#define ZR016_VERSION "v0.7"

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/drivers/media/video/zr36050.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/video/zr36050.c
+++ linux-2.6.13-rc2-mm1/drivers/media/video/zr36050.c
@@ -26,7 +26,6 @@

#define ZR050_VERSION "v0.7.1"

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/drivers/media/video/zr36060.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/video/zr36060.c
+++ linux-2.6.13-rc2-mm1/drivers/media/video/zr36060.c
@@ -26,7 +26,6 @@

#define ZR060_VERSION "v0.7"

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
Index: linux-2.6.13-rc2-mm1/include/media/ir-common.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/include/media/ir-common.h
+++ linux-2.6.13-rc2-mm1/include/media/ir-common.h
@@ -21,7 +21,6 @@
*  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

-#include <linux/version.h>
#include <linux/input.h>


Index: linux-2.6.13-rc2-mm1/include/media/saa7146.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/include/media/saa7146.h
+++ linux-2.6.13-rc2-mm1/include/media/saa7146.h
@@ -15,11 +15,6 @@
#include <linux/vmalloc.h>	/* for vmalloc() */
#include <linux/mm.h>		/* for vmalloc_to_page() */

-/* ugly, but necessary to build the dvb stuff under 2.4. */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#include "dvb_functions.h"
-#endif
-
#define SAA7146_VERSION_CODE KERNEL_VERSION(0,5,0)

#define saa7146_write(sxy,adr,dat)    writel((dat),(sxy->mem+(adr)))
@@ -33,13 +28,8 @@ extern unsigned int saa7146_debug;
#define DEBUG_VARIABLE saa7146_debug
#endif

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-#define DEBUG_PROLOG printk("%s: %s(): ",__stringify(KBUILD_BASENAME),__FUNCTION__)
-#define INFO(x) { printk("%s: ",__stringify(KBUILD_BASENAME)); printk x; }
-#else
#define DEBUG_PROLOG printk("%s: %s(): ",__stringify(KBUILD_MODNAME),__FUNCTION__)
#define INFO(x) { printk("%s: ",__stringify(KBUILD_MODNAME)); printk x; }
-#endif

#define ERR(x) { DEBUG_PROLOG; printk x; }

Index: linux-2.6.13-rc2-mm1/drivers/media/common/saa7146_i2c.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/common/saa7146_i2c.c
+++ linux-2.6.13-rc2-mm1/drivers/media/common/saa7146_i2c.c
@@ -1,4 +1,3 @@
-#include <linux/version.h>
#include <media/saa7146_vv.h>

static u32 saa7146_i2c_func(struct i2c_adapter *adapter)
@@ -404,12 +403,8 @@ int saa7146_i2c_adapter_prepare(struct s
saa7146_i2c_reset(dev);

if( NULL != i2c_adapter ) {
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-		i2c_adapter->data = dev;
-#else
BUG_ON(!i2c_adapter->class);
i2c_set_adapdata(i2c_adapter,dev);
-#endif
i2c_adapter->algo	   = &saa7146_algo;
i2c_adapter->algo_data     = NULL;
i2c_adapter->id		   = I2C_ALGO_SAA7146;
