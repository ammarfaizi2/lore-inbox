Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423009AbWJFXyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423009AbWJFXyK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWJFXyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:54:10 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:2770 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751169AbWJFXyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:54:04 -0400
Message-id: <54335498213213@wsc.cz>
Subject: [PATCH 1/2] Char: nozomi, Lindent the code
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <p.hardwick@option.com>
Date: Sat,  7 Oct 2006 01:53:58 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[on the top of nozomi-use-tty-wakeup]

nozomi, Lindent the code

Use script/Lindent to indent nozomi driver.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit e7e58c9f0d3ce7bed7f8c4b1921da37d65e3ee8f
tree c0021b53033d27540ed9211a85905ae36ce5668e
parent b19884f570ea41ff9100cc56962e8d6f435e2337
author Jiri Slaby <jirislaby@gmail.com> Sat, 07 Oct 2006 01:47:22 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 07 Oct 2006 01:47:22 +0200

 drivers/char/nozomi.c | 2759 ++++++++++++++++++++++++++-----------------------
 1 files changed, 1446 insertions(+), 1313 deletions(-)

diff --git a/drivers/char/nozomi.c b/drivers/char/nozomi.c
index 8d502d2..354a8a6 100644
--- a/drivers/char/nozomi.c
+++ b/drivers/char/nozomi.c
@@ -92,9 +92,8 @@ #include <linux/init.h>
 #include <linux/kfifo.h>
 #include <asm/uaccess.h>
 
-
-#define VERSION_STRING DRIVER_DESC " 2.1 (build date: " __DATE__ " " __TIME__ ")"
-
+#define VERSION_STRING DRIVER_DESC " 2.1 (build date: " __DATE__ " " \
+	__TIME__ ")"
 
 /*    Macros definitions */
 
@@ -105,11 +104,10 @@ #define VERSION_STRING DRIVER_DESC " 2.1
 #define NOZOMI_DEBUG_LEVEL 0x1
 
 #define P_BUF_SIZE 128
-#define NFO( _err_flag_, args...)                                            \
-  do{                                                                        \
-    char t_m_p_[P_BUF_SIZE];                                                 \
-      snprintf(t_m_p_, sizeof(t_m_p_), ##args);                              \
-      printk( _err_flag_ "[%d] %s(): %s\n", __LINE__, __FUNCTION__, t_m_p_); \
+#define NFO( _err_flag_, args...) do {					       \
+	char t_m_p_[P_BUF_SIZE];					       \
+	snprintf(t_m_p_, sizeof(t_m_p_), ##args);			       \
+	printk( _err_flag_ "[%d] %s(): %s\n", __LINE__, __FUNCTION__, t_m_p_); \
 } while(0)
 
 #define ERR(args...)  NFO( KERN_ERR, ##args)
@@ -123,7 +121,6 @@ #define D6(args...) D_(0x20, ##args)
 #define D7(args...) D_(0x40, ##args)
 #define D8(args...) D_(0x80, ##args)
 
-
 #ifdef NOZOMI_DEBUG
 #define D_(lvl, args...) D(lvl, ##args)
   /* Do we need this settable at runtime? */
@@ -135,74 +132,65 @@ #define D_(lvl, args...) D(lvl, ##args)
 /* These printouts are always printed */
 
 #else
-  static const int nzdebug = 0;
+static const int nzdebug = 0;
 #define D_(lvl, args...)
 #endif
 
 /* TODO: rewrite to optimize macros... */
-#define SET_FCR(value__) \
-  do {  \
-    writew((value__), (dc->REG_FCR )); \
+#define SET_FCR(value__) do {			\
+	writew((value__), (dc->REG_FCR ));	\
 } while(0)
 
-#define SET_IER(value__, mask__) \
-  do {  \
-    dc->ier_last_written = (dc->ier_last_written & ~mask__) | (value__ & mask__ );\
-    writew( dc->ier_last_written, (dc->REG_IER));\
+#define SET_IER(value__, mask__) do {					\
+	dc->ier_last_written = (dc->ier_last_written & ~mask__) |	\
+		(value__ & mask__ );					\
+	writew( dc->ier_last_written, (dc->REG_IER));			\
 } while(0)
 
-#define GET_IER(read_val__) \
-  do {  \
-    (read_val__) = readw((dc->REG_IER));\
+#define GET_IER(read_val__) do {		\
+	(read_val__) = readw((dc->REG_IER));	\
 } while(0)
 
-#define GET_IIR(read_val__) \
-  do {  \
-    (read_val__) = readw( (dc->REG_IIR));\
+#define GET_IIR(read_val__) do {		\
+	(read_val__) = readw( (dc->REG_IIR));	\
 } while(0)
 
-#define GET_MEM(value__, addr__, length__) \
-  do {  \
-/*    read_mem32( (u32*) (value__), (u32) (addr__), (length__)); */\
-    read_mem32( (u32*) (value__), (addr__), (length__));\
+#define GET_MEM(value__, addr__, length__) do {				\
+/*	read_mem32( (u32*) (value__), (u32) (addr__), (length__)); */	\
+	read_mem32( (u32*) (value__), (addr__), (length__));		\
 } while(0)
 
-#define GET_MEM_BUF(value__, addr__, length__) \
-  do {  \
-/*    read_mem32_buf( (u32*) (value__), (u32) (addr__), (length__)); */\
-    read_mem32_buf( (u32*) (value__), (addr__), (length__));\
+#define GET_MEM_BUF(value__, addr__, length__) do {			  \
+/*	read_mem32_buf( (u32*) (value__), (u32) (addr__), (length__)); */ \
+	read_mem32_buf( (u32*) (value__), (addr__), (length__));	  \
 } while(0)
 
-#define SET_MEM(addr__, value__, length__) \
-  do {  \
-  write_mem32( (addr__),  (u32*) (value__), (length__));\
+#define SET_MEM(addr__, value__, length__) do {			\
+  write_mem32( (addr__),  (u32*) (value__), (length__));	\
 } while(0)
 
-#define SET_MEM_BUF(addr__, value__, length__) \
-  do {  \
-  write_mem32_buf( (addr__),  (u32*) (value__), (length__));\
+#define SET_MEM_BUF(addr__, value__, length__) do {		\
+  write_mem32_buf( (addr__),  (u32*) (value__), (length__));	\
 } while(0)
 
-
 #define TMP_BUF_MAX 256
 
-#define DUMP(buf__,len__) \
-  do {  \
-    char tbuf[TMP_BUF_MAX]={0};\
-    if (len__>1) {\
-        snprintf(tbuf, len__ > TMP_BUF_MAX ? TMP_BUF_MAX : len__, "%s",buf__);\
-        if(tbuf[len__-2] == '\r') {\
-            tbuf[len__-2] = 'r';\
-        }\
-        D1( "SENDING: '%s' (%d+n)", tbuf, len__);\
-    } else {\
-        D1( "SENDING: '%s' (%d)", tbuf, len__);\
-    }\
+#define DUMP(buf__,len__) do {		\
+	char tbuf[TMP_BUF_MAX]={0};	\
+	if (len__>1) {			\
+		snprintf(tbuf, len__ > TMP_BUF_MAX ? TMP_BUF_MAX : len__, "%s",\
+			buf__);		\
+	if(tbuf[len__-2] == '\r') {	\
+		tbuf[len__-2] = 'r';	\
+	}				\
+	D1( "SENDING: '%s' (%d+n)", tbuf, len__); \
+	} else {			\
+		D1( "SENDING: '%s' (%d)", tbuf, len__); \
+	}				\
 } while(0)
 
 #define RELEVANT_IFLAG(iflag) ((iflag) & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
 
-
 /*    Defines */
 #define NOZOMI_NAME     "nozomi"
 #define NOZOMI_NAME_TTY "nozomi_tty"
@@ -229,12 +217,12 @@ #define MSR_RI		0x20
 #define MSR_DSR		0x40
 
 /* Define all types of vendors and devices to support */
-#define VENDOR1		 0x1931 /* Vendor Option */
-#define DEVICE1		 0x000c /* HSDPA card */
+#define VENDOR1		 0x1931	/* Vendor Option */
+#define DEVICE1		 0x000c	/* HSDPA card */
 
-#define R_IIR		 0x0000  /* Interrupt Identity Register */
-#define R_FCR		 0x0000  /* Flow Control Register */
-#define R_IER		 0x0004  /* Interrupt Enable Register */
+#define R_IIR		 0x0000	/* Interrupt Identity Register */
+#define R_FCR		 0x0000	/* Flow Control Register */
+#define R_IER		 0x0004	/* Interrupt Enable Register */
 
 #define CONFIG_MAGIC 0xEFEFFEFE
 #define TOGGLE_VALID 0x0000
@@ -275,7 +263,7 @@ #define NOZOMI_MAX_PORTS 5
 
 /* There are two types of nozomi cards, one with 2048 memory and with 8192 memory */
 enum card_type {
-	F32_2 = 2048,	/* Has 512 bytes downlink and uplink * 2             -> 2048 */
+	F32_2 = 2048,	/* Has 512 bytes downlink and uplink * 2 -> 2048 */
 	F32_8 = 8192,	/* Has 3072 bytes downlink and 1024 bytes uplink * 2 -> 8192 */
 };
 
@@ -287,80 +275,80 @@ enum channel_type {
 
 /* Port definition for the card regarding flow control */
 enum ctrl_port_type {
-    CTRL_CMD  = 0x00,
-    CTRL_MDM  = 0x01,
-    CTRL_DIAG = 0x02,
-    CTRL_APP1 = 0x03,
-    CTRL_APP2 = 0x04,
-    CTRL_ERROR = -1,
+	CTRL_CMD = 0x00,
+	CTRL_MDM = 0x01,
+	CTRL_DIAG = 0x02,
+	CTRL_APP1 = 0x03,
+	CTRL_APP2 = 0x04,
+	CTRL_ERROR = -1,
 };
 
 /* Ports that the nozomi has */
 enum port_type {
-    PORT_MDM = 0,
-    PORT_DIAG= 1,
-    PORT_APP1= 2,
-    PORT_APP2= 3,
-    PORT_CTRL= 4,
-    PORT_ERROR=-1,
+	PORT_MDM = 0,
+	PORT_DIAG = 1,
+	PORT_APP1 = 2,
+	PORT_APP2 = 3,
+	PORT_CTRL = 4,
+	PORT_ERROR = -1,
 };
 
 #ifdef __ARMEB__
 /* Big endian */
 
 typedef struct {
-    unsigned enabled : 5; /* Toggle fields are valid if enabled is 0, else A-channels
-                            must always be used. */
-    unsigned diag_dl : 1;
-    unsigned mdm_dl : 1;
-    unsigned mdm_ul : 1;
+	unsigned enabled:5;	/* Toggle fields are valid if enabled is 0,
+				   else A-channels must always be used. */
+	unsigned diag_dl:1;
+	unsigned mdm_dl:1;
+	unsigned mdm_ul:1;
 } __attribute__ ((packed)) toggles_t;
 
 /* Configuration table to read at startup of card */
 /* Is for now only needed during initialization phase */
 typedef struct {
-    u32 signature;
-    u16 product_information;
-    u16 version;
-    u8 pad3[3];
-    toggles_t toggle;
-    u8 pad1[4];
-    u16 dl_mdm_len1; /* If this is 64, it can hold 60 bytes + 4 that is length field */
-    u16 dl_start;
-
-    u16 dl_diag_len1;
-    u16 dl_mdm_len2; /* If this is 64, it can hold 60 bytes + 4 that is length field */
-    u16 dl_app1_len;
-
-    u16 dl_diag_len2;
-    u16 dl_ctrl_len;
-    u16 dl_app2_len;
-    u8 pad2[16];
-    u16 ul_mdm_len1;
-    u16 ul_start;
-    u16 ul_diag_len;
-    u16 ul_mdm_len2;
-    u16 ul_app1_len;
-    u16 ul_app2_len;
-    u16 ul_ctrl_len;
-} __attribute__((packed)) config_table_t;
+	u32 signature;
+	u16 product_information;
+	u16 version;
+	u8 pad3[3];
+	toggles_t toggle;
+	u8 pad1[4];
+	u16 dl_mdm_len1;	/* If this is 64, it can hold 60 bytes + 4 that is length field */
+	u16 dl_start;
+
+	u16 dl_diag_len1;
+	u16 dl_mdm_len2;	/* If this is 64, it can hold 60 bytes + 4 that is length field */
+	u16 dl_app1_len;
+
+	u16 dl_diag_len2;
+	u16 dl_ctrl_len;
+	u16 dl_app2_len;
+	u8 pad2[16];
+	u16 ul_mdm_len1;
+	u16 ul_start;
+	u16 ul_diag_len;
+	u16 ul_mdm_len2;
+	u16 ul_app1_len;
+	u16 ul_app2_len;
+	u16 ul_ctrl_len;
+} __attribute__ ((packed)) config_table_t;
 
 /* This stores all control downlink flags */
 typedef struct {
-    u8 port;
-    unsigned reserved : 4;
-    unsigned CTS : 1;
-    unsigned RI  : 1;
-    unsigned DCD : 1;
-    unsigned DSR : 1;
+	u8 port;
+	unsigned reserved:4;
+	unsigned CTS:1;
+	unsigned RI:1;
+	unsigned DCD:1;
+	unsigned DSR:1;
 } __attribute__ ((packed)) ctrl_dl_t;
 
 /* This stores all control uplink flags */
 typedef struct {
-    u8 port;
-    unsigned reserved : 6;
-    unsigned RTS : 1;
-    unsigned DTR : 1;
+	u8 port;
+	unsigned reserved:6;
+	unsigned RTS:1;
+	unsigned DTR:1;
 } __attribute__ ((packed)) ctrl_ul_t;
 
 #else
@@ -368,227 +356,234 @@ #else
 
 /* This represents the toggle information */
 typedef struct {
-    unsigned mdm_ul : 1;
-    unsigned mdm_dl : 1;
-    unsigned diag_dl : 1;
-    unsigned enabled : 5; /* Toggle fields are valid if enabled is 0, else A-channels
-                            must always be used. */
+	unsigned mdm_ul:1;
+	unsigned mdm_dl:1;
+	unsigned diag_dl:1;
+	unsigned enabled:5;	/* Toggle fields are valid if enabled is 0,
+				   else A-channels must always be used. */
 } __attribute__ ((packed)) toggles_t;
 
 /* Configuration table to read at startup of card */
 typedef struct {
-    u32 signature;
-    u16 version;
-    u16 product_information;
-    toggles_t toggle;
-    u8 pad1[7];
-    u16 dl_start;
-    u16 dl_mdm_len1; /* If this is 64, it can hold 60 bytes + 4 that is length field */
-    u16 dl_mdm_len2;
-    u16 dl_diag_len1;
-    u16 dl_diag_len2;
-    u16 dl_app1_len;
-    u16 dl_app2_len;
-    u16 dl_ctrl_len;
-    u8 pad2[16];
-    u16 ul_start;
-    u16 ul_mdm_len2;
-    u16 ul_mdm_len1;
-    u16 ul_diag_len;
-    u16 ul_app1_len;
-    u16 ul_app2_len;
-    u16 ul_ctrl_len;
-} __attribute__((packed)) config_table_t;
+	u32 signature;
+	u16 version;
+	u16 product_information;
+	toggles_t toggle;
+	u8 pad1[7];
+	u16 dl_start;
+	u16 dl_mdm_len1;	/* If this is 64, it can hold 60 bytes + 4 that is length field */
+	u16 dl_mdm_len2;
+	u16 dl_diag_len1;
+	u16 dl_diag_len2;
+	u16 dl_app1_len;
+	u16 dl_app2_len;
+	u16 dl_ctrl_len;
+	u8 pad2[16];
+	u16 ul_start;
+	u16 ul_mdm_len2;
+	u16 ul_mdm_len1;
+	u16 ul_diag_len;
+	u16 ul_app1_len;
+	u16 ul_app2_len;
+	u16 ul_ctrl_len;
+} __attribute__ ((packed)) config_table_t;
 
 /* This stores all control downlink flags */
 typedef struct {
-    unsigned DSR : 1;
-    unsigned DCD : 1;
-    unsigned RI  : 1;
-    unsigned CTS : 1;
-    unsigned reserverd : 4;
-    u8 port;
+	unsigned DSR:1;
+	unsigned DCD:1;
+	unsigned RI:1;
+	unsigned CTS:1;
+	unsigned reserverd:4;
+	u8 port;
 } __attribute__ ((packed)) ctrl_dl_t;
 
 /* This stores all control uplink flags */
 typedef struct {
-    unsigned DTR : 1;
-    unsigned RTS : 1;
-    unsigned reserved : 6;
-    u8 port;
+	unsigned DTR:1;
+	unsigned RTS:1;
+	unsigned reserved:6;
+	u8 port;
 } __attribute__ ((packed)) ctrl_ul_t;
 #endif
 
 /* This holds all information that is needed regarding a port */
 struct port {
-    u8			         update_flow_control;
-    ctrl_ul_t	         ctrl_ul;
-    ctrl_dl_t	         ctrl_dl;
-    struct kfifo        *fifo_ul;
-//    u32			         dl_addr[2];
+	u8 update_flow_control;
+	ctrl_ul_t ctrl_ul;
+	ctrl_dl_t ctrl_dl;
+	struct kfifo *fifo_ul;
+//	u32 dl_addr[2];
 	void __iomem *dl_addr[2];
-    u32			         dl_size[2];
-    u8			         toggle_dl;
-//    u32			         ul_addr[2];
+	u32 dl_size[2];
+	u8 toggle_dl;
+//	u32 ul_addr[2];
 	void __iomem *ul_addr[2];
-    u32			         ul_size[2];
-    u8			         toggle_ul;
-    u16					 token_dl;
-
-    struct tty_struct	*tty;
-    int			         tty_open_count;
-    struct semaphore	 tty_sem;
-    wait_queue_head_t	 tty_wait;
-    struct async_icount	 tty_icount;
-    int                  tty_index;
-    u32					 rx_data, tx_data;
-    u8					 tty_dont_flip;
-
+	u32 ul_size[2];
+	u8 toggle_ul;
+	u16 token_dl;
+
+	struct tty_struct *tty;
+	int tty_open_count;
+	struct semaphore tty_sem;
+	wait_queue_head_t tty_wait;
+	struct async_icount tty_icount;
+	int tty_index;
+	u32 rx_data, tx_data;
+	u8 tty_dont_flip;
 };
 
 /* Private data one for each card in the system */
 typedef struct {
-//    u32				     base_addr;
+//	u32 base_addr;
 	void __iomem *base_addr;
-    u8				     closing;
+	u8 closing;
 
 	/* Pointers to registers */
 	void __iomem *REG_IIR;
 	void __iomem *REG_FCR;
 	void __iomem *REG_IER;
 
-    u16		 ier_last_written;
-    enum card_type	card_type;
-    config_table_t 	     config_table; /* Configuration table */
-    struct pci_dev 	    *pdev;
-    struct port 			     port[NOZOMI_MAX_PORTS];
-    u8                  *send_buf;
+	u16 ier_last_written;
+	enum card_type card_type;
+	config_table_t config_table;	/* Configuration table */
+	struct pci_dev *pdev;
+	struct port port[NOZOMI_MAX_PORTS];
+	u8 *send_buf;
 
-    struct tty_driver    *tty_driver;
+	struct tty_driver *tty_driver;
 
-    struct workqueue_struct *tty_flip_wq;
-    struct work_struct	tty_flip_wq_struct;
+	struct workqueue_struct *tty_flip_wq;
+	struct work_struct tty_flip_wq_struct;
 
-    struct termios		*tty_termios[NTTY_TTY_MINORS];
-    struct termios		*tty_termios_locked[NTTY_TTY_MINORS];
-    spinlock_t			 spin_mutex;
+	struct termios *tty_termios[NTTY_TTY_MINORS];
+	struct termios *tty_termios_locked[NTTY_TTY_MINORS];
+	spinlock_t spin_mutex;
 
-    u32					open_ttys;
+	u32 open_ttys;
 } dc_t;
 
 /* This is a data packet that is read or written to/from card */
 struct buffer {
-    u32 size; /* size is the length of the data buffer */
-    u8 *data;
+	u32 size;		/* size is the length of the data buffer */
+	u8 *data;
 } __attribute__ ((packed));
 
 /*    Function declarations */
-static int ntty_tty_init(dc_t *dc);
+static int ntty_tty_init(dc_t * dc);
 static void tty_flip_queue_function(void *tmp_dc);
 
 /*    Global variables */
 static struct pci_device_id nozomi_pci_tbl[] = {
 	{PCI_DEVICE(VENDOR1, DEVICE1)},
-	{0, }
+	{0,}
 };
+
 MODULE_DEVICE_TABLE(pci, nozomi_pci_tbl);
 
 /* Used to store interrupt variables */
 typedef struct {
-    u16 read_iir; /* Holds current interrupt tokens */
+	u16 read_iir;		/* Holds current interrupt tokens */
 } irq_t;
 
 /* Representing the pci device of interest */
 static int cards_found;
-static dc_t* my_dev = NULL;
+static dc_t *my_dev = NULL;
 static irq_t my_irq;
 
-
-
-static inline dc_t* get_dc_by_pdev(struct pci_dev* pdev) {
-    return my_dev;
+static inline dc_t *get_dc_by_pdev(struct pci_dev *pdev)
+{
+	return my_dev;
 }
 
-static inline dc_t* get_dc_by_index(s32 index ) {
-    return my_dev;
+static inline dc_t *get_dc_by_index(s32 index)
+{
+	return my_dev;
 }
 
-static inline s32 get_index(struct tty_struct *tty) {
-    return tty->index;
+static inline s32 get_index(struct tty_struct *tty)
+{
+	return tty->index;
 }
 
-static inline struct port* get_port_by_tty(struct tty_struct *tty) {
-    return &my_dev->port[ get_index(tty) ];
+static inline struct port *get_port_by_tty(struct tty_struct *tty)
+{
+	return &my_dev->port[get_index(tty)];
 }
 
-static inline dc_t* get_dc_by_tty(struct tty_struct *tty ) {
-    return my_dev;
+static inline dc_t *get_dc_by_tty(struct tty_struct *tty)
+{
+	return my_dev;
 }
 
-
 /* TODO: */
 /* -Optimize */
 /* -Rewrite cleaner */
 //static void read_mem32(u32 *buf, u32 mem_addr_start, u32 size_bytes) {
-static void read_mem32(u32 *buf, void __iomem *mem_addr_start, u32 size_bytes) {
-    u32 i = 0;
-    u32* ptr =  (__force u32 *)mem_addr_start;
-    u16* buf16;
-
-    /* 2 bytes */
-    if (size_bytes == 2) {
-        buf16 = (u16*) buf;
-        *buf16 = readw((void __iomem *)ptr);
-        return;
-    }
-
-    while (i < size_bytes) {
-        if ( size_bytes - i == 2) {
-            /* Handle 2 bytes in the end */
-            buf16 = (u16*) buf;
-            *(buf16) = readw((void __iomem *)ptr);
-            i+=2;
-        } else {
-            /* Read 4 bytes */
-            *(buf) = readl((void __iomem *)ptr);
-            i+=4;
-        }
-        buf++; ptr++;
-    }
+static void read_mem32(u32 * buf, void __iomem * mem_addr_start, u32 size_bytes)
+{
+	u32 i = 0;
+	u32 *ptr = (__force u32 *) mem_addr_start;
+	u16 *buf16;
+
+	/* 2 bytes */
+	if (size_bytes == 2) {
+		buf16 = (u16 *) buf;
+		*buf16 = readw((void __iomem *)ptr);
+		return;
+	}
+
+	while (i < size_bytes) {
+		if (size_bytes - i == 2) {
+			/* Handle 2 bytes in the end */
+			buf16 = (u16 *) buf;
+			*(buf16) = readw((void __iomem *)ptr);
+			i += 2;
+		} else {
+			/* Read 4 bytes */
+			*(buf) = readl((void __iomem *)ptr);
+			i += 4;
+		}
+		buf++;
+		ptr++;
+	}
 }
 
 /* TODO: */
 /* - Rewrite cleaner */
 /* - merge with read_mem32() */
 //static void read_mem32_buf(u32 *buf, u32 mem_addr_start, u32 size_bytes) {
-static void read_mem32_buf(u32 *buf, void __iomem * mem_addr_start, u32 size_bytes) {
+static void read_mem32_buf(u32 * buf, void __iomem * mem_addr_start,
+			   u32 size_bytes)
+{
 #ifdef __ARMEB__
-    u32 i = 0;
-    u32* ptr =  (u32*) mem_addr_start;
-    u16* buf16;
-
-    /* 2 bytes */
-    if (size_bytes == 2) {
-        buf16 = (u16*) buf;
-        *buf16 = __le16_to_cpu( readw( ptr ));
-        return;
-    }
-
-    while (i < size_bytes) {
-        if ( size_bytes - i == 2) {
-            /* Handle 2 bytes in the end */
-            buf16 = (u16*) buf;
-            *(buf16) = __le16_to_cpu( readw( ptr ));
-            i+=2;
-        } else {
-            /* Read 4 bytes */
-            *(buf) = __le32_to_cpu( readl( ptr ));
-            i+=4;
-        }
-        buf++; ptr++;
-    }
+	u32 i = 0;
+	u32 *ptr = (u32 *) mem_addr_start;
+	u16 *buf16;
+
+	/* 2 bytes */
+	if (size_bytes == 2) {
+		buf16 = (u16 *) buf;
+		*buf16 = __le16_to_cpu(readw(ptr));
+		return;
+	}
+
+	while (i < size_bytes) {
+		if (size_bytes - i == 2) {
+			/* Handle 2 bytes in the end */
+			buf16 = (u16 *) buf;
+			*(buf16) = __le16_to_cpu(readw(ptr));
+			i += 2;
+		} else {
+			/* Read 4 bytes */
+			*(buf) = __le32_to_cpu(readl(ptr));
+			i += 4;
+		}
+		buf++;
+		ptr++;
+	}
 #else
-    read_mem32(buf, mem_addr_start, size_bytes);
+	read_mem32(buf, mem_addr_start, size_bytes);
 #endif
 }
 
@@ -596,242 +591,304 @@ #endif
 /* -Optimize */
 /* -Rewrite cleaner */
 //static u32 write_mem32(u32 mem_addr_start, u32 *buf, u32 size_bytes) {
-static u32 write_mem32(void __iomem *mem_addr_start, u32 *buf, u32 size_bytes) {
-    u32 i = 0;
-    u32* ptr = (__force u32*) mem_addr_start;
-    u16* buf16;
-
-    /* 2 bytes */
-    if (size_bytes == 2) {
-        buf16 = (u16*) buf;
-        writew( *buf16, (void __iomem *)ptr);
-        return 2;
-    }
-
-    while (i < size_bytes) {
-        if ( size_bytes - i == 2) {
-            /* 2 bytes */
-            buf16 = (u16*) buf;
-            writew( *buf16, (void __iomem *)ptr);
-            i+=2;
-        } else {
-            /* 4 bytes */
-            writel( *buf, (void __iomem *)ptr );
-            i += 4;
-        }
-        buf++; ptr++;
-    }
-    return size_bytes;
+static u32 write_mem32(void __iomem * mem_addr_start, u32 * buf, u32 size_bytes)
+{
+	u32 i = 0;
+	u32 *ptr = (__force u32 *) mem_addr_start;
+	u16 *buf16;
+
+	/* 2 bytes */
+	if (size_bytes == 2) {
+		buf16 = (u16 *) buf;
+		writew(*buf16, (void __iomem *)ptr);
+		return 2;
+	}
+
+	while (i < size_bytes) {
+		if (size_bytes - i == 2) {
+			/* 2 bytes */
+			buf16 = (u16 *) buf;
+			writew(*buf16, (void __iomem *)ptr);
+			i += 2;
+		} else {
+			/* 4 bytes */
+			writel(*buf, (void __iomem *)ptr);
+			i += 4;
+		}
+		buf++;
+		ptr++;
+	}
+	return size_bytes;
 }
 
 /* Todo: */
 /* - Merge with write_mem32() */
 //static u32 write_mem32_buf(u32 mem_addr_start, u32 *buf, u32 size_bytes) {
-static u32 write_mem32_buf(void __iomem *mem_addr_start, u32 *buf, u32 size_bytes) {
+static u32 write_mem32_buf(void __iomem * mem_addr_start, u32 * buf,
+			   u32 size_bytes)
+{
 #ifdef __ARMEB__
-    u32 i = 0;
-    u32* ptr = (u32*) mem_addr_start;
-    u16* buf16;
-
-    /* 2 bytes */
-    if (size_bytes == 2) {
-        buf16 = (u16*) buf;
-            writew( __le16_to_cpu(*buf16), ptr);
-        return 2;
-    }
-
-    while (i < size_bytes) {
-        if ( size_bytes - i == 2) {
-            /* 2 bytes */
-            buf16 = (u16*) buf;
-            writew( __le16_to_cpu(*buf16), ptr);
-            i+=2;
-        } else {
-            /* 4 bytes */
-            writel( __cpu_to_le32( *buf ), ptr );
-            i += 4;
-        }
-        buf++; ptr++;
-    }
-    return size_bytes;
+	u32 i = 0;
+	u32 *ptr = (u32 *) mem_addr_start;
+	u16 *buf16;
+
+	/* 2 bytes */
+	if (size_bytes == 2) {
+		buf16 = (u16 *) buf;
+		writew(__le16_to_cpu(*buf16), ptr);
+		return 2;
+	}
+
+	while (i < size_bytes) {
+		if (size_bytes - i == 2) {
+			/* 2 bytes */
+			buf16 = (u16 *) buf;
+			writew(__le16_to_cpu(*buf16), ptr);
+			i += 2;
+		} else {
+			/* 4 bytes */
+			writel(__cpu_to_le32(*buf), ptr);
+			i += 4;
+		}
+		buf++;
+		ptr++;
+	}
+	return size_bytes;
 #else
-    return write_mem32(mem_addr_start, buf, size_bytes);
+	return write_mem32(mem_addr_start, buf, size_bytes);
 #endif
 }
 
 /* Setup pointers to different channels and also setup buffer sizes. */
-static void setup_memory(dc_t *dc)
+static void setup_memory(dc_t * dc)
 {
-    void __iomem *offset = dc->base_addr + dc->config_table.dl_start;
-    /* The length reported is including the length field of 4 bytes, hence subtract with 4. */
-    u16 buff_offset = 4;
-
-    /* Modem port dl configuration */
-    dc->port[PORT_MDM].dl_addr[CH_A] = offset;
-    dc->port[PORT_MDM].dl_addr[CH_B] = (offset += dc->config_table.dl_mdm_len1);
-    dc->port[PORT_MDM].dl_size[CH_A] = dc->config_table.dl_mdm_len1 - buff_offset;
-    dc->port[PORT_MDM].dl_size[CH_B] = dc->config_table.dl_mdm_len2 - buff_offset;
-
-    /* Diag port dl configuration */
-    dc->port[PORT_DIAG].dl_addr[CH_A] = (offset += dc->config_table.dl_mdm_len2);
-    dc->port[PORT_DIAG].dl_size[CH_A] = dc->config_table.dl_diag_len1 - buff_offset;
-    dc->port[PORT_DIAG].dl_addr[CH_B] = (offset += dc->config_table.dl_diag_len1);
-    dc->port[PORT_DIAG].dl_size[CH_B] = dc->config_table.dl_diag_len2 - buff_offset;
-
-    /* App1 port dl configuration */
-    dc->port[PORT_APP1].dl_addr[CH_A] = (offset += dc->config_table.dl_diag_len2);
-    dc->port[PORT_APP1].dl_size[CH_A] = dc->config_table.dl_app1_len - buff_offset;
-
-    /* App2 port dl configuration */
-    dc->port[PORT_APP2].dl_addr[CH_A] = (offset += dc->config_table.dl_app1_len);
-    dc->port[PORT_APP2].dl_size[CH_A] = dc->config_table.dl_app2_len - buff_offset;
-
-    /* Ctrl dl configuration */
-    dc->port[PORT_CTRL].dl_addr[CH_A] = (offset += dc->config_table.dl_app2_len);
-    dc->port[PORT_CTRL].dl_size[CH_A] = dc->config_table.dl_ctrl_len - buff_offset;
-
-
-    /* Modem Port ul configuration */
-    dc->port[PORT_MDM].ul_addr[CH_A] = (offset = dc->base_addr + dc->config_table.ul_start);
-    dc->port[PORT_MDM].ul_size[CH_A] = dc->config_table.ul_mdm_len1 - buff_offset;
-    dc->port[PORT_MDM].ul_addr[CH_B] = (offset += dc->config_table.ul_mdm_len1);
-    dc->port[PORT_MDM].ul_size[CH_B] = dc->config_table.ul_mdm_len2 - buff_offset;
-
-    /* Diag port ul configuration */
-    dc->port[PORT_DIAG].ul_addr[CH_A] = (offset += dc->config_table.ul_mdm_len2);
-    dc->port[PORT_DIAG].ul_size[CH_A] = dc->config_table.ul_diag_len - buff_offset;
-
-    /* App1 port ul configuration */
-    dc->port[PORT_APP1].ul_addr[CH_A] = (offset += dc->config_table.ul_diag_len);
-    dc->port[PORT_APP1].ul_size[CH_A] = dc->config_table.ul_app1_len - buff_offset;
-
-    /* App2 port ul configuration */
-    dc->port[PORT_APP2].ul_addr[CH_A] = (offset += dc->config_table.ul_app1_len);
-    dc->port[PORT_APP2].ul_size[CH_A] = dc->config_table.ul_app2_len - buff_offset;
-
-    /* Ctrl ul configuration */
-    dc->port[PORT_CTRL].ul_addr[CH_A] = (offset += dc->config_table.ul_app2_len);
-    dc->port[PORT_CTRL].ul_size[CH_A] = dc->config_table.ul_ctrl_len - buff_offset;
+	void __iomem *offset = dc->base_addr + dc->config_table.dl_start;
+	/* The length reported is including the length field of 4 bytes, hence
+	   subtract with 4. */
+	u16 buff_offset = 4;
+
+	/* Modem port dl configuration */
+	dc->port[PORT_MDM].dl_addr[CH_A] = offset;
+	dc->port[PORT_MDM].dl_addr[CH_B] = (offset +=
+					    dc->config_table.dl_mdm_len1);
+	dc->port[PORT_MDM].dl_size[CH_A] =
+	    dc->config_table.dl_mdm_len1 - buff_offset;
+	dc->port[PORT_MDM].dl_size[CH_B] =
+	    dc->config_table.dl_mdm_len2 - buff_offset;
+
+	/* Diag port dl configuration */
+	dc->port[PORT_DIAG].dl_addr[CH_A] = (offset +=
+					     dc->config_table.dl_mdm_len2);
+	dc->port[PORT_DIAG].dl_size[CH_A] =
+	    dc->config_table.dl_diag_len1 - buff_offset;
+	dc->port[PORT_DIAG].dl_addr[CH_B] = (offset +=
+					     dc->config_table.dl_diag_len1);
+	dc->port[PORT_DIAG].dl_size[CH_B] =
+	    dc->config_table.dl_diag_len2 - buff_offset;
+
+	/* App1 port dl configuration */
+	dc->port[PORT_APP1].dl_addr[CH_A] = (offset +=
+					     dc->config_table.dl_diag_len2);
+	dc->port[PORT_APP1].dl_size[CH_A] =
+	    dc->config_table.dl_app1_len - buff_offset;
+
+	/* App2 port dl configuration */
+	dc->port[PORT_APP2].dl_addr[CH_A] = (offset +=
+					     dc->config_table.dl_app1_len);
+	dc->port[PORT_APP2].dl_size[CH_A] =
+	    dc->config_table.dl_app2_len - buff_offset;
+
+	/* Ctrl dl configuration */
+	dc->port[PORT_CTRL].dl_addr[CH_A] = (offset +=
+					     dc->config_table.dl_app2_len);
+	dc->port[PORT_CTRL].dl_size[CH_A] =
+	    dc->config_table.dl_ctrl_len - buff_offset;
+
+	/* Modem Port ul configuration */
+	dc->port[PORT_MDM].ul_addr[CH_A] = (offset =
+					    dc->base_addr +
+					    dc->config_table.ul_start);
+	dc->port[PORT_MDM].ul_size[CH_A] =
+	    dc->config_table.ul_mdm_len1 - buff_offset;
+	dc->port[PORT_MDM].ul_addr[CH_B] = (offset +=
+					    dc->config_table.ul_mdm_len1);
+	dc->port[PORT_MDM].ul_size[CH_B] =
+	    dc->config_table.ul_mdm_len2 - buff_offset;
+
+	/* Diag port ul configuration */
+	dc->port[PORT_DIAG].ul_addr[CH_A] = (offset +=
+					     dc->config_table.ul_mdm_len2);
+	dc->port[PORT_DIAG].ul_size[CH_A] =
+	    dc->config_table.ul_diag_len - buff_offset;
+
+	/* App1 port ul configuration */
+	dc->port[PORT_APP1].ul_addr[CH_A] = (offset +=
+					     dc->config_table.ul_diag_len);
+	dc->port[PORT_APP1].ul_size[CH_A] =
+	    dc->config_table.ul_app1_len - buff_offset;
+
+	/* App2 port ul configuration */
+	dc->port[PORT_APP2].ul_addr[CH_A] = (offset +=
+					     dc->config_table.ul_app1_len);
+	dc->port[PORT_APP2].ul_size[CH_A] =
+	    dc->config_table.ul_app2_len - buff_offset;
+
+	/* Ctrl ul configuration */
+	dc->port[PORT_CTRL].ul_addr[CH_A] = (offset +=
+					     dc->config_table.ul_app2_len);
+	dc->port[PORT_CTRL].ul_size[CH_A] =
+	    dc->config_table.ul_ctrl_len - buff_offset;
 //    offset = dc->config_table.ul_start;
 }
 
 /* Dump config table under initalization phase */
 #ifdef NOZOMI_DEBUG
-static void dump_table(dc_t *dc) {
-    D3("signature: 0x%08X", dc->config_table.signature);
-    D3("version: 0x%04X", dc->config_table.version);
-    D3("product_information: 0x%04X", dc->config_table.product_information);
-    D3("toggle enabled: %d", dc->config_table.toggle.enabled);
-    D3("toggle up_mdm: %d", dc->config_table.toggle.mdm_ul);
-    D3("toggle dl_mdm: %d", dc->config_table.toggle.mdm_dl);
-    D3("toggle dl_dbg: %d", dc->config_table.toggle.diag_dl);
-
-    D3("dl_start: 0x%04X", dc->config_table.dl_start);
-    D3("dl_mdm_len0: 0x%04X, %d", dc->config_table.dl_mdm_len1, dc->config_table.dl_mdm_len1);
-    D3("dl_mdm_len1: 0x%04X, %d", dc->config_table.dl_mdm_len2, dc->config_table.dl_mdm_len2);
-    D3("dl_diag_len0: 0x%04X, %d", dc->config_table.dl_diag_len1, dc->config_table.dl_diag_len1);
-    D3("dl_diag_len1: 0x%04X, %d", dc->config_table.dl_diag_len2, dc->config_table.dl_diag_len2);
-    D3("dl_app1_len: 0x%04X, %d", dc->config_table.dl_app1_len, dc->config_table.dl_app1_len);
-    D3("dl_app2_len: 0x%04X, %d", dc->config_table.dl_app2_len, dc->config_table.dl_app2_len);
-    D3("dl_ctrl_len: 0x%04X, %d", dc->config_table.dl_ctrl_len, dc->config_table.dl_ctrl_len);
-    D3("ul_start: 0x%04X, %d", dc->config_table.ul_start, dc->config_table.ul_start);
-    D3("ul_mdm_len[0]: 0x%04X, %d", dc->config_table.ul_mdm_len1, dc->config_table.ul_mdm_len1);
-    D3("ul_mdm_len[1]: 0x%04X, %d", dc->config_table.ul_mdm_len2, dc->config_table.ul_mdm_len2);
-    D3("ul_diag_len: 0x%04X, %d", dc->config_table.ul_diag_len, dc->config_table.ul_diag_len);
-    D3("ul_app1_len: 0x%04X, %d", dc->config_table.ul_app1_len, dc->config_table.ul_app1_len);
-    D3("ul_app2_len: 0x%04X, %d", dc->config_table.ul_app2_len, dc->config_table.ul_app2_len);
-    D3("ul_ctrl_len: 0x%04X, %d", dc->config_table.ul_ctrl_len, dc->config_table.ul_ctrl_len);
+static void dump_table(dc_t * dc)
+{
+	D3("signature: 0x%08X", dc->config_table.signature);
+	D3("version: 0x%04X", dc->config_table.version);
+	D3("product_information: 0x%04X", dc->config_table.product_information);
+	D3("toggle enabled: %d", dc->config_table.toggle.enabled);
+	D3("toggle up_mdm: %d", dc->config_table.toggle.mdm_ul);
+	D3("toggle dl_mdm: %d", dc->config_table.toggle.mdm_dl);
+	D3("toggle dl_dbg: %d", dc->config_table.toggle.diag_dl);
+
+	D3("dl_start: 0x%04X", dc->config_table.dl_start);
+	D3("dl_mdm_len0: 0x%04X, %d", dc->config_table.dl_mdm_len1,
+	   dc->config_table.dl_mdm_len1);
+	D3("dl_mdm_len1: 0x%04X, %d", dc->config_table.dl_mdm_len2,
+	   dc->config_table.dl_mdm_len2);
+	D3("dl_diag_len0: 0x%04X, %d", dc->config_table.dl_diag_len1,
+	   dc->config_table.dl_diag_len1);
+	D3("dl_diag_len1: 0x%04X, %d", dc->config_table.dl_diag_len2,
+	   dc->config_table.dl_diag_len2);
+	D3("dl_app1_len: 0x%04X, %d", dc->config_table.dl_app1_len,
+	   dc->config_table.dl_app1_len);
+	D3("dl_app2_len: 0x%04X, %d", dc->config_table.dl_app2_len,
+	   dc->config_table.dl_app2_len);
+	D3("dl_ctrl_len: 0x%04X, %d", dc->config_table.dl_ctrl_len,
+	   dc->config_table.dl_ctrl_len);
+	D3("ul_start: 0x%04X, %d", dc->config_table.ul_start,
+	   dc->config_table.ul_start);
+	D3("ul_mdm_len[0]: 0x%04X, %d", dc->config_table.ul_mdm_len1,
+	   dc->config_table.ul_mdm_len1);
+	D3("ul_mdm_len[1]: 0x%04X, %d", dc->config_table.ul_mdm_len2,
+	   dc->config_table.ul_mdm_len2);
+	D3("ul_diag_len: 0x%04X, %d", dc->config_table.ul_diag_len,
+	   dc->config_table.ul_diag_len);
+	D3("ul_app1_len: 0x%04X, %d", dc->config_table.ul_app1_len,
+	   dc->config_table.ul_app1_len);
+	D3("ul_app2_len: 0x%04X, %d", dc->config_table.ul_app2_len,
+	   dc->config_table.ul_app2_len);
+	D3("ul_ctrl_len: 0x%04X, %d", dc->config_table.ul_ctrl_len,
+	   dc->config_table.ul_ctrl_len);
 }
 #endif
 
 /* Read configuration table from card under intalization phase */
 /* Returns 1 if ok, else 0 */
-static int nozomi_read_config_table(dc_t *dc) {
+static int nozomi_read_config_table(dc_t * dc)
+{
 
-    GET_MEM( &dc->config_table, dc->base_addr + 0, sizeof(config_table_t));
+	GET_MEM(&dc->config_table, dc->base_addr + 0, sizeof(config_table_t));
 
-    /* D1( "0x%08X == 0x%08X ", dc->config_table.signature, CONFIG_MAGIC); */
+/*	D1( "0x%08X == 0x%08X ", dc->config_table.signature, CONFIG_MAGIC); */
 
-	if (dc->config_table.signature != CONFIG_MAGIC ) {
+	if (dc->config_table.signature != CONFIG_MAGIC) {
 		dev_err(&dc->pdev->dev, "ConfigTable Bad! 0x%08X != 0x%08X\n",
 			dc->config_table.signature, CONFIG_MAGIC);
 		return 0;
 	}
 
-    if( (dc->config_table.version == 0) || (dc->config_table.toggle.enabled == TOGGLE_VALID) ) {
-        int i;
-        D1( "Second phase, configuring card");
+	if ((dc->config_table.version == 0)
+	    || (dc->config_table.toggle.enabled == TOGGLE_VALID)) {
+		int i;
+		D1("Second phase, configuring card");
 
-        setup_memory(dc);
+		setup_memory(dc);
 
-        dc->port[PORT_MDM].toggle_ul = dc->config_table.toggle.mdm_ul;
-        dc->port[PORT_MDM].toggle_dl = dc->config_table.toggle.mdm_dl;
-        dc->port[PORT_DIAG].toggle_dl = dc->config_table.toggle.diag_dl;
-        D1( "toggle ports: MDM UL:%d MDM DL:%d, DIAG DL:%d",
-            dc->port[PORT_MDM].toggle_ul,
-            dc->port[PORT_MDM].toggle_dl,
-            dc->port[PORT_DIAG].toggle_dl);
+		dc->port[PORT_MDM].toggle_ul = dc->config_table.toggle.mdm_ul;
+		dc->port[PORT_MDM].toggle_dl = dc->config_table.toggle.mdm_dl;
+		dc->port[PORT_DIAG].toggle_dl = dc->config_table.toggle.diag_dl;
+		D1("toggle ports: MDM UL:%d MDM DL:%d, DIAG DL:%d",
+		   dc->port[PORT_MDM].toggle_ul,
+		   dc->port[PORT_MDM].toggle_dl, dc->port[PORT_DIAG].toggle_dl);
 
 #ifdef NOZOMI_DEBUG
-        dump_table(dc);
+		dump_table(dc);
 #endif
-        for (i=PORT_MDM; i< MAX_PORT;i++) {
-            dc->port[i].fifo_ul = kfifo_alloc( FIFO_BUFFER_SIZE_UL, GFP_ATOMIC , NULL);
-            memset( &dc->port[i].ctrl_dl, 0, sizeof (ctrl_dl_t));
-            memset( &dc->port[i].ctrl_ul, 0, sizeof (ctrl_ul_t));
-        }
-
-        /* Enable control channel */
-        SET_IER( CTRL_DL, CTRL_DL );
+		for (i = PORT_MDM; i < MAX_PORT; i++) {
+			dc->port[i].fifo_ul =
+			    kfifo_alloc(FIFO_BUFFER_SIZE_UL, GFP_ATOMIC, NULL);
+			memset(&dc->port[i].ctrl_dl, 0, sizeof(ctrl_dl_t));
+			memset(&dc->port[i].ctrl_ul, 0, sizeof(ctrl_ul_t));
+		}
+
+		/* Enable control channel */
+		SET_IER(CTRL_DL, CTRL_DL);
 
-        dev_info(&dc->pdev->dev, "Initialization OK!\n");
-        return 1;
-    }
+		dev_info(&dc->pdev->dev, "Initialization OK!\n");
+		return 1;
+	}
 
-    if( (dc->config_table.version > 0) && (dc->config_table.toggle.enabled != TOGGLE_VALID ) ) {
-        u32 offset = 0;
-        D1( "First phase: pushing upload buffers, clearing download");
+	if ((dc->config_table.version > 0)
+	    && (dc->config_table.toggle.enabled != TOGGLE_VALID)) {
+		u32 offset = 0;
+		D1("First phase: pushing upload buffers, clearing download");
 
-        dev_info(&dc->pdev->dev, "Version of card: %d\n", dc->config_table.version);
+		dev_info(&dc->pdev->dev, "Version of card: %d\n",
+			 dc->config_table.version);
 
-        /* Here we should disable all I/O over F32. */
-        setup_memory(dc);
+		/* Here we should disable all I/O over F32. */
+		setup_memory(dc);
 
-        /* We should send ALL channel pair tokens back along with reset token */
+		/* We should send ALL channel pair tokens back along with reset
+		   token */
 
-        /* push upload modem buffers */
-        SET_MEM( dc->port[PORT_MDM].ul_addr[CH_A], &offset, 4);
-        SET_MEM( dc->port[PORT_MDM].ul_addr[CH_B], &offset, 4);
+		/* push upload modem buffers */
+		SET_MEM(dc->port[PORT_MDM].ul_addr[CH_A], &offset, 4);
+		SET_MEM(dc->port[PORT_MDM].ul_addr[CH_B], &offset, 4);
 
-        SET_FCR( MDM_UL | DIAG_DL | MDM_DL );
+		SET_FCR(MDM_UL | DIAG_DL | MDM_DL);
 
-        D1( "First phase done");
-    }
+		D1("First phase done");
+	}
 
-    return 1;
+	return 1;
 }
 
 /* Enable uplink interrupts  */
-static void enable_transmit_ul( enum port_type port , dc_t *dc ) {
-
-    switch( port ) {
-        case PORT_MDM:  SET_IER( MDM_UL , MDM_UL  ); break;
-        case PORT_DIAG: SET_IER( DIAG_UL, DIAG_UL ); break;
-        case PORT_APP1: SET_IER( APP1_UL, APP1_UL ); break;
-        case PORT_APP2: SET_IER( APP2_UL, APP2_UL ); break;
-        case PORT_CTRL: SET_IER( CTRL_UL, CTRL_UL ); break;
-    default:
-        dev_err(&dc->pdev->dev, "Called with wrong port?\n");
-        break;
-    };
+static void enable_transmit_ul(enum port_type port, dc_t * dc)
+{
+
+	switch (port) {
+	case PORT_MDM:
+		SET_IER(MDM_UL, MDM_UL);
+		break;
+	case PORT_DIAG:
+		SET_IER(DIAG_UL, DIAG_UL);
+		break;
+	case PORT_APP1:
+		SET_IER(APP1_UL, APP1_UL);
+		break;
+	case PORT_APP2:
+		SET_IER(APP2_UL, APP2_UL);
+		break;
+	case PORT_CTRL:
+		SET_IER(CTRL_UL, CTRL_UL);
+		break;
+	default:
+		dev_err(&dc->pdev->dev, "Called with wrong port?\n");
+		break;
+	};
 }
 
 /* Disable uplink interrupts  */
-static void disable_transmit_ul(enum port_type port, dc_t *dc)
+static void disable_transmit_ul(enum port_type port, dc_t * dc)
 {
 	switch (port) {
 	case PORT_MDM:
-		SET_IER(0 ,MDM_UL);
+		SET_IER(0, MDM_UL);
 		break;
 	case PORT_DIAG:
 		SET_IER(0, DIAG_UL);
@@ -852,9 +909,9 @@ static void disable_transmit_ul(enum por
 }
 
 /* Enable downlink interrupts */
-static void enable_transmit_dl(enum port_type port, dc_t *dc)
+static void enable_transmit_dl(enum port_type port, dc_t * dc)
 {
-	switch(port) {
+	switch (port) {
 	case PORT_MDM:
 		SET_IER(MDM_DL, MDM_DL);
 		break;
@@ -877,14 +934,24 @@ static void enable_transmit_dl(enum port
 }
 
 /* Disable downlink interrupts */
-static void disable_transmit_dl(enum port_type port, dc_t *dc)
+static void disable_transmit_dl(enum port_type port, dc_t * dc)
 {
 	switch (port) {
-	case PORT_MDM:  SET_IER( 0 ,MDM_DL  ); break;
-	case PORT_DIAG: SET_IER( 0, DIAG_DL ); break;
-	case PORT_APP1: SET_IER( 0, APP1_DL ); break;
-	case PORT_APP2: SET_IER( 0, APP2_DL ); break;
-	case PORT_CTRL: SET_IER( 0, CTRL_DL ); break;
+	case PORT_MDM:
+		SET_IER(0, MDM_DL);
+		break;
+	case PORT_DIAG:
+		SET_IER(0, DIAG_DL);
+		break;
+	case PORT_APP1:
+		SET_IER(0, APP1_DL);
+		break;
+	case PORT_APP2:
+		SET_IER(0, APP2_DL);
+		break;
+	case PORT_CTRL:
+		SET_IER(0, CTRL_DL);
+		break;
 	default:
 		dev_err(&dc->pdev->dev, "Called with wrong port?\n");
 		break;
@@ -893,203 +960,224 @@ static void disable_transmit_dl(enum por
 
 /* Return 1 - send buffer to card and ack. */
 /* Return 0 - don't ack, don't send buffer to card. */
-static int send_data( enum port_type index, dc_t *dc ) {
-    u32	 size				 = 0;
-    struct port *port			 = &dc->port[index];
-    u8	 toggle				 = port->toggle_ul;
-    void __iomem *addr				 = port->ul_addr[toggle];
-    u32	 ul_size			 = port->ul_size[toggle];
-    struct tty_struct *tty   = port->tty;
-
-    if (index >= NTTY_TTY_MINORS) {
-	dev_err(&dc->pdev->dev, "Called with wrong index?\n");
-        return 0;
-    }
+static int send_data(enum port_type index, dc_t * dc)
+{
+	u32 size = 0;
+	struct port *port = &dc->port[index];
+	u8 toggle = port->toggle_ul;
+	void __iomem *addr = port->ul_addr[toggle];
+	u32 ul_size = port->ul_size[toggle];
+	struct tty_struct *tty = port->tty;
+
+	if (index >= NTTY_TTY_MINORS) {
+		dev_err(&dc->pdev->dev, "Called with wrong index?\n");
+		return 0;
+	}
 
-    /* Get data from tty and place in buf for now */
-    size = __kfifo_get( port->fifo_ul,	dc->send_buf, ul_size < SEND_BUF_MAX ? ul_size : SEND_BUF_MAX );
+	/* Get data from tty and place in buf for now */
+	size =
+	    __kfifo_get(port->fifo_ul, dc->send_buf,
+			ul_size < SEND_BUF_MAX ? ul_size : SEND_BUF_MAX);
 
-    if (size == 0) {
-        D4("No more data to send, disable link:");
-        return 0;
-    }
+	if (size == 0) {
+		D4("No more data to send, disable link:");
+		return 0;
+	}
 
-    port->tx_data += size;
+	port->tx_data += size;
 
-    /* DUMP(buf, size); */
+	/* DUMP(buf, size); */
 
-    /* Write length + data */
-    SET_MEM( addr, &size, 4 );
-    SET_MEM_BUF( addr + 4, dc->send_buf, size);
+	/* Write length + data */
+	SET_MEM(addr, &size, 4);
+	SET_MEM_BUF(addr + 4, dc->send_buf, size);
 
-    if (tty)
-	tty_wakeup(tty);
+	if (tty)
+		tty_wakeup(tty);
 
-    return 1;
+	return 1;
 }
 
 /* If all data has been read, return 1, else 0 */
-static int receive_data( enum port_type index, dc_t* dc ) {
-    u8 buf[RECEIVE_BUF_MAX]			 = {0};
-    int                size;
-    u32                offset        = 4;
-    struct port			   *port		 = &dc->port[index];
-    u8                 toggle        = port->toggle_dl;
-    void __iomem *                addr          = port->dl_addr[toggle];
-    struct tty_struct *tty           = port->tty;
-    int                i;
-
-    if ( !tty ) {
-        D1("tty not open for port: %d?", index);
-        return 1;
-    }
-
-    GET_MEM( &size, addr, 4 );
-    /*  D1( "%d bytes port: %d", size, index); */
-
-    if ( test_bit( TTY_THROTTLED, & tty->flags) ) {
-        D1("No room in tty, don't read data, don't ack interrupt, disable interrupt");
-
-        /* disable interrupt in downlink... */
-        disable_transmit_dl(index, dc);
-        return 0;
-    }
-
-    if (size == 0) {
-	dev_err(&dc->pdev->dev, "size == 0?\n");
-        return 1;
-    }
-
-    while( size > 0 ) {
-        GET_MEM_BUF(buf, addr + offset, 4);
-
-        i = 0;
-        while (i < 4 && size > 0) {
-            if (tty_buffer_request_room(tty, 1) < 1)
-            {
-                tty_flip_buffer_push(tty);
-            }
-            tty_insert_flip_char(tty, buf[i], TTY_NORMAL);
-            port->rx_data++;
-            i++;
-            size--;
-        }
-
-        offset += 4;
-    }
-
-    tty_flip_buffer_push(tty);
-
-    return 1;
+static int receive_data(enum port_type index, dc_t * dc)
+{
+	u8 buf[RECEIVE_BUF_MAX] = { 0 };
+	int size;
+	u32 offset = 4;
+	struct port *port = &dc->port[index];
+	u8 toggle = port->toggle_dl;
+	void __iomem *addr = port->dl_addr[toggle];
+	struct tty_struct *tty = port->tty;
+	int i;
+
+	if (!tty) {
+		D1("tty not open for port: %d?", index);
+		return 1;
+	}
+
+	GET_MEM(&size, addr, 4);
+	/*  D1( "%d bytes port: %d", size, index); */
+
+	if (test_bit(TTY_THROTTLED, &tty->flags)) {
+		D1("No room in tty, don't read data, don't ack interrupt, "
+			"disable interrupt");
+
+		/* disable interrupt in downlink... */
+		disable_transmit_dl(index, dc);
+		return 0;
+	}
+
+	if (size == 0) {
+		dev_err(&dc->pdev->dev, "size == 0?\n");
+		return 1;
+	}
+
+	while (size > 0) {
+		GET_MEM_BUF(buf, addr + offset, 4);
+
+		i = 0;
+		while (i < 4 && size > 0) {
+			if (tty_buffer_request_room(tty, 1) < 1) {
+				tty_flip_buffer_push(tty);
+			}
+			tty_insert_flip_char(tty, buf[i], TTY_NORMAL);
+			port->rx_data++;
+			i++;
+			size--;
+		}
+
+		offset += 4;
+	}
+
+	tty_flip_buffer_push(tty);
+
+	return 1;
 }
 
 /* Debug for interrupts */
 #ifdef NOZOMI_DEBUG
-static char* interrupt2str( u16 interrupt) {
-    static char buf[TMP_BUF_MAX];
-    char *p = buf;
+static char *interrupt2str(u16 interrupt)
+{
+	static char buf[TMP_BUF_MAX];
+	char *p = buf;
 
-    interrupt & MDM_DL1 ? p += snprintf(p, TMP_BUF_MAX, "MDM_DL1 "):0;
-    interrupt & MDM_DL2 ? p += snprintf(p, TMP_BUF_MAX, "MDM_DL2 "):0;
+	interrupt & MDM_DL1 ? p += snprintf(p, TMP_BUF_MAX, "MDM_DL1 ") : 0;
+	interrupt & MDM_DL2 ? p += snprintf(p, TMP_BUF_MAX, "MDM_DL2 ") : 0;
 
-    interrupt & MDM_UL1 ? p += snprintf(p, TMP_BUF_MAX, "MDM_UL1 "):0;
-    interrupt & MDM_UL2 ? p += snprintf(p, TMP_BUF_MAX, "MDM_UL2 "):0;
+	interrupt & MDM_UL1 ? p += snprintf(p, TMP_BUF_MAX, "MDM_UL1 ") : 0;
+	interrupt & MDM_UL2 ? p += snprintf(p, TMP_BUF_MAX, "MDM_UL2 ") : 0;
 
-    interrupt & DIAG_DL1 ? p += snprintf(p, TMP_BUF_MAX, "DIAG_DL1 "):0;
-    interrupt & DIAG_DL2 ? p += snprintf(p, TMP_BUF_MAX, "DIAG_DL2 "):0;
+	interrupt & DIAG_DL1 ? p += snprintf(p, TMP_BUF_MAX, "DIAG_DL1 ") : 0;
+	interrupt & DIAG_DL2 ? p += snprintf(p, TMP_BUF_MAX, "DIAG_DL2 ") : 0;
 
-    interrupt & DIAG_UL ? p += snprintf(p, TMP_BUF_MAX, "DIAG_UL "):0;
+	interrupt & DIAG_UL ? p += snprintf(p, TMP_BUF_MAX, "DIAG_UL ") : 0;
 
-    interrupt & APP1_DL ? p += snprintf(p, TMP_BUF_MAX, "APP1_DL "):0;
-    interrupt & APP2_DL ? p += snprintf(p, TMP_BUF_MAX, "APP2_DL "):0;
+	interrupt & APP1_DL ? p += snprintf(p, TMP_BUF_MAX, "APP1_DL ") : 0;
+	interrupt & APP2_DL ? p += snprintf(p, TMP_BUF_MAX, "APP2_DL ") : 0;
 
-    interrupt & APP1_UL ? p += snprintf(p, TMP_BUF_MAX, "APP1_UL "):0;
-    interrupt & APP2_UL ? p += snprintf(p, TMP_BUF_MAX, "APP2_UL "):0;
+	interrupt & APP1_UL ? p += snprintf(p, TMP_BUF_MAX, "APP1_UL ") : 0;
+	interrupt & APP2_UL ? p += snprintf(p, TMP_BUF_MAX, "APP2_UL ") : 0;
 
-    interrupt & CTRL_DL ? p += snprintf(p, TMP_BUF_MAX, "CTRL_DL "):0;
-    interrupt & CTRL_UL ? p += snprintf(p, TMP_BUF_MAX, "CTRL_UL "):0;
+	interrupt & CTRL_DL ? p += snprintf(p, TMP_BUF_MAX, "CTRL_DL ") : 0;
+	interrupt & CTRL_UL ? p += snprintf(p, TMP_BUF_MAX, "CTRL_UL ") : 0;
 
-    interrupt & RESET ? p += snprintf(p, TMP_BUF_MAX, "RESET "):0;
+	interrupt & RESET ? p += snprintf(p, TMP_BUF_MAX, "RESET ") : 0;
 
-    return buf;
+	return buf;
 }
 #endif
 
 /* Receive flow control */
 /* Return 1 - If ok, else 0 */
-static int receive_flow_control( dc_t *dc, irq_t *m) {
-    enum port_type port = PORT_MDM;
-    ctrl_dl_t ctrl_dl;
-    ctrl_dl_t old_ctrl;
-    u16 enable_ier = 0;
-
-    GET_MEM( &ctrl_dl, dc->port[PORT_CTRL].dl_addr[CH_A], 2);
-
-    switch( ctrl_dl.port ) {
-    case CTRL_CMD:
-        D1( "The Base Band sends this value as a response to a request for IMSI detach sent"
-          " over the control channel uplink (see section 7.6.1).");
-        break;
-    case CTRL_MDM:  port = PORT_MDM;  enable_ier = MDM_DL;  break;
-    case CTRL_DIAG: port = PORT_DIAG; enable_ier = DIAG_DL; break;
-    case CTRL_APP1: port = PORT_APP1; enable_ier = APP1_DL; break;
-    case CTRL_APP2: port = PORT_APP2; enable_ier = APP2_DL; break;
-    default:
-	dev_err(&dc->pdev->dev, "ERROR: flow control received for non-existing port\n");
-        return 0;
-    };
-
-    D1( "0x%04X->0x%04X", *((u16*) &dc->port[port].ctrl_dl), *((u16*)&ctrl_dl));
-
-    old_ctrl = dc->port[port].ctrl_dl;
-    dc->port[port].ctrl_dl = ctrl_dl;
-
-    if ( old_ctrl.CTS == 1 && ctrl_dl.CTS == 0 ) {
-        D1( "Disable interrupt (0x%04X) on port: %d", enable_ier, port);
-        disable_transmit_ul(port, dc);
-
-    } else if ( old_ctrl.CTS == 0 && ctrl_dl.CTS == 1 ) {
-
-        if ( __kfifo_len(dc->port[port].fifo_ul) ) {
-            D1( "Enable interrupt (0x%04X) on port: %d", enable_ier, port);
-            D1( "Data in buffer [%d], enable transmit! ", __kfifo_len(dc->port[port].fifo_ul) );
-            enable_transmit_ul( port, dc );
-        } else {
-            D1( "No data in buffer...");
-        }
-    }
-
-    if(*(u16*)&old_ctrl == *(u16*)&ctrl_dl)
-    {
-        D1( " No change in mctrl");
-        return 1;
-    }
-    /* Update statistics */
-    if(old_ctrl.CTS != ctrl_dl.CTS) {
-        dc->port[port].tty_icount.cts++;
-    }
-    if(old_ctrl.DSR != ctrl_dl.DSR) {
-        dc->port[port].tty_icount.dsr++;
-    }
-    if(old_ctrl.RI != ctrl_dl.RI) {
-        dc->port[port].tty_icount.rng++;
-    }
-    if(old_ctrl.DCD != ctrl_dl.DCD) {
-        dc->port[port].tty_icount.dcd++;
-    }
-    D1("port: %d DCD(%d), CTS(%d), RI(%d), DSR(%d)",
-      port,
-      dc->port[port].tty_icount.dcd, dc->port[port].tty_icount.cts,
-      dc->port[port].tty_icount.rng, dc->port[port].tty_icount.dsr);
-
-    return 1;
+static int receive_flow_control(dc_t * dc, irq_t * m)
+{
+	enum port_type port = PORT_MDM;
+	ctrl_dl_t ctrl_dl;
+	ctrl_dl_t old_ctrl;
+	u16 enable_ier = 0;
+
+	GET_MEM(&ctrl_dl, dc->port[PORT_CTRL].dl_addr[CH_A], 2);
+
+	switch (ctrl_dl.port) {
+	case CTRL_CMD:
+		D1("The Base Band sends this value as a response to a request "
+			"for IMSI detach sent" " over the control channel "
+			"uplink (see section 7.6.1).");
+		break;
+	case CTRL_MDM:
+		port = PORT_MDM;
+		enable_ier = MDM_DL;
+		break;
+	case CTRL_DIAG:
+		port = PORT_DIAG;
+		enable_ier = DIAG_DL;
+		break;
+	case CTRL_APP1:
+		port = PORT_APP1;
+		enable_ier = APP1_DL;
+		break;
+	case CTRL_APP2:
+		port = PORT_APP2;
+		enable_ier = APP2_DL;
+		break;
+	default:
+		dev_err(&dc->pdev->dev, "ERROR: flow control received for "
+			"non-existing port\n");
+		return 0;
+	};
+
+	D1("0x%04X->0x%04X", *((u16 *) & dc->port[port].ctrl_dl),
+		*((u16 *) & ctrl_dl));
+
+	old_ctrl = dc->port[port].ctrl_dl;
+	dc->port[port].ctrl_dl = ctrl_dl;
+
+	if (old_ctrl.CTS == 1 && ctrl_dl.CTS == 0) {
+		D1("Disable interrupt (0x%04X) on port: %d", enable_ier, port);
+		disable_transmit_ul(port, dc);
+
+	} else if (old_ctrl.CTS == 0 && ctrl_dl.CTS == 1) {
+
+		if (__kfifo_len(dc->port[port].fifo_ul)) {
+			D1("Enable interrupt (0x%04X) on port: %d", enable_ier,
+				port);
+			D1("Data in buffer [%d], enable transmit! ",
+				__kfifo_len(dc->port[port].fifo_ul));
+			enable_transmit_ul(port, dc);
+		} else {
+			D1("No data in buffer...");
+		}
+	}
+
+	if (*(u16 *) & old_ctrl == *(u16 *) & ctrl_dl) {
+		D1(" No change in mctrl");
+		return 1;
+	}
+	/* Update statistics */
+	if (old_ctrl.CTS != ctrl_dl.CTS) {
+		dc->port[port].tty_icount.cts++;
+	}
+	if (old_ctrl.DSR != ctrl_dl.DSR) {
+		dc->port[port].tty_icount.dsr++;
+	}
+	if (old_ctrl.RI != ctrl_dl.RI) {
+		dc->port[port].tty_icount.rng++;
+	}
+	if (old_ctrl.DCD != ctrl_dl.DCD) {
+		dc->port[port].tty_icount.dcd++;
+	}
+	D1("port: %d DCD(%d), CTS(%d), RI(%d), DSR(%d)", port,
+		dc->port[port].tty_icount.dcd, dc->port[port].tty_icount.cts,
+		dc->port[port].tty_icount.rng, dc->port[port].tty_icount.dsr);
+
+	return 1;
 }
 
 /* TODO:  */
 /* - return enum ctrl_port_type */
-static u8 port2ctrl (enum port_type port, dc_t *dc)
+static u8 port2ctrl(enum port_type port, dc_t * dc)
 {
-	switch(port) {
+	switch (port) {
 	case PORT_MDM:
 		return CTRL_MDM;
 	case PORT_DIAG:
@@ -1099,7 +1187,8 @@ static u8 port2ctrl (enum port_type port
 	case PORT_APP2:
 		return CTRL_APP2;
 	default:
-		dev_err(&dc->pdev->dev, "ERROR: send flow control received for non-existing port\n");
+		dev_err(&dc->pdev->dev, "ERROR: send flow control received for "
+			"non-existing port\n");
 	};
 	return -1;
 }
@@ -1107,237 +1196,252 @@ static u8 port2ctrl (enum port_type port
 /* Send flow control, can only update one channel at a time */
 /* Return 0 - If we have updated all flow control */
 /* Return 1 - If we need to update more flow control, ack current enable more */
-static int send_flow_control( dc_t *dc ) {
-    u32 i, more_flow_control_to_be_updated = 0;
-    u16* ctrl;
-
-    for( i=PORT_MDM; i<MAX_PORT ; i++ ) {
-        if( dc->port[i].update_flow_control ) {
-            if ( more_flow_control_to_be_updated ) {
-                /* We have more flow control to be updated */
-                return 1;
-            }
-            dc->port[i].ctrl_ul.port = port2ctrl(i, dc);
-            ctrl = (u16*) &dc->port[i].ctrl_ul;
-            /* D1( "sending flow control 0x%04X for port %d, %d", (u16) *ctrl, i, dc->port[i].ctrl_ul.port ); */
-            SET_MEM( dc->port[PORT_CTRL].ul_addr[0], (u32*) ctrl, 2 );
-            dc->port[i].update_flow_control = 0;
-            more_flow_control_to_be_updated = 1;
-        }
-    }
-    return 0;
+static int send_flow_control(dc_t * dc)
+{
+	u32 i, more_flow_control_to_be_updated = 0;
+	u16 *ctrl;
+
+	for (i = PORT_MDM; i < MAX_PORT; i++) {
+		if (dc->port[i].update_flow_control) {
+			if (more_flow_control_to_be_updated) {
+				/* We have more flow control to be updated */
+				return 1;
+			}
+			dc->port[i].ctrl_ul.port = port2ctrl(i, dc);
+			ctrl = (u16 *) & dc->port[i].ctrl_ul;
+/*			D1("sending flow control 0x%04X for port %d, %d",
+				(u16)*ctrl, i, dc->port[i].ctrl_ul.port); */
+			SET_MEM(dc->port[PORT_CTRL].ul_addr[0], (u32 *) ctrl,2);
+			dc->port[i].update_flow_control = 0;
+			more_flow_control_to_be_updated = 1;
+		}
+	}
+	return 0;
 }
 
 /* Handle donlink data, ports that are handled are modem and diagnostics */
 /* Return 1 - ok */
 /* Return 0 - toggle fields are out of sync */
-static int handle_data_dl(dc_t *dc, irq_t *m, enum port_type port, u8 *toggle, u16 mask1, u16 mask2) {
-
-    if ( *toggle == 0 && m->read_iir & mask1 ) {
-        if (receive_data( port, dc )) {
-            SET_FCR( mask1 );
-            *toggle = !(*toggle);
-        }
-
-        if ( m->read_iir & mask2 ) {
-            if (receive_data( port, dc )) {
-                SET_FCR( mask2 );
-                *toggle = !(*toggle);
-            }
-        }
-    } else if ( *toggle == 1 && m->read_iir & mask2 ) {
-        if (receive_data( port, dc )) {
-            SET_FCR( mask2 );
-            *toggle = !(*toggle);
-        }
-
-        if ( m->read_iir & mask1 ) {
-            if (receive_data( port, dc )) {
-                SET_FCR( mask1 );
-                *toggle = !(*toggle);
-            }
-        }
-    } else {
-        ERR("port out of sync!, toggle:%d", *toggle);
-        return 0;
-    }
-    return 1;
+static int handle_data_dl(dc_t * dc, irq_t * m, enum port_type port,
+			  u8 * toggle, u16 mask1, u16 mask2)
+{
+
+	if (*toggle == 0 && m->read_iir & mask1) {
+		if (receive_data(port, dc)) {
+			SET_FCR(mask1);
+			*toggle = !(*toggle);
+		}
+
+		if (m->read_iir & mask2) {
+			if (receive_data(port, dc)) {
+				SET_FCR(mask2);
+				*toggle = !(*toggle);
+			}
+		}
+	} else if (*toggle == 1 && m->read_iir & mask2) {
+		if (receive_data(port, dc)) {
+			SET_FCR(mask2);
+			*toggle = !(*toggle);
+		}
+
+		if (m->read_iir & mask1) {
+			if (receive_data(port, dc)) {
+				SET_FCR(mask1);
+				*toggle = !(*toggle);
+			}
+		}
+	} else {
+		ERR("port out of sync!, toggle:%d", *toggle);
+		return 0;
+	}
+	return 1;
 }
 
 /* Handle uplink data, this is currently for the modem port */
 /* Return 1 - ok */
 /* Return 0 - toggle field are out of sync */
-static int handle_data_ul(dc_t *dc, irq_t *m, enum port_type port) {
-
-    u8 *toggle = &(dc->port[port].toggle_ul);
-
-    if ( *toggle==0 && m->read_iir & MDM_UL1 ) {
-        SET_IER( 0, MDM_UL );
-        if (send_data(port, dc)) {
-            SET_FCR( MDM_UL1 );
-            SET_IER( MDM_UL, MDM_UL);
-            *toggle = !*toggle;
-        }
-
-        if ( m->read_iir & MDM_UL2 ) {
-            SET_IER( 0, MDM_UL );
-            if (send_data(port, dc)) {
-                SET_FCR( MDM_UL2 );
-                SET_IER( MDM_UL, MDM_UL);
-                *toggle = !*toggle;
-            }
-        }
-
-    } else if ( *toggle==1 && m->read_iir & MDM_UL2 ) {
-        SET_IER( 0, MDM_UL );
-        if (send_data(port, dc)) {
-            SET_FCR( MDM_UL2 );
-            SET_IER( MDM_UL, MDM_UL);
-            *toggle = !*toggle;
-        }
-
-        if ( m->read_iir & MDM_UL1 ) {
-            SET_IER( 0, MDM_UL );
-            if (send_data(port, dc)) {
-                SET_FCR( MDM_UL1 );
-                SET_IER( MDM_UL, MDM_UL);
-                *toggle = !*toggle;
-            }
-        }
-    } else {
-        SET_FCR( m->read_iir & MDM_UL );
-        ERR("port out of sync!");
-        return 0;
-    }
-    return 1;
+static int handle_data_ul(dc_t * dc, irq_t * m, enum port_type port)
+{
+
+	u8 *toggle = &(dc->port[port].toggle_ul);
+
+	if (*toggle == 0 && m->read_iir & MDM_UL1) {
+		SET_IER(0, MDM_UL);
+		if (send_data(port, dc)) {
+			SET_FCR(MDM_UL1);
+			SET_IER(MDM_UL, MDM_UL);
+			*toggle = !*toggle;
+		}
+
+		if (m->read_iir & MDM_UL2) {
+			SET_IER(0, MDM_UL);
+			if (send_data(port, dc)) {
+				SET_FCR(MDM_UL2);
+				SET_IER(MDM_UL, MDM_UL);
+				*toggle = !*toggle;
+			}
+		}
+
+	} else if (*toggle == 1 && m->read_iir & MDM_UL2) {
+		SET_IER(0, MDM_UL);
+		if (send_data(port, dc)) {
+			SET_FCR(MDM_UL2);
+			SET_IER(MDM_UL, MDM_UL);
+			*toggle = !*toggle;
+		}
+
+		if (m->read_iir & MDM_UL1) {
+			SET_IER(0, MDM_UL);
+			if (send_data(port, dc)) {
+				SET_FCR(MDM_UL1);
+				SET_IER(MDM_UL, MDM_UL);
+				*toggle = !*toggle;
+			}
+		}
+	} else {
+		SET_FCR(m->read_iir & MDM_UL);
+		ERR("port out of sync!");
+		return 0;
+	}
+	return 1;
 }
 
-static irqreturn_t interrupt_handler(int irq, void *dev_id, struct pt_regs *regs) {
-    dc_t *dc = NULL;
-    irq_t* m = &my_irq;
-
-    if (my_dev && my_dev->pdev != dev_id) {
-        return IRQ_NONE;
-    }
-
-    if ( !(dc = get_dc_by_pdev(dev_id)) )  {
-        ERR("Could not find device context from pci_dev: %p", dev_id);
-        return IRQ_NONE;
-    }
-
-    GET_IIR( m->read_iir );
-
-    /* Just handle interrupt enabled in IER (by masking with dc->ier_last_written) */
-    m->read_iir &= dc->ier_last_written;
-
-    if (m->read_iir == 0) {
-        return IRQ_NONE;
-    }
-
-    if (dc == NULL ) {
-        ERR("ERROR!!");
-        return IRQ_NONE;
-    }
-
-    spin_lock(&dc->spin_mutex);
-
-    D4( "%s irq:0x%04X, prev:0x%04X", interrupt2str(m->read_iir), m->read_iir, dc->ier_last_written);
-
-    if ( m->read_iir & RESET) {
-        if( !nozomi_read_config_table(dc) ) {
-            SET_IER( 0, 0xFFFF);
-            ERR("ERR: Could not read status from card, we should disable interface");
-        } else {
-            SET_FCR( RESET );
-        }
-        goto exit_handler;  /* No more useful info if this was the reset interrupt. */
-    }
-    if ( m->read_iir & CTRL_UL ) {
-        D1( "CTRL_UL");
-        SET_IER( 0, CTRL_UL );
-        if ( send_flow_control(dc) ) {
-            SET_FCR( CTRL_UL );
-            SET_IER( CTRL_UL, CTRL_UL );
-        }
-    }
-    if ( m->read_iir & CTRL_DL ) {
-        receive_flow_control(dc, m);
-        SET_FCR( CTRL_DL );
-    }
-    if ( m->read_iir & MDM_DL ) {
-        if ( !(handle_data_dl(dc, m, PORT_MDM, &(dc->port[PORT_MDM].toggle_dl), MDM_DL1, MDM_DL2)) ) {
-            ERR("MDM_DL out of sync!");
-            goto exit_handler;
-        }
-    }
-    if ( m->read_iir & MDM_UL ) {
-        if ( !handle_data_ul(dc, m, PORT_MDM ) ) {
-            ERR("MDM_UL out of sync!");
-            goto exit_handler;
-        }
-    }
-    if ( m->read_iir & DIAG_DL ) {
-        if ( !(handle_data_dl(dc, m, PORT_DIAG, &(dc->port[PORT_DIAG].toggle_dl), DIAG_DL1, DIAG_DL2)) ) {
-            ERR("DIAG_DL out of sync!");
-            goto exit_handler;
-        }
-    }
-    if ( m->read_iir & DIAG_UL ) {
-        SET_IER( 0, DIAG_UL );
-        if( send_data( PORT_DIAG, dc ) ) {
-            SET_FCR( DIAG_UL );
-            SET_IER( DIAG_UL, DIAG_UL );
-        }
-    }
-    if ( m->read_iir & APP1_DL )  {
-        if (receive_data( PORT_APP1, dc ) ) {
-            SET_FCR( APP1_DL );
-        }
-    }
-    if ( m->read_iir & APP1_UL )  {
-        SET_IER( 0, APP1_UL );
-        if(send_data( PORT_APP1, dc )) {
-            SET_FCR( APP1_UL );
-            SET_IER( APP1_UL, APP1_UL );
-        }
-    }
-    if ( m->read_iir & APP2_DL ) {
-        if (receive_data( PORT_APP2, dc )) {
-            SET_FCR( APP2_DL );
-        }
-    }
-    if ( m->read_iir & APP2_UL ) {
-        SET_IER( 0, APP2_UL );
-        if(send_data( PORT_APP2, dc )) {
-            SET_FCR( APP2_UL );
-            SET_IER( APP2_UL, APP2_UL );
-        }
-    }
-
-  exit_handler:
-    spin_unlock(&dc->spin_mutex);
-    return IRQ_HANDLED;
+static irqreturn_t interrupt_handler(int irq, void *dev_id,
+				     struct pt_regs *regs)
+{
+	dc_t *dc = NULL;
+	irq_t *m = &my_irq;
+
+	if (my_dev && my_dev->pdev != dev_id) {
+		return IRQ_NONE;
+	}
+
+	if (!(dc = get_dc_by_pdev(dev_id))) {
+		ERR("Could not find device context from pci_dev: %p", dev_id);
+		return IRQ_NONE;
+	}
+
+	GET_IIR(m->read_iir);
+
+	/* Just handle interrupt enabled in IER (by masking with 
+	   dc->ier_last_written) */
+	m->read_iir &= dc->ier_last_written;
+
+	if (m->read_iir == 0) {
+		return IRQ_NONE;
+	}
+
+	if (dc == NULL) {
+		ERR("ERROR!!");
+		return IRQ_NONE;
+	}
+
+	spin_lock(&dc->spin_mutex);
+
+	D4("%s irq:0x%04X, prev:0x%04X", interrupt2str(m->read_iir),
+	   m->read_iir, dc->ier_last_written);
+
+	if (m->read_iir & RESET) {
+		if (!nozomi_read_config_table(dc)) {
+			SET_IER(0, 0xFFFF);
+			ERR("ERR: Could not read status from card, we should "
+				"disable interface");
+		} else {
+			SET_FCR(RESET);
+		}
+		goto exit_handler;	/* No more useful info if this was the reset interrupt. */
+	}
+	if (m->read_iir & CTRL_UL) {
+		D1("CTRL_UL");
+		SET_IER(0, CTRL_UL);
+		if (send_flow_control(dc)) {
+			SET_FCR(CTRL_UL);
+			SET_IER(CTRL_UL, CTRL_UL);
+		}
+	}
+	if (m->read_iir & CTRL_DL) {
+		receive_flow_control(dc, m);
+		SET_FCR(CTRL_DL);
+	}
+	if (m->read_iir & MDM_DL) {
+		if (!(handle_data_dl(dc, m, PORT_MDM,
+				&(dc->port[PORT_MDM].toggle_dl), MDM_DL1,
+				MDM_DL2))) {
+			ERR("MDM_DL out of sync!");
+			goto exit_handler;
+		}
+	}
+	if (m->read_iir & MDM_UL) {
+		if (!handle_data_ul(dc, m, PORT_MDM)) {
+			ERR("MDM_UL out of sync!");
+			goto exit_handler;
+		}
+	}
+	if (m->read_iir & DIAG_DL) {
+		if (!(handle_data_dl(dc, m, PORT_DIAG,
+				&(dc->port[PORT_DIAG].toggle_dl), DIAG_DL1,
+				DIAG_DL2))) {
+			ERR("DIAG_DL out of sync!");
+			goto exit_handler;
+		}
+	}
+	if (m->read_iir & DIAG_UL) {
+		SET_IER(0, DIAG_UL);
+		if (send_data(PORT_DIAG, dc)) {
+			SET_FCR(DIAG_UL);
+			SET_IER(DIAG_UL, DIAG_UL);
+		}
+	}
+	if (m->read_iir & APP1_DL) {
+		if (receive_data(PORT_APP1, dc)) {
+			SET_FCR(APP1_DL);
+		}
+	}
+	if (m->read_iir & APP1_UL) {
+		SET_IER(0, APP1_UL);
+		if (send_data(PORT_APP1, dc)) {
+			SET_FCR(APP1_UL);
+			SET_IER(APP1_UL, APP1_UL);
+		}
+	}
+	if (m->read_iir & APP2_DL) {
+		if (receive_data(PORT_APP2, dc)) {
+			SET_FCR(APP2_DL);
+		}
+	}
+	if (m->read_iir & APP2_UL) {
+		SET_IER(0, APP2_UL);
+		if (send_data(PORT_APP2, dc)) {
+			SET_FCR(APP2_UL);
+			SET_IER(APP2_UL, APP2_UL);
+		}
+	}
+
+      exit_handler:
+	spin_unlock(&dc->spin_mutex);
+	return IRQ_HANDLED;
 }
 
 /* Request a shared IRQ from system */
-static int nozomi_setup_interrupt(struct pci_dev *pdev) {
-
-    int rval = 0;
+static int nozomi_setup_interrupt(struct pci_dev *pdev)
+{
+	int rval = 0;
 
-    if ( (rval = request_irq( pdev->irq, &interrupt_handler, SA_SHIRQ, NOZOMI_NAME, pdev )) ) {
-        ERR("Cannot open because IRQ %d is already in use.", pdev->irq );
-        return rval;
-    }
+	if ((rval = request_irq(pdev->irq, &interrupt_handler, SA_SHIRQ,
+			NOZOMI_NAME, pdev))) {
+		ERR("Cannot open because IRQ %d is already in use.", pdev->irq);
+		return rval;
+	}
 
-    return rval;
+	return rval;
 }
 
-static void nozomi_get_card_type(dc_t *dc)
+static void nozomi_get_card_type(dc_t * dc)
 {
 	int i;
 	u32 size = 0;
 
-	for (i=0; i<6; i++)
+	for (i = 0; i < 6; i++)
 		size += pci_resource_len(dc->pdev, i);
 
 	/* Assume card type F32_8 if no match */
@@ -1346,43 +1450,44 @@ static void nozomi_get_card_type(dc_t *d
 	dev_info(&dc->pdev->dev, "Card type is: %d\n", dc->card_type);
 }
 
-static void nozomi_setup_private_data(dc_t *dc) {
-    void __iomem *offset = dc->base_addr + dc->card_type/2;
-    int i;
-
-    dc->REG_FCR = (void __iomem *)(offset + R_FCR);
-    dc->REG_IIR = (void __iomem *)(offset + R_IIR);
-    dc->REG_IER = (void __iomem *)(offset + R_IER);
-    dc->ier_last_written = 0;
-    dc->closing = 0;
-
-    dc->port[PORT_MDM ].token_dl = MDM_DL;
-    dc->port[PORT_DIAG].token_dl = DIAG_DL;
-    dc->port[PORT_APP1].token_dl = APP1_DL;
-    dc->port[PORT_APP2].token_dl = APP2_DL;
-
-    for(i=PORT_MDM;i<MAX_PORT;i++) {
-        dc->port[i].rx_data = dc->port[i].tx_data = 0;
-        dc->port[i].tty_dont_flip = 0;
-    }
-}
+static void nozomi_setup_private_data(dc_t * dc)
+{
+	void __iomem *offset = dc->base_addr + dc->card_type / 2;
+	int i;
 
+	dc->REG_FCR = (void __iomem *)(offset + R_FCR);
+	dc->REG_IIR = (void __iomem *)(offset + R_IIR);
+	dc->REG_IER = (void __iomem *)(offset + R_IER);
+	dc->ier_last_written = 0;
+	dc->closing = 0;
 
-static void tty_flip_queue_function(void *tmp_dc) {
-    dc_t *dc = (dc_t*) tmp_dc;
-    int i;
-    u32 flags;
-
-    /* Enable interrupt for that port */
-    for(i=0;i<MAX_PORT;i++) {
-        if (dc->port[i].tty_dont_flip) {
-            D6("Enable for port: %d", i);
-            dc->port[i].tty_dont_flip = 0;
-            spin_lock_irqsave(&dc->spin_mutex, flags);
-            enable_transmit_dl(dc->port[i].tty_index, dc);
-            spin_unlock_irqrestore(&dc->spin_mutex, flags);
-        }
-    }
+	dc->port[PORT_MDM].token_dl = MDM_DL;
+	dc->port[PORT_DIAG].token_dl = DIAG_DL;
+	dc->port[PORT_APP1].token_dl = APP1_DL;
+	dc->port[PORT_APP2].token_dl = APP2_DL;
+
+	for (i = PORT_MDM; i < MAX_PORT; i++) {
+		dc->port[i].rx_data = dc->port[i].tx_data = 0;
+		dc->port[i].tty_dont_flip = 0;
+	}
+}
+
+static void tty_flip_queue_function(void *tmp_dc)
+{
+	dc_t *dc = (dc_t *) tmp_dc;
+	int i;
+	u32 flags;
+
+	/* Enable interrupt for that port */
+	for (i = 0; i < MAX_PORT; i++) {
+		if (dc->port[i].tty_dont_flip) {
+			D6("Enable for port: %d", i);
+			dc->port[i].tty_dont_flip = 0;
+			spin_lock_irqsave(&dc->spin_mutex, flags);
+			enable_transmit_dl(dc->port[i].tty_index, dc);
+			spin_unlock_irqrestore(&dc->spin_mutex, flags);
+		}
+	}
 }
 
 static int card_type_show(struct device *dev, struct device_attribute *attr,
@@ -1393,6 +1498,7 @@ static int card_type_show(struct device 
 
 	return sprintf(buf, "%d\n", dc->card_type);
 }
+
 static DEVICE_ATTR(card_type, 0444, card_type_show, NULL);
 
 static int open_ttys_show(struct device *dev, struct device_attribute *attr,
@@ -1403,24 +1509,26 @@ static int open_ttys_show(struct device 
 
 	return sprintf(buf, "%d\n", dc->open_ttys);
 }
+
 static DEVICE_ATTR(open_ttys, 0444, open_ttys_show, NULL);
 
 #if 0
-static int read_proc_rtx(char *buf, char **start, off_t offset, int len) {
-    dc_t *dc = get_dc_by_index(0);
-    int i;
-
-    len = 0;
+static int read_proc_rtx(char *buf, char **start, off_t offset, int len)
+{
+	dc_t *dc = get_dc_by_index(0);
+	int i;
 
+	len = 0;
 
-    for(i=PORT_MDM;i<MAX_PORT;i++) {
-        len += sprintf(buf+len,"noz%d rx: %d, tx: %d\n", i, dc->port[i].rx_data, dc->port[i].tx_data);
-    }
-    return len;
+	for (i = PORT_MDM; i < MAX_PORT; i++) {
+		len += sprintf(buf + len, "noz%d rx: %d, tx: %d\n", i,
+			    dc->port[i].rx_data, dc->port[i].tx_data);
+	}
+	return len;
 }
 #endif
 
-static void make_sysfs_files(dc_t *dc)
+static void make_sysfs_files(dc_t * dc)
 {
 	int retval;
 
@@ -1428,16 +1536,17 @@ static void make_sysfs_files(dc_t *dc)
 	retval = device_create_file(&dc->pdev->dev, &dev_attr_open_ttys);
 }
 
-static void remove_sysfs_files(dc_t *dc)
+static void remove_sysfs_files(dc_t * dc)
 {
 	device_remove_file(&dc->pdev->dev, &dev_attr_card_type);
 	device_remove_file(&dc->pdev->dev, &dev_attr_open_ttys);
 }
 
 /* Allocate memory for one device */
-static int __devinit nozomi_card_init(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit nozomi_card_init(struct pci_dev *pdev,
+				      const struct pci_device_id *ent)
 {
-	resource_size_t	start;
+	resource_size_t start;
 	int ret = -EIO;
 	dc_t *dc = NULL;
 
@@ -1445,11 +1554,11 @@ static int __devinit nozomi_card_init(st
 	dev_info(&pdev->dev, "Init, cards_found: %d\n", cards_found);
 
 	if (!(my_dev = kmalloc(sizeof(dc_t), GFP_KERNEL))) {
-		D1( "Could not allocate memory");
+		D1("Could not allocate memory");
 		return -EIO;
 	}
 
-	memset(my_dev, 0, sizeof( dc_t ));
+	memset(my_dev, 0, sizeof(dc_t));
 
 	if (cards_found > 1) {
 		dev_err(&pdev->dev, "This driver only supports 1 device\n");
@@ -1509,70 +1618,70 @@ static int __devinit nozomi_card_init(st
 
 	D1("base_addr: 0x%08X", dc->base_addr);
 
-	if ( !(dc->tty_flip_wq = create_singlethread_workqueue(NOZOMI_NAME )) ) {
+	if (!(dc->tty_flip_wq = create_singlethread_workqueue(NOZOMI_NAME))) {
 		ERR("Could not create workqueue?");
 		BUG_ON(!dc->tty_flip_wq);
 		return -ENOMEM;
 	}
 	INIT_WORK(&dc->tty_flip_wq_struct, tty_flip_queue_function, dc);
 
-    spin_lock_init(&dc->spin_mutex);
+	spin_lock_init(&dc->spin_mutex);
 
-    make_sysfs_files(dc);
+	make_sysfs_files(dc);
 
-    ntty_tty_init(dc);
+	ntty_tty_init(dc);
 
-    /* Enable  RESET interrupt. */
-    SET_IER( RESET, 0xFFFF );
+	/* Enable  RESET interrupt. */
+	SET_IER(RESET, 0xFFFF);
 
 	pci_set_drvdata(pdev, dc);
 
 	return 0;
 
-err_disable_regions:
+      err_disable_regions:
 	pci_release_regions(pdev);
 	iounmap(dc->base_addr);
 	dc->base_addr = NULL;
 
-err_disable_device:
+      err_disable_device:
 	pci_disable_device(pdev);
-	kfree( my_dev );
+	kfree(my_dev);
 	return ret;
 }
 
-static void tty_do_close(dc_t *dc, struct port *port) {
+static void tty_do_close(dc_t * dc, struct port *port)
+{
 
-    u32      flags;
+	u32 flags;
 
-    if(down_interruptible(&port->tty_sem)){
-      return;
-  }
+	if (down_interruptible(&port->tty_sem)) {
+		return;
+	}
 
-    if ( !port->tty_open_count ) {
-        goto exit;
-    }
+	if (!port->tty_open_count) {
+		goto exit;
+	}
 
-    dc->open_ttys--;
-    port->tty_open_count--;
+	dc->open_ttys--;
+	port->tty_open_count--;
 
-    if ( port->tty_open_count == 0) {
-        D1("close: %d", port->token_dl );
-      spin_lock_irqsave(&dc->spin_mutex, flags);
-        SET_IER( 0,  port->token_dl );
-      spin_unlock_irqrestore(&dc->spin_mutex, flags);
-    }
+	if (port->tty_open_count == 0) {
+		D1("close: %d", port->token_dl);
+		spin_lock_irqsave(&dc->spin_mutex, flags);
+		SET_IER(0, port->token_dl);
+		spin_unlock_irqrestore(&dc->spin_mutex, flags);
+	}
 
 exit:
-    up(&port->tty_sem);
+	up(&port->tty_sem);
 }
 
-
 static void __devexit tty_exit(void)
 {
 	dc_t *dc = my_dev;
 	int i;
 
-	D1( " ");
+	D1(" ");
 
 	for (i = 0; i < NTTY_TTY_MINORS; i++) {
 		while (dc->port[i].tty_open_count)
@@ -1588,512 +1697,536 @@ static void __devexit tty_exit(void)
 }
 
 /* Deallocate memory for one device */
-static void __devexit nozomi_card_exit(struct pci_dev *pdev) {
-    int i;
-    ctrl_ul_t ctrl;
-    dc_t *dc = get_dc_by_pdev(pdev);
+static void __devexit nozomi_card_exit(struct pci_dev *pdev)
+{
+	int i;
+	ctrl_ul_t ctrl;
+	dc_t *dc = get_dc_by_pdev(pdev);
 
-    /* Disable all interrupts */
-    SET_IER( 0, 0xFFFF);
+	/* Disable all interrupts */
+	SET_IER(0, 0xFFFF);
 
-    /* Send 0x0001, command card to resend the reset token. */
-    /* This is to get the reset when the module is reloaded. */
-    ctrl.port = 0x00; ctrl.reserved = 0; ctrl.RTS=0; ctrl.DTR=1;
-    D1( "sending flow control 0x%04X",  * ((u16*) &ctrl) );
+	/* Send 0x0001, command card to resend the reset token. */
+	/* This is to get the reset when the module is reloaded. */
+	ctrl.port = 0x00;
+	ctrl.reserved = 0;
+	ctrl.RTS = 0;
+	ctrl.DTR = 1;
+	D1("sending flow control 0x%04X", *((u16 *) & ctrl));
 
-    /* Setup dc->reg addresses to we can use defines here */
-    nozomi_setup_private_data(dc);
-    SET_MEM( dc->port[PORT_CTRL].ul_addr[0], (u32*) &ctrl, 2 );
-    SET_FCR( CTRL_UL );     /* push the token to the card. */
+	/* Setup dc->reg addresses to we can use defines here */
+	nozomi_setup_private_data(dc);
+	SET_MEM(dc->port[PORT_CTRL].ul_addr[0], (u32 *) & ctrl, 2);
+	SET_FCR(CTRL_UL);	/* push the token to the card. */
 
-    D1( "pci_release_regions");
-    pci_release_regions(pdev);
+	D1("pci_release_regions");
+	pci_release_regions(pdev);
 
-    if(dc->base_addr)
-        iounmap(dc->base_addr);
+	if (dc->base_addr)
+		iounmap(dc->base_addr);
 
-    D1( "pci_disable_device");
-    pci_disable_device(pdev);
+	D1("pci_disable_device");
+	pci_disable_device(pdev);
 
-    free_irq( pdev->irq, pdev );
+	free_irq(pdev->irq, pdev);
 
-    for (i=PORT_MDM; i< MAX_PORT;i++) {
-        kfree ( dc->port[i].fifo_ul );
-    }
+	for (i = PORT_MDM; i < MAX_PORT; i++) {
+		kfree(dc->port[i].fifo_ul);
+	}
 
-    kfree( dc->send_buf );
+	kfree(dc->send_buf);
 
-    tty_exit();
+	tty_exit();
 
-    remove_sysfs_files(dc);
+	remove_sysfs_files(dc);
 
-    destroy_workqueue(dc->tty_flip_wq);
+	destroy_workqueue(dc->tty_flip_wq);
 
-    if (my_dev) {
-        kfree( my_dev );
-    }
+	if (my_dev) {
+		kfree(my_dev);
+	}
 
-    cards_found--;
+	cards_found--;
 }
 
-static void set_rts(int index, int rts) {
-    dc_t *dc = get_dc_by_index(index);
+static void set_rts(int index, int rts)
+{
+	dc_t *dc = get_dc_by_index(index);
 
-    dc->port[index].ctrl_ul.RTS = rts;
-    dc->port[index].update_flow_control = 1;
-    enable_transmit_ul(PORT_CTRL, dc);
+	dc->port[index].ctrl_ul.RTS = rts;
+	dc->port[index].update_flow_control = 1;
+	enable_transmit_ul(PORT_CTRL, dc);
 }
 
-static void set_dtr(int index, int dtr) {
-    dc_t *dc = get_dc_by_index(index);
+static void set_dtr(int index, int dtr)
+{
+	dc_t *dc = get_dc_by_index(index);
 
-    D1("SETTING DTR index: %d, dtr: %d", index, dtr);
+	D1("SETTING DTR index: %d, dtr: %d", index, dtr);
 
-    dc->port[index].ctrl_ul.DTR = dtr;
-    dc->port[index].update_flow_control = 1;
-    enable_transmit_ul(PORT_CTRL, dc);
+	dc->port[index].ctrl_ul.DTR = dtr;
+	dc->port[index].update_flow_control = 1;
+	enable_transmit_ul(PORT_CTRL, dc);
 }
 
-
-/* ---------------------------------------------------------------------------------------------------
+/*------------------------------------------------------------------------------
   TTY code
-  ---------------------------------------------------------------------------------------------------*/
-
+------------------------------------------------------------------------------*/
 
 /* Called when the userspace process opens the tty, /dev/noz*. */
-static int ntty_open(struct tty_struct *tty, struct file *file) {
-
-    s32 index = get_index(tty);
-    struct port *port = get_port_by_tty(tty);
-    dc_t *dc = get_dc_by_tty(tty);
-    u32      flags;
-
-  if(down_interruptible(&port->tty_sem)){
-      return -ERESTARTSYS;
-  }
+static int ntty_open(struct tty_struct *tty, struct file *file)
+{
 
-    tty->low_latency  = 1;
-    tty->driver_data  = port;
-    port->tty         = tty;
-    port->tty_index   = index;
+	s32 index = get_index(tty);
+	struct port *port = get_port_by_tty(tty);
+	dc_t *dc = get_dc_by_tty(tty);
+	u32 flags;
 
-    port->tty_open_count++;
-    dc->open_ttys++;
+	if (down_interruptible(&port->tty_sem)) {
+		return -ERESTARTSYS;
+	}
 
-    /* Enable interrupt downlink for channel */
-    if ( port->tty_open_count == 1) {
-        port->rx_data = port->tx_data = 0;
-        D1("open: %d", port->token_dl );
-      spin_lock_irqsave(&dc->spin_mutex, flags);
-        SET_IER( port->token_dl,  port->token_dl );
-      spin_unlock_irqrestore(&dc->spin_mutex, flags);
-    }
+	tty->low_latency = 1;
+	tty->driver_data = port;
+	port->tty = tty;
+	port->tty_index = index;
+
+	port->tty_open_count++;
+	dc->open_ttys++;
+
+	/* Enable interrupt downlink for channel */
+	if (port->tty_open_count == 1) {
+		port->rx_data = port->tx_data = 0;
+		D1("open: %d", port->token_dl);
+		spin_lock_irqsave(&dc->spin_mutex, flags);
+		SET_IER(port->token_dl, port->token_dl);
+		spin_unlock_irqrestore(&dc->spin_mutex, flags);
+	}
 
-    up(&port->tty_sem);
+	up(&port->tty_sem);
 
-    return 0;
+	return 0;
 }
 
 /* Called when the userspace process close the tty, /dev/noz*. */
-static void ntty_close(struct tty_struct *tty, struct file *file) {
-    dc_t *dc = get_dc_by_tty(tty);
-    tty_do_close(dc, (struct port *) tty->driver_data);
+static void ntty_close(struct tty_struct *tty, struct file *file)
+{
+	dc_t *dc = get_dc_by_tty(tty);
+	tty_do_close(dc, (struct port *)tty->driver_data);
 }
 
 /* called when the userspace process writes to the tty (/dev/noz*).  */
-/* Data is inserted into a fifo, which is then read and transfered to the modem. */
-static int ntty_write(struct tty_struct *tty, const unsigned char *buffer, int count) {
-    int                  rval = -EINVAL;
-    dc_t                *dc = get_dc_by_tty(tty);
-    struct port              *port = (struct port *) tty->driver_data;
-    u32      flags;
-
-    /* D1( "WRITEx: %d, index = %d", count, index); */
-
-    if (! port) {
-        return -ENODEV;
-    }
-
-  if(down_trylock(&port->tty_sem) ) { // must test lock as tty layer wraps calls to this function with BKL
-      ERR("Would have deadlocked - return ERESTARTSYS");
-      return -ERESTARTSYS;
-  }
-
-    if (! port->tty_open_count) {
-        D1( " ");
-        goto exit;
-    }
-
-    rval = __kfifo_put(port->fifo_ul, (unsigned char *) buffer, count);
-
-    /* notify card */
-    if ( dc == NULL) {
-        D1( "No device context?");
-        goto exit;
-    }
-
-  spin_lock_irqsave(&dc->spin_mutex, flags);
-    // CTS is only valid on the modem channel
-    if ( port == &(dc->port[PORT_MDM]) ) {
-        if ( port->ctrl_dl.CTS ) {
-            D4( "Enable interrupt");
-            enable_transmit_ul(port->tty_index, dc );
-        } else {
-            ERR("CTS not active on modem port?");
-        }
-    } else {
-        enable_transmit_ul(port->tty_index, dc );
-    }
-  spin_unlock_irqrestore(&dc->spin_mutex, flags);
+/* Data is inserted into a fifo, which is then read and transfered to the
+   modem. */
+static int ntty_write(struct tty_struct *tty, const unsigned char *buffer,
+		      int count)
+{
+	int rval = -EINVAL;
+	dc_t *dc = get_dc_by_tty(tty);
+	struct port *port = (struct port *)tty->driver_data;
+	u32 flags;
 
-exit:
-    up(&port->tty_sem);
-    return rval;
+	/* D1( "WRITEx: %d, index = %d", count, index); */
+
+	if (!port) {
+		return -ENODEV;
+	}
+
+	if (down_trylock(&port->tty_sem)) { /* must test lock as tty layer wraps
+					       calls to this function with BKL*/
+		ERR("Would have deadlocked - return ERESTARTSYS");
+		return -ERESTARTSYS;
+	}
+
+	if (!port->tty_open_count) {
+		D1(" ");
+		goto exit;
+	}
+
+	rval = __kfifo_put(port->fifo_ul, (unsigned char *)buffer, count);
+
+	/* notify card */
+	if (dc == NULL) {
+		D1("No device context?");
+		goto exit;
+	}
+
+	spin_lock_irqsave(&dc->spin_mutex, flags);
+	// CTS is only valid on the modem channel
+	if (port == &(dc->port[PORT_MDM])) {
+		if (port->ctrl_dl.CTS) {
+			D4("Enable interrupt");
+			enable_transmit_ul(port->tty_index, dc);
+		} else {
+			ERR("CTS not active on modem port?");
+		}
+	} else {
+		enable_transmit_ul(port->tty_index, dc);
+	}
+	spin_unlock_irqrestore(&dc->spin_mutex, flags);
+
+      exit:
+	up(&port->tty_sem);
+	return rval;
 }
 
 /* Calculate how much is left in device */
 /* This method is called by the upper tty layer. */
-/*   #according to sources N_TTY.c it expects a value >= 0 and does not check for negative values. */
-static int ntty_write_room(struct tty_struct *tty) {
-    struct port  *port = (struct port *) tty->driver_data;
-    int      room = 0;
-//	u32      flags = 0;
-//	dc_t *dc = get_dc_by_tty(tty);
-
-    if (! port) {
-        return 0;
-    }
-  if(down_trylock(&port->tty_sem)){
-      return 0;
-  }
+/*   #according to sources N_TTY.c it expects a value >= 0 and does not check
+     for negative values. */
+static int ntty_write_room(struct tty_struct *tty)
+{
+	struct port *port = (struct port *)tty->driver_data;
+	int room = 0;
+//      u32      flags = 0;
+//      dc_t *dc = get_dc_by_tty(tty);
 
+	if (!port) {
+		return 0;
+	}
+	if (down_trylock(&port->tty_sem)) {
+		return 0;
+	}
 // if(down_interruptible(&port->tty_sem)){
 //      return 0;
 // }
 
-    if (! port->tty_open_count) {
-        goto exit;
-    }
+	if (!port->tty_open_count) {
+		goto exit;
+	}
 
-    room = port->fifo_ul->size - __kfifo_len(port->fifo_ul);
+	room = port->fifo_ul->size - __kfifo_len(port->fifo_ul);
 
-exit:
-    up(&port->tty_sem);
-    return room;
+      exit:
+	up(&port->tty_sem);
+	return room;
 }
 
 /* Sets termios flags, called by the tty layer. */
-static void ntty_set_termios(struct tty_struct *tty, struct termios *old_termios) {
-    unsigned int cflag;
-
-    cflag = tty->termios->c_cflag;
-
-    if (old_termios) {
-        if ((cflag == old_termios->c_cflag) &&
-            (RELEVANT_IFLAG(tty->termios->c_iflag) == RELEVANT_IFLAG(old_termios->c_iflag))) {
-            D1( " - nothing to change...");
-            goto exit_termios;
-        }
-    }
-
-    /* get the byte size */
-    switch (cflag & CSIZE) {
-        case CS5:
-            D1( " - data bits = 5");
-            break;
-        case CS6:
-            D1( " - data bits = 6");
-            break;
-        case CS7:
-            D1( " - data bits = 7");
-            break;
-        default:
-        case CS8:
-            D1( " - data bits = 8");
-            break;
-    }
-
-    /* determine the parity */
-    if (cflag & PARENB) {
-        if (cflag & PARODD) {
-            D1( " - parity = odd");
-        } else {
-            D1( " - parity = even");
-        }
-    } else {
-        D1( " - parity = none");
-    }
-
-    /* figure out the stop bits requested */
-    if (cflag & CSTOPB) {
-        D1( " - stop bits = 2");
-    } else {
-        D1( " - stop bits = 1");
-    }
-
-    /* figure out the hardware flow control settings */
-    if (cflag & CRTSCTS) {
-        D1( " - RTS/CTS is enabled");
-    } else {
-        D1( " - RTS/CTS is disabled");
-    }
-
-    /* determine software flow control */
-    /* if we are implementing XON/XOFF, set the start and
-    * stop character in the device */
-    if (I_IXOFF(tty) || I_IXON(tty)) {
+static void ntty_set_termios(struct tty_struct *tty,
+			     struct termios *old_termios)
+{
+	unsigned int cflag;
+
+	cflag = tty->termios->c_cflag;
+
+	if (old_termios) {
+		if ((cflag == old_termios->c_cflag) &&
+		    (RELEVANT_IFLAG(tty->termios->c_iflag) ==
+		     RELEVANT_IFLAG(old_termios->c_iflag))) {
+			D1(" - nothing to change...");
+			goto exit_termios;
+		}
+	}
+
+	/* get the byte size */
+	switch (cflag & CSIZE) {
+	case CS5:
+		D1(" - data bits = 5");
+		break;
+	case CS6:
+		D1(" - data bits = 6");
+		break;
+	case CS7:
+		D1(" - data bits = 7");
+		break;
+	default:
+	case CS8:
+		D1(" - data bits = 8");
+		break;
+	}
+
+	/* determine the parity */
+	if (cflag & PARENB) {
+		if (cflag & PARODD) {
+			D1(" - parity = odd");
+		} else {
+			D1(" - parity = even");
+		}
+	} else {
+		D1(" - parity = none");
+	}
+
+	/* figure out the stop bits requested */
+	if (cflag & CSTOPB) {
+		D1(" - stop bits = 2");
+	} else {
+		D1(" - stop bits = 1");
+	}
+
+	/* figure out the hardware flow control settings */
+	if (cflag & CRTSCTS) {
+		D1(" - RTS/CTS is enabled");
+	} else {
+		D1(" - RTS/CTS is disabled");
+	}
+
+	/* determine software flow control */
+	/* if we are implementing XON/XOFF, set the start and
+	 * stop character in the device */
+	if (I_IXOFF(tty) || I_IXON(tty)) {
 #ifdef NOZOMI_DEBUG
-        unsigned char stop_char  = STOP_CHAR(tty);
-        unsigned char start_char = START_CHAR(tty);
+		unsigned char stop_char = STOP_CHAR(tty);
+		unsigned char start_char = START_CHAR(tty);
 #endif
-        /* if we are implementing INBOUND XON/XOFF */
-        if (I_IXOFF(tty)) {
-            D1( " - INBOUND XON/XOFF is enabled, "
-                "XON = %2x, XOFF = %2x", start_char, stop_char);
-        } else {
-            D1( " - INBOUND XON/XOFF is disabled");
-        }
-
-        /* if we are implementing OUTBOUND XON/XOFF */
-        if (I_IXON(tty)) {
-            D1( " - OUTBOUND XON/XOFF is enabled, "
-                "XON = %2x, XOFF = %2x", start_char, stop_char);
-        } else {
-            D1( " - OUTBOUND XON/XOFF is disabled");
-        }
-    }
-
-  exit_termios:
-    return;
+		/* if we are implementing INBOUND XON/XOFF */
+		if (I_IXOFF(tty)) {
+			D1(" - INBOUND XON/XOFF is enabled, "
+			   "XON = %2x, XOFF = %2x", start_char, stop_char);
+		} else {
+			D1(" - INBOUND XON/XOFF is disabled");
+		}
+
+		/* if we are implementing OUTBOUND XON/XOFF */
+		if (I_IXON(tty)) {
+			D1(" - OUTBOUND XON/XOFF is enabled, "
+			   "XON = %2x, XOFF = %2x", start_char, stop_char);
+		} else {
+			D1(" - OUTBOUND XON/XOFF is disabled");
+		}
+	}
+
+      exit_termios:
+	return;
 }
 
 /* Gets io control parameters */
-static int ntty_tiocmget(struct tty_struct *tty, struct file *file) {
-    struct port *port = tty->driver_data;
-    ctrl_dl_t *ctrl_dl = &port->ctrl_dl;
-    ctrl_ul_t *ctrl_ul = &port->ctrl_ul;
-
-    return 0
-        | (ctrl_ul->RTS ? TIOCM_RTS : 0)
-        | (ctrl_ul->DTR ? TIOCM_DTR : 0)
-        | (ctrl_dl->DCD ? TIOCM_CAR : 0)
-        | (ctrl_dl->RI  ? TIOCM_RNG : 0)
-        | (ctrl_dl->DSR ? TIOCM_DSR : 0)
-        | (ctrl_dl->CTS ? TIOCM_CTS : 0);
+static int ntty_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	struct port *port = tty->driver_data;
+	ctrl_dl_t *ctrl_dl = &port->ctrl_dl;
+	ctrl_ul_t *ctrl_ul = &port->ctrl_ul;
+
+	return 0 | (ctrl_ul->RTS ? TIOCM_RTS : 0)
+	    | (ctrl_ul->DTR ? TIOCM_DTR : 0)
+	    | (ctrl_dl->DCD ? TIOCM_CAR : 0)
+	    | (ctrl_dl->RI ? TIOCM_RNG : 0)
+	    | (ctrl_dl->DSR ? TIOCM_DSR : 0)
+	    | (ctrl_dl->CTS ? TIOCM_CTS : 0);
 }
 
 /* Sets io controls parameters */
-static int ntty_tiocmset(struct tty_struct *tty, struct file *file, u32 arg) {
-    struct port *port = (struct port *) tty->driver_data;
+static int ntty_tiocmset(struct tty_struct *tty, struct file *file, u32 arg)
+{
+	struct port *port = (struct port *)tty->driver_data;
 
-    set_rts(port->tty_index, (arg & TIOCM_RTS) ? 1 : 0);
-    set_dtr(port->tty_index, (arg & TIOCM_DTR) ? 1 : 0);
+	set_rts(port->tty_index, (arg & TIOCM_RTS) ? 1 : 0);
+	set_dtr(port->tty_index, (arg & TIOCM_DTR) ? 1 : 0);
 
-    return 0;
+	return 0;
 }
 
-static int ntty_ioctl_tiocmiwait(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg) {
-    struct port *port = (struct port *) tty->driver_data;
-
-    if (cmd == TIOCMIWAIT) {
-        DECLARE_WAITQUEUE(wait, current);
-        struct async_icount cnow;
-        struct async_icount cprev;
-
-        cprev = port->tty_icount;
-        while (1) {
-            add_wait_queue(&port->tty_wait, &wait);
-            set_current_state(TASK_INTERRUPTIBLE);
-            schedule();
-            remove_wait_queue(&port->tty_wait, &wait);
-
-            /* see if a signal woke us up */
-            if (signal_pending(current))
-                return -ERESTARTSYS;
-
-            cnow = port->tty_icount;
-            if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr &&
-                cnow.dcd == cprev.dcd && cnow.cts == cprev.cts)
-                return -EIO; /* no change => error */
-            if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
-                ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
-                ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
-                ((arg & TIOCM_CTS) && (cnow.cts != cprev.cts)) ) {
-                return 0;
-            }
-            cprev = cnow;
-        }
-
-    }
-    return -ENOIOCTLCMD;
+static int ntty_ioctl_tiocmiwait(struct tty_struct *tty, struct file *file,
+				 unsigned int cmd, unsigned long arg)
+{
+	struct port *port = (struct port *)tty->driver_data;
+
+	if (cmd == TIOCMIWAIT) {
+		DECLARE_WAITQUEUE(wait, current);
+		struct async_icount cnow;
+		struct async_icount cprev;
+
+		cprev = port->tty_icount;
+		while (1) {
+			add_wait_queue(&port->tty_wait, &wait);
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule();
+			remove_wait_queue(&port->tty_wait, &wait);
+
+			/* see if a signal woke us up */
+			if (signal_pending(current))
+				return -ERESTARTSYS;
+
+			cnow = port->tty_icount;
+			if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr &&
+			    cnow.dcd == cprev.dcd && cnow.cts == cprev.cts)
+				return -EIO;	/* no change => error */
+			if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
+			    ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
+			    ((arg & TIOCM_CD) && (cnow.dcd != cprev.dcd)) ||
+			    ((arg & TIOCM_CTS) && (cnow.cts != cprev.cts))) {
+				return 0;
+			}
+			cprev = cnow;
+		}
+
+	}
+	return -ENOIOCTLCMD;
 }
 
-static int ntty_ioctl_tiocgicount(struct tty_struct *tty, struct file *file, unsigned int cmd, void __user *arg) {
-    struct port *port = (struct port *) tty->driver_data;
-
-    if (cmd == TIOCGICOUNT) {
-        struct async_icount cnow = port->tty_icount;
-        struct serial_icounter_struct icount;
-
-        icount.cts	= cnow.cts;
-        icount.dsr	= cnow.dsr;
-        icount.rng	= cnow.rng;
-        icount.dcd	= cnow.dcd;
-        icount.rx	= cnow.rx;
-        icount.tx	= cnow.tx;
-        icount.frame	= cnow.frame;
-        icount.overrun	= cnow.overrun;
-        icount.parity	= cnow.parity;
-        icount.brk	= cnow.brk;
-        icount.buf_overrun = cnow.buf_overrun;
-
-        if (copy_to_user(arg, &icount, sizeof(icount)))
-            return -EFAULT;
-        return 0;
-    }
-    return -ENOIOCTLCMD;
+static int ntty_ioctl_tiocgicount(struct tty_struct *tty, struct file *file,
+				  unsigned int cmd, void __user * arg)
+{
+	struct port *port = (struct port *)tty->driver_data;
+
+	if (cmd == TIOCGICOUNT) {
+		struct async_icount cnow = port->tty_icount;
+		struct serial_icounter_struct icount;
+
+		icount.cts = cnow.cts;
+		icount.dsr = cnow.dsr;
+		icount.rng = cnow.rng;
+		icount.dcd = cnow.dcd;
+		icount.rx = cnow.rx;
+		icount.tx = cnow.tx;
+		icount.frame = cnow.frame;
+		icount.overrun = cnow.overrun;
+		icount.parity = cnow.parity;
+		icount.brk = cnow.brk;
+		icount.buf_overrun = cnow.buf_overrun;
+
+		if (copy_to_user(arg, &icount, sizeof(icount)))
+			return -EFAULT;
+		return 0;
+	}
+	return -ENOIOCTLCMD;
 }
 
-static int ntty_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg) {
-    struct port *port = tty->driver_data;
-    dc_t    *dc = get_dc_by_tty(tty);
-    u32      flags;
-    int mask;
-    int rval = -ENOIOCTLCMD;
-
-    D1("******** IOCTL, cmd: %d", cmd);
-
-
-    switch (cmd) {
-    case TCGETS:
-        D1( "IOCTL TCGETS ...");
-        rval = -ENOIOCTLCMD;
-        break;
-    case TCSETS:
-        D1( "IOCTL TCSETS ...");
-        rval = -ENOIOCTLCMD;
-        break;
-    case TIOCMIWAIT:
-        rval = ntty_ioctl_tiocmiwait(tty, file, cmd, arg);
-        break;
-    case TIOCGICOUNT:
-        rval =  ntty_ioctl_tiocgicount(tty, file, cmd, (void __user *)arg);
-        break;
-    case TIOCMGET:
-      spin_lock_irqsave(&dc->spin_mutex, flags);
-        rval = ntty_tiocmget(tty, file);
-      spin_unlock_irqrestore(&dc->spin_mutex, flags);
-        break;
-    case TIOCMSET:
-        rval = ntty_tiocmset(tty, file, arg);
-        break;
-    case TIOCMBIC:
-        if (get_user(mask, (unsigned long __user *)arg))
-            return -EFAULT;
-
-      spin_lock_irqsave(&dc->spin_mutex, flags);
-        if (mask & TIOCM_RTS)
-            set_rts(port->tty_index, 0);
-        if (mask & TIOCM_DTR)
-            set_dtr(port->tty_index, 0);
-      spin_unlock_irqrestore(&dc->spin_mutex, flags);
-        rval = 0;
-        break;
-    case TIOCMBIS:
-        if (get_user(mask, (unsigned long __user *)arg))
-            return -EFAULT;
-
-      spin_lock_irqsave(&dc->spin_mutex, flags);
-        if (mask & TIOCM_RTS)
-            set_rts(port->tty_index, 1);
-        if (mask & TIOCM_DTR)
-            set_dtr(port->tty_index, 1);
-      spin_unlock_irqrestore(&dc->spin_mutex, flags);
-        rval = 0;
-        break;
-    case TCFLSH:
-        D1( "IOCTL TCFLSH ...");
-        rval = -ENOIOCTLCMD;
-        break;
-
-    default:
-        D1( "ERR: 0x%08X, %d", cmd, cmd);
-        break;
-    };
-
-    return rval;
+static int ntty_ioctl(struct tty_struct *tty, struct file *file,
+		      unsigned int cmd, unsigned long arg)
+{
+	struct port *port = tty->driver_data;
+	dc_t *dc = get_dc_by_tty(tty);
+	u32 flags;
+	int mask;
+	int rval = -ENOIOCTLCMD;
+
+	D1("******** IOCTL, cmd: %d", cmd);
+
+	switch (cmd) {
+	case TCGETS:
+		D1("IOCTL TCGETS ...");
+		rval = -ENOIOCTLCMD;
+		break;
+	case TCSETS:
+		D1("IOCTL TCSETS ...");
+		rval = -ENOIOCTLCMD;
+		break;
+	case TIOCMIWAIT:
+		rval = ntty_ioctl_tiocmiwait(tty, file, cmd, arg);
+		break;
+	case TIOCGICOUNT:
+		rval =
+		    ntty_ioctl_tiocgicount(tty, file, cmd, (void __user *)arg);
+		break;
+	case TIOCMGET:
+		spin_lock_irqsave(&dc->spin_mutex, flags);
+		rval = ntty_tiocmget(tty, file);
+		spin_unlock_irqrestore(&dc->spin_mutex, flags);
+		break;
+	case TIOCMSET:
+		rval = ntty_tiocmset(tty, file, arg);
+		break;
+	case TIOCMBIC:
+		if (get_user(mask, (unsigned long __user *)arg))
+			return -EFAULT;
+
+		spin_lock_irqsave(&dc->spin_mutex, flags);
+		if (mask & TIOCM_RTS)
+			set_rts(port->tty_index, 0);
+		if (mask & TIOCM_DTR)
+			set_dtr(port->tty_index, 0);
+		spin_unlock_irqrestore(&dc->spin_mutex, flags);
+		rval = 0;
+		break;
+	case TIOCMBIS:
+		if (get_user(mask, (unsigned long __user *)arg))
+			return -EFAULT;
+
+		spin_lock_irqsave(&dc->spin_mutex, flags);
+		if (mask & TIOCM_RTS)
+			set_rts(port->tty_index, 1);
+		if (mask & TIOCM_DTR)
+			set_dtr(port->tty_index, 1);
+		spin_unlock_irqrestore(&dc->spin_mutex, flags);
+		rval = 0;
+		break;
+	case TCFLSH:
+		D1("IOCTL TCFLSH ...");
+		rval = -ENOIOCTLCMD;
+		break;
+
+	default:
+		D1("ERR: 0x%08X, %d", cmd, cmd);
+		break;
+	};
+
+	return rval;
 }
 
 /* Called by the upper tty layer when tty buffers are ready */
 /* to receive data again after a call to throttle. */
-static void ntty_unthrottle(struct tty_struct *tty) {
-    struct port  *port = (struct port *) tty->driver_data;
-    dc_t    *dc = get_dc_by_tty(tty);
-    u32      flags;
+static void ntty_unthrottle(struct tty_struct *tty)
+{
+	struct port *port = (struct port *)tty->driver_data;
+	dc_t *dc = get_dc_by_tty(tty);
+	u32 flags;
 
-    D1( "UNTHROTTLE");
-    spin_lock_irqsave(&dc->spin_mutex, flags);
-    enable_transmit_dl(port->tty_index, dc);
-    set_rts(port->tty_index, 1);
+	D1("UNTHROTTLE");
+	spin_lock_irqsave(&dc->spin_mutex, flags);
+	enable_transmit_dl(port->tty_index, dc);
+	set_rts(port->tty_index, 1);
 
-    spin_unlock_irqrestore(&dc->spin_mutex, flags);
+	spin_unlock_irqrestore(&dc->spin_mutex, flags);
 }
 
 /* Called by the upper tty layer when the tty buffers are almost full. */
 /* The driver should stop send more data. */
-static void ntty_throttle(struct tty_struct *tty) {
-    struct port  *port = (struct port *) tty->driver_data;
-    dc_t    *dc = get_dc_by_tty(tty);
-    u32      flags;
-
-    D1( "THROTTLE");
-    spin_lock_irqsave(&dc->spin_mutex, flags);
-    set_rts(port->tty_index, 0);
-    spin_unlock_irqrestore(&dc->spin_mutex, flags);
+static void ntty_throttle(struct tty_struct *tty)
+{
+	struct port *port = (struct port *)tty->driver_data;
+	dc_t *dc = get_dc_by_tty(tty);
+	u32 flags;
+
+	D1("THROTTLE");
+	spin_lock_irqsave(&dc->spin_mutex, flags);
+	set_rts(port->tty_index, 0);
+	spin_unlock_irqrestore(&dc->spin_mutex, flags);
 }
 
-static void ntty_put_char(struct tty_struct *tty, unsigned char c) {
-    D2("PUT CHAR Function: %c", c);
+static void ntty_put_char(struct tty_struct *tty, unsigned char c)
+{
+	D2("PUT CHAR Function: %c", c);
 }
 
 /* Returns number of chars in buffer, called by tty layer */
-static s32 ntty_chars_in_buffer(struct tty_struct *tty) {
-    struct port *port = (struct port *) tty->driver_data;
-    s32 rval;
+static s32 ntty_chars_in_buffer(struct tty_struct *tty)
+{
+	struct port *port = (struct port *)tty->driver_data;
+	s32 rval;
 
-    if (! port) {
-        rval = -ENODEV;
-        goto exit_in_buffer;
-    }
+	if (!port) {
+		rval = -ENODEV;
+		goto exit_in_buffer;
+	}
 
-    if (! port->tty_open_count) {
-        ERR("No tty open?");
-        rval = -ENODEV;
-        goto exit_in_buffer;
-    }
+	if (!port->tty_open_count) {
+		ERR("No tty open?");
+		rval = -ENODEV;
+		goto exit_in_buffer;
+	}
 
-    rval = __kfifo_len(port->fifo_ul);
+	rval = __kfifo_len(port->fifo_ul);
 
-  exit_in_buffer:
-    return rval;
+      exit_in_buffer:
+	return rval;
 }
 
 static struct tty_operations tty_ops = {
-	.ioctl =		ntty_ioctl,
-	.open =			ntty_open,
-	.close =		ntty_close,
-	.write =		ntty_write,
-	.write_room =		ntty_write_room,
-	.unthrottle =		ntty_unthrottle,
-	.throttle =		ntty_throttle,
-	.set_termios =		ntty_set_termios,
-	.chars_in_buffer=	ntty_chars_in_buffer,
-	.put_char =		ntty_put_char,
+	.ioctl = ntty_ioctl,
+	.open = ntty_open,
+	.close = ntty_close,
+	.write = ntty_write,
+	.write_room = ntty_write_room,
+	.unthrottle = ntty_unthrottle,
+	.throttle = ntty_throttle,
+	.set_termios = ntty_set_termios,
+	.chars_in_buffer = ntty_chars_in_buffer,
+	.put_char = ntty_put_char,
 };
 
-
 /* Initializes the tty */
-static int ntty_tty_init(dc_t *dc)
+static int ntty_tty_init(dc_t * dc)
 {
 	struct tty_driver *td;
 	int rval;
@@ -2113,8 +2246,8 @@ static int ntty_tty_init(dc_t *dc)
 	td->init_termios = tty_std_termios;
 	td->init_termios.c_cflag = B115200 | CS8 | CREAD | HUPCL | CLOCAL;
 
-	td->termios               = dc->tty_termios;
-	td->termios_locked        = dc->tty_termios_locked;
+	td->termios = dc->tty_termios;
+	td->termios_locked = dc->tty_termios_locked;
 	tty_set_operations(dc->tty_driver, &tty_ops);
 
 	rval = tty_register_driver(td);
@@ -2136,10 +2269,10 @@ static int ntty_tty_init(dc_t *dc)
 
 /* Module initialization */
 static struct pci_driver nozomi_driver = {
-	.name		= NOZOMI_NAME,
-	.id_table	= nozomi_pci_tbl,
-	.probe		= nozomi_card_init,
-	.remove		= __devexit_p(nozomi_card_exit),
+	.name = NOZOMI_NAME,
+	.id_table = nozomi_pci_tbl,
+	.probe = nozomi_card_init,
+	.remove = __devexit_p(nozomi_card_exit),
 };
 
 static __init int nozomi_init(void)
