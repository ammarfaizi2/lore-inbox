Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbSKEFlA>; Tue, 5 Nov 2002 00:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264871AbSKEFlA>; Tue, 5 Nov 2002 00:41:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:25730 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264791AbSKEFjQ>;
	Tue, 5 Nov 2002 00:39:16 -0500
Message-ID: <3DC75B06.FEC60C88@digeo.com>
Date: Mon, 04 Nov 2002 21:45:42 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 4/4] timers: drivers/*
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Nov 2002 05:45:43.0051 (UTC) FILETIME=[9471E5B0:01C2848E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Results of a quick pass through everything under drivers/.  We're
mostly OK in there.  I will have missed some.


 drivers/acorn/block/fd1772.c     |   22 +++++++++-------------
 drivers/atm/idt77105.c           |   10 ++++------
 drivers/atm/iphase.c             |    2 +-
 drivers/block/acsi.c             |    2 +-
 drivers/block/acsi_slm.c         |    2 +-
 drivers/block/ataflop.c          |   10 +++++-----
 drivers/block/floppy.c           |    1 +
 drivers/block/paride/pseudo.h    |    2 +-
 drivers/block/ps2esdi.c          |    3 ++-
 drivers/block/swim_iop.c         |    1 +
 drivers/cdrom/aztcd.c            |    2 +-
 drivers/cdrom/cm206.c            |    1 +
 drivers/cdrom/gscd.c             |    2 +-
 drivers/cdrom/mcd.c              |    2 +-
 drivers/cdrom/optcd.c            |    2 +-
 drivers/cdrom/sbpcd.c            |    9 ++++++---
 drivers/cdrom/sjcd.c             |    2 +-
 drivers/char/cyclades.c          |    4 ++--
 drivers/char/ip2/i2ellis.c       |    1 +
 drivers/char/ip2main.c           |    2 +-
 drivers/char/istallion.c         |    3 +--
 drivers/char/keyboard.c          |    3 ++-
 drivers/char/mixcomwd.c          |    2 +-
 drivers/char/softdog.c           |    5 ++---
 drivers/fc4/fc.c                 |    1 +
 drivers/macintosh/mac_keyb.c     |    2 +-
 drivers/media/video/msp3400.c    |    1 +
 drivers/media/video/tvaudio.c    |    1 +
 drivers/net/atari_bionet.c       |    2 +-
 drivers/net/atari_pamsnet.c      |    2 +-
 drivers/net/bmac.c               |    2 +-
 drivers/net/hamradio/yam.c       |    2 +-
 drivers/net/pcmcia/3c574_cs.c    |    2 ++
 drivers/net/pcmcia/3c589_cs.c    |    1 +
 drivers/net/pcmcia/axnet_cs.c    |    1 +
 drivers/net/pcmcia/pcnet_cs.c    |    1 +
 drivers/net/pcmcia/smc91c92_cs.c |    1 +
 drivers/net/tulip/de2104x.c      |    1 +
 drivers/net/tulip/de4x5.c        |    1 +
 drivers/net/wan/comx-hw-munich.c |    1 +
 drivers/net/wan/comx-proto-fr.c  |    1 +
 drivers/oprofile/buffer_sync.c   |    3 ++-
 drivers/pcmcia/ds.c              |    1 +
 drivers/pcmcia/i82365.c          |    1 +
 drivers/pcmcia/sa1100_generic.c  |    1 +
 drivers/sbus/char/aurora.c       |    4 ++--
 drivers/sbus/char/bpp.c          |    1 +
 drivers/sbus/char/cpwatchdog.c   |    1 +
 drivers/scsi/pluto.c             |    3 ++-
 drivers/video/fbcon.c            |    5 ++---
 50 files changed, 79 insertions(+), 59 deletions(-)

--- 25/drivers/acorn/block/fd1772.c~drivers-timer-init	Mon Nov  4 19:24:43 2002
+++ 25-akpm/drivers/acorn/block/fd1772.c	Mon Nov  4 19:55:14 2002
@@ -378,23 +378,19 @@ static void do_fd_request(request_queue_
 
 /************************* End of Prototypes **************************/
 
-static struct timer_list motor_off_timer = {
-	.function	= fd_motor_off_timer,
-};
+static struct timer_list motor_off_timer =
+	TIMER_INITIALIZER(fd_motor_off_timer, 0, 0);
 
 #ifdef TRACKBUFFER
-static struct timer_list readtrack_timer = {
-	.function 	= fd_readtrack_check,
-};
+static struct timer_list readtrack_timer =
+	TIMER_INITIALIZER(fd_readtrack_check, 0, 0);
 #endif
 
-static struct timer_list timeout_timer = {
-	.function	= fd_times_out,
-};
-
-static struct timer_list fd_timer = {
-	.function	= check_change,
-};
+static struct timer_list timeout_timer =
+	TIMER_INITIALIZER(fd_times_out, 0, 0);
+
+static struct timer_list fd_timer =
+	TIMER_INITIALIZER(check_change, 0, 0);
 
 /* DAG: Haven't got a clue what this is? */
 int stdma_islocked(void)
--- 25/drivers/atm/iphase.c~drivers-timer-init	Mon Nov  4 19:24:43 2002
+++ 25-akpm/drivers/atm/iphase.c	Mon Nov  4 19:55:38 2002
@@ -78,7 +78,7 @@ static IADEV *ia_dev[8];
 static struct atm_dev *_ia_dev[8];
 static int iadev_count;
 static void ia_led_timer(unsigned long arg);
-static struct timer_list ia_timer = { function: ia_led_timer };
+static struct timer_list ia_timer = TIMER_INITIALIZER(ia_led_timer, 0, 0);
 struct atm_vcc *vcc_close_que[100];
 static int IA_TX_BUF = DFL_TX_BUFFERS, IA_TX_BUF_SZ = DFL_TX_BUF_SZ;
 static int IA_RX_BUF = DFL_RX_BUFFERS, IA_RX_BUF_SZ = DFL_RX_BUF_SZ;
--- 25/drivers/atm/idt77105.c~drivers-timer-init	Mon Nov  4 19:24:43 2002
+++ 25-akpm/drivers/atm/idt77105.c	Mon Nov  4 19:56:57 2002
@@ -48,12 +48,10 @@ static void idt77105_stats_timer_func(un
 static void idt77105_restart_timer_func(unsigned long);
 
 
-static struct timer_list stats_timer = {
-    function:	&idt77105_stats_timer_func
-};
-static struct timer_list restart_timer = {
-    function:	&idt77105_restart_timer_func
-};
+static struct timer_list stats_timer =
+    TIMER_INITIALIZER(idt77105_stats_timer_func, 0, 0);
+static struct timer_list restart_timer =
+    TIMER_INITIALIZER(idt77105_restart_timer_func, 0, 0);
 static int start_timer = 1;
 static struct idt77105_priv *idt77105_all = NULL;
 
--- 25/drivers/block/acsi.c~drivers-timer-init	Mon Nov  4 19:24:44 2002
+++ 25-akpm/drivers/block/acsi.c	Mon Nov  4 19:57:51 2002
@@ -374,7 +374,7 @@ static int acsi_revalidate (struct gendi
 /************************* End of Prototypes **************************/
 
 
-struct timer_list acsi_timer = { function: acsi_times_out };
+struct timer_list acsi_timer = TIMER_INITIALIZER(acsi_times_out, 0, 0);
 
 
 #ifdef CONFIG_ATARI_SLM
--- 25/drivers/block/floppy.c~drivers-timer-init	Mon Nov  4 19:24:44 2002
+++ 25-akpm/drivers/block/floppy.c	Mon Nov  4 19:58:22 2002
@@ -4347,6 +4347,7 @@ int __init floppy_init(void)
 	}
 	
 	for (drive = 0; drive < N_DRIVE; drive++) {
+		init_timer(&motor_off_timer[drive]);
 		motor_off_timer[drive].data = drive;
 		motor_off_timer[drive].function = motor_off_callback;
 		if (!(allowed_drive_mask & (1 << drive)))
--- 25/drivers/block/acsi_slm.c~drivers-timer-init	Mon Nov  4 19:24:44 2002
+++ 25-akpm/drivers/block/acsi_slm.c	Mon Nov  4 19:59:10 2002
@@ -270,7 +270,7 @@ static int slm_get_pagesize( int device,
 /************************* End of Prototypes **************************/
 
 
-static struct timer_list slm_timer = { function: slm_test_ready };
+static struct timer_list slm_timer = TIMER_INITIALIZER(slm_test_ready, 0, 0);
 
 static struct file_operations slm_fops = {
 	owner:		THIS_MODULE,
--- 25/drivers/block/ataflop.c~drivers-timer-init	Mon Nov  4 19:24:44 2002
+++ 25-akpm/drivers/block/ataflop.c	Mon Nov  4 20:00:28 2002
@@ -395,15 +395,15 @@ static int floppy_release( struct inode 
 /************************* End of Prototypes **************************/
 
 static struct timer_list motor_off_timer =
-	{ function: fd_motor_off_timer };
-static struct timer_list readtrack_timer =
-	{ function: fd_readtrack_check };
+	TIMER_INITIALIZER(fd_motor_off_timer, 0, 0);
+static struct timer_list readtrack_timer
+	TIMER_INITIALIZER(fd_readtrack_check, 0, 0);
 
 static struct timer_list timeout_timer =
-	{ function: fd_times_out };
+	TIMER_INITIALIZER(fd_times_out, 0, 0);
 
 static struct timer_list fd_timer =
-	{ function: check_change };
+	TIMER_INITIALIZER(check_change, 0, 0);
 	
 static inline void
 start_motor_off_timer(void)
--- 25/drivers/block/ps2esdi.c~drivers-timer-init	Mon Nov  4 19:24:44 2002
+++ 25-akpm/drivers/block/ps2esdi.c	Mon Nov  4 20:00:46 2002
@@ -107,7 +107,8 @@ static DECLARE_WAIT_QUEUE_HEAD(ps2esdi_i
 static int no_int_yet;
 static int ps2esdi_drives;
 static u_short io_base;
-static struct timer_list esdi_timer = { function: ps2esdi_reset_timer };
+static struct timer_list esdi_timer =
+		TIMER_INITIALIZER(ps2esdi_reset_timer, 0, 0);
 static int reset_status;
 static int ps2esdi_slot = -1;
 static int tp720esdi = 0;	/* Is it Integrated ESDI of ThinkPad-720? */
--- 25/drivers/block/swim_iop.c~drivers-timer-init	Mon Nov  4 19:24:44 2002
+++ 25-akpm/drivers/block/swim_iop.c	Mon Nov  4 20:01:19 2002
@@ -464,6 +464,7 @@ static void set_timeout(struct floppy_st
 	save_flags(flags); cli();
 	if (fs->timeout_pending)
 		del_timer(&fs->timeout);
+	init_timer(&fs->timeout);
 	fs->timeout.expires = jiffies + nticks;
 	fs->timeout.function = proc;
 	fs->timeout.data = (unsigned long) fs;
--- 25/drivers/block/paride/pseudo.h~drivers-timer-init	Mon Nov  4 19:24:45 2002
+++ 25-akpm/drivers/block/paride/pseudo.h	Mon Nov  4 20:01:46 2002
@@ -49,7 +49,7 @@ static int ps_nice = 0;
 
 static spinlock_t ps_spinlock __attribute__((unused)) = SPIN_LOCK_UNLOCKED;
 
-static struct timer_list ps_timer = { function: ps_timer_int };
+static struct timer_list ps_timer = TIMER_INITIALIZER(ps_timer_int, 0, 0);
 static DECLARE_WORK(ps_tq, ps_tq_int, NULL);
 
 static void ps_set_intr( void (*continuation)(void), 
--- 25/drivers/cdrom/aztcd.c~drivers-timer-init	Mon Nov  4 19:24:45 2002
+++ 25-akpm/drivers/cdrom/aztcd.c	Mon Nov  4 20:02:17 2002
@@ -299,7 +299,7 @@ static char azt_auto_eject = AZT_AUTO_EJ
 
 static int AztTimeout, AztTries;
 static DECLARE_WAIT_QUEUE_HEAD(azt_waitq);
-static struct timer_list delay_timer;
+static struct timer_list delay_timer = TIMER_INITIALIZER(NULL, 0, 0);
 
 static struct azt_DiskInfo DiskInfo;
 static struct azt_Toc Toc[MAX_TRACKS];
--- 25/drivers/cdrom/cm206.c~drivers-timer-init	Mon Nov  4 19:24:45 2002
+++ 25-akpm/drivers/cdrom/cm206.c	Mon Nov  4 20:02:48 2002
@@ -451,6 +451,7 @@ void cm206_timeout(unsigned long who)
 int sleep_or_timeout(wait_queue_head_t * wait, int timeout)
 {
 	cd->timed_out = 0;
+	init_timer(&cd->timer);
 	cd->timer.data = (unsigned long) wait;
 	cd->timer.expires = jiffies + timeout;
 	add_timer(&cd->timer);
--- 25/drivers/cdrom/gscd.c~drivers-timer-init	Mon Nov  4 19:24:45 2002
+++ 25-akpm/drivers/cdrom/gscd.c	Mon Nov  4 20:02:59 2002
@@ -148,7 +148,7 @@ static int AudioStart_f;
 static int AudioEnd_m;
 static int AudioEnd_f;
 
-static struct timer_list gscd_timer;
+static struct timer_list gscd_timer = TIMER_INITIALIZER(NULL, 0, 0);
 static spinlock_t gscd_lock = SPIN_LOCK_UNLOCKED;
 struct request_queue gscd_queue;
 
--- 25/drivers/cdrom/mcd.c~drivers-timer-init	Mon Nov  4 19:24:45 2002
+++ 25-akpm/drivers/cdrom/mcd.c	Mon Nov  4 20:03:22 2002
@@ -193,7 +193,7 @@ static int mcd_audio_ioctl(struct cdrom_
 		    void *arg);
 static int mcd_drive_status(struct cdrom_device_info *cdi, int slot_nr);
 
-static struct timer_list mcd_timer;
+static struct timer_list mcd_timer = TIMER_INITIALIZER(NULL, 0, 0);
 
 static struct cdrom_device_ops mcd_dops = {
 	.open			= mcd_open,
--- 25/drivers/cdrom/optcd.c~drivers-timer-init	Mon Nov  4 19:24:45 2002
+++ 25-akpm/drivers/cdrom/optcd.c	Mon Nov  4 20:03:43 2002
@@ -265,7 +265,7 @@ inline static int flag_low(int flag, uns
 static int sleep_timeout;	/* max # of ticks to sleep */
 static DECLARE_WAIT_QUEUE_HEAD(waitq);
 static void sleep_timer(unsigned long data);
-static struct timer_list delay_timer = {function: sleep_timer};
+static struct timer_list delay_timer = TIMER_INITIALIZER(sleep_timer, 0, 0);
 static spinlock_t optcd_lock = SPIN_LOCK_UNLOCKED;
 static struct request_queue opt_queue;
 
--- 25/drivers/cdrom/sjcd.c~drivers-timer-init	Mon Nov  4 19:24:45 2002
+++ 25-akpm/drivers/cdrom/sjcd.c	Mon Nov  4 20:04:02 2002
@@ -152,7 +152,7 @@ static struct sjcd_stat statistic;
 /*
  * Timer.
  */
-static struct timer_list sjcd_delay_timer;
+static struct timer_list sjcd_delay_timer = TIMER_INITIALIZER(NULL, 0, 0);
 
 #define SJCD_SET_TIMER( func, tmout )           \
     ( sjcd_delay_timer.expires = jiffies+tmout,         \
--- 25/drivers/cdrom/sbpcd.c~drivers-timer-init	Mon Nov  4 19:24:45 2002
+++ 25-akpm/drivers/cdrom/sbpcd.c	Mon Nov  4 20:04:44 2002
@@ -743,10 +743,13 @@ static struct sbpcd_drive *current_drive
 unsigned long cli_sti; /* for saving the processor flags */
 #endif
 /*==========================================================================*/
-static struct timer_list delay_timer = { function: mark_timeout_delay};
-static struct timer_list data_timer = { function: mark_timeout_data};
+static struct timer_list delay_timer =
+		TIMER_INITIALIZER(mark_timeout_delay, 0, 0);
+static struct timer_list data_timer =
+		TIMER_INITIALIZER(mark_timeout_data, 0, 0);
 #if 0
-static struct timer_list audio_timer = { function: mark_timeout_audio};
+static struct timer_list audio_timer =
+		TIMER_INITIALIZER(mark_timeout_audio, 0, 0);
 #endif
 /*==========================================================================*/
 /*
--- 25/drivers/char/cyclades.c~drivers-timer-init	Mon Nov  4 19:24:45 2002
+++ 25-akpm/drivers/char/cyclades.c	Mon Nov  4 20:05:16 2002
@@ -883,8 +883,7 @@ static void cyz_poll(unsigned long);
 static long cyz_polling_cycle = CZ_DEF_POLL;
 
 static int cyz_timeron = 0;
-static struct timer_list cyz_timerlist = {
-    function: cyz_poll
+static struct timer_list cyz_timerlist = TIMER_INITIALIZER(cyz_poll, 0, 0);
 };
 #else /* CONFIG_CYZ_INTR */
 static void cyz_rx_restart(unsigned long);
@@ -5667,6 +5666,7 @@ cy_init(void)
                     info->jiffies[2] = 0;
                     info->rflush_count = 0;
 #ifdef CONFIG_CYZ_INTR
+		    init_timer(&cyz_rx_full_timer[port]);
 		    cyz_rx_full_timer[port].function = NULL;
 #endif
                 }
--- 25/drivers/char/ip2main.c~drivers-timer-init	Mon Nov  4 19:24:46 2002
+++ 25-akpm/drivers/char/ip2main.c	Mon Nov  4 20:05:50 2002
@@ -352,7 +352,7 @@ static unsigned long bh_counter = 0;
  * selected, the board is serviced periodically to see if anything needs doing.
  */
 #define  POLL_TIMEOUT   (jiffies + 1)
-static struct timer_list PollTimer = { function: ip2_poll };
+static struct timer_list PollTimer = TIMER_INITIALIZER(ip2_poll, 0, 0);
 static char  TimerOn;
 
 #ifdef IP2DEBUG_TRACE
--- 25/drivers/char/istallion.c~drivers-timer-init	Mon Nov  4 19:24:46 2002
+++ 25-akpm/drivers/char/istallion.c	Mon Nov  4 20:06:20 2002
@@ -797,8 +797,7 @@ static struct file_operations	stli_fsiom
  *	much cheaper on host cpu than using interrupts. It turns out to
  *	not increase character latency by much either...
  */
-static struct timer_list	stli_timerlist = {
-	function: stli_poll
+static struct timer_list stli_timerlist = TIMER_INITIALIZER(stli_poll, 0, 0);
 };
 
 static int	stli_timeron;
--- 25/drivers/char/keyboard.c~drivers-timer-init	Mon Nov  4 19:24:46 2002
+++ 25-akpm/drivers/char/keyboard.c	Mon Nov  4 20:06:33 2002
@@ -233,7 +233,8 @@ static void kd_nosound(unsigned long ign
 	}
 }
 
-static struct timer_list kd_mksound_timer = { function: kd_nosound };
+static struct timer_list kd_mksound_timer =
+		TIMER_INITIALIZER(kd_nosound, 0, 0);
 
 void kd_mksound(unsigned int hz, unsigned int ticks)
 {
--- 25/drivers/char/mixcomwd.c~drivers-timer-init	Mon Nov  4 19:24:46 2002
+++ 25-akpm/drivers/char/mixcomwd.c	Mon Nov  4 20:06:53 2002
@@ -61,7 +61,7 @@ static long mixcomwd_opened; /* long req
 
 static int watchdog_port;
 static int mixcomwd_timer_alive;
-static struct timer_list mixcomwd_timer;
+static struct timer_list mixcomwd_timer = TIMER_INITIALIZER(NULL, 0, 0);
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
--- 25/drivers/char/softdog.c~drivers-timer-init	Mon Nov  4 19:24:47 2002
+++ 25-akpm/drivers/char/softdog.c	Mon Nov  4 20:08:18 2002
@@ -67,9 +67,8 @@ MODULE_LICENSE("GPL");
  
 static void watchdog_fire(unsigned long);
 
-static struct timer_list watchdog_ticktock = {
-	function:	watchdog_fire,
-};
+static struct timer_list watchdog_ticktock =
+		TIMER_INITIALIZER(watchdog_fire, 0, 0);
 static int timer_alive;
 
 
--- 25/drivers/char/ip2/i2ellis.c~drivers-timer-init	Mon Nov  4 19:24:48 2002
+++ 25-akpm/drivers/char/ip2/i2ellis.c	Mon Nov  4 20:09:27 2002
@@ -87,6 +87,7 @@ static void
 iiEllisInit(void)
 {
 	pDelayTimer = kmalloc ( sizeof (struct timer_list), GFP_KERNEL );
+	init_timer(pDelayTimer);
 	init_waitqueue_head(&pDelayWait);
 	LOCK_INIT(&Dl_spinlock);
 }
--- 25/drivers/fc4/fc.c~drivers-timer-init	Mon Nov  4 19:24:48 2002
+++ 25-akpm/drivers/fc4/fc.c	Mon Nov  4 20:10:10 2002
@@ -553,6 +553,7 @@ int fcp_initialize(fc_channel *fcchain, 
 	l->count = count;
 	FCND(("FCP Init for %d channels\n", count))
 	init_MUTEX_LOCKED(&l->sem);
+	init_timer(&l->timer);
 	l->timer.function = fcp_login_timeout;
 	l->timer.data = (unsigned long)l;
 	atomic_set (&l->todo, count);
--- 25/drivers/macintosh/mac_keyb.c~drivers-timer-init	Mon Nov  4 19:24:51 2002
+++ 25-akpm/drivers/macintosh/mac_keyb.c	Mon Nov  4 20:12:27 2002
@@ -229,7 +229,7 @@ static u_short macctrl_alt_map[NR_KEYS] 
 
 
 static void kbd_repeat(unsigned long);
-static struct timer_list repeat_timer = { function: kbd_repeat };
+static struct timer_list repeat_timer = TIMER_INITIALIZER(kbd_repeat, 0, 0);
 static int last_keycode;
 
 static void mackeyb_probe(void);
--- 25/drivers/media/video/msp3400.c~drivers-timer-init	Mon Nov  4 19:24:51 2002
+++ 25-akpm/drivers/media/video/msp3400.c	Mon Nov  4 20:13:16 2002
@@ -1300,6 +1300,7 @@ static int msp_attach(struct i2c_adapter
 	}
 
 	/* timer for stereo checking */
+	init_timer(&msp->wake_stereo);
 	msp->wake_stereo.function = msp3400c_stereo_wake;
 	msp->wake_stereo.data     = (unsigned long)msp;
 
--- 25/drivers/media/video/tvaudio.c~drivers-timer-init	Mon Nov  4 19:24:51 2002
+++ 25-akpm/drivers/media/video/tvaudio.c	Mon Nov  4 20:13:42 2002
@@ -1392,6 +1392,7 @@ static int chip_attach(struct i2c_adapte
 		/* start async thread */
 		DECLARE_MUTEX_LOCKED(sem);
 		chip->notify = &sem;
+		init_timer(&chip->wt);
 		chip->wt.function = chip_thread_wake;
 		chip->wt.data     = (unsigned long)chip;
 		init_waitqueue_head(&chip->wq);
--- 25/drivers/net/atari_bionet.c~drivers-timer-init	Mon Nov  4 19:24:52 2002
+++ 25-akpm/drivers/net/atari_bionet.c	Mon Nov  4 20:14:39 2002
@@ -159,7 +159,7 @@ static int bionet_close(struct net_devic
 static struct net_device_stats *net_get_stats(struct net_device *dev);
 static void bionet_tick(unsigned long);
 
-static struct timer_list bionet_timer = { function: bionet_tick };
+static struct timer_list bionet_timer = TIMER_INITIALIZER(bionet_tick, 0, 0);
 
 #define STRAM_ADDR(a)	(((a) & 0xff000000) == 0)
 
--- 25/drivers/net/atari_pamsnet.c~drivers-timer-init	Mon Nov  4 19:24:52 2002
+++ 25-akpm/drivers/net/atari_pamsnet.c	Mon Nov  4 20:15:02 2002
@@ -169,7 +169,7 @@ static void pamsnet_tick(unsigned long);
 
 static void pamsnet_intr(int irq, void *data, struct pt_regs *fp);
 
-static struct timer_list pamsnet_timer = { function: amsnet_tick };
+static struct timer_list pamsnet_timer = TIMER_INITIALIZER(amsnet_tick, 0, 0);
 
 #define STRAM_ADDR(a)	(((a) & 0xff000000) == 0)
 
--- 25/drivers/net/bmac.c~drivers-timer-init	Mon Nov  4 19:24:52 2002
+++ 25-akpm/drivers/net/bmac.c	Mon Nov  4 20:15:46 2002
@@ -1403,7 +1403,7 @@ static void __init bmac_probe1(struct de
 
 	memset((char *) bp->tx_cmds, 0,
 	       (N_TX_RING + N_RX_RING + 2) * sizeof(struct dbdma_cmd));
-	/*     init_timer(&bp->tx_timeout); */
+	init_timer(&bp->tx_timeout);
 	/*     bp->timeout_active = 0; */
 
 	ret = request_irq(dev->irq, bmac_misc_intr, 0, "BMAC-misc", dev);
--- 25/drivers/net/hamradio/yam.c~drivers-timer-init	Mon Nov  4 19:24:55 2002
+++ 25-akpm/drivers/net/hamradio/yam.c	Mon Nov  4 20:18:06 2002
@@ -170,7 +170,7 @@ static char ax25_bcast[7] =
 static char ax25_test[7] =
 {'L' << 1, 'I' << 1, 'N' << 1, 'U' << 1, 'X' << 1, ' ' << 1, '1' << 1};
 
-static struct timer_list yam_timer;
+static struct timer_list yam_timer = TIMER_INITIALIZER(NULL, 0, 0);
 
 /* --------------------------------------------------------------------- */
 
--- 25/drivers/net/pcmcia/3c574_cs.c~drivers-timer-init	Mon Nov  4 19:24:55 2002
+++ 25-akpm/drivers/net/pcmcia/3c574_cs.c	Mon Nov  4 20:18:58 2002
@@ -515,6 +515,8 @@ static void tc574_config(dev_link_t *lin
 		lp->autoselect = config.u.autoselect;
 	}
 
+	init_timer(&lp->media);
+
 	{
 		int phy;
 		
--- 25/drivers/net/pcmcia/3c589_cs.c~drivers-timer-init	Mon Nov  4 19:24:55 2002
+++ 25-akpm/drivers/net/pcmcia/3c589_cs.c	Mon Nov  4 20:19:29 2002
@@ -745,6 +745,7 @@ static int el3_open(struct net_device *d
     netif_start_queue(dev);
     
     tc589_reset(dev);
+    init_timer(&lp->media);
     lp->media.function = &media_check;
     lp->media.data = (unsigned long)lp;
     lp->media.expires = jiffies + HZ;
--- 25/drivers/net/pcmcia/axnet_cs.c~drivers-timer-init	Mon Nov  4 19:24:55 2002
+++ 25-akpm/drivers/net/pcmcia/axnet_cs.c	Mon Nov  4 20:19:47 2002
@@ -689,6 +689,7 @@ static int axnet_open(struct net_device 
     request_irq(dev->irq, ei_irq_wrapper, SA_SHIRQ, dev_info, dev);
 
     info->link_status = 0x00;
+    init_timer(&info->watchdog);
     info->watchdog.function = &ei_watchdog;
     info->watchdog.data = (u_long)info;
     info->watchdog.expires = jiffies + HZ;
--- 25/drivers/net/pcmcia/pcnet_cs.c~drivers-timer-init	Mon Nov  4 19:24:55 2002
+++ 25-akpm/drivers/net/pcmcia/pcnet_cs.c	Mon Nov  4 20:20:02 2002
@@ -1034,6 +1034,7 @@ static int pcnet_open(struct net_device 
 
     info->phy_id = info->eth_phy;
     info->link_status = 0x00;
+    init_timer(&info->watchdog);
     info->watchdog.function = &ei_watchdog;
     info->watchdog.data = (u_long)info;
     info->watchdog.expires = jiffies + HZ;
--- 25/drivers/net/pcmcia/smc91c92_cs.c~drivers-timer-init	Mon Nov  4 19:24:55 2002
+++ 25-akpm/drivers/net/pcmcia/smc91c92_cs.c	Mon Nov  4 20:20:45 2002
@@ -1304,6 +1304,7 @@ static int smc91c92_open(struct net_devi
     smc->packets_waiting = 0;
     
     smc_reset(dev);
+    init_timer(&smc->media);
     smc->media.function = &media_check;
     smc->media.data = (u_long)smc;
     smc->media.expires = jiffies + HZ;
--- 25/drivers/net/tulip/de2104x.c~drivers-timer-init	Mon Nov  4 19:24:56 2002
+++ 25-akpm/drivers/net/tulip/de2104x.c	Mon Nov  4 20:23:18 2002
@@ -2014,6 +2014,7 @@ static int __init de_init_one (struct pc
 	dev->watchdog_timeo = TX_TIMEOUT;
 
 	dev->irq = pdev->irq;
+	init_timer(&de->media_timer);
 
 	de = dev->priv;
 	de->de21040 = ent->driver_data == 0 ? 1 : 0;
--- 25/drivers/net/tulip/de4x5.c~drivers-timer-init	Mon Nov  4 19:24:56 2002
+++ 25-akpm/drivers/net/tulip/de4x5.c	Mon Nov  4 20:23:44 2002
@@ -5291,6 +5291,7 @@ timeout(struct net_device *dev, void (*f
     if (dt==0) dt=1;
     
     /* Set up timer */
+    init_timer(&lp->timer);
     lp->timer.expires = jiffies + dt;
     lp->timer.function = fn;
     lp->timer.data = data;
--- 25/drivers/net/wan/comx-hw-munich.c~drivers-timer-init	Mon Nov  4 19:24:56 2002
+++ 25-akpm/drivers/net/wan/comx-hw-munich.c	Mon Nov  4 20:58:37 2002
@@ -1854,6 +1854,7 @@ static int MUNICH_open(struct net_device
 
     if (board->isx21)
     {
+	init_timer(&board->modemline_timer);
 	board->modemline_timer.data = (unsigned int)board;
 	board->modemline_timer.function = pcicom_modemline;
 	board->modemline_timer.expires = jiffies + HZ;
--- 25/drivers/net/wan/comx-proto-fr.c~drivers-timer-init	Mon Nov  4 19:24:56 2002
+++ 25-akpm/drivers/net/wan/comx-proto-fr.c	Mon Nov  4 20:59:01 2002
@@ -214,6 +214,7 @@ static void fr_set_keepalive(struct net_
 		}
 		fr->keepa_freq = keepa;
 		fr->local_cnt = fr->remote_cnt = 0;
+		init_timer(&fr->keepa_timer);
 		fr->keepa_timer.expires = jiffies + HZ;
 		fr->keepa_timer.function = fr_keepalive_timerfun;
 		fr->keepa_timer.data = (unsigned long)dev;
--- 25/drivers/oprofile/buffer_sync.c~drivers-timer-init	Mon Nov  4 19:24:57 2002
+++ 25-akpm/drivers/oprofile/buffer_sync.c	Mon Nov  4 21:01:22 2002
@@ -91,7 +91,8 @@ int sync_start(void)
 	err = profile_event_register(EXEC_UNMAP, &exec_unmap_nb);
 	if (err)
 		goto out3;
- 
+
+	init_timer(&sync_timer);
 	sync_timer.function = timer_ping;
 	sync_timer.expires = jiffies + DEFAULT_EXPIRE;
 	add_timer(&sync_timer);
--- 25/drivers/pcmcia/ds.c~drivers-timer-init	Mon Nov  4 19:24:58 2002
+++ 25-akpm/drivers/pcmcia/ds.c	Mon Nov  4 21:01:55 2002
@@ -316,6 +316,7 @@ static int ds_event(event_t event, int p
 	s->state &= ~SOCKET_PRESENT;
 	if (!(s->state & SOCKET_REMOVAL_PENDING)) {
 	    s->state |= SOCKET_REMOVAL_PENDING;
+	    init_timer(&s->removal);
 	    s->removal.expires = jiffies + HZ/10;
 	    add_timer(&s->removal);
 	}
--- 25/drivers/pcmcia/i82365.c~drivers-timer-init	Mon Nov  4 19:24:58 2002
+++ 25-akpm/drivers/pcmcia/i82365.c	Mon Nov  4 21:02:20 2002
@@ -1003,6 +1003,7 @@ static void pcic_interrupt(int irq, void
 static void pcic_interrupt_wrapper(u_long data)
 {
     pcic_interrupt(0, NULL, NULL);
+    init_timer(&poll_timer);
     poll_timer.expires = jiffies + poll_interval;
     add_timer(&poll_timer);
 }
--- 25/drivers/pcmcia/sa1100_generic.c~drivers-timer-init	Mon Nov  4 19:24:58 2002
+++ 25-akpm/drivers/pcmcia/sa1100_generic.c	Mon Nov  4 21:02:36 2002
@@ -334,6 +334,7 @@ static DECLARE_WORK(sa1100_pcmcia_task, 
 static void sa1100_pcmcia_poll_event(unsigned long dummy)
 {
   DEBUG(4, "%s(): polling for events\n", __FUNCTION__);
+  init_timer(&poll_timer);
   poll_timer.function = sa1100_pcmcia_poll_event;
   poll_timer.expires = jiffies + SA1100_PCMCIA_POLL_PERIOD;
   add_timer(&poll_timer);
--- 25/drivers/sbus/char/bpp.c~drivers-timer-init	Mon Nov  4 19:24:59 2002
+++ 25-akpm/drivers/sbus/char/bpp.c	Mon Nov  4 21:03:51 2002
@@ -303,6 +303,7 @@ static void bpp_wake_up(unsigned long va
 
 static void snooze(unsigned long snooze_time, unsigned minor)
 {
+      init_timer(&instances[minor].timer_list);
       instances[minor].timer_list.expires = jiffies + snooze_time + 1;
       instances[minor].timer_list.data    = minor;
       add_timer(&instances[minor].timer_list);
--- 25/drivers/sbus/char/aurora.c~drivers-timer-init	Mon Nov  4 19:24:59 2002
+++ 25-akpm/drivers/sbus/char/aurora.c	Mon Nov  4 21:04:26 2002
@@ -883,8 +883,8 @@ static void aurora_interrupt(int irq, vo
 #ifdef AURORA_INT_DEBUG
 static void aurora_timer (unsigned long ignored);
 
-static struct timer_list
-aurora_poll_timer = { NULL, NULL, 0, 0, aurora_timer };
+static struct timer_list aurora_poll_timer =
+			TIMER_INITIALIZER(aurora_timer, 0, 0);
 
 static void
 aurora_timer (unsigned long ignored)
--- 25/drivers/sbus/char/cpwatchdog.c~drivers-timer-init	Mon Nov  4 19:24:59 2002
+++ 25-akpm/drivers/sbus/char/cpwatchdog.c	Mon Nov  4 21:05:02 2002
@@ -685,6 +685,7 @@ static void wd_brokentimer(unsigned long
 
 	if(tripped) {
 		/* there is at least one timer brokenstopped-- reschedule */
+		init_timer(&wd_timer);
 		wd_timer.expires = WD_BTIMEOUT;
 		add_timer(&wd_timer);
 	}
--- 25/drivers/scsi/pluto.c~drivers-timer-init	Mon Nov  4 19:24:59 2002
+++ 25-akpm/drivers/scsi/pluto.c	Mon Nov  4 21:07:30 2002
@@ -95,7 +95,8 @@ int __init pluto_detect(Scsi_Host_Templa
 	int i, retry, nplutos;
 	fc_channel *fc;
 	Scsi_Device dev;
-	struct timer_list fc_timer = { function: pluto_detect_timeout };
+	struct timer_list fc_timer =
+		TIMER_INITIALIZER(pluto_detect_timeout, 0, 0);
 
 	tpnt->proc_name = "pluto";
 	fcscount = 0;
--- 25/drivers/video/fbcon.c~drivers-timer-init	Mon Nov  4 19:25:01 2002
+++ 25-akpm/drivers/video/fbcon.c	Mon Nov  4 21:09:56 2002
@@ -230,9 +230,8 @@ static void fbcon_vbl_detect(int irq, vo
 
 static void cursor_timer_handler(unsigned long dev_addr);
 
-static struct timer_list cursor_timer = {
-    function: cursor_timer_handler
-};
+static struct timer_list cursor_timer =
+		TIMER_INITIALIZER(cursor_timer_handler, 0, 0);
 
 static void cursor_timer_handler(unsigned long dev_addr)
 {

.
