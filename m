Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316531AbSFJD6u>; Sun, 9 Jun 2002 23:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSFJD5s>; Sun, 9 Jun 2002 23:57:48 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:23188 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S316531AbSFJD43>;
	Sun, 9 Jun 2002 23:56:29 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200206100356.UAA17066@csl.Stanford.EDU>
Subject: [CHECKER] 37 stack variables >= 1K in 2.4.17
To: linux-kernel@vger.kernel.org
Date: Sun, 9 Jun 2002 20:56:30 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 37 errors where variables >= 1024 bytes are allocated on a function's
stack.

Dawson

# BUGs	|	File Name
4	|	/drivers/cdrom.c
4	|	/message/i2o_proc.c
3	|	/net/airo.c
3	|	/../inflate.c
2	|	/fs/zlib.c
2	|	/drivers/zlib.c
2	|	/drivers/cpqfcTScontrol.c
2	|	/fs/compr_rtime.c
1	|	/char/sidewinder.c
1	|	/drivers/ide-cs.c
1	|	/drivers/iphase.c
1	|	/drivers/ixj_pcmcia.c
1	|	/i386/nmi.c
1	|	/drivers/parport_cs.c
1	|	/net/br_ioctl.c
1	|	/drivers/qlogicfc.c
1	|	/drivers/cpqarray.c
1	|	/drivers/optcd.c
1	|	/net/wanmain.c
1	|	/i386/setup.c
1	|	/fs/nfsroot.c
1	|	/net/cycx_x25.c
1	|	/fs/ioctl.c


############################################################
# 2.4.17 specific errors

#
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/qlogicfc.c:840:isp2x00_make_portdb: ERROR:VAR:840:840: suspicious var 'temp' = 3072 bytes:840 [nbytes=3072]
static int isp2x00_make_portdb(struct Scsi_Host *host)
{

	short param[8];
	int i, j;

Error --->
	struct id_name_map temp[QLOGICFC_MAX_ID + 1];
	struct isp2x00_hostdata *hostdata;

	isp2x00_disable_irqs(host);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/message/i2o/i2o_proc.c:838:i2o_proc_read_ddm_table: ERROR:VAR:838:838: suspicious var 'result' = 2828 bytes:838 [nbytes=2828]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		i2o_exec_execute_ddm_table ddm_table[MAX_I2O_MODULES];

Error --->
	} result;

	i2o_exec_execute_ddm_table ddm_table;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/cdrom/optcd.c:1625:cdromread: ERROR:VAR:1625:1625: suspicious var 'buf' = 2646 bytes:1625 [nbytes=2646]

static int cdromread(unsigned long arg, int blocksize, int cmd)
{
	int status;
	struct cdrom_msf msf;

Error --->
	char buf[CD_FRAMESIZE_RAWER];

	status = verify_area(VERIFY_WRITE, (void *) arg, blocksize);
	if (status)
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/message/i2o/i2o_proc.c:2266:i2o_proc_read_lan_mcast_addr: ERROR:VAR:2266:2266: suspicious var 'result' = 2060 bytes:2266 [nbytes=2060]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		u8  mc_addr[256][8];

Error --->
	} result;	

	spin_lock(&i2o_proc_lock);	
	len = 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/message/i2o/i2o_proc.c:2497:i2o_proc_read_lan_alt_addr: ERROR:VAR:2497:2497: suspicious var 'result' = 2060 bytes:2497 [nbytes=2060]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		u8  alt_addr[256][8];

Error --->
	} result;	

	spin_lock(&i2o_proc_lock);	
	len = 0;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/message/i2o/i2o_proc.c:1049:i2o_proc_read_groups: ERROR:VAR:1049:1049: suspicious var 'result' = 2060 bytes:1049 [nbytes=2060]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		i2o_group_info group[256];

Error --->
	} result;

	spin_lock(&i2o_proc_lock);

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/cpqfcTScontrol.c:721:CpqTsProcessIMQEntry: ERROR:VAR:721:721: suspicious var 'ulFibreFrame' = 2048 bytes:721 [nbytes=2048]
  int iStatus;
  USHORT i, RPCset, DPCset;
  ULONG x_ID;
  ULONG ulBuff, dwStatus;
  TachFCHDR_GCMND* fchs;

Error --->
  ULONG ulFibreFrame[2048/4];  // max number of DWORDS in incoming Fibre Frame
  UCHAR ucInboundMessageType;  // Inbound CM, dword 3 "type" field

  ENTER("ProcessIMQEntry");
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/atm/iphase.c:2772:ia_ioctl: ERROR:VAR:2772:2772: suspicious var 'regs_local' = 2048 bytes:2772 [nbytes=2048]
             ia_cmds.status = 0;
             ia_cmds.len = 0x80;
             break;
          case MEMDUMP_FFL:
          {  

Error --->
             ia_regs_t       regs_local;
             ffredn_t        *ffL = &regs_local.ffredn;
             rfredn_t        *rfL = &regs_local.rfredn;
                     
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/wireless/airo.c:4316:readrids: ERROR:VAR:4316:4316: suspicious var 'iobuf' = 2048 bytes:4316 [nbytes=2048]
 * as needed.  This represents the READ side of control I/O to
 * the card
 */
static int readrids(struct net_device *dev, aironet_ioctl *comp) {
	unsigned short ridcode;

Error --->
	unsigned char iobuf[2048];

	switch(comp->command)
	{
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/wireless/airo.c:4364:writerids: ERROR:VAR:4364:4364: suspicious var 'iobuf' = 2048 bytes:4364 [nbytes=2048]

static int writerids(struct net_device *dev, aironet_ioctl *comp) {
	int  ridcode;
	Resp      rsp;
	static int (* writer)(struct airo_info *, u16 rid, const void *, int);

Error --->
	unsigned char iobuf[2048];

	/* Only super-user can write RIDs */
	if (!capable(CAP_NET_ADMIN))
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/scsi/cpqfcTScontrol.c:610:PeekIMQEntry: ERROR:VAR:610:610: suspicious var 'ulFibreFrame' = 2048 bytes:610 [nbytes=2048]
      // If we find it, check the incoming frame payload (1st word)
      // for LILP frame
        if( (fcChip->IMQ->QEntry[CI].type & 0x1FF) == 0x104 )
        { 
          TachFCHDR_GCMND* fchs;

Error --->
          ULONG ulFibreFrame[2048/4];  // max DWORDS in incoming FC Frame
	  USHORT SFQpi = (USHORT)(fcChip->IMQ->QEntry[CI].word[0] & 0x0fffL);

	  CpqTsGetSFQEntry( fcChip,
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/arch/i386/kernel/setup.c:519:sanitize_e820_map: ERROR:VAR:519:519: function stack consumes 1840 bytes:519 [nbytes=1840]
		   ______________________4_
	*/

	/* if there's only one memory region, don't bother */
	if (*pnr_map < 2)

Error --->
		return -1;

	old_nr = *pnr_map;

---------------------------------------------------------
[BUG] *think* so
/u2/engler/mc/oses/linux/2.4.17/fs/umsdos/ioctl.c:96:UMSDOS_ioctl_dir: ERROR:VAR:96:96: function stack consumes 1772 bytes:96 [nbytes=1772]
	    && cmd != UMSDOS_UNLINK_EMD
	    && cmd != UMSDOS_UNLINK_DOS
	    && cmd != UMSDOS_RMDIR_DOS
	    && cmd != UMSDOS_STAT_DOS
	    && cmd != UMSDOS_DOS_SETUP)

Error --->
		return fat_dir_ioctl (dir, filp, cmd, data_ptr);

	/* #Specification: ioctl / access
	 * Only root (effective id) is allowed to do IOCTL on directory
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/wireless/airo.c:3319:airo_ioctl: ERROR:VAR:3319:3319: function stack consumes 1676 bytes:3319 [nbytes=1676]
#endif /* CISCO_EXT */
	{
		/* If the command read some stuff, we better get it out of
		 * the card first... */
		if(IW_IS_GET(cmd))

Error --->
			readStatusRid(local, &status_rid);
		if(IW_IS_GET(cmd) || (cmd == SIOCSIWRATE) || (cmd == SIOCSIWENCODE))
			readCapabilityRid(local, &cap_rid);
		/* Get config in all cases, because SET will just modify it */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/block/cpqarray.c:1188:ida_ioctl: ERROR:VAR:1188:1188: suspicious var 'my_io' = 1296 bytes:1188 [nbytes=1296]
	int dsk  = MINOR(inode->i_rdev) >> NWD_SHIFT;
	int error;
	int diskinfo[4];
	struct hd_geometry *geo = (struct hd_geometry *)arg;
	ida_ioctl_t *io = (ida_ioctl_t*)arg;

Error --->
	ida_ioctl_t my_io;

	switch(cmd) {
	case HDIO_GETGEO:
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/net/wanrouter/wanmain.c:754:device_new_if: ERROR:VAR:754:754: suspicious var 'conf' = 1272 bytes:754 [nbytes=1272]
 *	o register network interface
 */

static int device_new_if (wan_device_t *wandev, wanif_conf_t *u_conf)
{

Error --->
	wanif_conf_t conf;
	netdevice_t *dev=NULL;
#ifdef CONFIG_WANPIPE_MULTPPP
	struct ppp_device *pppdev=NULL;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/block/../../lib/inflate.c:750:inflate_dynamic: ERROR:VAR:750:750: suspicious var 'll' = 1264 bytes:750 [nbytes=1264]
  unsigned nl;          /* number of literal/length codes */
  unsigned nd;          /* number of distance codes */
#ifdef PKZIP_BUG_WORKAROUND
  unsigned ll[288+32];  /* literal/length and distance code lengths */
#else

Error --->
  unsigned ll[286+30];  /* literal/length and distance code lengths */
#endif
  register ulg b;       /* bit buffer */
  register unsigned k;  /* number of bits in bit buffer */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/zlib.c:4216:huft_build: ERROR:VAR:4216:4216: suspicious var 'v' = 1152 bytes:4216 [nbytes=1152]
  int l;                        /* bits per table (returned in m) */
  register uIntf *p;            /* pointer into c[], b[], or v[] */
  inflate_huft *q;              /* points to current table */
  struct inflate_huft_s r;      /* table entry for structure assignment */
  inflate_huft *u[BMAX];        /* table stack */

Error --->
  uInt v[N_MAX];                /* values in order of bit length */
  register int w;               /* bits before this table == (l * h) */
  uInt x[BMAX+1];               /* bit offsets, then code stack */
  uIntf *xp;                    /* pointer into x */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/fs/jffs2/zlib.c:4501:inflate_trees_fixed: ERROR:VAR:4501:4501: suspicious var 'c' = 1152 bytes:4501 [nbytes=1152]
{
  /* build fixed tables if not already (multiple overlapped executions ok) */
  if (!fixed_built)
  {
    int k;              /* temporary variable */

Error --->
    unsigned c[288];    /* length list for huft_build */
    z_stream z;         /* for falloc function */
    int f = FIXEDH;     /* number of hufts left in fixed_mem */

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/fs/jffs2/zlib.c:4216:huft_build: ERROR:VAR:4216:4216: suspicious var 'v' = 1152 bytes:4216 [nbytes=1152]
  int l;                        /* bits per table (returned in m) */
  register uIntf *p;            /* pointer into c[], b[], or v[] */
  inflate_huft *q;              /* points to current table */
  struct inflate_huft_s r;      /* table entry for structure assignment */
  inflate_huft *u[BMAX];        /* table stack */

Error --->
  uInt v[N_MAX];                /* values in order of bit length */
  register int w;               /* bits before this table == (l * h) */
  uInt x[BMAX+1];               /* bit offsets, then code stack */
  uIntf *xp;                    /* pointer into x */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/block/../../lib/inflate.c:688:inflate_fixed: ERROR:VAR:688:688: suspicious var 'l' = 1152 bytes:688 [nbytes=1152]
  int i;                /* temporary variable */
  struct huft *tl;      /* literal/length code table */
  struct huft *td;      /* distance code table */
  int bl;               /* lookup bits for tl */
  int bd;               /* lookup bits for td */

Error --->
  unsigned l[288];      /* length list for huft_build */

DEBG("<fix");

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/block/../../lib/inflate.c:301:huft_build: ERROR:VAR:301:301: suspicious var 'v' = 1152 bytes:301 [nbytes=1152]
  int l;                        /* bits per table (returned in m) */
  register unsigned *p;         /* pointer into c[], b[], or v[] */
  register struct huft *q;      /* points to current table */
  struct huft r;                /* table entry for structure assignment */
  struct huft *u[BMAX];         /* table stack */

Error --->
  unsigned v[N_MAX];            /* values in order of bit length */
  register int w;               /* bits before this table == (l * h) */
  unsigned x[BMAX+1];           /* bit offsets, then code stack */
  unsigned *xp;                 /* pointer into x */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/zlib.c:4501:inflate_trees_fixed: ERROR:VAR:4501:4501: suspicious var 'c' = 1152 bytes:4501 [nbytes=1152]
{
  /* build fixed tables if not already (multiple overlapped executions ok) */
  if (!fixed_built)
  {
    int k;              /* temporary variable */

Error --->
    unsigned c[288];    /* length list for huft_build */
    z_stream z;         /* for falloc function */
    int f = FIXEDH;     /* number of hufts left in fixed_mem */

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/ide/ide-cs.c:247:ide_config: ERROR:VAR:367:367: function stack consumes 1148 bytes:367 [nbytes=1148]
	   link->conf.Vpp1/10, link->conf.Vpp1%10);

    link->state &= ~DEV_CONFIG_PENDING;
    return;
    

Error --->
cs_failed:
    cs_error(link->handle, last_fn, last_ret);
failed:
    ide_release((u_long)link);
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/parport/parport_cs.c:252:parport_config: ERROR:VAR:327:327: function stack consumes 1136 bytes:327 [nbytes=1136]
    printk("]\n");
    
    link->state &= ~DEV_CONFIG_PENDING;
    return;
    

Error --->
cs_failed:
    cs_error(link->handle, last_fn, last_ret);
failed:
    parport_cs_release((u_long)link);
---------------------------------------------------------
[BUG]  this function just keeps showing up...
/u2/engler/mc/oses/linux/2.4.17/drivers/telephony/ixj_pcmcia.c:221:ixj_config: ERROR:VAR:266:266: function stack consumes 1132 bytes:266 [nbytes=1132]
	info->node.major = PHONE_MAJOR;
	link->dev = &info->node;
	ixj_get_serial(link, j);
	link->state &= ~DEV_CONFIG_PENDING;
	return;

Error --->
      cs_failed:
	cs_error(link->handle, last_fn, last_ret);
	ixj_cs_release((u_long) link);
}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/char/joystick/sidewinder.c:572:sw_connect: ERROR:VAR:572:572: function stack consumes 1093 bytes:572 [nbytes=1093]
	unsigned char m = 1;
	char comment[40];

	comment[0] = 0;


Error --->
	if (!(sw = kmalloc(sizeof(struct sw), GFP_KERNEL))) return;
	memset(sw, 0, sizeof(struct sw));

	gameport->private = sw;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/cdrom/cdrom.c:738:cdrom_number_of_slots: ERROR:VAR:738:738: suspicious var 'info' = 1032 bytes:738 [nbytes=1032]
 */
int cdrom_number_of_slots(struct cdrom_device_info *cdi) 
{
	int status;
	int nslots = 1;

Error --->
	struct cdrom_changer_info info;

	cdinfo(CD_CHANGER, "entering cdrom_number_of_slots()\n"); 
	/* cdrom_read_mech_status requires a valid value for capacity: */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/cdrom/cdrom.c:780:cdrom_select_disc: ERROR:VAR:780:780: suspicious var 'info' = 1032 bytes:780 [nbytes=1032]
	return cdi->ops->generic_packet(cdi, &cgc);
}

int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
{

Error --->
	struct cdrom_changer_info info;
	int curslot;
	int ret;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/cdrom/cdrom.c:1526:cdrom_ioctl: ERROR:VAR:1526:1526: suspicious var 'info' = 1032 bytes:1526 [nbytes=1032]
			cdi->options |= CDO_AUTO_CLOSE | CDO_AUTO_EJECT;
		return 0;
		}

	case CDROM_MEDIA_CHANGED: {

Error --->
		struct cdrom_changer_info info;

		cdinfo(CD_DO_IOCTL, "entering CDROM_MEDIA_CHANGED\n"); 
		if (!CDROM_CAN(CDC_MEDIA_CHANGED))
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/cdrom/cdrom.c:714:cdrom_slot_status: ERROR:VAR:714:714: suspicious var 'info' = 1032 bytes:714 [nbytes=1032]
	return cdo->generic_packet(cdi, &cgc);
}

static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
{

Error --->
	struct cdrom_changer_info info;
	int ret;

	cdinfo(CD_CHANGER, "entering cdrom_slot_status()\n"); 
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/fs/jffs2/compr_rtime.c:97:rtime_decompress: ERROR:VAR:97:97: suspicious var 'positions' = 1024 bytes:97 [nbytes=1024]


void rtime_decompress(unsigned char *data_in, unsigned char *cpage_out,
		      __u32 srclen, __u32 destlen)
{

Error --->
	int positions[256];
	int outpos = 0;
	int pos=0;
	
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/fs/nfs/nfsroot.c:238:root_nfs_name: ERROR:VAR:238:238: suspicious var 'buf' = 1024 bytes:238 [nbytes=1024]
/*
 *  Prepare the NFS data structure and parse all options.
 */
static int __init root_nfs_name(char *name)
{

Error --->
	char buf[NFS_MAXPATHLEN];
	char *cp;

	/* Set some default values */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/drivers/net/wan/cycx_x25.c:983:hex_dump: ERROR:VAR:983:983: suspicious var 'hex' = 1024 bytes:983 [nbytes=1024]
			 card->devname, cmd->command);
}
#ifdef CYCLOMX_X25_DEBUG
static void hex_dump(char *msg, unsigned char *p, int len)
{

Error --->
	unsigned char hex[1024],
	    	* phex = hex;

	if (len >= (sizeof(hex) / 2))
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/fs/jffs2/compr_rtime.c:57:rtime_compress: ERROR:VAR:57:57: suspicious var 'positions' = 1024 bytes:57 [nbytes=1024]

/* _compress returns the compressed size, -1 if bigger */
int rtime_compress(unsigned char *data_in, unsigned char *cpage_out, 
		   __u32 *sourcelen, __u32 *dstlen)
{

Error --->
	int positions[256];
	int outpos = 0;
	int pos=0;

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/arch/i386/kernel/nmi.c:48:check_nmi_watchdog: ERROR:VAR:48:48: suspicious var 'tmp' = 1024 bytes:48 [nbytes=1024]
#define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
#define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED

int __init check_nmi_watchdog (void)
{

Error --->
	irq_cpustat_t tmp[NR_CPUS];
	int j, cpu;

	printk(KERN_INFO "testing NMI watchdog ... ");
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.17/net/bridge/br_ioctl.c:86:br_ioctl_device: ERROR:VAR:86:86: suspicious var 'indices' = 1024 bytes:86 [nbytes=1024]
	}

	case BRCTL_GET_PORT_LIST:
	{
		int i;

Error --->
		int indices[256];

		for (i=0;i<256;i++)
			indices[i] = 0;

