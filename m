Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSG3WqJ>; Tue, 30 Jul 2002 18:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSG3WqJ>; Tue, 30 Jul 2002 18:46:09 -0400
Received: from patan.Sun.COM ([192.18.98.43]:43435 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S316792AbSG3Wpr>;
	Tue, 30 Jul 2002 18:45:47 -0400
Message-ID: <3D4717E5.3000802@sun.com>
Date: Tue, 30 Jul 2002 15:49:09 -0700
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: 2.5 PATCH: nvram.c Lindent
Content-Type: multipart/mixed;
 boundary="------------060908030307010807020500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060908030307010807020500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

All,

This patch is pretty simple:  It runs drivers/char/nvram.c through 
Lindent, with a few manual cosmetics on top.  I'm sending this now 
because it makes my follow-up patch to this file easier :)

It is also available as a changeset from 
http://suncobalt.bkbits.net/submit-2.5

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com

--------------060908030307010807020500
Content-Type: text/plain;
 name="nvram-cleanup-2.5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nvram-cleanup-2.5.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.536   -> 1.536.1.1
#	drivers/char/nvram.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/29	torvalds@penguin.transmeta.com	1.537
# Chris Wright points out that this was also missed in the
# file locking LSM update
# --------------------------------------------
# 02/07/29	torvalds@home.transmeta.com	1.538
# Merge http://linux-isdn.bkbits.net/linux-2.5.make
# into home.transmeta.com:/home/torvalds/v2.5/linux
# --------------------------------------------
# 02/07/29	th122948@scl1.sfbay.sun.com	1.536.1.1
# Lindent drivers/char/nvram.c in anticipation of more patching
# --------------------------------------------
#
diff -Nru a/drivers/char/nvram.c b/drivers/char/nvram.c
--- a/drivers/char/nvram.c	Tue Jul 30 15:32:37 2002
+++ b/drivers/char/nvram.c	Tue Jul 30 15:32:37 2002
@@ -38,12 +38,12 @@
 #include <linux/smp_lock.h>
 
 #define PC		1
-#define ATARI	2
+#define ATARI		2
 
 /* select machine configuration */
 #if defined(CONFIG_ATARI)
 #define MACH ATARI
-#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) /* and others?? */
+#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)  /* and others?? */
 #define MACH PC
 #else
 #error Cannot build nvram driver for this machine configuration.
@@ -52,12 +52,12 @@
 #if MACH == PC
 
 /* RTC in a PC */
-#define CHECK_DRIVER_INIT() 1
+#define CHECK_DRIVER_INIT()	1
 
 /* On PCs, the checksum is built only over bytes 2..31 */
 #define PC_CKS_RANGE_START	2
 #define PC_CKS_RANGE_END	31
-#define PC_CKS_LOC			32
+#define PC_CKS_LOC		32
 
 #define	mach_check_checksum	pc_check_checksum
 #define	mach_set_checksum	pc_set_checksum
@@ -70,14 +70,14 @@
 /* Special parameters for RTC in Atari machines */
 #include <asm/atarihw.h>
 #include <asm/atariints.h>
-#define RTC_PORT(x)			(TT_RTC_BAS + 2*(x))
-#define CHECK_DRIVER_INIT() (MACH_IS_ATARI && ATARIHW_PRESENT(TT_CLK))
+#define RTC_PORT(x)		(TT_RTC_BAS + 2*(x))
+#define CHECK_DRIVER_INIT()	(MACH_IS_ATARI && ATARIHW_PRESENT(TT_CLK))
 
 /* On Ataris, the checksum is over all bytes except the checksum bytes
  * themselves; these are at the very end */
 #define ATARI_CKS_RANGE_START	0
-#define ATARI_CKS_RANGE_END		47
-#define ATARI_CKS_LOC			48
+#define ATARI_CKS_RANGE_END	47
+#define ATARI_CKS_LOC		48
 
 #define	mach_check_checksum	atari_check_checksum
 #define	mach_set_checksum	atari_set_checksum
@@ -109,46 +109,50 @@
 
 static int nvram_open_cnt;	/* #times opened */
 static int nvram_open_mode;	/* special open modes */
-static spinlock_t nvram_open_lock = SPIN_LOCK_UNLOCKED;
-                               /* guards nvram_open_cnt and
-                                         nvram_open_mode */
-#define	NVRAM_WRITE		1		/* opened for writing (exclusive) */
-#define	NVRAM_EXCL		2		/* opened with O_EXCL */
+static spinlock_t nvram_open_lock = SPIN_LOCK_UNLOCKED; /* guards 
+							 * nvram_open_cnt and
+							 * nvram_open_mode */
+#define	NVRAM_WRITE		1	/* opened for writing (exclusive) */
+#define	NVRAM_EXCL		2	/* opened with O_EXCL */
+
+#define	RTC_FIRST_BYTE		14	/* RTC register number of first
+					 * NVRAM byte */
+#define	NVRAM_BYTES		128-RTC_FIRST_BYTE /* number of NVRAM bytes */
 
-#define	RTC_FIRST_BYTE		14	/* RTC register number of first NVRAM byte */
-#define	NVRAM_BYTES			128-RTC_FIRST_BYTE	/* number of NVRAM bytes */
+static int mach_check_checksum(void);
+static void mach_set_checksum(void);
 
-
-static int mach_check_checksum( void );
-static void mach_set_checksum( void );
 #ifdef CONFIG_PROC_FS
-static int mach_proc_infos( unsigned char *contents, char *buffer, int *len,
-							off_t *begin, off_t offset, int size );
+static int mach_proc_infos(unsigned char *contents, char *buffer, int *len,
+    off_t *begin, off_t offset, int size);
 #endif
 
-
 /*
  * These are the internal NVRAM access functions, which do NOT disable
  * interrupts and do not check the checksum. Both tasks are left to higher
  * level function, so they need to be done only once per syscall.
  */
 
-static __inline__ unsigned char nvram_read_int( int i )
+static __inline__ unsigned char
+nvram_read_int(int i)
 {
-	return( CMOS_READ( RTC_FIRST_BYTE+i ) );
+	return (CMOS_READ(RTC_FIRST_BYTE + i));
 }
 
-static __inline__ void nvram_write_int( unsigned char c, int i )
+static __inline__ void
+nvram_write_int(unsigned char c, int i)
 {
-	CMOS_WRITE( c, RTC_FIRST_BYTE+i );
+	CMOS_WRITE(c, RTC_FIRST_BYTE + i);
 }
 
-static __inline__ int nvram_check_checksum_int( void )
+static __inline__ int
+nvram_check_checksum_int(void)
 {
-	return( mach_check_checksum() );
+	return (mach_check_checksum());
 }
 
-static __inline__ void nvram_set_checksum_int( void )
+static __inline__ void
+nvram_set_checksum_int(void)
 {
 	mach_set_checksum();
 }
@@ -166,178 +170,183 @@
  * module), so they access config information themselves.
  */
 
-unsigned char nvram_read_byte( int i )
+unsigned char
+nvram_read_byte(int i)
 {
 	unsigned long flags;
 	unsigned char c;
 
-	spin_lock_irqsave (&rtc_lock, flags);
-	c = nvram_read_int( i );
-	spin_unlock_irqrestore (&rtc_lock, flags);
-	return( c );
+	spin_lock_irqsave(&rtc_lock, flags);
+	c = nvram_read_int(i);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return (c);
 }
 
 /* This races nicely with trying to read with checksum checking (nvram_read) */
-void nvram_write_byte( unsigned char c, int i )
+void
+nvram_write_byte(unsigned char c, int i)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave (&rtc_lock, flags);
-	nvram_write_int( c, i );
-	spin_unlock_irqrestore (&rtc_lock, flags);
+	spin_lock_irqsave(&rtc_lock, flags);
+	nvram_write_int(c, i);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 }
 
-int nvram_check_checksum( void )
+int
+nvram_check_checksum(void)
 {
 	unsigned long flags;
 	int rv;
 
-	spin_lock_irqsave (&rtc_lock, flags);
+	spin_lock_irqsave(&rtc_lock, flags);
 	rv = nvram_check_checksum_int();
-	spin_unlock_irqrestore (&rtc_lock, flags);
-	return( rv );
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return (rv);
 }
 
-void nvram_set_checksum( void )
+void
+nvram_set_checksum(void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave (&rtc_lock, flags);
+	spin_lock_irqsave(&rtc_lock, flags);
 	nvram_set_checksum_int();
-	spin_unlock_irqrestore (&rtc_lock, flags);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 }
 
 #endif /* MACH == ATARI */
 
-
 /*
  * The are the file operation function for user access to /dev/nvram
  */
 
-static long long nvram_llseek(struct file *file,loff_t offset, int origin )
+static long long
+nvram_llseek(struct file *file, loff_t offset, int origin)
 {
 	lock_kernel();
-	switch( origin ) {
-	  case 0:
+	switch (origin) {
+	case 0:
 		/* nothing to do */
 		break;
-	  case 1:
+	case 1:
 		offset += file->f_pos;
 		break;
-	  case 2:
+	case 2:
 		offset += NVRAM_BYTES;
 		break;
 	}
 	unlock_kernel();
-	return( (offset >= 0) ? (file->f_pos = offset) : -EINVAL );
+	return ((offset >= 0) ? (file->f_pos = offset) : -EINVAL);
 }
 
-static ssize_t nvram_read(struct file * file,
-	char * buf, size_t count, loff_t *ppos )
+static ssize_t
+nvram_read(struct file *file, char *buf, size_t count, loff_t *ppos)
 {
-	char contents [NVRAM_BYTES];
+	char contents[NVRAM_BYTES];
 	unsigned i = *ppos;
 	char *tmp;
 
-	spin_lock_irq (&rtc_lock);
-	
+	spin_lock_irq(&rtc_lock);
+
 	if (!nvram_check_checksum_int())
 		goto checksum_err;
 
 	for (tmp = contents; count-- > 0 && i < NVRAM_BYTES; ++i, ++tmp)
 		*tmp = nvram_read_int(i);
 
-	spin_unlock_irq (&rtc_lock);
+	spin_unlock_irq(&rtc_lock);
 
-	if (copy_to_user (buf, contents, tmp - contents))
+	if (copy_to_user(buf, contents, tmp - contents))
 		return -EFAULT;
 
 	*ppos = i;
 
 	return (tmp - contents);
 
-checksum_err:
-	spin_unlock_irq (&rtc_lock);
+      checksum_err:
+	spin_unlock_irq(&rtc_lock);
 	return -EIO;
 }
 
-static ssize_t nvram_write(struct file * file,
-		const char * buf, size_t count, loff_t *ppos )
+static ssize_t
+nvram_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
-	char contents [NVRAM_BYTES];
+	char contents[NVRAM_BYTES];
 	unsigned i = *ppos;
-	char * tmp;
+	char *tmp;
 
-	if (copy_from_user (contents, buf, (NVRAM_BYTES - i) < count ?
-						(NVRAM_BYTES - i) : count))
+	if (copy_from_user(contents, buf, (NVRAM_BYTES - i) < count ?
+	    (NVRAM_BYTES - i) : count))
 		return -EFAULT;
 
-	spin_lock_irq (&rtc_lock);
+	spin_lock_irq(&rtc_lock);
 
 	if (!nvram_check_checksum_int())
 		goto checksum_err;
 
 	for (tmp = contents; count-- > 0 && i < NVRAM_BYTES; ++i, ++tmp)
-		nvram_write_int (*tmp, i);
+		nvram_write_int(*tmp, i);
 
 	nvram_set_checksum_int();
 
-	spin_unlock_irq (&rtc_lock);
+	spin_unlock_irq(&rtc_lock);
 
 	*ppos = i;
 
 	return (tmp - contents);
 
-checksum_err:
-	spin_unlock_irq (&rtc_lock);
+      checksum_err:
+	spin_unlock_irq(&rtc_lock);
 	return -EIO;
 }
 
-static int nvram_ioctl( struct inode *inode, struct file *file,
-						unsigned int cmd, unsigned long arg )
+static int
+nvram_ioctl(struct inode *inode, struct file *file,
+    unsigned int cmd, unsigned long arg)
 {
 	int i;
-	
-	switch( cmd ) {
 
-	  case NVRAM_INIT:			/* initialize NVRAM contents and checksum */
+	switch (cmd) {
+
+	case NVRAM_INIT:	/* initialize NVRAM contents and checksum */
 		if (!capable(CAP_SYS_ADMIN))
-			return( -EACCES );
+			return (-EACCES);
 
-		spin_lock_irq (&rtc_lock);
+		spin_lock_irq(&rtc_lock);
 
-		for( i = 0; i < NVRAM_BYTES; ++i )
-			nvram_write_int( 0, i );
+		for (i = 0; i < NVRAM_BYTES; ++i)
+			nvram_write_int(0, i);
 		nvram_set_checksum_int();
-		
-		spin_unlock_irq (&rtc_lock);
-		return( 0 );
-	  
-	  case NVRAM_SETCKS:		/* just set checksum, contents unchanged
-								 * (maybe useful after checksum garbaged
-								 * somehow...) */
+
+		spin_unlock_irq(&rtc_lock);
+		return (0);
+
+	case NVRAM_SETCKS:	/* just set checksum, contents unchanged
+				 * (maybe useful after checksum garbaged
+				 * somehow...) */
 		if (!capable(CAP_SYS_ADMIN))
-			return( -EACCES );
+			return (-EACCES);
 
-		spin_lock_irq (&rtc_lock);
+		spin_lock_irq(&rtc_lock);
 		nvram_set_checksum_int();
-		spin_unlock_irq (&rtc_lock);
-		return( 0 );
+		spin_unlock_irq(&rtc_lock);
+		return (0);
 
-	  default:
-		return( -ENOTTY );
+	default:
+		return (-ENOTTY);
 	}
 }
 
-static int nvram_open( struct inode *inode, struct file *file )
+static int
+nvram_open(struct inode *inode, struct file *file)
 {
-	spin_lock( &nvram_open_lock );
+	spin_lock(&nvram_open_lock);
 	if ((nvram_open_cnt && (file->f_flags & O_EXCL)) ||
-		(nvram_open_mode & NVRAM_EXCL) ||
-		((file->f_mode & 2) && (nvram_open_mode & NVRAM_WRITE)))
-	{	
-		spin_unlock( &nvram_open_lock );
-		return( -EBUSY );
+	    (nvram_open_mode & NVRAM_EXCL) ||
+	    ((file->f_mode & 2) && (nvram_open_mode & NVRAM_WRITE))) {
+		spin_unlock(&nvram_open_lock);
+		return (-EBUSY);
 	}
 
 	if (file->f_flags & O_EXCL)
@@ -345,60 +354,65 @@
 	if (file->f_mode & 2)
 		nvram_open_mode |= NVRAM_WRITE;
 	nvram_open_cnt++;
-	spin_unlock( &nvram_open_lock );
-	return( 0 );
+	spin_unlock(&nvram_open_lock);
+	return (0);
 }
 
-static int nvram_release( struct inode *inode, struct file *file )
+static int
+nvram_release(struct inode *inode, struct file *file)
 {
-	spin_lock( &nvram_open_lock );
+	spin_lock(&nvram_open_lock);
 	nvram_open_cnt--;
 	if (file->f_flags & O_EXCL)
 		nvram_open_mode &= ~NVRAM_EXCL;
 	if (file->f_mode & 2)
 		nvram_open_mode &= ~NVRAM_WRITE;
-	spin_unlock( &nvram_open_lock );
-	return( 0 );
+	spin_unlock(&nvram_open_lock);
+	return (0);
 }
 
-
 #ifndef CONFIG_PROC_FS
-static int nvram_read_proc( char *buffer, char **start, off_t offset,
-			    int size, int *eof, void *data) { return 0; }
+static int
+nvram_read_proc(char *buffer, char **start, off_t offset,
+    int size, int *eof, void *data)
+{
+	return 0;
+}
 #else
 
-static int nvram_read_proc( char *buffer, char **start, off_t offset,
-							int size, int *eof, void *data )
+static int
+nvram_read_proc(char *buffer, char **start, off_t offset,
+    int size, int *eof, void *data)
 {
 	unsigned char contents[NVRAM_BYTES];
-    int i, len = 0;
-    off_t begin = 0;
+	int i, len = 0;
+	off_t begin = 0;
+
+	spin_lock_irq(&rtc_lock);
+	for (i = 0; i < NVRAM_BYTES; ++i)
+		contents[i] = nvram_read_int(i);
+	spin_unlock_irq(&rtc_lock);
+
+	*eof = mach_proc_infos(contents, buffer, &len, &begin, offset, size);
+
+	if (offset >= begin + len)
+		return (0);
+	*start = buffer + (offset - begin);
+	return (size < begin + len - offset ? size : begin + len - offset);
 
-	spin_lock_irq (&rtc_lock);
-	for( i = 0; i < NVRAM_BYTES; ++i )
-		contents[i] = nvram_read_int( i );
-	spin_unlock_irq (&rtc_lock);
-	
-	*eof = mach_proc_infos( contents, buffer, &len, &begin, offset, size );
-
-    if (offset >= begin + len)
-		return( 0 );
-    *start = buffer + (offset - begin);
-    return( size < begin + len - offset ? size : begin + len - offset );
-	
 }
 
 /* This macro frees the machine specific function from bounds checking and
  * this like that... */
-#define	PRINT_PROC(fmt,args...)							\
-	do {												\
+#define	PRINT_PROC(fmt,args...)					\
+	do {							\
 		*len += sprintf( buffer+*len, fmt, ##args );	\
-		if (*begin + *len > offset + size)				\
-			return( 0 );								\
-		if (*begin + *len < offset) {					\
-			*begin += *len;								\
-			*len = 0;									\
-		}												\
+		if (*begin + *len > offset + size)		\
+			return( 0 );				\
+		if (*begin + *len < offset) {			\
+			*begin += *len;				\
+			*len = 0;				\
+		}						\
 	} while(0)
 
 #endif /* CONFIG_PROC_FS */
@@ -419,72 +433,75 @@
 	&nvram_fops
 };
 
-
-static int __init nvram_init(void)
+static int __init
+nvram_init(void)
 {
 	int ret;
 
 	/* First test whether the driver should init at all */
 	if (!CHECK_DRIVER_INIT())
-	    return( -ENXIO );
+		return (-ENXIO);
 
-	ret = misc_register( &nvram_dev );
+	ret = misc_register(&nvram_dev);
 	if (ret) {
-		printk(KERN_ERR "nvram: can't misc_register on minor=%d\n", NVRAM_MINOR);
+		printk(KERN_ERR "nvram: can't misc_register on minor=%d\n",
+		    NVRAM_MINOR);
 		goto out;
 	}
-	if (!create_proc_read_entry("driver/nvram",0,0,nvram_read_proc,NULL)) {
+	if (!create_proc_read_entry("driver/nvram", 0, 0, nvram_read_proc,
+		NULL)) {
 		printk(KERN_ERR "nvram: can't create /proc/driver/nvram\n");
 		ret = -ENOMEM;
 		goto outmisc;
 	}
 	ret = 0;
 	printk(KERN_INFO "Non-volatile memory driver v" NVRAM_VERSION "\n");
-out:
-	return( ret );
-outmisc:
-	misc_deregister( &nvram_dev );
+      out:
+	return (ret);
+      outmisc:
+	misc_deregister(&nvram_dev);
 	goto out;
 }
 
-static void __exit nvram_cleanup_module (void)
+static void __exit
+nvram_cleanup_module(void)
 {
-	remove_proc_entry( "driver/nvram", 0 );
-	misc_deregister( &nvram_dev );
+	remove_proc_entry("driver/nvram", 0);
+	misc_deregister(&nvram_dev);
 }
 
 module_init(nvram_init);
 module_exit(nvram_cleanup_module);
 
-
 /*
  * Machine specific functions
  */
 
-
 #if MACH == PC
 
-static int pc_check_checksum( void )
+static int
+pc_check_checksum(void)
 {
 	int i;
 	unsigned short sum = 0;
-	
-	for( i = PC_CKS_RANGE_START; i <= PC_CKS_RANGE_END; ++i )
-		sum += nvram_read_int( i );
-	return( (sum & 0xffff) ==
-			((nvram_read_int(PC_CKS_LOC) << 8) |
-			 nvram_read_int(PC_CKS_LOC+1)) );
+
+	for (i = PC_CKS_RANGE_START; i <= PC_CKS_RANGE_END; ++i)
+		sum += nvram_read_int(i);
+	return ((sum & 0xffff) ==
+	    ((nvram_read_int(PC_CKS_LOC) << 8) |
+		nvram_read_int(PC_CKS_LOC + 1)));
 }
 
-static void pc_set_checksum( void )
+static void
+pc_set_checksum(void)
 {
 	int i;
 	unsigned short sum = 0;
-	
-	for( i = PC_CKS_RANGE_START; i <= PC_CKS_RANGE_END; ++i )
-		sum += nvram_read_int( i );
-	nvram_write_int( sum >> 8, PC_CKS_LOC );
-	nvram_write_int( sum & 0xff, PC_CKS_LOC+1 );
+
+	for (i = PC_CKS_RANGE_START; i <= PC_CKS_RANGE_END; ++i)
+		sum += nvram_read_int(i);
+	nvram_write_int(sum >> 8, PC_CKS_LOC);
+	nvram_write_int(sum & 0xff, PC_CKS_LOC + 1);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -501,69 +518,67 @@
 	"monochrome",
 };
 
-static int pc_proc_infos( unsigned char *nvram, char *buffer, int *len,
-						  off_t *begin, off_t offset, int size )
+static int
+pc_proc_infos(unsigned char *nvram, char *buffer, int *len,
+    off_t *begin, off_t offset, int size)
 {
 	int checksum;
 	int type;
 
-	spin_lock_irq (&rtc_lock);
+	spin_lock_irq(&rtc_lock);
 	checksum = nvram_check_checksum_int();
-	spin_unlock_irq (&rtc_lock);
+	spin_unlock_irq(&rtc_lock);
 
-	PRINT_PROC( "Checksum status: %svalid\n", checksum ? "" : "not " );
+	PRINT_PROC("Checksum status: %svalid\n", checksum ? "" : "not ");
 
-	PRINT_PROC( "# floppies     : %d\n",
-				(nvram[6] & 1) ? (nvram[6] >> 6) + 1 : 0 );
-	PRINT_PROC( "Floppy 0 type  : " );
+	PRINT_PROC("# floppies     : %d\n",
+	    (nvram[6] & 1) ? (nvram[6] >> 6) + 1 : 0);
+	PRINT_PROC("Floppy 0 type  : ");
 	type = nvram[2] >> 4;
-	if (type < sizeof(floppy_types)/sizeof(*floppy_types))
-		PRINT_PROC( "%s\n", floppy_types[type] );
+	if (type < sizeof (floppy_types) / sizeof (*floppy_types))
+		PRINT_PROC("%s\n", floppy_types[type]);
 	else
-		PRINT_PROC( "%d (unknown)\n", type );
-	PRINT_PROC( "Floppy 1 type  : " );
+		PRINT_PROC("%d (unknown)\n", type);
+	PRINT_PROC("Floppy 1 type  : ");
 	type = nvram[2] & 0x0f;
-	if (type < sizeof(floppy_types)/sizeof(*floppy_types))
-		PRINT_PROC( "%s\n", floppy_types[type] );
+	if (type < sizeof (floppy_types) / sizeof (*floppy_types))
+		PRINT_PROC("%s\n", floppy_types[type]);
 	else
-		PRINT_PROC( "%d (unknown)\n", type );
+		PRINT_PROC("%d (unknown)\n", type);
 
-	PRINT_PROC( "HD 0 type      : " );
+	PRINT_PROC("HD 0 type      : ");
 	type = nvram[4] >> 4;
 	if (type)
-		PRINT_PROC( "%02x\n", type == 0x0f ? nvram[11] : type );
+		PRINT_PROC("%02x\n", type == 0x0f ? nvram[11] : type);
 	else
-		PRINT_PROC( "none\n" );
+		PRINT_PROC("none\n");
 
-	PRINT_PROC( "HD 1 type      : " );
+	PRINT_PROC("HD 1 type      : ");
 	type = nvram[4] & 0x0f;
 	if (type)
-		PRINT_PROC( "%02x\n", type == 0x0f ? nvram[12] : type );
+		PRINT_PROC("%02x\n", type == 0x0f ? nvram[12] : type);
 	else
-		PRINT_PROC( "none\n" );
+		PRINT_PROC("none\n");
+
+	PRINT_PROC("HD type 48 data: %d/%d/%d C/H/S, precomp %d, lz %d\n",
+	    nvram[18] | (nvram[19] << 8),
+	    nvram[20], nvram[25],
+	    nvram[21] | (nvram[22] << 8), nvram[23] | (nvram[24] << 8));
+	PRINT_PROC("HD type 49 data: %d/%d/%d C/H/S, precomp %d, lz %d\n",
+	    nvram[39] | (nvram[40] << 8),
+	    nvram[41], nvram[46],
+	    nvram[42] | (nvram[43] << 8), nvram[44] | (nvram[45] << 8));
+
+	PRINT_PROC("DOS base memory: %d kB\n", nvram[7] | (nvram[8] << 8));
+	PRINT_PROC("Extended memory: %d kB (configured), %d kB (tested)\n",
+	    nvram[9] | (nvram[10] << 8), nvram[34] | (nvram[35] << 8));
 
-	PRINT_PROC( "HD type 48 data: %d/%d/%d C/H/S, precomp %d, lz %d\n",
-				nvram[18] | (nvram[19] << 8),
-				nvram[20], nvram[25],
-				nvram[21] | (nvram[22] << 8),
-				nvram[23] | (nvram[24] << 8) );
-	PRINT_PROC( "HD type 49 data: %d/%d/%d C/H/S, precomp %d, lz %d\n",
-				nvram[39] | (nvram[40] << 8),
-				nvram[41], nvram[46],
-				nvram[42] | (nvram[43] << 8),
-				nvram[44] | (nvram[45] << 8) );
-
-	PRINT_PROC( "DOS base memory: %d kB\n", nvram[7] | (nvram[8] << 8) );
-	PRINT_PROC( "Extended memory: %d kB (configured), %d kB (tested)\n",
-				nvram[9] | (nvram[10] << 8),
-				nvram[34] | (nvram[35] << 8) );
-
-	PRINT_PROC( "Gfx adapter    : %s\n", gfx_types[ (nvram[6] >> 4)&3 ] );
-
-	PRINT_PROC( "FPU            : %sinstalled\n",
-				(nvram[6] & 2) ? "" : "not " );
-	
-	return( 1 );
+	PRINT_PROC("Gfx adapter    : %s\n", gfx_types[(nvram[6] >> 4) & 3]);
+
+	PRINT_PROC("FPU            : %sinstalled\n",
+	    (nvram[6] & 2) ? "" : "not ");
+
+	return (1);
 }
 #endif
 
@@ -571,26 +586,28 @@
 
 #if MACH == ATARI
 
-static int atari_check_checksum( void )
+static int
+atari_check_checksum(void)
 {
 	int i;
 	unsigned char sum = 0;
-	
-	for( i = ATARI_CKS_RANGE_START; i <= ATARI_CKS_RANGE_END; ++i )
-		sum += nvram_read_int( i );
-	return( nvram_read_int( ATARI_CKS_LOC ) == (~sum & 0xff) &&
-			nvram_read_int( ATARI_CKS_LOC+1 ) == (sum & 0xff) );
+
+	for (i = ATARI_CKS_RANGE_START; i <= ATARI_CKS_RANGE_END; ++i)
+		sum += nvram_read_int(i);
+	return (nvram_read_int(ATARI_CKS_LOC) == (~sum & 0xff) &&
+	    nvram_read_int(ATARI_CKS_LOC + 1) == (sum & 0xff));
 }
 
-static void atari_set_checksum( void )
+static void
+atari_set_checksum(void)
 {
 	int i;
 	unsigned char sum = 0;
-	
-	for( i = ATARI_CKS_RANGE_START; i <= ATARI_CKS_RANGE_END; ++i )
-		sum += nvram_read_int( i );
-	nvram_write_int( ~sum, ATARI_CKS_LOC );
-	nvram_write_int( sum, ATARI_CKS_LOC+1 );
+
+	for (i = ATARI_CKS_RANGE_START; i <= ATARI_CKS_RANGE_END; ++i)
+		sum += nvram_read_int(i);
+	nvram_write_int(~sum, ATARI_CKS_LOC);
+	nvram_write_int(sum, ATARI_CKS_LOC + 1);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -635,81 +652,74 @@
 
 #define fieldsize(a)	(sizeof(a)/sizeof(*a))
 
-static int atari_proc_infos( unsigned char *nvram, char *buffer, int *len,
-			    off_t *begin, off_t offset, int size )
+static int
+atari_proc_infos(unsigned char *nvram, char *buffer, int *len,
+    off_t *begin, off_t offset, int size)
 {
 	int checksum = nvram_check_checksum();
 	int i;
 	unsigned vmode;
-	
-	PRINT_PROC( "Checksum status  : %svalid\n", checksum ? "" : "not " );
 
-	PRINT_PROC( "Boot preference  : " );
-	for( i = fieldsize(boot_prefs)-1; i >= 0; --i ) {
+	PRINT_PROC("Checksum status  : %svalid\n", checksum ? "" : "not ");
+
+	PRINT_PROC("Boot preference  : ");
+	for (i = fieldsize(boot_prefs) - 1; i >= 0; --i) {
 		if (nvram[1] == boot_prefs[i].val) {
-			PRINT_PROC( "%s\n", boot_prefs[i].name );
+			PRINT_PROC("%s\n", boot_prefs[i].name);
 			break;
 		}
 	}
 	if (i < 0)
-		PRINT_PROC( "0x%02x (undefined)\n", nvram[1] );
+		PRINT_PROC("0x%02x (undefined)\n", nvram[1]);
 
-	PRINT_PROC( "SCSI arbitration : %s\n", (nvram[16] & 0x80) ? "on" : "off" );
-	PRINT_PROC( "SCSI host ID     : " );
+	PRINT_PROC("SCSI arbitration : %s\n",
+	    (nvram[16] & 0x80) ? "on" : "off");
+	PRINT_PROC("SCSI host ID     : ");
 	if (nvram[16] & 0x80)
-		PRINT_PROC( "%d\n", nvram[16] & 7 );
+		PRINT_PROC("%d\n", nvram[16] & 7);
 	else
-		PRINT_PROC( "n/a\n" );
+		PRINT_PROC("n/a\n");
 
 	/* the following entries are defined only for the Falcon */
 	if ((atari_mch_cookie >> 16) != ATARI_MCH_FALCON)
 		return 1;
 
-	PRINT_PROC( "OS language      : " );
+	PRINT_PROC("OS language      : ");
 	if (nvram[6] < fieldsize(languages))
-		PRINT_PROC( "%s\n", languages[nvram[6]] );
+		PRINT_PROC("%s\n", languages[nvram[6]]);
 	else
-		PRINT_PROC( "%u (undefined)\n", nvram[6] );
-	PRINT_PROC( "Keyboard language: " );
+		PRINT_PROC("%u (undefined)\n", nvram[6]);
+	PRINT_PROC("Keyboard language: ");
 	if (nvram[7] < fieldsize(languages))
-		PRINT_PROC( "%s\n", languages[nvram[7]] );
+		PRINT_PROC("%s\n", languages[nvram[7]]);
 	else
-		PRINT_PROC( "%u (undefined)\n", nvram[7] );
-	PRINT_PROC( "Date format      : " );
-	PRINT_PROC( dateformat[nvram[8]&7],
-				nvram[9] ? nvram[9] : '/', nvram[9] ? nvram[9] : '/' );
-	PRINT_PROC( ", %dh clock\n", nvram[8] & 16 ? 24 : 12 );
-	PRINT_PROC( "Boot delay       : " );
+		PRINT_PROC("%u (undefined)\n", nvram[7]);
+	PRINT_PROC("Date format      : ");
+	PRINT_PROC(dateformat[nvram[8] & 7],
+	    nvram[9] ? nvram[9] : '/', nvram[9] ? nvram[9] : '/');
+	PRINT_PROC(", %dh clock\n", nvram[8] & 16 ? 24 : 12);
+	PRINT_PROC("Boot delay       : ");
 	if (nvram[10] == 0)
-		PRINT_PROC( "default" );
+		PRINT_PROC("default");
 	else
-		PRINT_PROC( "%ds%s\n", nvram[10],
-					nvram[10] < 8 ? ", no memory test" : "" );
+		PRINT_PROC("%ds%s\n", nvram[10],
+		    nvram[10] < 8 ? ", no memory test" : "");
 
 	vmode = (nvram[14] << 8) || nvram[15];
-	PRINT_PROC( "Video mode       : %s colors, %d columns, %s %s monitor\n",
-				colors[vmode & 7],
-				vmode & 8 ? 80 : 40,
-				vmode & 16 ? "VGA" : "TV",
-				vmode & 32 ? "PAL" : "NTSC" );
-	PRINT_PROC( "                   %soverscan, compat. mode %s%s\n",
-				vmode & 64 ? "" : "no ",
-				vmode & 128 ? "on" : "off",
-				vmode & 256 ?
-				  (vmode & 16 ? ", line doubling" : ", half screen") : "" );
-		
-	return( 1 );
+	PRINT_PROC("Video mode       : %s colors, %d columns, %s %s monitor\n",
+	    colors[vmode & 7],
+	    vmode & 8 ? 80 : 40,
+	    vmode & 16 ? "VGA" : "TV", vmode & 32 ? "PAL" : "NTSC");
+	PRINT_PROC("                   %soverscan, compat. mode %s%s\n",
+	    vmode & 64 ? "" : "no ",
+	    vmode & 128 ? "on" : "off",
+	    vmode & 256 ?
+	    (vmode & 16 ? ", line doubling" : ", half screen") : "");
+
+	return (1);
 }
 #endif
 
 #endif /* MACH == ATARI */
 
 MODULE_LICENSE("GPL");
-
-/*
- * Local variables:
- *  c-indent-level: 4
- *  tab-width: 4
- * End:
- */
-

--------------060908030307010807020500--

