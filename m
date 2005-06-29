Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262637AbVF2VKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbVF2VKB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 17:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVF2VKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 17:10:01 -0400
Received: from mail.dif.dk ([193.138.115.101]:61363 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262655AbVF2U6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:58:38 -0400
Date: Wed, 29 Jun 2005 23:04:29 +0200 (CEST)
From: Jesper Juhl <juhl@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] clean up  inline static  vs  static inline  
Message-ID: <Pine.LNX.4.62.0506292256280.2998@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, I know you generally don't want to take patches for stuff that 
only fixes gcc -W warnings except through maintainers, but this one I 
found to be so obviously correct that I desided to take the chance anyway 
- especially since you've taken patches like this one in the past. :-)
Lets merge this and get rid of this little annoyance once and for all.

gcc likes to complain if the static keyword is not at the beginning of the 
declaration. This patch fixes all remaining occurrences of "inline static" 
up with "static inline" in the entire kernel tree (140 occurrences in 47 
files).
While making this change I came across a few lines with trailing 
whitespace that I also fixed up, I have also added or removed a blank line 
or two here and there, but there are no functional changes in the patch.


--- linux-2.6.13-rc1-orig/arch/ia64/sn/include/pci/pcibr_provider.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/arch/ia64/sn/include/pci/pcibr_provider.h	2005-06-29 22:25:10.000000000 +0200
@@ -114,7 +114,7 @@ struct pcibus_info {
 /*
  * pcibus_info structure locking macros
  */
-inline static unsigned long
+static inline unsigned long
 pcibr_lock(struct pcibus_info *pcibus_info)
 {
 	unsigned long flag;
--- linux-2.6.13-rc1-orig/crypto/aes.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/crypto/aes.c	2005-06-29 22:25:22.000000000 +0200
@@ -67,7 +67,7 @@
 /*
  * #define byte(x, nr) ((unsigned char)((x) >> (nr*8))) 
  */
-inline static u8
+static inline u8
 byte(const u32 x, const unsigned n)
 {
 	return x >> (n << 3);
--- linux-2.6.13-rc1-orig/drivers/cdrom/optcd.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/drivers/cdrom/optcd.c	2005-06-29 22:26:54.000000000 +0200
@@ -245,7 +245,7 @@ module_param(optcd_port, short, 0);
 
 
 /* Busy wait until FLAG goes low. Return 0 on timeout. */
-inline static int flag_low(int flag, unsigned long timeout)
+static inline int flag_low(int flag, unsigned long timeout)
 {
 	int flag_high;
 	unsigned long count = 0;
@@ -381,7 +381,7 @@ static int send_seek_params(struct cdrom
 
 /* Wait for command execution status. Choice between busy waiting
    and sleeping. Return value <0 indicates timeout. */
-inline static int get_exec_status(int busy_waiting)
+static inline int get_exec_status(int busy_waiting)
 {
 	unsigned char exec_status;
 
@@ -398,7 +398,7 @@ inline static int get_exec_status(int bu
 
 /* Wait busy for extra byte of data that a command returns.
    Return value <0 indicates timeout. */
-inline static int get_data(int short_timeout)
+static inline int get_data(int short_timeout)
 {
 	unsigned char data;
 
@@ -441,14 +441,14 @@ static int reset_drive(void)
 /* Facilities for asynchronous operation */
 
 /* Read status/data availability flags FL_STEN and FL_DTEN */
-inline static int stdt_flags(void)
+static inline int stdt_flags(void)
 {
 	return inb(STATUS_PORT) & FL_STDT;
 }
 
 
 /* Fetch status that has previously been waited for. <0 means not available */
-inline static int fetch_status(void)
+static inline int fetch_status(void)
 {
 	unsigned char status;
 
@@ -462,7 +462,7 @@ inline static int fetch_status(void)
 
 
 /* Fetch data that has previously been waited for. */
-inline static void fetch_data(char *buf, int n)
+static inline void fetch_data(char *buf, int n)
 {
 	insb(DATA_PORT, buf, n);
 	DEBUG((DEBUG_DRIVE_IF, "fetched 0x%x bytes", n));
@@ -470,7 +470,7 @@ inline static void fetch_data(char *buf,
 
 
 /* Flush status and data fifos */
-inline static void flush_data(void)
+static inline void flush_data(void)
 {
 	while ((inb(STATUS_PORT) & FL_STDT) != FL_STDT)
 		inb(DATA_PORT);
@@ -482,7 +482,7 @@ inline static void flush_data(void)
 
 /* Send a simple command and wait for response. Command codes < COMFETCH
    are quick response commands */
-inline static int exec_cmd(int cmd)
+static inline int exec_cmd(int cmd)
 {
 	int ack = send_cmd(cmd);
 	if (ack < 0)
@@ -493,7 +493,7 @@ inline static int exec_cmd(int cmd)
 
 /* Send a command with parameters. Don't wait for the response,
  * which consists of data blocks read from the CD. */
-inline static int exec_read_cmd(int cmd, struct cdrom_msf *params)
+static inline int exec_read_cmd(int cmd, struct cdrom_msf *params)
 {
 	int ack = send_cmd(cmd);
 	if (ack < 0)
@@ -503,7 +503,7 @@ inline static int exec_read_cmd(int cmd,
 
 
 /* Send a seek command with parameters and wait for response */
-inline static int exec_seek_cmd(int cmd, struct cdrom_msf *params)
+static inline int exec_seek_cmd(int cmd, struct cdrom_msf *params)
 {
 	int ack = send_cmd(cmd);
 	if (ack < 0)
@@ -516,7 +516,7 @@ inline static int exec_seek_cmd(int cmd,
 
 
 /* Send a command with parameters and wait for response */
-inline static int exec_long_cmd(int cmd, struct cdrom_msf *params)
+static inline int exec_long_cmd(int cmd, struct cdrom_msf *params)
 {
 	int ack = exec_read_cmd(cmd, params);
 	if (ack < 0)
@@ -528,7 +528,7 @@ inline static int exec_long_cmd(int cmd,
 
 
 /* Binary to BCD (2 digits) */
-inline static void single_bin2bcd(u_char *p)
+static inline void single_bin2bcd(u_char *p)
 {
 	DEBUG((DEBUG_CONV, "bin2bcd %02d", *p));
 	*p = (*p % 10) | ((*p / 10) << 4);
@@ -565,7 +565,7 @@ static void lba2msf(int lba, struct cdro
 
 
 /* Two BCD digits to binary */
-inline static u_char bcd2bin(u_char bcd)
+static inline u_char bcd2bin(u_char bcd)
 {
 	DEBUG((DEBUG_CONV, "bcd2bin %x%02x", bcd));
 	return (bcd >> 4) * 10 + (bcd & 0x0f);
@@ -988,7 +988,7 @@ static char buf[CD_FRAMESIZE * N_BUFS];
 static volatile int buf_bn[N_BUFS], next_bn;
 static volatile int buf_in = 0, buf_out = NOBUF;
 
-inline static void opt_invalidate_buffers(void)
+static inline void opt_invalidate_buffers(void)
 {
 	int i;
 
--- linux-2.6.13-rc1-orig/drivers/char/ipmi/ipmi_si_intf.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/drivers/char/ipmi/ipmi_si_intf.c	2005-06-29 22:27:06.000000000 +0200
@@ -1726,7 +1726,7 @@ static int dmi_table(u32 base, int len, 
 	return status;
 }
 
-inline static int dmi_checksum(u8 *buf)
+static inline int dmi_checksum(u8 *buf)
 {
 	u8   sum=0;
 	int  a;
--- linux-2.6.13-rc1-orig/drivers/ide/pci/cmd640.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/drivers/ide/pci/cmd640.c	2005-06-29 22:27:20.000000000 +0200
@@ -487,7 +487,7 @@ static void display_clocks (unsigned int
  * Pack active and recovery counts into single byte representation
  * used by controller
  */
-inline static u8 pack_nibbles (u8 upper, u8 lower)
+static inline u8 pack_nibbles (u8 upper, u8 lower)
 {
 	return ((upper & 0x0f) << 4) | (lower & 0x0f);
 }
--- linux-2.6.13-rc1-orig/drivers/isdn/hisax/avm_a1.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/drivers/isdn/hisax/avm_a1.c	2005-06-29 22:27:33.000000000 +0200
@@ -135,7 +135,7 @@ avm_a1_interrupt(int intno, void *dev_id
 	return IRQ_HANDLED;
 }
 
-inline static void
+static inline void
 release_ioregs(struct IsdnCardState *cs, int mask)
 {
 	release_region(cs->hw.avm.cfg_reg, 8);
--- linux-2.6.13-rc1-orig/drivers/isdn/hisax/isdnl2.c	2005-06-29 21:44:51.000000000 +0200
+++ linux-2.6.13-rc1/drivers/isdn/hisax/isdnl2.c	2005-06-29 22:27:44.000000000 +0200
@@ -212,7 +212,7 @@ sethdraddr(struct Layer2 *l2, u_char * h
 	}
 }
 
-inline static void
+static inline void
 enqueue_super(struct PStack *st,
 	      struct sk_buff *skb)
 {
--- linux-2.6.13-rc1-orig/drivers/isdn/hisax/teles3.c	2005-06-29 21:44:51.000000000 +0200
+++ linux-2.6.13-rc1/drivers/isdn/hisax/teles3.c	2005-06-29 22:27:56.000000000 +0200
@@ -143,7 +143,7 @@ teles3_interrupt(int intno, void *dev_id
 	return IRQ_HANDLED;
 }
 
-inline static void
+static inline void
 release_ioregs(struct IsdnCardState *cs, int mask)
 {
 	if (mask & 1)
--- linux-2.6.13-rc1-orig/drivers/md/md.c	2005-06-29 21:44:52.000000000 +0200
+++ linux-2.6.13-rc1/drivers/md/md.c	2005-06-29 22:28:06.000000000 +0200
@@ -284,7 +284,7 @@ static mdk_rdev_t * find_rdev(mddev_t * 
 	return NULL;
 }
 
-inline static sector_t calc_dev_sboffset(struct block_device *bdev)
+static inline sector_t calc_dev_sboffset(struct block_device *bdev)
 {
 	sector_t size = bdev->bd_inode->i_size >> BLOCK_SIZE_BITS;
 	return MD_NEW_SIZE_BLOCKS(size);
--- linux-2.6.13-rc1-orig/drivers/media/radio/radio-maestro.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/drivers/media/radio/radio-maestro.c	2005-06-29 22:28:25.000000000 +0200
@@ -154,7 +154,7 @@ static void radio_bits_set(struct radio_
 	msleep(125);
 }
 
-inline static int radio_function(struct inode *inode, struct file *file,
+static inline int radio_function(struct inode *inode, struct file *file,
 				 unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
@@ -283,7 +283,7 @@ static int __init maestro_radio_init(voi
 module_init(maestro_radio_init);
 module_exit(maestro_radio_exit);
 
-inline static __u16 radio_power_on(struct radio_device *dev)
+static inline __u16 radio_power_on(struct radio_device *dev)
 {
 	register __u16 io=dev->io;
 	register __u32 ofreq;
--- linux-2.6.13-rc1-orig/drivers/media/radio/radio-maxiradio.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/drivers/media/radio/radio-maxiradio.c	2005-06-29 22:28:36.000000000 +0200
@@ -166,7 +166,7 @@ static int get_tune(__u16 io)
 }
 
 
-inline static int radio_function(struct inode *inode, struct file *file,
+static inline int radio_function(struct inode *inode, struct file *file,
 				 unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
--- linux-2.6.13-rc1-orig/drivers/mmc/wbsd.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/drivers/mmc/wbsd.c	2005-06-29 22:28:48.000000000 +0200
@@ -1054,7 +1054,7 @@ static struct mmc_host_ops wbsd_ops = {
  * Tasklets
  */
 
-inline static struct mmc_data* wbsd_get_data(struct wbsd_host* host)
+static inline struct mmc_data* wbsd_get_data(struct wbsd_host* host)
 {
 	WARN_ON(!host->mrq);
 	if (!host->mrq)
--- linux-2.6.13-rc1-orig/drivers/net/3c505.c	2005-06-29 21:44:56.000000000 +0200
+++ linux-2.6.13-rc1/drivers/net/3c505.c	2005-06-29 22:28:58.000000000 +0200
@@ -272,7 +272,7 @@ static inline void set_hsf(struct net_de
 
 static int start_receive(struct net_device *, pcb_struct *);
 
-inline static void adapter_reset(struct net_device *dev)
+static inline void adapter_reset(struct net_device *dev)
 {
 	unsigned long timeout;
 	elp_device *adapter = dev->priv;
--- linux-2.6.13-rc1-orig/drivers/net/plip.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/drivers/net/plip.c	2005-06-29 22:32:39.000000000 +0200
@@ -160,7 +160,7 @@ static struct net_device_stats *plip_get
 static int plip_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
 static int plip_preempt(void *handle);
 static void plip_wakeup(void *handle);
-
+
 enum plip_connection_state {
 	PLIP_CN_NONE=0,
 	PLIP_CN_RECEIVE,
@@ -231,8 +231,8 @@ struct net_local {
 	atomic_t kill_timer;
 	struct semaphore killed_timer_sem;
 };
-
-inline static void enable_parport_interrupts (struct net_device *dev)
+
+static inline void enable_parport_interrupts (struct net_device *dev)
 {
 	if (dev->irq != -1)
 	{
@@ -242,7 +242,7 @@ inline static void enable_parport_interr
 	}
 }
 
-inline static void disable_parport_interrupts (struct net_device *dev)
+static inline void disable_parport_interrupts (struct net_device *dev)
 {
 	if (dev->irq != -1)
 	{
@@ -252,7 +252,7 @@ inline static void disable_parport_inter
 	}
 }
 
-inline static void write_data (struct net_device *dev, unsigned char data)
+static inline void write_data (struct net_device *dev, unsigned char data)
 {
 	struct parport *port =
 	   ((struct net_local *)dev->priv)->pardev->port;
@@ -260,14 +260,14 @@ inline static void write_data (struct ne
 	port->ops->write_data (port, data);
 }
 
-inline static unsigned char read_status (struct net_device *dev)
+static inline unsigned char read_status (struct net_device *dev)
 {
 	struct parport *port =
 	   ((struct net_local *)dev->priv)->pardev->port;
 
 	return port->ops->read_status (port);
 }
-
+
 /* Entry point of PLIP driver.
    Probe the hardware, and register/initialize the driver.
 
@@ -316,7 +316,7 @@ plip_init_netdev(struct net_device *dev)
 
 	spin_lock_init(&nl->lock);
 }
-
+
 /* Bottom half handler for the delayed request.
    This routine is kicked by do_timer().
    Request `plip_bh' to be invoked. */
@@ -471,7 +471,7 @@ plip_bh_timeout_error(struct net_device 
 
 	return TIMEOUT;
 }
-
+
 static int
 plip_none(struct net_device *dev, struct net_local *nl,
 	  struct plip_local *snd, struct plip_local *rcv)
@@ -481,7 +481,7 @@ plip_none(struct net_device *dev, struct
 
 /* PLIP_RECEIVE --- receive a byte(two nibbles)
    Returns OK on success, TIMEOUT on timeout */
-inline static int
+static inline int
 plip_receive(unsigned short nibble_timeout, struct net_device *dev,
 	     enum plip_nibble_state *ns_p, unsigned char *data_p)
 {
@@ -582,7 +582,6 @@ static unsigned short plip_type_trans(st
 	return htons(ETH_P_802_2);
 }
 
-
 /* PLIP_RECEIVE_PACKET --- receive a packet */
 static int
 plip_receive_packet(struct net_device *dev, struct net_local *nl,
@@ -702,7 +701,7 @@ plip_receive_packet(struct net_device *d
 
 /* PLIP_SEND --- send a byte (two nibbles)
    Returns OK on success, TIMEOUT when timeout    */
-inline static int
+static inline int
 plip_send(unsigned short nibble_timeout, struct net_device *dev,
 	  enum plip_nibble_state *ns_p, unsigned char data)
 {
@@ -902,7 +901,7 @@ plip_error(struct net_device *dev, struc
 
 	return OK;
 }
-
+
 /* Handle the parallel port interrupts. */
 static void
 plip_interrupt(int irq, void *dev_id, struct pt_regs * regs)
@@ -957,7 +956,7 @@ plip_interrupt(int irq, void *dev_id, st
 
 	spin_unlock_irq(&nl->lock);
 }
-
+
 static int
 plip_tx_packet(struct sk_buff *skb, struct net_device *dev)
 {
@@ -1238,7 +1237,7 @@ plip_ioctl(struct net_device *dev, struc
 	}
 	return 0;
 }
-
+
 static int parport[PLIP_MAX] = { [0 ... PLIP_MAX-1] = -1 };
 static int timid;
 
--- linux-2.6.13-rc1-orig/drivers/net/via-velocity.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/drivers/net/via-velocity.h	2005-06-29 22:33:03.000000000 +0200
@@ -1414,7 +1414,7 @@ static inline void mac_get_cam(struct ma
  *	the rest of the logic from the result of sleep/wakeup
  */
 
-inline static void mac_wol_reset(struct mac_regs __iomem * regs)
+static inline void mac_wol_reset(struct mac_regs __iomem * regs)
 {
 
 	/* Turn off SWPTAG right after leaving power mode */
@@ -1811,7 +1811,7 @@ struct velocity_info {
  *	CHECK ME: locking
  */
 
-inline static int velocity_get_ip(struct velocity_info *vptr)
+static inline int velocity_get_ip(struct velocity_info *vptr)
 {
 	struct in_device *in_dev = (struct in_device *) vptr->dev->ip_ptr;
 	struct in_ifaddr *ifa;
--- linux-2.6.13-rc1-orig/drivers/net/wireless/airo.c	2005-06-29 21:44:58.000000000 +0200
+++ linux-2.6.13-rc1/drivers/net/wireless/airo.c	2005-06-29 22:33:15.000000000 +0200
@@ -5013,7 +5013,7 @@ static void proc_SSID_on_close( struct i
 	enable_MAC(ai, &rsp, 1);
 }
 
-inline static u8 hexVal(char c) {
+static inline u8 hexVal(char c) {
 	if (c>='0' && c<='9') return c -= '0';
 	if (c>='a' && c<='f') return c -= 'a'-10;
 	if (c>='A' && c<='F') return c -= 'A'-10;
--- linux-2.6.13-rc1-orig/drivers/oprofile/cpu_buffer.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/drivers/oprofile/cpu_buffer.c	2005-06-29 22:35:25.000000000 +0200
@@ -42,8 +42,7 @@ void free_cpu_buffers(void)
 		vfree(cpu_buffer[i].buffer);
 	}
 }
- 
- 
+
 int alloc_cpu_buffers(void)
 {
 	int i;
@@ -74,7 +73,6 @@ fail:
 	free_cpu_buffers();
 	return -ENOMEM;
 }
- 
 
 void start_cpu_work(void)
 {
@@ -93,7 +91,6 @@ void start_cpu_work(void)
 	}
 }
 
-
 void end_cpu_work(void)
 {
 	int i;
@@ -109,7 +106,6 @@ void end_cpu_work(void)
 	flush_scheduled_work();
 }
 
-
 /* Resets the cpu buffer to a sane state. */
 void cpu_buffer_reset(struct oprofile_cpu_buffer * cpu_buf)
 {
@@ -121,7 +117,6 @@ void cpu_buffer_reset(struct oprofile_cp
 	cpu_buf->last_task = NULL;
 }
 
-
 /* compute number of available slots in cpu_buffer queue */
 static unsigned long nr_available_slots(struct oprofile_cpu_buffer const * b)
 {
@@ -134,7 +129,6 @@ static unsigned long nr_available_slots(
 	return tail + (b->buffer_size - head) - 1;
 }
 
-
 static void increment_head(struct oprofile_cpu_buffer * b)
 {
 	unsigned long new_head = b->head_pos + 1;
@@ -149,10 +143,7 @@ static void increment_head(struct oprofi
 		b->head_pos = 0;
 }
 
-
-
-
-inline static void
+static inline void
 add_sample(struct oprofile_cpu_buffer * cpu_buf,
            unsigned long pc, unsigned long event)
 {
@@ -162,14 +153,12 @@ add_sample(struct oprofile_cpu_buffer * 
 	increment_head(cpu_buf);
 }
 
-
-inline static void
+static inline void
 add_code(struct oprofile_cpu_buffer * buffer, unsigned long value)
 {
 	add_sample(buffer, ESCAPE_CODE, value);
 }
 
-
 /* This must be safe from any context. It's safe writing here
  * because of the head/tail separation of the writer and reader
  * of the CPU buffer.
@@ -223,13 +212,11 @@ static int oprofile_begin_trace(struct o
 	return 1;
 }
 
-
 static void oprofile_end_trace(struct oprofile_cpu_buffer * cpu_buf)
 {
 	cpu_buf->tracing = 0;
 }
 
-
 void oprofile_add_sample(struct pt_regs * const regs, unsigned long event)
 {
 	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[smp_processor_id()];
@@ -251,14 +238,12 @@ void oprofile_add_sample(struct pt_regs 
 	oprofile_end_trace(cpu_buf);
 }
 
-
 void oprofile_add_pc(unsigned long pc, int is_kernel, unsigned long event)
 {
 	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[smp_processor_id()];
 	log_sample(cpu_buf, pc, is_kernel, event);
 }
 
-
 void oprofile_add_trace(unsigned long pc)
 {
 	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[smp_processor_id()];
@@ -283,8 +268,6 @@ void oprofile_add_trace(unsigned long pc
 	add_sample(cpu_buf, pc, 0);
 }
 
-
-
 /*
  * This serves to avoid cpu buffer overflow, and makes sure
  * the task mortuary progresses
--- linux-2.6.13-rc1-orig/drivers/s390/cio/qdio.c	2005-06-29 21:44:58.000000000 +0200
+++ linux-2.6.13-rc1/drivers/s390/cio/qdio.c	2005-06-29 22:36:34.000000000 +0200
@@ -432,7 +432,7 @@ tiqdio_clear_global_summary(void)
 
 /************************* OUTBOUND ROUTINES *******************************/
 
-inline static int
+static inline int
 qdio_get_outbound_buffer_frontier(struct qdio_q *q)
 {
 	int f,f_mod_no;
@@ -510,7 +510,7 @@ out:
 }
 
 /* all buffers are processed */
-inline static int
+static inline int
 qdio_is_outbound_q_done(struct qdio_q *q)
 {
 	int no_used;
@@ -532,7 +532,7 @@ qdio_is_outbound_q_done(struct qdio_q *q
 	return (no_used==0);
 }
 
-inline static int
+static inline int
 qdio_has_outbound_q_moved(struct qdio_q *q)
 {
 	int i;
@@ -552,7 +552,7 @@ qdio_has_outbound_q_moved(struct qdio_q 
 	}
 }
 
-inline static void
+static inline void
 qdio_kick_outbound_q(struct qdio_q *q)
 {
 	int result;
@@ -641,7 +641,7 @@ qdio_kick_outbound_q(struct qdio_q *q)
 		}
 }
 
-inline static void
+static inline void
 qdio_kick_outbound_handler(struct qdio_q *q)
 {
 	int start, end, real_end, count;
@@ -740,7 +740,7 @@ qdio_outbound_processing(struct qdio_q *
 /************************* INBOUND ROUTINES *******************************/
 
 
-inline static int
+static inline int
 qdio_get_inbound_buffer_frontier(struct qdio_q *q)
 {
 	int f,f_mod_no;
@@ -865,7 +865,7 @@ out:
 	return q->first_to_check;
 }
 
-inline static int
+static inline int
 qdio_has_inbound_q_moved(struct qdio_q *q)
 {
 	int i;
@@ -898,7 +898,7 @@ qdio_has_inbound_q_moved(struct qdio_q *
 }
 
 /* means, no more buffers to be filled */
-inline static int
+static inline int
 tiqdio_is_inbound_q_done(struct qdio_q *q)
 {
 	int no_used;
@@ -951,7 +951,7 @@ tiqdio_is_inbound_q_done(struct qdio_q *
 	return 0;
 }
 
-inline static int
+static inline int
 qdio_is_inbound_q_done(struct qdio_q *q)
 {
 	int no_used;
@@ -1010,7 +1010,7 @@ qdio_is_inbound_q_done(struct qdio_q *q)
 	}
 }
 
-inline static void
+static inline void
 qdio_kick_inbound_handler(struct qdio_q *q)
 {
 	int count, start, end, real_end, i;
--- linux-2.6.13-rc1-orig/drivers/s390/net/qeth.h	2005-06-29 21:44:58.000000000 +0200
+++ linux-2.6.13-rc1/drivers/s390/net/qeth.h	2005-06-29 22:38:21.000000000 +0200
@@ -824,7 +824,7 @@ extern struct list_head qeth_notify_list
 
 #define QETH_CARD_IFNAME(card) (((card)->dev)? (card)->dev->name : "")
 
-inline static __u8
+static inline __u8
 qeth_get_ipa_adp_type(enum qeth_link_types link_type)
 {
 	switch (link_type) {
@@ -835,7 +835,7 @@ qeth_get_ipa_adp_type(enum qeth_link_typ
 	}
 }
 
-inline static int
+static inline int
 qeth_realloc_headroom(struct qeth_card *card, struct sk_buff **skb, int size)
 {
 	struct sk_buff *new_skb = NULL;
@@ -852,6 +852,7 @@ qeth_realloc_headroom(struct qeth_card *
 	}
 	return 0;
 }
+
 static inline struct sk_buff *
 qeth_pskb_unshare(struct sk_buff *skb, int pri)
 {
@@ -863,8 +864,7 @@ qeth_pskb_unshare(struct sk_buff *skb, i
         return nskb;
 }
 
-
-inline static void *
+static inline void *
 qeth_push_skb(struct qeth_card *card, struct sk_buff **skb, int size)
 {
         void *hdr;
@@ -887,7 +887,7 @@ qeth_push_skb(struct qeth_card *card, st
 }
 
 
-inline static int
+static inline int
 qeth_get_hlen(__u8 link_type)
 {
 #ifdef CONFIG_QETH_IPV6
@@ -911,7 +911,7 @@ qeth_get_hlen(__u8 link_type)
 #endif /* CONFIG_QETH_IPV6 */
 }
 
-inline static unsigned short
+static inline unsigned short
 qeth_get_netdev_flags(struct qeth_card *card)
 {
 	if (card->options.layer2)
@@ -929,7 +929,7 @@ qeth_get_netdev_flags(struct qeth_card *
 	}
 }
 
-inline static int
+static inline int
 qeth_get_initial_mtu_for_card(struct qeth_card * card)
 {
 	switch (card->info.type) {
@@ -950,7 +950,7 @@ qeth_get_initial_mtu_for_card(struct qet
 	}
 }
 
-inline static int
+static inline int
 qeth_get_max_mtu_for_card(int cardtype)
 {
 	switch (cardtype) {
@@ -965,7 +965,7 @@ qeth_get_max_mtu_for_card(int cardtype)
 	}
 }
 
-inline static int
+static inline int
 qeth_get_mtu_out_of_mpc(int cardtype)
 {
 	switch (cardtype) {
@@ -976,7 +976,7 @@ qeth_get_mtu_out_of_mpc(int cardtype)
 	}
 }
 
-inline static int
+static inline int
 qeth_get_mtu_outof_framesize(int framesize)
 {
 	switch (framesize) {
@@ -993,7 +993,7 @@ qeth_get_mtu_outof_framesize(int framesi
 	}
 }
 
-inline static int
+static inline int
 qeth_mtu_is_valid(struct qeth_card * card, int mtu)
 {
 	switch (card->info.type) {
@@ -1008,7 +1008,7 @@ qeth_mtu_is_valid(struct qeth_card * car
 	}
 }
 
-inline static int
+static inline int
 qeth_get_arphdr_type(int cardtype, int linktype)
 {
 	switch (cardtype) {
@@ -1027,7 +1027,7 @@ qeth_get_arphdr_type(int cardtype, int l
 }
 
 #ifdef CONFIG_QETH_PERF_STATS
-inline static int
+static inline int
 qeth_get_micros(void)
 {
 	return (int) (get_clock() >> 12);
--- linux-2.6.13-rc1-orig/drivers/scsi/dc395x.c	2005-06-29 21:44:58.000000000 +0200
+++ linux-2.6.13-rc1/drivers/scsi/dc395x.c	2005-06-29 22:38:35.000000000 +0200
@@ -744,7 +744,7 @@ static void free_tag(struct DeviceCtlBlk
 
 
 /* Find cmd in SRB list */
-inline static struct ScsiReqBlk *find_cmd(struct scsi_cmnd *cmd, 
+static inline struct ScsiReqBlk *find_cmd(struct scsi_cmnd *cmd, 
 		struct list_head *head)
 {
 	struct ScsiReqBlk *i;
--- linux-2.6.13-rc1-orig/drivers/scsi/fdomain.c	2005-06-29 21:44:58.000000000 +0200
+++ linux-2.6.13-rc1/drivers/scsi/fdomain.c	2005-06-29 22:38:47.000000000 +0200
@@ -570,7 +570,7 @@ static void do_pause(unsigned amount)	/*
 	mdelay(10*amount);
 }
 
-inline static void fdomain_make_bus_idle( void )
+static inline void fdomain_make_bus_idle( void )
 {
    outb(0, port_base + SCSI_Cntl);
    outb(0, port_base + SCSI_Mode_Cntl);
--- linux-2.6.13-rc1-orig/drivers/usb/image/microtek.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/drivers/usb/image/microtek.c	2005-06-29 22:39:15.000000000 +0200
@@ -361,8 +361,7 @@ int mts_scsi_queuecommand (Scsi_Cmnd *sr
 static void mts_transfer_cleanup( struct urb *transfer );
 static void mts_do_sg(struct urb * transfer, struct pt_regs *regs);
 
-
-inline static
+static inline
 void mts_int_submit_urb (struct urb* transfer,
 			int pipe,
 			void* data,
--- linux-2.6.13-rc1-orig/drivers/video/pm2fb.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/drivers/video/pm2fb.c	2005-06-29 22:40:06.000000000 +0200
@@ -138,27 +138,27 @@ static struct fb_var_screeninfo pm2fb_va
  * Utility functions
  */
 
-inline static u32 RD32(unsigned char __iomem *base, s32 off)
+static inline u32 RD32(unsigned char __iomem *base, s32 off)
 {
 	return fb_readl(base + off);
 }
 
-inline static void WR32(unsigned char __iomem *base, s32 off, u32 v)
+static inline void WR32(unsigned char __iomem *base, s32 off, u32 v)
 {
 	fb_writel(v, base + off);
 }
 
-inline static u32 pm2_RD(struct pm2fb_par* p, s32 off)
+static inline u32 pm2_RD(struct pm2fb_par* p, s32 off)
 {
 	return RD32(p->v_regs, off);
 }
 
-inline static void pm2_WR(struct pm2fb_par* p, s32 off, u32 v)
+static inline void pm2_WR(struct pm2fb_par* p, s32 off, u32 v)
 {
 	WR32(p->v_regs, off, v);
 }
 
-inline static u32 pm2_RDAC_RD(struct pm2fb_par* p, s32 idx)
+static inline u32 pm2_RDAC_RD(struct pm2fb_par* p, s32 idx)
 {
 	int index = PM2R_RD_INDEXED_DATA;
 	switch (p->type) {
@@ -174,7 +174,7 @@ inline static u32 pm2_RDAC_RD(struct pm2
 	return pm2_RD(p, index);
 }
 
-inline static void pm2_RDAC_WR(struct pm2fb_par* p, s32 idx, u32 v)
+static inline void pm2_RDAC_WR(struct pm2fb_par* p, s32 idx, u32 v)
 {
 	int index = PM2R_RD_INDEXED_DATA;
 	switch (p->type) {
@@ -190,7 +190,7 @@ inline static void pm2_RDAC_WR(struct pm
 	pm2_WR(p, index, v);
 }
 
-inline static void pm2v_RDAC_WR(struct pm2fb_par* p, s32 idx, u32 v)
+static inline void pm2v_RDAC_WR(struct pm2fb_par* p, s32 idx, u32 v)
 {
 	pm2_WR(p, PM2VR_RD_INDEX_LOW, idx & 0xff);
 	mb();
@@ -200,7 +200,7 @@ inline static void pm2v_RDAC_WR(struct p
 #ifdef CONFIG_FB_PM2_FIFO_DISCONNECT
 #define WAIT_FIFO(p,a)
 #else
-inline static void WAIT_FIFO(struct pm2fb_par* p, u32 a)
+static inline void WAIT_FIFO(struct pm2fb_par* p, u32 a)
 {
 	while( pm2_RD(p, PM2R_IN_FIFO_SPACE) < a );
 	mb();
--- linux-2.6.13-rc1-orig/fs/reiserfs/journal.c	2005-06-29 21:45:02.000000000 +0200
+++ linux-2.6.13-rc1/fs/reiserfs/journal.c	2005-06-29 22:40:29.000000000 +0200
@@ -515,13 +515,13 @@ static inline void insert_journal_hash(s
 }
 
 /* lock the current transaction */
-inline static void lock_journal(struct super_block *p_s_sb) {
+static inline void lock_journal(struct super_block *p_s_sb) {
     PROC_INFO_INC( p_s_sb, journal.lock_journal );
     down(&SB_JOURNAL(p_s_sb)->j_lock);
 }
 
 /* unlock the current transaction */
-inline static void unlock_journal(struct super_block *p_s_sb) {
+static inline void unlock_journal(struct super_block *p_s_sb) {
     up(&SB_JOURNAL(p_s_sb)->j_lock);
 }
 
--- linux-2.6.13-rc1-orig/include/sound/vx_core.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/include/sound/vx_core.h	2005-06-29 22:41:18.000000000 +0200
@@ -233,37 +233,37 @@ irqreturn_t snd_vx_irq_handler(int irq, 
 /*
  * lowlevel functions
  */
-inline static int vx_test_and_ack(vx_core_t *chip)
+static inline int vx_test_and_ack(vx_core_t *chip)
 {
 	snd_assert(chip->ops->test_and_ack, return -ENXIO);
 	return chip->ops->test_and_ack(chip);
 }
 
-inline static void vx_validate_irq(vx_core_t *chip, int enable)
+static inline void vx_validate_irq(vx_core_t *chip, int enable)
 {
 	snd_assert(chip->ops->validate_irq, return);
 	chip->ops->validate_irq(chip, enable);
 }
 
-inline static unsigned char snd_vx_inb(vx_core_t *chip, int reg)
+static inline unsigned char snd_vx_inb(vx_core_t *chip, int reg)
 {
 	snd_assert(chip->ops->in8, return 0);
 	return chip->ops->in8(chip, reg);
 }
 
-inline static unsigned int snd_vx_inl(vx_core_t *chip, int reg)
+static inline unsigned int snd_vx_inl(vx_core_t *chip, int reg)
 {
 	snd_assert(chip->ops->in32, return 0);
 	return chip->ops->in32(chip, reg);
 }
 
-inline static void snd_vx_outb(vx_core_t *chip, int reg, unsigned char val)
+static inline void snd_vx_outb(vx_core_t *chip, int reg, unsigned char val)
 {
 	snd_assert(chip->ops->out8, return);
 	chip->ops->out8(chip, reg, val);
 }
 
-inline static void snd_vx_outl(vx_core_t *chip, int reg, unsigned int val)
+static inline void snd_vx_outl(vx_core_t *chip, int reg, unsigned int val)
 {
 	snd_assert(chip->ops->out32, return);
 	chip->ops->out32(chip, reg, val);
@@ -303,14 +303,14 @@ int snd_vx_check_reg_bit(vx_core_t *chip
 /*
  * pseudo-DMA transfer
  */
-inline static void vx_pseudo_dma_write(vx_core_t *chip, snd_pcm_runtime_t *runtime,
+static inline void vx_pseudo_dma_write(vx_core_t *chip, snd_pcm_runtime_t *runtime,
 				       vx_pipe_t *pipe, int count)
 {
 	snd_assert(chip->ops->dma_write, return);
 	chip->ops->dma_write(chip, runtime, pipe, count);
 }
 
-inline static void vx_pseudo_dma_read(vx_core_t *chip, snd_pcm_runtime_t *runtime,
+static inline void vx_pseudo_dma_read(vx_core_t *chip, snd_pcm_runtime_t *runtime,
 				      vx_pipe_t *pipe, int count)
 {
 	snd_assert(chip->ops->dma_read, return);
--- linux-2.6.13-rc1-orig/kernel/time.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/kernel/time.c	2005-06-29 22:41:27.000000000 +0200
@@ -128,7 +128,7 @@ asmlinkage long sys_gettimeofday(struct 
  * as real UNIX machines always do it. This avoids all headaches about
  * daylight saving times and warping kernel clocks.
  */
-inline static void warp_clock(void)
+static inline void warp_clock(void)
 {
 	write_seqlock_irq(&xtime_lock);
 	wall_to_monotonic.tv_sec -= sys_tz.tz_minuteswest * 60;
--- linux-2.6.13-rc1-orig/net/core/pktgen.c	2005-06-29 21:45:09.000000000 +0200
+++ linux-2.6.13-rc1/net/core/pktgen.c	2005-06-29 22:41:38.000000000 +0200
@@ -363,7 +363,7 @@ struct pktgen_thread {
  * All Rights Reserved.
  *
  */
-inline static s64 divremdi3(s64 x, s64 y, int type) 
+static inline s64 divremdi3(s64 x, s64 y, int type) 
 {
         u64 a = (x < 0) ? -x : x;
         u64 b = (y < 0) ? -y : y;
--- linux-2.6.13-rc1-orig/sound/core/seq/oss/seq_oss_device.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/core/seq/oss/seq_oss_device.h	2005-06-29 22:41:58.000000000 +0200
@@ -158,21 +158,21 @@ void snd_seq_oss_readq_info_read(seq_oss
 #define is_nonblock_mode(mode)	((mode) & SNDRV_SEQ_OSS_FILE_NONBLOCK)
 
 /* dispatch event */
-inline static int
+static inline int
 snd_seq_oss_dispatch(seq_oss_devinfo_t *dp, snd_seq_event_t *ev, int atomic, int hop)
 {
 	return snd_seq_kernel_client_dispatch(dp->cseq, ev, atomic, hop);
 }
 
 /* ioctl */
-inline static int
+static inline int
 snd_seq_oss_control(seq_oss_devinfo_t *dp, unsigned int type, void *arg)
 {
 	return snd_seq_kernel_client_ctl(dp->cseq, type, arg);
 }
 
 /* fill the addresses in header */
-inline static void
+static inline void
 snd_seq_oss_fill_addr(seq_oss_devinfo_t *dp, snd_seq_event_t *ev,
 		     int dest_client, int dest_port)
 {
--- linux-2.6.13-rc1-orig/sound/core/seq/seq_memory.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/core/seq/seq_memory.c	2005-06-29 22:42:17.000000000 +0200
@@ -36,12 +36,12 @@
 #define semaphore_of(fp)	((fp)->f_dentry->d_inode->i_sem)
 
 
-inline static int snd_seq_pool_available(pool_t *pool)
+static inline int snd_seq_pool_available(pool_t *pool)
 {
 	return pool->total_elements - atomic_read(&pool->counter);
 }
 
-inline static int snd_seq_output_ok(pool_t *pool)
+static inline int snd_seq_output_ok(pool_t *pool)
 {
 	return snd_seq_pool_available(pool) >= pool->room;
 }
--- linux-2.6.13-rc1-orig/sound/core/seq/seq_midi_event.c	2005-06-29 21:45:12.000000000 +0200
+++ linux-2.6.13-rc1/sound/core/seq/seq_midi_event.c	2005-06-29 22:42:28.000000000 +0200
@@ -146,7 +146,7 @@ void snd_midi_event_free(snd_midi_event_
 /*
  * initialize record
  */
-inline static void reset_encode(snd_midi_event_t *dev)
+static inline void reset_encode(snd_midi_event_t *dev)
 {
 	dev->read = 0;
 	dev->qlen = 0;
--- linux-2.6.13-rc1-orig/sound/drivers/serial-u16550.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/drivers/serial-u16550.c	2005-06-29 22:43:20.000000000 +0200
@@ -168,7 +168,7 @@ typedef struct _snd_uart16550 {
 
 static snd_card_t *snd_serial_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
 
-inline static void snd_uart16550_add_timer(snd_uart16550_t *uart)
+static inline void snd_uart16550_add_timer(snd_uart16550_t *uart)
 {
 	if (! uart->timer_running) {
 		/* timer 38600bps * 10bit * 16byte */
@@ -178,7 +178,7 @@ inline static void snd_uart16550_add_tim
 	}
 }
 
-inline static void snd_uart16550_del_timer(snd_uart16550_t *uart)
+static inline void snd_uart16550_del_timer(snd_uart16550_t *uart)
 {
 	if (uart->timer_running) {
 		del_timer(&uart->buffer_timer);
@@ -187,7 +187,7 @@ inline static void snd_uart16550_del_tim
 }
 
 /* This macro is only used in snd_uart16550_io_loop */
-inline static void snd_uart16550_buffer_output(snd_uart16550_t *uart)
+static inline void snd_uart16550_buffer_output(snd_uart16550_t *uart)
 {
 	unsigned short buff_out = uart->buff_out;
 	if( uart->buff_in_count > 0 ) {
@@ -579,7 +579,7 @@ static int snd_uart16550_output_close(sn
 	return 0;
 };
 
-inline static int snd_uart16550_buffer_can_write( snd_uart16550_t *uart, int Num )
+static inline int snd_uart16550_buffer_can_write( snd_uart16550_t *uart, int Num )
 {
 	if( uart->buff_in_count + Num < TX_BUFF_SIZE )
 		return 1;
@@ -587,7 +587,7 @@ inline static int snd_uart16550_buffer_c
 		return 0;
 }
 
-inline static int snd_uart16550_write_buffer(snd_uart16550_t *uart, unsigned char byte)
+static inline int snd_uart16550_write_buffer(snd_uart16550_t *uart, unsigned char byte)
 {
 	unsigned short buff_in = uart->buff_in;
 	if( uart->buff_in_count < TX_BUFF_SIZE ) {
--- linux-2.6.13-rc1-orig/sound/isa/sb/emu8000_patch.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/isa/sb/emu8000_patch.c	2005-06-29 22:43:51.000000000 +0200
@@ -128,7 +128,7 @@ snd_emu8000_write_wait(emu8000_t *emu)
  * This is therefore much slower than need be, but is at least
  * working.
  */
-inline static void
+static inline void
 write_word(emu8000_t *emu, int *offset, unsigned short data)
 {
 	if (emu8000_reset_addr) {
--- linux-2.6.13-rc1-orig/sound/oss/dmasound/dmasound_awacs.c	2005-06-29 21:45:12.000000000 +0200
+++ linux-2.6.13-rc1/sound/oss/dmasound/dmasound_awacs.c	2005-06-29 22:44:06.000000000 +0200
@@ -1557,7 +1557,7 @@ static int awacs_sleep_notify(struct pmu
 /* All the burgundy functions: */
 
 /* Waits for busy flag to clear */
-inline static void
+static inline void
 awacs_burgundy_busy_wait(void)
 {
 	int count = 50; /* > 2 samples at 44k1 */
@@ -1565,7 +1565,7 @@ awacs_burgundy_busy_wait(void)
 		udelay(1) ;
 }
 
-inline static void
+static inline void
 awacs_burgundy_extend_wait(void)
 {
 	int count = 50 ; /* > 2 samples at 44k1 */
--- linux-2.6.13-rc1-orig/sound/pci/cmipci.c	2005-06-29 21:45:13.000000000 +0200
+++ linux-2.6.13-rc1/sound/pci/cmipci.c	2005-06-29 22:44:54.000000000 +0200
@@ -488,32 +488,34 @@ struct snd_stru_cmipci {
 
 
 /* read/write operations for dword register */
-inline static void snd_cmipci_write(cmipci_t *cm, unsigned int cmd, unsigned int data)
+static inline void snd_cmipci_write(cmipci_t *cm, unsigned int cmd, unsigned int data)
 {
 	outl(data, cm->iobase + cmd);
 }
-inline static unsigned int snd_cmipci_read(cmipci_t *cm, unsigned int cmd)
+
+static inline unsigned int snd_cmipci_read(cmipci_t *cm, unsigned int cmd)
 {
 	return inl(cm->iobase + cmd);
 }
 
 /* read/write operations for word register */
-inline static void snd_cmipci_write_w(cmipci_t *cm, unsigned int cmd, unsigned short data)
+static inline void snd_cmipci_write_w(cmipci_t *cm, unsigned int cmd, unsigned short data)
 {
 	outw(data, cm->iobase + cmd);
 }
-inline static unsigned short snd_cmipci_read_w(cmipci_t *cm, unsigned int cmd)
+
+static inline unsigned short snd_cmipci_read_w(cmipci_t *cm, unsigned int cmd)
 {
 	return inw(cm->iobase + cmd);
 }
 
 /* read/write operations for byte register */
-inline static void snd_cmipci_write_b(cmipci_t *cm, unsigned int cmd, unsigned char data)
+static inline void snd_cmipci_write_b(cmipci_t *cm, unsigned int cmd, unsigned char data)
 {
 	outb(data, cm->iobase + cmd);
 }
 
-inline static unsigned char snd_cmipci_read_b(cmipci_t *cm, unsigned int cmd)
+static inline unsigned char snd_cmipci_read_b(cmipci_t *cm, unsigned int cmd)
 {
 	return inb(cm->iobase + cmd);
 }
--- linux-2.6.13-rc1-orig/sound/pci/cs4281.c	2005-06-29 21:45:13.000000000 +0200
+++ linux-2.6.13-rc1/sound/pci/cs4281.c	2005-06-29 22:45:07.000000000 +0200
@@ -542,7 +542,7 @@ static void snd_cs4281_delay(unsigned in
 	}
 }
 
-inline static void snd_cs4281_delay_long(void)
+static inline void snd_cs4281_delay_long(void)
 {
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(1);
--- linux-2.6.13-rc1-orig/sound/pci/emu10k1/memory.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/pci/emu10k1/memory.c	2005-06-29 22:45:20.000000000 +0200
@@ -495,7 +495,7 @@ static int synth_free_pages(emu10k1_t *e
 }
 
 /* calculate buffer pointer from offset address */
-inline static void *offset_ptr(emu10k1_t *emu, int page, int offset)
+static inline void *offset_ptr(emu10k1_t *emu, int page, int offset)
 {
 	char *ptr;
 	snd_assert(page >= 0 && page < emu->max_cache_pages, return NULL);
--- linux-2.6.13-rc1-orig/sound/pci/es1968.c	2005-06-29 21:45:13.000000000 +0200
+++ linux-2.6.13-rc1/sound/pci/es1968.c	2005-06-29 22:46:10.000000000 +0200
@@ -636,7 +636,7 @@ static void __maestro_write(es1968_t *ch
 	chip->maestro_map[reg] = data;
 }
 
-inline static void maestro_write(es1968_t *chip, u16 reg, u16 data)
+static inline void maestro_write(es1968_t *chip, u16 reg, u16 data)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&chip->reg_lock, flags);
@@ -654,7 +654,7 @@ static u16 __maestro_read(es1968_t *chip
 	return chip->maestro_map[reg];
 }
 
-inline static u16 maestro_read(es1968_t *chip, u16 reg)
+static inline u16 maestro_read(es1968_t *chip, u16 reg)
 {
 	unsigned long flags;
 	u16 result;
@@ -755,7 +755,7 @@ static void __apu_set_register(es1968_t 
 	apu_data_set(chip, data);
 }
 
-inline static void apu_set_register(es1968_t *chip, u16 channel, u8 reg, u16 data)
+static inline void apu_set_register(es1968_t *chip, u16 channel, u8 reg, u16 data)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&chip->reg_lock, flags);
@@ -771,7 +771,7 @@ static u16 __apu_get_register(es1968_t *
 	return __maestro_read(chip, IDR0_DATA_PORT);
 }
 
-inline static u16 apu_get_register(es1968_t *chip, u16 channel, u8 reg)
+static inline u16 apu_get_register(es1968_t *chip, u16 channel, u8 reg)
 {
 	unsigned long flags;
 	u16 v;
@@ -957,7 +957,7 @@ static u32 snd_es1968_compute_rate(es196
 }
 
 /* get current pointer */
-inline static unsigned int
+static inline unsigned int
 snd_es1968_get_dma_ptr(es1968_t *chip, esschan_t *es)
 {
 	unsigned int offset;
@@ -978,7 +978,7 @@ static void snd_es1968_apu_set_freq(es19
 }
 
 /* spin lock held */
-inline static void snd_es1968_trigger_apu(es1968_t *esm, int apu, int mode)
+static inline void snd_es1968_trigger_apu(es1968_t *esm, int apu, int mode)
 {
 	/* set the APU mode */
 	__apu_set_register(esm, apu, 0,
--- linux-2.6.13-rc1-orig/sound/pci/maestro3.c	2005-06-29 21:45:13.000000000 +0200
+++ linux-2.6.13-rc1/sound/pci/maestro3.c	2005-06-29 22:46:39.000000000 +0200
@@ -1055,22 +1055,22 @@ static struct m3_hv_quirk m3_hv_quirk_li
 	schedule_timeout(((msec) * HZ) / 1000);\
 } while (0)
 	
-inline static void snd_m3_outw(m3_t *chip, u16 value, unsigned long reg)
+static inline void snd_m3_outw(m3_t *chip, u16 value, unsigned long reg)
 {
 	outw(value, chip->iobase + reg);
 }
 
-inline static u16 snd_m3_inw(m3_t *chip, unsigned long reg)
+static inline u16 snd_m3_inw(m3_t *chip, unsigned long reg)
 {
 	return inw(chip->iobase + reg);
 }
 
-inline static void snd_m3_outb(m3_t *chip, u8 value, unsigned long reg)
+static inline void snd_m3_outb(m3_t *chip, u8 value, unsigned long reg)
 {
 	outb(value, chip->iobase + reg);
 }
 
-inline static u8 snd_m3_inb(m3_t *chip, unsigned long reg)
+static inline u8 snd_m3_inb(m3_t *chip, unsigned long reg)
 {
 	return inb(chip->iobase + reg);
 }
--- linux-2.6.13-rc1-orig/sound/pci/nm256/nm256.c	2005-06-29 21:45:13.000000000 +0200
+++ linux-2.6.13-rc1/sound/pci/nm256/nm256.c	2005-06-29 22:47:36.000000000 +0200
@@ -285,43 +285,43 @@ MODULE_DEVICE_TABLE(pci, snd_nm256_ids);
  * lowlvel stuffs
  */
 
-inline static u8
+static inline u8
 snd_nm256_readb(nm256_t *chip, int offset)
 {
 	return readb(chip->cport + offset);
 }
 
-inline static u16
+static inline u16
 snd_nm256_readw(nm256_t *chip, int offset)
 {
 	return readw(chip->cport + offset);
 }
 
-inline static u32
+static inline u32
 snd_nm256_readl(nm256_t *chip, int offset)
 {
 	return readl(chip->cport + offset);
 }
 
-inline static void
+static inline void
 snd_nm256_writeb(nm256_t *chip, int offset, u8 val)
 {
 	writeb(val, chip->cport + offset);
 }
 
-inline static void
+static inline void
 snd_nm256_writew(nm256_t *chip, int offset, u16 val)
 {
 	writew(val, chip->cport + offset);
 }
 
-inline static void
+static inline void
 snd_nm256_writel(nm256_t *chip, int offset, u32 val)
 {
 	writel(val, chip->cport + offset);
 }
 
-inline static void
+static inline void
 snd_nm256_write_buffer(nm256_t *chip, void *src, int offset, int size)
 {
 	offset -= chip->buffer_start;
@@ -926,7 +926,7 @@ snd_nm256_init_chip(nm256_t *chip)
 }
 
 
-inline static void
+static inline void
 snd_nm256_intr_check(nm256_t *chip)
 {
 	if (chip->badintrcount++ > 1000) {
--- linux-2.6.13-rc1-orig/sound/pci/trident/trident_main.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/pci/trident/trident_main.c	2005-06-29 22:47:51.000000000 +0200
@@ -3204,7 +3204,7 @@ static inline void snd_trident_free_game
 /*
  * delay for 1 tick
  */
-inline static void do_delay(trident_t *chip)
+static inline void do_delay(trident_t *chip)
 {
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(1);
--- linux-2.6.13-rc1-orig/sound/pci/trident/trident_memory.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/pci/trident/trident_memory.c	2005-06-29 22:48:02.000000000 +0200
@@ -118,7 +118,7 @@ static inline void set_silent_tlb(triden
 #endif /* PAGE_SIZE */
 
 /* calculate buffer pointer from offset address */
-inline static void *offset_ptr(trident_t *trident, int offset)
+static inline void *offset_ptr(trident_t *trident, int offset)
 {
 	char *ptr;
 	ptr = page_to_ptr(trident, get_aligned_page(offset));
--- linux-2.6.13-rc1-orig/sound/pci/vx222/vx222_ops.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/pci/vx222/vx222_ops.c	2005-06-29 22:48:22.000000000 +0200
@@ -82,7 +82,7 @@ static int vx2_reg_index[VX_REG_MAX] = {
 	[VX_GPIOC]	= 0,	/* on the PLX */
 };
 
-inline static unsigned long vx2_reg_addr(vx_core_t *_chip, int reg)
+static inline unsigned long vx2_reg_addr(vx_core_t *_chip, int reg)
 {
 	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
 	return chip->port[vx2_reg_index[reg]] + vx2_reg_offset[reg];
@@ -235,7 +235,7 @@ static void vx2_setup_pseudo_dma(vx_core
 /*
  * vx_release_pseudo_dma - disable the pseudo-DMA mode
  */
-inline static void vx2_release_pseudo_dma(vx_core_t *chip)
+static inline void vx2_release_pseudo_dma(vx_core_t *chip)
 {
 	/* HREQ pin disabled. */
 	vx_outl(chip, ICR, 0);
--- linux-2.6.13-rc1-orig/sound/pcmcia/vx/vxp_ops.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/pcmcia/vx/vxp_ops.c	2005-06-29 22:48:35.000000000 +0200
@@ -49,7 +49,7 @@ static int vxp_reg_offset[VX_REG_MAX] = 
 };
 
 
-inline static unsigned long vxp_reg_addr(vx_core_t *_chip, int reg)
+static inline unsigned long vxp_reg_addr(vx_core_t *_chip, int reg)
 {
 	struct snd_vxpocket *chip = (struct snd_vxpocket *)_chip;
 	return chip->port + vxp_reg_offset[reg];
--- linux-2.6.13-rc1-orig/sound/ppc/burgundy.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/ppc/burgundy.c	2005-06-29 22:48:56.000000000 +0200
@@ -30,7 +30,7 @@
 
 
 /* Waits for busy flag to clear */
-inline static void
+static inline void
 snd_pmac_burgundy_busy_wait(pmac_t *chip)
 {
 	int timeout = 50;
@@ -40,7 +40,7 @@ snd_pmac_burgundy_busy_wait(pmac_t *chip
 		printk(KERN_DEBUG "burgundy_busy_wait: timeout\n");
 }
 
-inline static void
+static inline void
 snd_pmac_burgundy_extend_wait(pmac_t *chip)
 {
 	int timeout;
--- linux-2.6.13-rc1-orig/sound/ppc/pmac.c	2005-06-29 21:45:13.000000000 +0200
+++ linux-2.6.13-rc1/sound/ppc/pmac.c	2005-06-29 22:49:23.000000000 +0200
@@ -153,7 +153,7 @@ static pmac_stream_t *snd_pmac_get_strea
 /*
  * wait while run status is on
  */
-inline static void
+static inline void
 snd_pmac_wait_ack(pmac_stream_t *rec)
 {
 	int timeout = 50000;
@@ -177,7 +177,7 @@ static void snd_pmac_pcm_set_format(pmac
 /*
  * stop the DMA transfer
  */
-inline static void snd_pmac_dma_stop(pmac_stream_t *rec)
+static inline void snd_pmac_dma_stop(pmac_stream_t *rec)
 {
 	out_le32(&rec->dma->control, (RUN|WAKE|FLUSH|PAUSE) << 16);
 	snd_pmac_wait_ack(rec);
@@ -186,7 +186,7 @@ inline static void snd_pmac_dma_stop(pma
 /*
  * set the command pointer address
  */
-inline static void snd_pmac_dma_set_command(pmac_stream_t *rec, pmac_dbdma_t *cmd)
+static inline void snd_pmac_dma_set_command(pmac_stream_t *rec, pmac_dbdma_t *cmd)
 {
 	out_le32(&rec->dma->cmdptr, cmd->addr);
 }
@@ -194,7 +194,7 @@ inline static void snd_pmac_dma_set_comm
 /*
  * start the DMA
  */
-inline static void snd_pmac_dma_run(pmac_stream_t *rec, int status)
+static inline void snd_pmac_dma_run(pmac_stream_t *rec, int status)
 {
 	out_le32(&rec->dma->control, status | (status << 16));
 }
--- linux-2.6.13-rc1-orig/sound/usb/usbaudio.c	2005-06-29 21:45:13.000000000 +0200
+++ linux-2.6.13-rc1/sound/usb/usbaudio.c	2005-06-29 22:49:50.000000000 +0200
@@ -212,7 +212,7 @@ static snd_usb_audio_t *usb_chip[SNDRV_C
  * convert a sampling rate into our full speed format (fs/1000 in Q16.16)
  * this will overflow at approx 524 kHz
  */
-inline static unsigned get_usb_full_speed_rate(unsigned int rate)
+static inline unsigned get_usb_full_speed_rate(unsigned int rate)
 {
 	return ((rate << 13) + 62) / 125;
 }
@@ -221,19 +221,19 @@ inline static unsigned get_usb_full_spee
  * convert a sampling rate into USB high speed format (fs/8000 in Q16.16)
  * this will overflow at approx 4 MHz
  */
-inline static unsigned get_usb_high_speed_rate(unsigned int rate)
+static inline unsigned get_usb_high_speed_rate(unsigned int rate)
 {
 	return ((rate << 10) + 62) / 125;
 }
 
 /* convert our full speed USB rate into sampling rate in Hz */
-inline static unsigned get_full_speed_hz(unsigned int usb_rate)
+static inline unsigned get_full_speed_hz(unsigned int usb_rate)
 {
 	return (usb_rate * 125 + (1 << 12)) >> 13;
 }
 
 /* convert our high speed USB rate into sampling rate in Hz */
-inline static unsigned get_high_speed_hz(unsigned int usb_rate)
+static inline unsigned get_high_speed_hz(unsigned int usb_rate)
 {
 	return (usb_rate * 125 + (1 << 9)) >> 10;
 }
--- linux-2.6.13-rc1-orig/sound/usb/usbmixer.c	2005-06-29 21:45:13.000000000 +0200
+++ linux-2.6.13-rc1/sound/usb/usbmixer.c	2005-06-29 22:50:10.000000000 +0200
@@ -363,7 +363,7 @@ static int get_cur_ctl_value(usb_mixer_e
 }
 
 /* channel = 0: master, 1 = first channel */
-inline static int get_cur_mix_value(usb_mixer_elem_info_t *cval, int channel, int *value)
+static inline int get_cur_mix_value(usb_mixer_elem_info_t *cval, int channel, int *value)
 {
 	return get_ctl_value(cval, GET_CUR, (cval->control << 8) | channel, value);
 }
@@ -399,7 +399,7 @@ static int set_cur_ctl_value(usb_mixer_e
 	return set_ctl_value(cval, SET_CUR, validx, value);
 }
 
-inline static int set_cur_mix_value(usb_mixer_elem_info_t *cval, int channel, int value)
+static inline int set_cur_mix_value(usb_mixer_elem_info_t *cval, int channel, int value)
 {
 	return set_ctl_value(cval, SET_CUR, (cval->control << 8) | channel, value);
 }
