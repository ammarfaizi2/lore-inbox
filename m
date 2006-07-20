Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWGTTFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWGTTFf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 15:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWGTTFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 15:05:34 -0400
Received: from student.uhasselt.be ([193.190.2.1]:21772 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP id S964831AbWGTTFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 15:05:33 -0400
Date: Thu, 20 Jul 2006 21:05:29 +0200
To: linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, chas@cmf.nrl.navy.mil, miquel@df.uba.ar,
       kkeil@suse.de, benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, jgarzik@pobox.com,
       vandrove@vc.cvut.cz, adaplas@pol.net, thomas@winischhofer.net,
       weissg@vienna.at, philb@gnu.org, linux-pcmcia@lists.infradead.org,
       jkmaline@cc.hut.fi, paulus@samba.org
Subject: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Message-ID: <20060720190529.GC7643@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

drivers: Conversions from kmalloc+memset to k(z|c)alloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
Second edition

 drivers/acpi/hotkey.c                      |    6 ++----
 drivers/atm/zatm.c                         |    6 ++----
 drivers/char/consolemap.c                  |    6 ++----
 drivers/char/keyboard.c                    |    4 ++--
 drivers/char/random.c                      |    6 ++----
 drivers/char/sx.c                          |   14 +-------------
 drivers/char/tty_io.c                      |   29 ++++++----------------------
 drivers/isdn/hisax/elsa_cs.c               |    3 +--
 drivers/isdn/hisax/hfc_usb.c               |    6 ++----
 drivers/isdn/hisax/sedlbauer_cs.c          |    3 +--
 drivers/isdn/hisax/teles_cs.c              |    3 +--
 drivers/isdn/hysdn/hysdn_proclog.c         |    7 ++++---
 drivers/isdn/i4l/isdn_v110.c               |    4 ++--
 drivers/macintosh/therm_windtunnel.c       |    4 ++--
 drivers/md/dm-mpath.c                      |    9 +++------
 drivers/media/video/planb.c                |    4 ++--
 drivers/mfd/mcp-core.c                     |    3 +--
 drivers/misc/ibmasm/module.c               |    3 +--
 drivers/mmc/mmc_sysfs.c                    |    4 +---
 drivers/net/e100.c                         |    4 ++--
 drivers/net/loopback.c                     |    3 +--
 drivers/net/pcmcia/ibmtr_cs.c              |    3 +--
 drivers/net/wireless/hostap/hostap_ioctl.c |   12 +++---------
 drivers/nubus/nubus.c                      |    8 ++++----
 drivers/parport/parport_cs.c               |    3 +--
 drivers/rapidio/rio-scan.c                 |    6 ++----
 drivers/scsi/ide-scsi.c                    |   16 +++++++--------
 drivers/scsi/megaraid.c                    |   10 +++++++---
 drivers/scsi/pcmcia/aha152x_stub.c         |    3 +--
 drivers/scsi/pcmcia/nsp_cs.c               |    3 +--
 drivers/scsi/sata_mv.c                     |    9 +++------
 drivers/scsi/sata_qstor.c                  |    3 +--
 drivers/scsi/sata_svw.c                    |    3 +--
 drivers/scsi/sata_sx4.c                    |    9 +++------
 drivers/scsi/sata_via.c                    |    3 +--
 drivers/scsi/sata_vsc.c                    |    3 +--
 drivers/serial/ip22zilog.c                 |   17 ++--------------
 drivers/serial/serial_core.c               |    7 ++-----
 drivers/usb/host/ohci-hcd.c                |    3 +--
 drivers/usb/host/sl811_cs.c                |    3 +--
 drivers/usb/serial/ark3116.c               |    3 +--
 drivers/usb/serial/console.c               |    6 ++----
 drivers/usb/serial/ti_usb_3410_5052.c      |    5 ++---
 drivers/video/amba-clcd.c                  |    3 +--
 drivers/video/aty/atyfb_base.c             |    3 +--
 drivers/video/au1100fb.c                   |    9 ++++-----
 drivers/video/au1200fb.c                   |    3 +--
 drivers/video/clps711xfb.c                 |    3 +--
 drivers/video/controlfb.c                  |    3 +--
 drivers/video/cyber2000fb.c                |    4 +---
 drivers/video/i810/i810_main.c             |    4 ++--
 drivers/video/igafb.c                      |    7 ++-----
 drivers/video/intelfb/intelfbdrv.c         |    3 +--
 drivers/video/matrox/matroxfb_crtc2.c      |    3 +--
 drivers/video/nvidia/nvidia.c              |    4 +---
 drivers/video/offb.c                       |    5 ++---
 drivers/video/pvr2fb.c                     |    4 +---
 drivers/video/pxafb.c                      |    3 +--
 drivers/video/retz3fb.c                    |    5 ++---
 drivers/video/riva/fbdev.c                 |    3 +--
 drivers/video/sa1100fb.c                   |    3 +--
 drivers/video/savage/savagefb_driver.c     |    3 +--
 drivers/video/sis/sis_main.c               |    3 +--
 drivers/video/sun3fb.c                     |    3 +--
 drivers/video/tgafb.c                      |    3 +--
 drivers/video/valkyriefb.c                 |    3 +--
 66 files changed, 119 insertions(+), 237 deletions(-)

diff --git a/drivers/acpi/hotkey.c b/drivers/acpi/hotkey.c
index 32c9d88..037d022 100644
--- a/drivers/acpi/hotkey.c
+++ b/drivers/acpi/hotkey.c
@@ -246,10 +246,8 @@ static char *format_result(union acpi_ob
 {
 	char *buf = NULL;
 
-	buf = (char *)kmalloc(RESULT_STR_LEN, GFP_KERNEL);
-	if (buf)
-		memset(buf, 0, RESULT_STR_LEN);
-	else
+	buf = kzalloc(RESULT_STR_LEN, GFP_KERNEL);
+	if (!buf)
 		goto do_fail;
 
 	/* Now, just support integer type */
diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index 2c65e82..438917e 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -603,9 +603,8 @@ static int start_rx(struct atm_dev *dev)
 DPRINTK("start_rx\n");
 	zatm_dev = ZATM_DEV(dev);
 	size = sizeof(struct atm_vcc *)*zatm_dev->chans;
-	zatm_dev->rx_map = (struct atm_vcc **) kmalloc(size,GFP_KERNEL);
+	zatm_dev->rx_map = kzalloc(size,GFP_KERNEL);
 	if (!zatm_dev->rx_map) return -ENOMEM;
-	memset(zatm_dev->rx_map,0,size);
 	/* set VPI/VCI split (use all VCIs and give what's left to VPIs) */
 	zpokel(zatm_dev,(1 << dev->ci_range.vci_bits)-1,uPD98401_VRR);
 	/* prepare free buffer pools */
@@ -951,9 +950,8 @@ static int open_tx_first(struct atm_vcc 
 	skb_queue_head_init(&zatm_vcc->tx_queue);
 	init_waitqueue_head(&zatm_vcc->tx_wait);
 	/* initialize ring */
-	zatm_vcc->ring = kmalloc(RING_SIZE,GFP_KERNEL);
+	zatm_vcc->ring = kzalloc(RING_SIZE,GFP_KERNEL);
 	if (!zatm_vcc->ring) return -ENOMEM;
-	memset(zatm_vcc->ring,0,RING_SIZE);
 	loop = zatm_vcc->ring+RING_ENTRIES*RING_WORDS;
 	loop[0] = uPD98401_TXPD_V;
 	loop[1] = loop[2] = 0;
diff --git a/drivers/char/consolemap.c b/drivers/char/consolemap.c
index 04a1202..b3f6c1b 100644
--- a/drivers/char/consolemap.c
+++ b/drivers/char/consolemap.c
@@ -192,8 +192,7 @@ static void set_inverse_transl(struct vc
 	q = p->inverse_translations[i];
 
 	if (!q) {
-		q = p->inverse_translations[i] = (unsigned char *) 
-			kmalloc(MAX_GLYPH, GFP_KERNEL);
+		q = p->inverse_translations[i] = kmalloc(MAX_GLYPH, GFP_KERNEL);
 		if (!q) return;
 	}
 	memset(q, 0, MAX_GLYPH);
@@ -443,12 +442,11 @@ int con_clear_unimap(struct vc_data *vc,
 	p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
 	if (p && p->readonly) return -EIO;
 	if (!p || --p->refcount) {
-		q = (struct uni_pagedir *)kmalloc(sizeof(*p), GFP_KERNEL);
+		q = kzalloc(sizeof(*p), GFP_KERNEL);
 		if (!q) {
 			if (p) p->refcount++;
 			return -ENOMEM;
 		}
-		memset(q, 0, sizeof(*q));
 		q->refcount=1;
 		*vc->vc_uni_pagedir_loc = (unsigned long)q;
 	} else {
diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 056ebe8..c39d9bc 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1298,9 +1298,9 @@ static struct input_handle *kbd_connect(
 	if (i == BTN_MISC && !test_bit(EV_SND, dev->evbit))
 		return NULL;
 
-	if (!(handle = kmalloc(sizeof(struct input_handle), GFP_KERNEL)))
+	handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
+	if (!handle)
 		return NULL;
-	memset(handle, 0, sizeof(struct input_handle));
 
 	handle->dev = dev;
 	handle->handler = handler;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4c3a5ca..0b520f6 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -911,9 +911,8 @@ void rand_initialize_irq(int irq)
 	 * If kmalloc returns null, we just won't use that entropy
 	 * source.
 	 */
-	state = kmalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
 	if (state) {
-		memset(state, 0, sizeof(struct timer_rand_state));
 		irq_timer_state[irq] = state;
 	}
 }
@@ -926,9 +925,8 @@ void rand_initialize_disk(struct gendisk
 	 * If kmalloc returns null, we just won't use that entropy
 	 * source.
 	 */
-	state = kmalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
 	if (state) {
-		memset(state, 0, sizeof(struct timer_rand_state));
 		disk->random = state;
 	}
 }
diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index e1cd2bc..22b240c 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -2278,18 +2278,6 @@ static int sx_init_drivers(void)
 	return 0;
 }
 
-
-static void * ckmalloc (int size)
-{
-	void *p;
-
-	p = kmalloc(size, GFP_KERNEL);
-	if (p) 
-		memset(p, 0, size);
-	return p;
-}
-
-
 static int sx_init_portstructs (int nboards, int nports)
 {
 	struct sx_board *board;
@@ -2302,7 +2290,7 @@ static int sx_init_portstructs (int nboa
 
 	/* Many drivers statically allocate the maximum number of ports
 	   There is no reason not to allocate them dynamically. Is there? -- REW */
-	sx_ports          = ckmalloc(nports * sizeof (struct sx_port));
+	sx_ports          = kcalloc(nports, sizeof (struct sx_port), GFP_KERNEL);
 	if (!sx_ports)
 		return -ENOMEM;
 
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index bfdb902..afcc4bb 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -153,17 +153,6 @@ int tty_ioctl(struct inode * inode, stru
 static int tty_fasync(int fd, struct file * filp, int on);
 static void release_mem(struct tty_struct *tty, int idx);
 
-
-static struct tty_struct *alloc_tty_struct(void)
-{
-	struct tty_struct *tty;
-
-	tty = kmalloc(sizeof(struct tty_struct), GFP_KERNEL);
-	if (tty)
-		memset(tty, 0, sizeof(struct tty_struct));
-	return tty;
-}
-
 static void tty_buffer_free_all(struct tty_struct *);
 
 static inline void free_tty_struct(struct tty_struct *tty)
@@ -1477,7 +1466,7 @@ static int init_dev(struct tty_driver *d
 	tp = o_tp = NULL;
 	ltp = o_ltp = NULL;
 
-	tty = alloc_tty_struct();
+	tty = kzalloc(sizeof(struct tty_struct), GFP_KERNEL);
 	if(!tty)
 		goto fail_no_mem;
 	initialize_tty_struct(tty);
@@ -1502,15 +1491,13 @@ static int init_dev(struct tty_driver *d
 	}
 
 	if (!*ltp_loc) {
-		ltp = (struct termios *) kmalloc(sizeof(struct termios),
-						 GFP_KERNEL);
+		ltp = kzalloc(sizeof(struct termios), GFP_KERNEL);
 		if (!ltp)
 			goto free_mem_out;
-		memset(ltp, 0, sizeof(struct termios));
 	}
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY) {
-		o_tty = alloc_tty_struct();
+		o_tty = kzalloc(sizeof(struct tty_struct), GFP_KERNEL);
 		if (!o_tty)
 			goto free_mem_out;
 		initialize_tty_struct(o_tty);
@@ -1535,11 +1522,9 @@ static int init_dev(struct tty_driver *d
 		}
 
 		if (!*o_ltp_loc) {
-			o_ltp = (struct termios *)
-				kmalloc(sizeof(struct termios), GFP_KERNEL);
+			o_ltp = kzalloc(sizeof(struct termios), GFP_KERNEL);
 			if (!o_ltp)
 				goto free_mem_out;
-			memset(o_ltp, 0, sizeof(struct termios));
 		}
 
 		/*
@@ -2996,9 +2981,8 @@ struct tty_driver *alloc_tty_driver(int 
 {
 	struct tty_driver *driver;
 
-	driver = kmalloc(sizeof(struct tty_driver), GFP_KERNEL);
+	driver = kzalloc(sizeof(struct tty_driver), GFP_KERNEL);
 	if (driver) {
-		memset(driver, 0, sizeof(struct tty_driver));
 		driver->magic = TTY_DRIVER_MAGIC;
 		driver->num = lines;
 		/* later we'll move allocation of tables here */
@@ -3057,10 +3041,9 @@ int tty_register_driver(struct tty_drive
 		return 0;
 
 	if (!(driver->flags & TTY_DRIVER_DEVPTS_MEM)) {
-		p = kmalloc(driver->num * 3 * sizeof(void *), GFP_KERNEL);
+		p = kcalloc(driver->num * 3, sizeof(void *), GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;
-		memset(p, 0, driver->num * 3 * sizeof(void *));
 	}
 
 	if (!driver->major) {
diff --git a/drivers/isdn/hisax/elsa_cs.c b/drivers/isdn/hisax/elsa_cs.c
index e18e75b..be625b7 100644
--- a/drivers/isdn/hisax/elsa_cs.c
+++ b/drivers/isdn/hisax/elsa_cs.c
@@ -146,9 +146,8 @@ static int elsa_cs_probe(struct pcmcia_d
     DEBUG(0, "elsa_cs_attach()\n");
 
     /* Allocate space for private device-specific data */
-    local = kmalloc(sizeof(local_info_t), GFP_KERNEL);
+    local = kzalloc(sizeof(local_info_t), GFP_KERNEL);
     if (!local) return -ENOMEM;
-    memset(local, 0, sizeof(local_info_t));
 
     local->p_dev = link;
     link->priv = local;
diff --git a/drivers/isdn/hisax/hfc_usb.c b/drivers/isdn/hisax/hfc_usb.c
index b5e571a..8373ce4 100644
--- a/drivers/isdn/hisax/hfc_usb.c
+++ b/drivers/isdn/hisax/hfc_usb.c
@@ -1479,11 +1479,9 @@ #endif
 		/* found a valid USB Ta Endpint config */
 		if (small_match != 0xffff) {
 			iface = iface_used;
-			if (!
-			    (context =
-			     kmalloc(sizeof(hfcusb_data), GFP_KERNEL)))
+			context = kzalloc(sizeof(hfcusb_data), GFP_KERNEL);
+			if (!context)
 				return (-ENOMEM);	/* got no mem */
-			memset(context, 0, sizeof(hfcusb_data));
 
 			ep = iface->endpoint;
 			vcf = validconf[small_match];
diff --git a/drivers/isdn/hisax/sedlbauer_cs.c b/drivers/isdn/hisax/sedlbauer_cs.c
index f9c14a2..3255a0c 100644
--- a/drivers/isdn/hisax/sedlbauer_cs.c
+++ b/drivers/isdn/hisax/sedlbauer_cs.c
@@ -155,9 +155,8 @@ static int sedlbauer_probe(struct pcmcia
     DEBUG(0, "sedlbauer_attach()\n");
 
     /* Allocate space for private device-specific data */
-    local = kmalloc(sizeof(local_info_t), GFP_KERNEL);
+    local = kzalloc(sizeof(local_info_t), GFP_KERNEL);
     if (!local) return -ENOMEM;
-    memset(local, 0, sizeof(local_info_t));
     local->cardnr = -1;
 
     local->p_dev = link;
diff --git a/drivers/isdn/hisax/teles_cs.c b/drivers/isdn/hisax/teles_cs.c
index afcc2ae..a1f91f6 100644
--- a/drivers/isdn/hisax/teles_cs.c
+++ b/drivers/isdn/hisax/teles_cs.c
@@ -137,9 +137,8 @@ static int teles_probe(struct pcmcia_dev
     DEBUG(0, "teles_attach()\n");
 
     /* Allocate space for private device-specific data */
-    local = kmalloc(sizeof(local_info_t), GFP_KERNEL);
+    local = kzalloc(sizeof(local_info_t), GFP_KERNEL);
     if (!local) return -ENOMEM;
-    memset(local, 0, sizeof(local_info_t));
     local->cardnr = -1;
 
     local->p_dev = link;
diff --git a/drivers/isdn/hysdn/hysdn_proclog.c b/drivers/isdn/hysdn/hysdn_proclog.c
index c4301e8..e125c5a 100644
--- a/drivers/isdn/hysdn/hysdn_proclog.c
+++ b/drivers/isdn/hysdn/hysdn_proclog.c
@@ -111,7 +111,8 @@ put_log_buffer(hysdn_card * card, char *
 	if (pd->if_used <= 0)
 		return;		/* no open file for read */
 
-	if (!(ib = (struct log_data *) kmalloc(sizeof(struct log_data) + strlen(cp), GFP_ATOMIC)))
+	ib = kmalloc(sizeof(struct log_data) + strlen(cp), GFP_ATOMIC);
+	if (!ib)
 		 return;	/* no memory */
 	strcpy(ib->log_start, cp);	/* set output string */
 	ib->next = NULL;
@@ -408,8 +409,8 @@ hysdn_proclog_init(hysdn_card * card)
 
 	/* create a cardlog proc entry */
 
-	if ((pd = (struct procdata *) kmalloc(sizeof(struct procdata), GFP_KERNEL)) != NULL) {
-		memset(pd, 0, sizeof(struct procdata));
+	pd = kzalloc(sizeof(struct procdata), GFP_KERNEL);
+	if (pd) {
 		sprintf(pd->log_name, "%s%d", PROC_LOG_BASENAME, card->myid);
 		if ((pd->log = create_proc_entry(pd->log_name, S_IFREG | S_IRUGO | S_IWUSR, hysdn_proc_entry)) != NULL) {
 		        pd->log->proc_fops = &log_fops; 
diff --git a/drivers/isdn/i4l/isdn_v110.c b/drivers/isdn/i4l/isdn_v110.c
index 38619e8..8ac2e9b 100644
--- a/drivers/isdn/i4l/isdn_v110.c
+++ b/drivers/isdn/i4l/isdn_v110.c
@@ -92,9 +92,9 @@ isdn_v110_open(unsigned char key, int hd
 	int i;
 	isdn_v110_stream *v;
 
-	if ((v = kmalloc(sizeof(isdn_v110_stream), GFP_ATOMIC)) == NULL)
+	v = kzalloc(sizeof(isdn_v110_stream), GFP_ATOMIC);
+	if (!v)
 		return NULL;
-	memset(v, 0, sizeof(isdn_v110_stream));
 	v->key = key;
 	v->nbits = 0;
 	for (i = 0; key & (1 << i); i++)
diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index c7d1c29..34fd26e 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -430,9 +430,9 @@ do_probe( struct i2c_adapter *adapter, i
 				     | I2C_FUNC_SMBUS_WRITE_BYTE) )
 		return 0;
 
-	if( !(cl=kmalloc(sizeof(*cl), GFP_KERNEL)) )
+	cl = kzalloc(sizeof(*cl), GFP_KERNEL);
+	if( !cl )
 		return -ENOMEM;
-	memset( cl, 0, sizeof(struct i2c_client) );
 
 	cl->addr = addr;
 	cl->adapter = adapter;
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 217615b..0b69351 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -114,10 +114,9 @@ static void trigger_event(void *data);
 
 static struct pgpath *alloc_pgpath(void)
 {
-	struct pgpath *pgpath = kmalloc(sizeof(*pgpath), GFP_KERNEL);
+	struct pgpath *pgpath = kzalloc(sizeof(*pgpath), GFP_KERNEL);
 
 	if (pgpath) {
-		memset(pgpath, 0, sizeof(*pgpath));
 		pgpath->path.is_active = 1;
 	}
 
@@ -133,11 +132,10 @@ static struct priority_group *alloc_prio
 {
 	struct priority_group *pg;
 
-	pg = kmalloc(sizeof(*pg), GFP_KERNEL);
+	pg = kzalloc(sizeof(*pg), GFP_KERNEL);
 	if (!pg)
 		return NULL;
 
-	memset(pg, 0, sizeof(*pg));
 	INIT_LIST_HEAD(&pg->pgpaths);
 
 	return pg;
@@ -172,9 +170,8 @@ static struct multipath *alloc_multipath
 {
 	struct multipath *m;
 
-	m = kmalloc(sizeof(*m), GFP_KERNEL);
+	m = kzalloc(sizeof(*m), GFP_KERNEL);
 	if (m) {
-		memset(m, 0, sizeof(*m));
 		INIT_LIST_HEAD(&m->priority_groups);
 		spin_lock_init(&m->lock);
 		m->queue_io = 1;
diff --git a/drivers/media/video/planb.c b/drivers/media/video/planb.c
index 3484e36..25f8485 100644
--- a/drivers/media/video/planb.c
+++ b/drivers/media/video/planb.c
@@ -353,9 +353,9 @@ static int planb_prepare_open(struct pla
 		* PLANB_DUMMY)*sizeof(struct dbdma_cmd)
 		+(PLANB_MAXLINES*((PLANB_MAXPIXELS+7)& ~7))/8
 		+MAX_GBUFFERS*sizeof(unsigned int);
-	if ((pb->priv_space = kmalloc (size, GFP_KERNEL)) == 0)
+	pb->priv_space = kzalloc (size, GFP_KERNEL);
+	if (!pb->priv_space)
 		return -ENOMEM;
-	memset ((void *) pb->priv_space, 0, size);
 	pb->overlay_last1 = pb->ch1_cmd = (volatile struct dbdma_cmd *)
 						DBDMA_ALIGN (pb->priv_space);
 	pb->overlay_last2 = pb->ch2_cmd = pb->ch1_cmd + pb->tab_size;
diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index 75f401d..b4ed57e 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -200,9 +200,8 @@ struct mcp *mcp_host_alloc(struct device
 {
 	struct mcp *mcp;
 
-	mcp = kmalloc(sizeof(struct mcp) + size, GFP_KERNEL);
+	mcp = kzalloc(sizeof(struct mcp) + size, GFP_KERNEL);
 	if (mcp) {
-		memset(mcp, 0, sizeof(struct mcp) + size);
 		spin_lock_init(&mcp->lock);
 		mcp->attached_device.parent = parent;
 		mcp->attached_device.bus = &mcp_bus_type;
diff --git a/drivers/misc/ibmasm/module.c b/drivers/misc/ibmasm/module.c
index 2f3bddf..80d2798 100644
--- a/drivers/misc/ibmasm/module.c
+++ b/drivers/misc/ibmasm/module.c
@@ -77,13 +77,12 @@ static int __devinit ibmasm_init_one(str
 	/* vnc client won't work without bus-mastering */
 	pci_set_master(pdev);
 
-	sp = kmalloc(sizeof(struct service_processor), GFP_KERNEL);
+	sp = kzalloc(sizeof(struct service_processor), GFP_KERNEL);
 	if (sp == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate memory\n");
 		result = -ENOMEM;
 		goto error_kmalloc;
 	}
-	memset(sp, 0, sizeof(struct service_processor));
 
 	spin_lock_init(&sp->lock);
 	INIT_LIST_HEAD(&sp->command_queue);
diff --git a/drivers/mmc/mmc_sysfs.c b/drivers/mmc/mmc_sysfs.c
index a2a35fd..db4cac5 100644
--- a/drivers/mmc/mmc_sysfs.c
+++ b/drivers/mmc/mmc_sysfs.c
@@ -262,10 +262,8 @@ struct mmc_host *mmc_alloc_host_sysfs(in
 {
 	struct mmc_host *host;
 
-	host = kmalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
+	host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
 	if (host) {
-		memset(host, 0, sizeof(struct mmc_host) + extra);
-
 		host->dev = dev;
 		host->class_dev.dev = host->dev;
 		host->class_dev.class = &mmc_host_class;
diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index 91ef5f2..a45fbd6 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -1930,9 +1930,9 @@ static int e100_rx_alloc_list(struct nic
 	nic->rx_to_use = nic->rx_to_clean = NULL;
 	nic->ru_running = RU_UNINITIALIZED;
 
-	if(!(nic->rxs = kmalloc(sizeof(struct rx) * count, GFP_ATOMIC)))
+	nic->rxs = kcalloc(count, sizeof(struct rx), GFP_ATOMIC);
+	if(!nic->rxs)
 		return -ENOMEM;
-	memset(nic->rxs, 0, sizeof(struct rx) * count);
 
 	for(rx = nic->rxs, i = 0; i < count; rx++, i++) {
 		rx->next = (i + 1 < count) ? rx + 1 : nic->rxs;
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 997cbce..ccfb96a 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -224,9 +224,8 @@ int __init loopback_init(void)
 	struct net_device_stats *stats;
 
 	/* Can survive without statistics */
-	stats = kmalloc(sizeof(struct net_device_stats), GFP_KERNEL);
+	stats = kzalloc(sizeof(struct net_device_stats), GFP_KERNEL);
 	if (stats) {
-		memset(stats, 0, sizeof(struct net_device_stats));
 		loopback_dev.priv = stats;
 		loopback_dev.get_stats = &get_stats;
 	}
diff --git a/drivers/net/pcmcia/ibmtr_cs.c b/drivers/net/pcmcia/ibmtr_cs.c
index b8fe70b..b4e363a 100644
--- a/drivers/net/pcmcia/ibmtr_cs.c
+++ b/drivers/net/pcmcia/ibmtr_cs.c
@@ -146,9 +146,8 @@ static int ibmtr_attach(struct pcmcia_de
     DEBUG(0, "ibmtr_attach()\n");
 
     /* Create new token-ring device */
-    info = kmalloc(sizeof(*info), GFP_KERNEL); 
+    info = kzalloc(sizeof(*info), GFP_KERNEL);
     if (!info) return -ENOMEM;
-    memset(info,0,sizeof(*info));
     dev = alloc_trdev(sizeof(struct tok_info));
     if (!dev) {
 	kfree(info);
diff --git a/drivers/net/wireless/hostap/hostap_ioctl.c b/drivers/net/wireless/hostap/hostap_ioctl.c
index 8399de5..dfeeda2 100644
--- a/drivers/net/wireless/hostap/hostap_ioctl.c
+++ b/drivers/net/wireless/hostap/hostap_ioctl.c
@@ -181,12 +181,10 @@ static int prism2_ioctl_siwencode(struct
 		struct ieee80211_crypt_data *new_crypt;
 
 		/* take WEP into use */
-		new_crypt = (struct ieee80211_crypt_data *)
-			kmalloc(sizeof(struct ieee80211_crypt_data),
+		new_crypt = kzalloc(sizeof(struct ieee80211_crypt_data),
 				GFP_KERNEL);
 		if (new_crypt == NULL)
 			return -ENOMEM;
-		memset(new_crypt, 0, sizeof(struct ieee80211_crypt_data));
 		new_crypt->ops = ieee80211_get_crypto_ops("WEP");
 		if (!new_crypt->ops) {
 			request_module("ieee80211_crypt_wep");
@@ -3320,14 +3318,12 @@ static int prism2_ioctl_siwencodeext(str
 
 		prism2_crypt_delayed_deinit(local, crypt);
 
-		new_crypt = (struct ieee80211_crypt_data *)
-			kmalloc(sizeof(struct ieee80211_crypt_data),
+		new_crypt = kzalloc(sizeof(struct ieee80211_crypt_data),
 				GFP_KERNEL);
 		if (new_crypt == NULL) {
 			ret = -ENOMEM;
 			goto done;
 		}
-		memset(new_crypt, 0, sizeof(struct ieee80211_crypt_data));
 		new_crypt->ops = ops;
 		new_crypt->priv = new_crypt->ops->init(i);
 		if (new_crypt->priv == NULL) {
@@ -3538,14 +3534,12 @@ static int prism2_ioctl_set_encryption(l
 
 		prism2_crypt_delayed_deinit(local, crypt);
 
-		new_crypt = (struct ieee80211_crypt_data *)
-			kmalloc(sizeof(struct ieee80211_crypt_data),
+		new_crypt = kzalloc(sizeof(struct ieee80211_crypt_data),
 				GFP_KERNEL);
 		if (new_crypt == NULL) {
 			ret = -ENOMEM;
 			goto done;
 		}
-		memset(new_crypt, 0, sizeof(struct ieee80211_crypt_data));
 		new_crypt->ops = ops;
 		new_crypt->priv = new_crypt->ops->init(param->u.crypt.idx);
 		if (new_crypt->priv == NULL) {
diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index 3a0a3a7..da52dbe 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -466,9 +466,9 @@ static struct nubus_dev* __init
 		       parent->base, dir.base);
 
 	/* Actually we should probably panic if this fails */
-	if ((dev = kmalloc(sizeof(*dev), GFP_ATOMIC)) == NULL)
+	dev = kzalloc(sizeof(*dev), GFP_ATOMIC);
+	if (!dev)
 		return NULL;	
-	memset(dev, 0, sizeof(*dev));
 	dev->resid = parent->type;
 	dev->directory = dir.base;
 	dev->board = board;
@@ -800,9 +800,9 @@ static struct nubus_board* __init nubus_
 	nubus_rewind(&rp, FORMAT_BLOCK_SIZE, bytelanes);
 
 	/* Actually we should probably panic if this fails */
-	if ((board = kmalloc(sizeof(*board), GFP_ATOMIC)) == NULL)
+	board = kzalloc(sizeof(*board), GFP_ATOMIC);
+	if (!board)
 		return NULL;	
-	memset(board, 0, sizeof(*board));
 	board->fblock = rp;
 
 	/* Dump the format block for debugging purposes */
diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index b953d59..2ac1269 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -106,9 +106,8 @@ static int parport_probe(struct pcmcia_d
     DEBUG(0, "parport_attach()\n");
 
     /* Create new parport device */
-    info = kmalloc(sizeof(*info), GFP_KERNEL);
+    info = kzalloc(sizeof(*info), GFP_KERNEL);
     if (!info) return -ENOMEM;
-    memset(info, 0, sizeof(*info));
     link->priv = info;
     info->p_dev = link;
 
diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 7bf7b2c..50051e0 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -297,11 +297,10 @@ static struct rio_dev *rio_setup_device(
 	struct rio_switch *rswitch;
 	int result, rdid;
 
-	rdev = kmalloc(sizeof(struct rio_dev), GFP_KERNEL);
+	rdev = kzalloc(sizeof(struct rio_dev), GFP_KERNEL);
 	if (!rdev)
 		goto out;
 
-	memset(rdev, 0, sizeof(struct rio_dev));
 	rdev->net = net;
 	rio_mport_read_config_32(port, destid, hopcount, RIO_DEV_ID_CAR,
 				 &result);
@@ -784,9 +783,8 @@ static struct rio_net __devinit *rio_all
 {
 	struct rio_net *net;
 
-	net = kmalloc(sizeof(struct rio_net), GFP_KERNEL);
+	net = kzalloc(sizeof(struct rio_net), GFP_KERNEL);
 	if (net) {
-		memset(net, 0, sizeof(struct rio_net));
 		INIT_LIST_HEAD(&net->node);
 		INIT_LIST_HEAD(&net->devices);
 		INIT_LIST_HEAD(&net->mports);
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index f7b5d73..c362d20 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -259,9 +259,9 @@ static inline void idescsi_transform_pc1
 			unsigned short new_len;
 			if (!scsi_buf)
 				return;
-			if ((atapi_buf = kmalloc(pc->buffer_size + 4, GFP_ATOMIC)) == NULL)
+			atapi_buf = kzalloc(pc->buffer_size + 4, GFP_ATOMIC);
+			if (!atapi_buf)
 				return;
-			memset(atapi_buf, 0, pc->buffer_size + 4);
 			memset (c, 0, 12);
 			c[0] = sc[0] | 0x40;
 			c[1] = sc[1];
@@ -327,17 +327,15 @@ static int idescsi_check_condition(ide_d
 	u8             *buf;
 
 	/* stuff a sense request in front of our current request */
-	pc = kmalloc (sizeof (idescsi_pc_t), GFP_ATOMIC);
-	rq = kmalloc (sizeof (struct request), GFP_ATOMIC);
-	buf = kmalloc(SCSI_SENSE_BUFFERSIZE, GFP_ATOMIC);
+	pc = kzalloc(sizeof(*pc), GFP_ATOMIC);
+	rq = kmalloc(sizeof(*rq), GFP_ATOMIC);
+	buf = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_ATOMIC);
 	if (pc == NULL || rq == NULL || buf == NULL) {
 		kfree(buf);
 		kfree(rq);
 		kfree(pc);
 		return -ENOMEM;
 	}
-	memset (pc, 0, sizeof (idescsi_pc_t));
-	memset (buf, 0, SCSI_SENSE_BUFFERSIZE);
 	ide_init_drive_cmd(rq);
 	rq->special = (char *) pc;
 	pc->rq = rq;
@@ -899,8 +897,8 @@ static int idescsi_queue (struct scsi_cm
 		goto abort;
 	}
 	scsi = drive_to_idescsi(drive);
-	pc = kmalloc (sizeof (idescsi_pc_t), GFP_ATOMIC);
-	rq = kmalloc (sizeof (struct request), GFP_ATOMIC);
+	pc = kmalloc(sizeof(*pc), GFP_ATOMIC);
+	rq = kmalloc(sizeof(*rq), GFP_ATOMIC);
 	if (rq == NULL || pc == NULL) {
 		printk (KERN_ERR "ide-scsi: %s: out of memory\n", drive->name);
 		goto abort;
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 76edbb6..4ba63d6 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -4487,8 +4487,12 @@ mega_internal_command(adapter_t *adapter
 	scmd = &adapter->int_scmd;
 	memset(scmd, 0, sizeof(Scsi_Cmnd));
 
-	sdev = kmalloc(sizeof(struct scsi_device), GFP_KERNEL);
-	memset(sdev, 0, sizeof(struct scsi_device));
+	sdev = kzalloc(sizeof(struct scsi_device), GFP_KERNEL);
+	if (!sdev) {
+		rval = -ENOMEM;
+		printk(KERN_ERR "megaraid: memory allocation failed\n");
+		goto out;
+	}
 	scmd->device = sdev;
 
 	scmd->device->host = adapter->host;
@@ -4526,7 +4530,7 @@ mega_internal_command(adapter_t *adapter
 		printk("megaraid: cmd [%x, %x, %x] status:[%x]\n",
 			mc->cmd, mc->opcode, mc->subopcode, scmd->result);
 	}
-
+out:
 	mutex_unlock(&adapter->int_mtx);
 
 	return rval;
diff --git a/drivers/scsi/pcmcia/aha152x_stub.c b/drivers/scsi/pcmcia/aha152x_stub.c
index ee449b2..02fff2f 100644
--- a/drivers/scsi/pcmcia/aha152x_stub.c
+++ b/drivers/scsi/pcmcia/aha152x_stub.c
@@ -107,9 +107,8 @@ static int aha152x_probe(struct pcmcia_d
     DEBUG(0, "aha152x_attach()\n");
 
     /* Create new SCSI device */
-    info = kmalloc(sizeof(*info), GFP_KERNEL);
+    info = kzalloc(sizeof(*info), GFP_KERNEL);
     if (!info) return -ENOMEM;
-    memset(info, 0, sizeof(*info));
     info->p_dev = link;
     link->priv = info;
 
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index 0d4c04e..f8004db 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -1602,9 +1602,8 @@ static int nsp_cs_probe(struct pcmcia_de
 	nsp_dbg(NSP_DEBUG_INIT, "in");
 
 	/* Create new SCSI device */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (info == NULL) { return -ENOMEM; }
-	memset(info, 0, sizeof(*info));
 	info->p_dev = link;
 	link->priv = info;
 	data->ScsiInfo = info;
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 1053c7c..7473643 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -883,10 +883,9 @@ static int mv_port_start(struct ata_port
 	dma_addr_t mem_dma;
 	int rc = -ENOMEM;
 
-	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
 	if (!pp)
 		goto err_out;
-	memset(pp, 0, sizeof(*pp));
 
 	mem = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA_SZ, &mem_dma,
 				 GFP_KERNEL);
@@ -2365,13 +2364,12 @@ static int mv_init_one(struct pci_dev *p
 		goto err_out;
 	}
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
@@ -2381,12 +2379,11 @@ static int mv_init_one(struct pci_dev *p
 		goto err_out_free_ent;
 	}
 
-	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
+	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv) {
 		rc = -ENOMEM;
 		goto err_out_iounmap;
 	}
-	memset(hpriv, 0, sizeof(*hpriv));
 
 	probe_ent->sht = mv_port_info[board_idx].sht;
 	probe_ent->host_flags = mv_port_info[board_idx].host_flags;
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index d374c1d..107c0cd 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -662,13 +662,12 @@ static int qs_ata_init_one(struct pci_de
 	if (rc)
 		goto err_out_iounmap;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;
 		goto err_out_iounmap;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 7d08580..f3965d9 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -394,13 +394,12 @@ static int k2_sata_init_one (struct pci_
 	if (rc)
 		goto err_out_regions;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index ccc8cad..31fba65 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -266,12 +266,11 @@ static int pdc_port_start(struct ata_por
 	if (rc)
 		return rc;
 
-	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
 	if (!pp) {
 		rc = -ENOMEM;
 		goto err_out;
 	}
-	memset(pp, 0, sizeof(*pp));
 
 	pp->pkt = dma_alloc_coherent(dev, 128, &pp->pkt_dma, GFP_KERNEL);
 	if (!pp->pkt) {
@@ -1395,13 +1394,12 @@ static int pdc_sata_init_one (struct pci
 	if (rc)
 		goto err_out_regions;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
@@ -1412,12 +1410,11 @@ static int pdc_sata_init_one (struct pci
 	}
 	base = (unsigned long) mmio_base;
 
-	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
+	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv) {
 		rc = -ENOMEM;
 		goto err_out_iounmap;
 	}
-	memset(hpriv, 0, sizeof(*hpriv));
 
 	dimm_mmio = pci_iomap(pdev, 4, 0);
 	if (!dimm_mmio) {
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 03baec2..a9c7687 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -229,11 +229,10 @@ static struct ata_probe_ent *vt6421_init
 	struct ata_probe_ent *probe_ent;
 	unsigned int i;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (!probe_ent)
 		return NULL;
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index ad37871..f5e8d14 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -373,12 +373,11 @@ static int __devinit vsc_sata_init_one (
 	if (rc)
 		goto err_out_regions;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
diff --git a/drivers/serial/ip22zilog.c b/drivers/serial/ip22zilog.c
index 5ff269f..35bcba3 100644
--- a/drivers/serial/ip22zilog.c
+++ b/drivers/serial/ip22zilog.c
@@ -922,23 +922,10 @@ static struct zilog_layout **ip22zilog_c
 static struct uart_ip22zilog_port *ip22zilog_irq_chain;
 static int zilog_irq = -1;
 
-static void * __init alloc_one_table(unsigned long size)
-{
-	void *ret;
-
-	ret = kmalloc(size, GFP_KERNEL);
-	if (ret != NULL)
-		memset(ret, 0, size);
-
-	return ret;
-}
-
 static void __init ip22zilog_alloc_tables(void)
 {
-	ip22zilog_port_table = (struct uart_ip22zilog_port *)
-		alloc_one_table(NUM_CHANNELS * sizeof(struct uart_ip22zilog_port));
-	ip22zilog_chip_regs = (struct zilog_layout **)
-		alloc_one_table(NUM_IP22ZILOG * sizeof(struct zilog_layout *));
+	ip22zilog_port_table = kcalloc(NUM_CHANNELS, sizeof(struct uart_ip22zilog_port), GFP_KERNEL);
+	ip22zilog_chip_regs = kcalloc(NUM_IP22ZILOG, sizeof(struct zilog_layout *), GFP_KERNEL);
 
 	if (ip22zilog_port_table == NULL || ip22zilog_chip_regs == NULL) {
 		panic("IP22-Zilog: Cannot allocate IP22-Zilog tables.");
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 80ef7d4..8d437d6 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1522,9 +1522,8 @@ static struct uart_state *uart_get(struc
 	}
 
 	if (!state->info) {
-		state->info = kmalloc(sizeof(struct uart_info), GFP_KERNEL);
+		state->info = kzalloc(sizeof(struct uart_info), GFP_KERNEL);
 		if (state->info) {
-			memset(state->info, 0, sizeof(struct uart_info));
 			init_waitqueue_head(&state->info->open_wait);
 			init_waitqueue_head(&state->info->delta_msr_wait);
 
@@ -2147,13 +2146,11 @@ int uart_register_driver(struct uart_dri
 	 * Maybe we should be using a slab cache for this, especially if
 	 * we have a large number of ports to handle.
 	 */
-	drv->state = kmalloc(sizeof(struct uart_state) * drv->nr, GFP_KERNEL);
+	drv->state = kcalloc(drv->nr, sizeof(struct uart_state), GFP_KERNEL);
 	retval = -ENOMEM;
 	if (!drv->state)
 		goto out;
 
-	memset(drv->state, 0, sizeof(struct uart_state) * drv->nr);
-
 	normal  = alloc_tty_driver(drv->nr);
 	if (!normal)
 		goto out;
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index afef5ac..648d200 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -223,11 +223,10 @@ #endif
 	}
 
 	/* allocate the private part of the URB */
-	urb_priv = kmalloc (sizeof (urb_priv_t) + size * sizeof (struct td *),
+	urb_priv = kzalloc (sizeof (urb_priv_t) + size * sizeof (struct td *),
 			mem_flags);
 	if (!urb_priv)
 		return -ENOMEM;
-	memset (urb_priv, 0, sizeof (urb_priv_t) + size * sizeof (struct td *));
 	INIT_LIST_HEAD (&urb_priv->pending);
 	urb_priv->length = size;
 	urb_priv->ed = ed;	
diff --git a/drivers/usb/host/sl811_cs.c b/drivers/usb/host/sl811_cs.c
index 54f554e..d49bec7 100644
--- a/drivers/usb/host/sl811_cs.c
+++ b/drivers/usb/host/sl811_cs.c
@@ -286,10 +286,9 @@ static int sl811_cs_probe(struct pcmcia_
 {
 	local_info_t *local;
 
-	local = kmalloc(sizeof(local_info_t), GFP_KERNEL);
+	local = kzalloc(sizeof(local_info_t), GFP_KERNEL);
 	if (!local)
 		return -ENOMEM;
-	memset(local, 0, sizeof(local_info_t));
 	local->p_dev = link;
 	link->priv = local;
 
diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 970d9ef..cc2d0eb 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -84,10 +84,9 @@ static int ark3116_attach(struct usb_ser
 	int i;
 
 	for (i = 0; i < serial->num_ports; ++i) {
-		priv = kmalloc (sizeof (struct ark3116_private), GFP_KERNEL);
+		priv = kzalloc (sizeof (struct ark3116_private), GFP_KERNEL);
 		if (!priv)
 			goto cleanup;
-		memset (priv, 0x00, sizeof (struct ark3116_private));
 		spin_lock_init(&priv->lock);
 
 		usb_set_serial_port_data(serial->port[i], priv);
diff --git a/drivers/usb/serial/console.c b/drivers/usb/serial/console.c
index 3a9073d..31b70d1 100644
--- a/drivers/usb/serial/console.c
+++ b/drivers/usb/serial/console.c
@@ -166,19 +166,17 @@ static int usb_console_setup(struct cons
 	if (serial->type->set_termios) {
 		/* build up a fake tty structure so that the open call has something
 		 * to look at to get the cflag value */
-		tty = kmalloc (sizeof (*tty), GFP_KERNEL);
+		tty = kzalloc (sizeof (*tty), GFP_KERNEL);
 		if (!tty) {
 			err ("no more memory");
 			return -ENOMEM;
 		}
-		termios = kmalloc (sizeof (*termios), GFP_KERNEL);
+		termios = kzalloc (sizeof (*termios), GFP_KERNEL);
 		if (!termios) {
 			err ("no more memory");
 			kfree (tty);
 			return -ENOMEM;
 		}
-		memset (tty, 0x00, sizeof(*tty));
-		memset (termios, 0x00, sizeof(*termios));
 		termios->c_cflag = cflag;
 		tty->termios = termios;
 		port->tty = tty;
diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index ac9b8ee..c3b17b4 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -459,13 +459,12 @@ static int ti_startup(struct usb_serial 
 
 	/* set up port structures */
 	for (i = 0; i < serial->num_ports; ++i) {
-		tport = kmalloc(sizeof(struct ti_port), GFP_KERNEL);
+		tport = kzalloc(sizeof(struct ti_port), GFP_KERNEL);
 		if (tport == NULL) {
 			dev_err(&dev->dev, "%s - out of memory\n", __FUNCTION__);
 			status = -ENOMEM;
 			goto free_tports;
 		}
-		memset(tport, 0, sizeof(struct ti_port));
 		spin_lock_init(&tport->tp_lock);
 		tport->tp_uart_base_addr = (i == 0 ? TI_UART1_BASE_ADDR : TI_UART2_BASE_ADDR);
 		tport->tp_flags = low_latency ? ASYNC_LOW_LATENCY : 0;
@@ -1709,7 +1708,7 @@ static struct circ_buf *ti_buf_alloc(voi
 {
 	struct circ_buf *cb;
 
-	cb = (struct circ_buf *)kmalloc(sizeof(struct circ_buf), GFP_KERNEL);
+	cb = kmalloc(sizeof(struct circ_buf), GFP_KERNEL);
 	if (cb == NULL)
 		return NULL;
 
diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 6761b68..a7a1c89 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -447,13 +447,12 @@ static int clcdfb_probe(struct amba_devi
 		goto out;
 	}
 
-	fb = (struct clcd_fb *) kmalloc(sizeof(struct clcd_fb), GFP_KERNEL);
+	fb = kzalloc(sizeof(struct clcd_fb), GFP_KERNEL);
 	if (!fb) {
 		printk(KERN_INFO "CLCD: could not allocate new clcd_fb struct\n");
 		ret = -ENOMEM;
 		goto free_region;
 	}
-	memset(fb, 0, sizeof(struct clcd_fb));
 
 	fb->dev = dev;
 	fb->board = board;
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 1507d19..54723e4 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2995,12 +2995,11 @@ static int __devinit atyfb_setup_sparc(s
 		/* nothing */ ;
 	j = i + 4;
 
-	par->mmap_map = kmalloc(j * sizeof(*par->mmap_map), GFP_ATOMIC);
+	par->mmap_map = kzalloc(j * sizeof(*par->mmap_map), GFP_ATOMIC);
 	if (!par->mmap_map) {
 		PRINTKE("atyfb_setup_sparc() can't alloc mmap_map\n");
 		return -ENOMEM;
 	}
-	memset(par->mmap_map, 0, j * sizeof(*par->mmap_map));
 
 	for (i = 0, j = 2; i < 6 && pdev->resource[i].start; i++) {
 		struct resource *rp = &pdev->resource[i];
diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index a92a91f..1bce04e 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -453,11 +453,11 @@ int au1100fb_drv_probe(struct device *de
 			return -EINVAL;
 
 	/* Allocate new device private */
-	if (!(fbdev = kmalloc(sizeof(struct au1100fb_device), GFP_KERNEL))) {
+	fbdev = kzalloc(sizeof(struct au1100fb_device), GFP_KERNEL);
+	if (!fbdev) {
 		print_err("fail to allocate device private record");
 		return -ENOMEM;
 	}
-	memset((void*)fbdev, 0, sizeof(struct au1100fb_device));
 
 	fbdev->panel = &known_lcd_panels[drv_info.panel_idx];
 
@@ -534,10 +534,9 @@ #endif
 	fbdev->info.fbops = &au1100fb_ops;
 	fbdev->info.fix = au1100fb_fix;
 
-	if (!(fbdev->info.pseudo_palette = kmalloc(sizeof(u32) * 16, GFP_KERNEL))) {
+	fbdev->info.pseudo_palette = kcalloc(16, sizeof(u32), GFP_KERNEL);
+	if (!fbdev->info.pseudo_palette)
 		return -ENOMEM;
-	}
-	memset(fbdev->info.pseudo_palette, 0, sizeof(u32) * 16);
 
 	if (fb_alloc_cmap(&fbdev->info.cmap, AU1100_LCD_NBR_PALETTE_ENTRIES, 0) < 0) {
 		print_err("Fail to allocate colormap (%d entries)",
diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index c6a5f0c..1dafd0b 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -1589,11 +1589,10 @@ static int au1200fb_init_fbinfo(struct a
 		return -EFAULT;
 	}
 
-	fbi->pseudo_palette = kmalloc(sizeof(u32) * 16, GFP_KERNEL);
+	fbi->pseudo_palette = kcalloc(16, sizeof(u32), GFP_KERNEL);
 	if (!fbi->pseudo_palette) {
 		return -ENOMEM;
 	}
-	memset(fbi->pseudo_palette, 0, sizeof(u32) * 16);
 
 	if (fb_alloc_cmap(&fbi->cmap, AU1200_LCD_NBR_PALETTE_ENTRIES, 0) < 0) {
 		print_err("Fail to allocate colormap (%d entries)",
diff --git a/drivers/video/clps711xfb.c b/drivers/video/clps711xfb.c
index 50b78af..dea6579 100644
--- a/drivers/video/clps711xfb.c
+++ b/drivers/video/clps711xfb.c
@@ -366,11 +366,10 @@ int __init clps711xfb_init(void)
 	if (fb_get_options("clps711xfb", NULL))
 		return -ENODEV;
 
-	cfb = kmalloc(sizeof(*cfb), GFP_KERNEL);
+	cfb = kzalloc(sizeof(*cfb), GFP_KERNEL);
 	if (!cfb)
 		goto out;
 
-	memset(cfb, 0, sizeof(*cfb));
 	strcpy(cfb->fix.id, "clps711x");
 
 	cfb->fbops		= &clps7111fb_ops;
diff --git a/drivers/video/controlfb.c b/drivers/video/controlfb.c
index 8cc6c0e..3be5219 100644
--- a/drivers/video/controlfb.c
+++ b/drivers/video/controlfb.c
@@ -692,11 +692,10 @@ static int __init control_of_init(struct
 		printk(KERN_ERR "can't get 2 addresses for control\n");
 		return -ENXIO;
 	}
-	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (p == 0)
 		return -ENXIO;
 	control_fb = p;	/* save it for cleanups */
-	memset(p, 0, sizeof(*p));
 
 	/* Map in frame buffer and registers */
 	p->fb_orig_base = fb_res.start;
diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
index aae6d9c..37c369c 100644
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -1221,12 +1221,10 @@ cyberpro_alloc_fb_info(unsigned int id, 
 {
 	struct cfb_info *cfb;
 
-	cfb = kmalloc(sizeof(struct cfb_info), GFP_KERNEL);
+	cfb = kzalloc(sizeof(struct cfb_info), GFP_KERNEL);
 	if (!cfb)
 		return NULL;
 
-	memset(cfb, 0, sizeof(struct cfb_info));
-
 	cfb->id			= id;
 
 	if (id == ID_CYBERPRO_5000)
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index a6ca02f..cecd439 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -2010,11 +2010,11 @@ static int __devinit i810fb_init_pci (st
 	par = info->par;
 	par->dev = dev;
 
-	if (!(info->pixmap.addr = kmalloc(8*1024, GFP_KERNEL))) {
+	info->pixmap.addr = kzalloc(8*1024, GFP_KERNEL);
+	if (!info->pixmap.addr) {
 		i810fb_release_resource(info, par);
 		return -ENOMEM;
 	}
-	memset(info->pixmap.addr, 0, 8*1024);
 	info->pixmap.size = 8*1024;
 	info->pixmap.buf_align = 8;
 	info->pixmap.access_align = 32;
diff --git a/drivers/video/igafb.c b/drivers/video/igafb.c
index 67f384f..c7a13cb 100644
--- a/drivers/video/igafb.c
+++ b/drivers/video/igafb.c
@@ -400,12 +400,11 @@ int __init igafb_init(void)
 	
 	size = sizeof(struct fb_info) + sizeof(struct iga_par) + sizeof(u32)*16;
 
-        info = kmalloc(size, GFP_ATOMIC);
+        info = kzalloc(size, GFP_ATOMIC);
         if (!info) {
                 printk("igafb_init: can't alloc fb_info\n");
                 return -ENOMEM;
         }
-        memset(info, 0, size);
 
 	par = (struct iga_par *) (info + 1);
 	
@@ -464,7 +463,7 @@ #ifdef __sparc__
 	 * one additional region with size == 0. 
 	 */
 
-	par->mmap_map = kmalloc(4 * sizeof(*par->mmap_map), GFP_ATOMIC);
+	par->mmap_map = kzalloc(4 * sizeof(*par->mmap_map), GFP_ATOMIC);
 	if (!par->mmap_map) {
 		printk("igafb_init: can't alloc mmap_map\n");
 		iounmap((void *)par->io_base);
@@ -473,8 +472,6 @@ #ifdef __sparc__
 		return -ENOMEM;
 	}
 
-	memset(par->mmap_map, 0, 4 * sizeof(*par->mmap_map));
-
 	/*
 	 * Set default vmode and cmode from PROM properties.
 	 */
diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index 06af89d..6022a22 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -529,12 +529,11 @@ intelfb_pci_register(struct pci_dev *pde
 	dinfo->pdev  = pdev;
 
 	/* Reserve pixmap space. */
-	info->pixmap.addr = kmalloc(64 * 1024, GFP_KERNEL);
+	info->pixmap.addr = kzalloc(64 * 1024, GFP_KERNEL);
 	if (info->pixmap.addr == NULL) {
 		ERR_MSG("Cannot reserve pixmap memory.\n");
 		goto err_out_pixmap;
 	}
-	memset(info->pixmap.addr, 0, 64 * 1024);
 
 	/* set early this option because it could be changed by tv encoder
 	   driver */
diff --git a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
index 27eb4bb..03ae55b 100644
--- a/drivers/video/matrox/matroxfb_crtc2.c
+++ b/drivers/video/matrox/matroxfb_crtc2.c
@@ -694,12 +694,11 @@ static void* matroxfb_crtc2_probe(struct
 	/* hardware is CRTC2 incapable... */
 	if (!ACCESS_FBINFO(devflags.crtc2))
 		return NULL;
-	m2info = (struct matroxfb_dh_fb_info*)kmalloc(sizeof(*m2info), GFP_KERNEL);
+	m2info = kzalloc(sizeof(*m2info), GFP_KERNEL);
 	if (!m2info) {
 		printk(KERN_ERR "matroxfb_crtc2: Not enough memory for CRTC2 control structs\n");
 		return NULL;
 	}
-	memset(m2info, 0, sizeof(*m2info));
 	m2info->primary_dev = MINFO;
 	if (matroxfb_dh_registerfb(m2info)) {
 		kfree(m2info);
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 9f2066f..a4c39ee 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1194,13 +1194,11 @@ static int __devinit nvidiafb_probe(stru
 	par = info->par;
 	par->pci_dev = pd;
 
-	info->pixmap.addr = kmalloc(8 * 1024, GFP_KERNEL);
+	info->pixmap.addr = kzalloc(8 * 1024, GFP_KERNEL);
 
 	if (info->pixmap.addr == NULL)
 		goto err_out_kfree;
 
-	memset(info->pixmap.addr, 0, 8 * 1024);
-
 	if (pci_enable_device(pd)) {
 		printk(KERN_ERR PFX "cannot enable PCI device\n");
 		goto err_out_enable;
diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index ce5f303..d8bade0 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -376,13 +376,12 @@ static void __init offb_init_fb(const ch
 
 	size = sizeof(struct fb_info) + sizeof(u32) * 17;
 
-	info = kmalloc(size, GFP_ATOMIC);
+	info = kzalloc(size, GFP_ATOMIC);
 	
-	if (info == 0) {
+	if (!info) {
 		release_mem_region(res_start, res_size);
 		return;
 	}
-	memset(info, 0, size);
 
 	fix = &info->fix;
 	var = &info->var;
diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index 940ba2b..0bc9f97 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -1065,14 +1065,12 @@ #ifndef MODULE
 #endif
 	size = sizeof(struct fb_info) + sizeof(struct pvr2fb_par) + 16 * sizeof(u32);
 
-	fb_info = kmalloc(size, GFP_KERNEL);
+	fb_info = kzalloc(size, GFP_KERNEL);
 	if (!fb_info) {
 		printk(KERN_ERR "Failed to allocate memory for fb_info\n");
 		return -ENOMEM;
 	}
 
-	memset(fb_info, 0, size);
-
 	currentpar = (struct pvr2fb_par *)(fb_info + 1);
 
 	for (i = 0; i < ARRAY_SIZE(board_list); i++) {
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index bbb0710..57931cf 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1051,11 +1051,10 @@ static struct pxafb_info * __init pxafb_
 	struct pxafb_mach_info *inf = dev->platform_data;
 
 	/* Alloc the pxafb_info and pseudo_palette in one step */
-	fbi = kmalloc(sizeof(struct pxafb_info) + sizeof(u32) * 16, GFP_KERNEL);
+	fbi = kzalloc(sizeof(struct pxafb_info) + sizeof(u32) * 16, GFP_KERNEL);
 	if (!fbi)
 		return NULL;
 
-	memset(fbi, 0, sizeof(struct pxafb_info));
 	fbi->dev = dev;
 
 	strcpy(fbi->fb.fix.id, PXA_NAME);
diff --git a/drivers/video/retz3fb.c b/drivers/video/retz3fb.c
index cf41ff1..b59ec08 100644
--- a/drivers/video/retz3fb.c
+++ b/drivers/video/retz3fb.c
@@ -1369,10 +1369,9 @@ int __init retz3fb_init(void)
 			release_mem_region(board_addr, 0x00c00000);
 			continue;
 		}
-		if (!(zinfo = kmalloc(sizeof(struct retz3_fb_info),
-				      GFP_KERNEL)))
+		zinfo = kzalloc(sizeof(struct retz3_fb_info), GFP_KERNEL);
+		if (!zinfo)
 			return -ENOMEM;
-		memset(zinfo, 0, sizeof(struct retz3_fb_info));
 
 		zinfo->base = ioremap(board_addr, board_size);
 		zinfo->regs = zinfo->base;
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 33dddba..624d27d 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -1999,12 +1999,11 @@ static int __devinit rivafb_probe(struct
 	default_par = info->par;
 	default_par->pdev = pd;
 
-	info->pixmap.addr = kmalloc(8 * 1024, GFP_KERNEL);
+	info->pixmap.addr = kzalloc(8 * 1024, GFP_KERNEL);
 	if (info->pixmap.addr == NULL) {
 	    	ret = -ENOMEM;
 		goto err_framebuffer_release;
 	}
-	memset(info->pixmap.addr, 0, 8 * 1024);
 
 	ret = pci_enable_device(pd);
 	if (ret < 0) {
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index a2e6e72..fdcc617 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -1373,12 +1373,11 @@ static struct sa1100fb_info * __init sa1
 	struct sa1100fb_mach_info *inf;
 	struct sa1100fb_info *fbi;
 
-	fbi = kmalloc(sizeof(struct sa1100fb_info) + sizeof(u32) * 16,
+	fbi = kzalloc(sizeof(struct sa1100fb_info) + sizeof(u32) * 16,
 		      GFP_KERNEL);
 	if (!fbi)
 		return NULL;
 
-	memset(fbi, 0, sizeof(struct sa1100fb_info));
 	fbi->dev = dev;
 
 	strcpy(fbi->fb.fix.id, SA1100_NAME);
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 461e094..89c64c4 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2122,11 +2122,10 @@ static int __devinit savage_init_fb_info
 
 #if defined(CONFIG_FB_SAVAGE_ACCEL)
 	/* FIFO size + padding for commands */
-	info->pixmap.addr = kmalloc(8*1024, GFP_KERNEL);
+	info->pixmap.addr = kzalloc(8*1024, GFP_KERNEL);
 
 	err = -ENOMEM;
 	if (info->pixmap.addr) {
-		memset(info->pixmap.addr, 0, 8*1024);
 		info->pixmap.size = 8*1024;
 		info->pixmap.scan_align = 4;
 		info->pixmap.buf_align = 4;
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 895ebda..1d7991c 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -5875,10 +5875,9 @@ #if (LINUX_VERSION_CODE >= KERNEL_VERSIO
 	if(!sis_fb_info)
 		return -ENOMEM;
 #else
-	sis_fb_info = kmalloc(sizeof(*sis_fb_info) + sizeof(*ivideo), GFP_KERNEL);
+	sis_fb_info = kzalloc(sizeof(*sis_fb_info) + sizeof(*ivideo), GFP_KERNEL);
 	if(!sis_fb_info)
 		return -ENOMEM;
-	memset(sis_fb_info, 0, sizeof(*sis_fb_info) + sizeof(*ivideo));
 	sis_fb_info->par = ((char *)sis_fb_info + sizeof(*sis_fb_info));
 #endif
 
diff --git a/drivers/video/sun3fb.c b/drivers/video/sun3fb.c
index f80356d..352d6f8 100644
--- a/drivers/video/sun3fb.c
+++ b/drivers/video/sun3fb.c
@@ -524,11 +524,10 @@ static int __init sun3fb_init_fb(int fbt
 	int linebytes, w, h, depth;
 	char *p = NULL;
 	
-	fb = kmalloc(sizeof(struct fb_info_sbusfb), GFP_ATOMIC);
+	fb = kzalloc(sizeof(struct fb_info_sbusfb), GFP_ATOMIC);
 	if (!fb)
 		return -ENOMEM;
 	
-	memset(fb, 0, sizeof(struct fb_info_sbusfb));
 	fix = &fb->fix;
 	var = &fb->var;
 	disp = &fb->disp;
diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
index 94fde62..86d2df8 100644
--- a/drivers/video/tgafb.c
+++ b/drivers/video/tgafb.c
@@ -1394,12 +1394,11 @@ tgafb_pci_register(struct pci_dev *pdev,
 	}
 
 	/* Allocate the fb and par structures.  */
-	all = kmalloc(sizeof(*all), GFP_KERNEL);
+	all = kzalloc(sizeof(*all), GFP_KERNEL);
 	if (!all) {
 		printk(KERN_ERR "tgafb: Cannot allocate memory\n");
 		return -ENOMEM;
 	}
-	memset(all, 0, sizeof(*all));
 	pci_set_drvdata(pdev, all);
 
 	/* Request the mem regions.  */
diff --git a/drivers/video/valkyriefb.c b/drivers/video/valkyriefb.c
index 47f2792..b376c23 100644
--- a/drivers/video/valkyriefb.c
+++ b/drivers/video/valkyriefb.c
@@ -357,10 +357,9 @@ #else /* ppc (!CONFIG_MAC) */
 	}
 #endif /* ppc (!CONFIG_MAC) */
 
-	p = kmalloc(sizeof(*p), GFP_ATOMIC);
+	p = kzalloc(sizeof(*p), GFP_ATOMIC);
 	if (p == 0)
 		return -ENOMEM;
-	memset(p, 0, sizeof(*p));
 
 	/* Map in frame buffer and registers */
 	if (!request_mem_region(frame_buffer_phys, 0x100000, "valkyriefb")) {
-- 
1.4.2.rc1.ge7a0-dirty

