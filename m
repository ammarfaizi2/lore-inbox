Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbREXVKa>; Thu, 24 May 2001 17:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262297AbREXVKM>; Thu, 24 May 2001 17:10:12 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:4829 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262296AbREXVKC>;
	Thu, 24 May 2001 17:10:02 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105242110.OAA29766@csl.Stanford.EDU>
Subject: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
To: linux-kernel@vger.kernel.org
Date: Thu, 24 May 2001 14:10:00 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here are 37 errors where variables >= 1024 bytes are allocated on a function's
stack.

	Summary for 
		2.4.4ac8-specific errors          = 9
		2.4.4-specific errors 		  = 0
		Common errors 		      	  = 28
		Total 				  = 37

Dawson

# BUGs	|	File Name
5	|	drivers/message/i2o/i2o_proc.c
4	|	drivers/cdrom/cdrom.c
3	|	drivers/block/../../lib/inflate.c
3	|	drivers/acpi/ospm/busmgr/bmpm.c
2	|	drivers/acpi/ospm/busmgr/bmdriver.c
2	|	net/irda/af_irda.c
2	|	fs/jffs2/compr_rtime.c
1	|	drivers/sound/emu10k1/audio.c
1	|	fs/jffs2/zlib.c
1	|	drivers/scsi/qlogicfc.c
1	|	arch/i386/kernel/nmi.c
1	|	drivers/net/wan/cycx_x25.c
1	|	drivers/media/video/w9966.c
1	|	drivers/block/cpqarray.c
1	|	fs/ntfs/super.c
1	|	fs/nfs/nfsroot.c
1	|	arch/i386/kernel/setup.c
1	|	drivers/net/zlib.c
1	|	fs/devfs/base.c
1	|	drivers/net/ewrk3.c
1	|	net/wanrouter/wanmain.c
1	|	net/bridge/br_ioctl.c
1	|	drivers/atm/iphase.c

############################################################
# 2.4.4ac8 specific errors
#
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/media/video/w9966.c:921:w9966_v4l_read: ERROR:VAR:921:921: suspicious var 'tbuf' = 2048 bytes:921 [nbytes=2048]
	}
	
	while(dleft > 0)
	{
		unsigned long tsize = (dleft > W9966_RBUFFER) ? W9966_RBUFFER : dleft;

Error --->
		unsigned char tbuf[W9966_RBUFFER];
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/acpi/ospm/busmgr/bmpm.c:57:bm_get_inferred_power_state: ERROR:VAR:57:57: suspicious var 'pr_list' = 1028 bytes:57 [nbytes=1028]
ACPI_STATUS
bm_get_inferred_power_state (
	BM_DEVICE               *device)
{
	ACPI_STATUS             status = AE_OK;

Error --->
	BM_HANDLE_LIST          pr_list;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/acpi/ospm/busmgr/bmpm.c:205:bm_set_power_state: ERROR:VAR:205:205: suspicious var 'target_list' = 1028 bytes:205 [nbytes=1028]
{
	ACPI_STATUS             status = AE_OK;
	BM_DEVICE		*device = NULL;
	BM_DEVICE		*parent_device = NULL;
	BM_HANDLE_LIST          current_list;

Error --->
	BM_HANDLE_LIST          target_list;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/acpi/ospm/busmgr/bmpm.c:204:bm_set_power_state: ERROR:VAR:204:204: suspicious var 'current_list' = 1028 bytes:204 [nbytes=1028]
	BM_POWER_STATE          state)
{
	ACPI_STATUS             status = AE_OK;
	BM_DEVICE		*device = NULL;
	BM_DEVICE		*parent_device = NULL;

Error --->
	BM_HANDLE_LIST          current_list;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/acpi/ospm/busmgr/bmdriver.c:323:bm_register_driver: ERROR:VAR:323:323: suspicious var 'device_list' = 1028 bytes:323 [nbytes=1028]
bm_register_driver (
	BM_DEVICE_ID		*criteria,
	BM_DRIVER		*driver)
{
	ACPI_STATUS             status = AE_NOT_FOUND;

Error --->
	BM_HANDLE_LIST          device_list;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/acpi/ospm/busmgr/bmdriver.c:407:bm_unregister_driver: ERROR:VAR:407:407: suspicious var 'device_list' = 1028 bytes:407 [nbytes=1028]
bm_unregister_driver (
	BM_DEVICE_ID		*criteria,
	BM_DRIVER		*driver)
{
	ACPI_STATUS             status = AE_NOT_FOUND;

Error --->
	BM_HANDLE_LIST          device_list;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/arch/i386/kernel/nmi.c:47:check_nmi_watchdog: ERROR:VAR:47:47: suspicious var 'tmp' = 1024 bytes:47 [nbytes=1024]
#define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
#define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED

int __init check_nmi_watchdog (void)
{

Error --->
	irq_cpustat_t tmp[NR_CPUS];
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/jffs2/compr_rtime.c:97:rtime_decompress: ERROR:VAR:97:97: suspicious var 'positions' = 1024 bytes:97 [nbytes=1024]


void rtime_decompress(unsigned char *data_in, unsigned char *cpage_out,
		      __u32 srclen, __u32 destlen)
{

Error --->
	int positions[256];
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/jffs2/compr_rtime.c:57:rtime_compress: ERROR:VAR:57:57: suspicious var 'positions' = 1024 bytes:57 [nbytes=1024]

/* _compress returns the compressed size, -1 if bigger */
int rtime_compress(unsigned char *data_in, unsigned char *cpage_out, 
		   __u32 *sourcelen, __u32 *dstlen)
{

Error --->
	int positions[256];


############################################################
# errors common to both

#
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/sound/emu10k1/audio.c:906:emu10k1_audio_ioctl: ERROR:VAR:906:906: suspicious var 'buf' = 4016 bytes:906 [nbytes=4016]

		break;

	case SNDCTL_COPR_LOAD:
		{

Error --->
			copr_buffer buf;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/message/i2o/i2o_proc.c:955:i2o_proc_read_drivers_stored: ERROR:VAR:955:955: suspicious var 'result' = 3596 bytes:955 [nbytes=3596]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		i2o_driver_store_table dst[MAX_I2O_MODULES];

Error --->
	} result;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/ewrk3.c:1639:ewrk3_ioctl: ERROR:VAR:1639:1639: suspicious var 'tmp' = 3072 bytes:1639 [nbytes=3072]
	int i, j, status = 0;
	u_char csr;
	union {
		u_char addr[HASH_TABLE_LEN * ETH_ALEN];
		u_short val[(HASH_TABLE_LEN * ETH_ALEN) >> 1];

Error --->
	} tmp;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/qlogicfc.c:867:isp2x00_make_portdb: ERROR:VAR:867:867: suspicious var 'temp' = 3072 bytes:867 [nbytes=3072]
static int isp2x00_make_portdb(struct Scsi_Host *host)
{

	short param[8];
	int i, j;

Error --->
	struct id_name_map temp[QLOGICFC_MAX_ID + 1];
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/message/i2o/i2o_proc.c:840:i2o_proc_read_ddm_table: ERROR:VAR:840:840: suspicious var 'result' = 2828 bytes:840 [nbytes=2828]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		i2o_exec_execute_ddm_table ddm_table[MAX_I2O_MODULES];

Error --->
	} result;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/message/i2o/i2o_proc.c:1044:i2o_proc_read_groups: ERROR:VAR:1044:1044: suspicious var 'result' = 2060 bytes:1044 [nbytes=2060]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		i2o_group_info group[256];

Error --->
	} result;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/message/i2o/i2o_proc.c:2261:i2o_proc_read_lan_mcast_addr: ERROR:VAR:2261:2261: suspicious var 'result' = 2060 bytes:2261 [nbytes=2060]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		u8  mc_addr[256][8];

Error --->
	} result;	
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/message/i2o/i2o_proc.c:2492:i2o_proc_read_lan_alt_addr: ERROR:VAR:2492:2492: suspicious var 'result' = 2060 bytes:2492 [nbytes=2060]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		u8  alt_addr[256][8];

Error --->
	} result;	
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/atm/iphase.c:2766:ia_ioctl: ERROR:VAR:2766:2766: suspicious var 'regs_local' = 2048 bytes:2766 [nbytes=2048]
             ia_cmds.status = 0;
             ia_cmds.len = 0x80;
             break;
          case MEMDUMP_FFL:
          {  

Error --->
             ia_regs_t       regs_local;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/ntfs/super.c:352:ntfs_get_free_cluster_count: ERROR:VAR:352:352: suspicious var 'bits' = 2048 bytes:352 [nbytes=2048]

static int nc[16]={4,3,3,2,3,2,2,1,3,2,2,1,2,1,1,0};

int ntfs_get_free_cluster_count(ntfs_inode *bitmap)
{

Error --->
	unsigned char bits[2048];
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/arch/i386/kernel/setup.c:576:sanitize_e820_map: ERROR:VAR:576:576: function stack consumes 1840 bytes:576 [nbytes=1840]
			{
				if (overlap_list[i] == change_point[chgidx]->pbios)
					overlap_list[i] = overlap_list[overlap_entries-1];
			}
			overlap_entries--;

Error --->
		}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/net/irda/af_irda.c:1981:irda_getsockopt: ERROR:VAR:1981:1981: suspicious var 'ias_opt' = 1356 bytes:1981 [nbytes=1356]
{
	struct sock *sk = sock->sk;
	struct irda_sock *self;
	struct irda_device_list list;
	struct irda_device_info *discoveries;

Error --->
	struct irda_ias_set	ias_opt;	/* IAS get/query params */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/net/irda/af_irda.c:1743:irda_setsockopt: ERROR:VAR:1743:1743: suspicious var 'ias_opt' = 1356 bytes:1743 [nbytes=1356]
static int irda_setsockopt(struct socket *sock, int level, int optname, 
			   char *optval, int optlen)
{
 	struct sock *sk = sock->sk;
	struct irda_sock *self;

Error --->
	struct irda_ias_set	ias_opt;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/block/cpqarray.c:1196:ida_ioctl: ERROR:VAR:1196:1196: suspicious var 'my_io' = 1296 bytes:1196 [nbytes=1296]
	int dsk  = MINOR(inode->i_rdev) >> NWD_SHIFT;
	int error;
	int diskinfo[4];
	struct hd_geometry *geo = (struct hd_geometry *)arg;
	ida_ioctl_t *io = (ida_ioctl_t*)arg;

Error --->
	ida_ioctl_t my_io;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/net/wanrouter/wanmain.c:765:device_new_if: ERROR:VAR:765:765: suspicious var 'conf' = 1272 bytes:765 [nbytes=1272]
 *	o register network interface
 */

static int device_new_if (wan_device_t *wandev, wanif_conf_t *u_conf)
{

Error --->
	wanif_conf_t conf;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/block/../../lib/inflate.c:750:inflate_dynamic: ERROR:VAR:750:750: suspicious var 'll' = 1264 bytes:750 [nbytes=1264]
  unsigned nl;          /* number of literal/length codes */
  unsigned nd;          /* number of distance codes */
#ifdef PKZIP_BUG_WORKAROUND
  unsigned ll[288+32];  /* literal/length and distance code lengths */
#else

Error --->
  unsigned ll[286+30];  /* literal/length and distance code lengths */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/zlib.c:4501:inflate_trees_fixed: ERROR:VAR:4501:4501: suspicious var 'c' = 1152 bytes:4501 [nbytes=1152]
{
  /* build fixed tables if not already (multiple overlapped executions ok) */
  if (!fixed_built)
  {
    int k;              /* temporary variable */

Error --->
    unsigned c[288];    /* length list for huft_build */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/block/../../lib/inflate.c:688:inflate_fixed: ERROR:VAR:688:688: suspicious var 'l' = 1152 bytes:688 [nbytes=1152]
  int i;                /* temporary variable */
  struct huft *tl;      /* literal/length code table */
  struct huft *td;      /* distance code table */
  int bl;               /* lookup bits for tl */
  int bd;               /* lookup bits for td */

Error --->
  unsigned l[288];      /* length list for huft_build */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/block/../../lib/inflate.c:301:huft_build: ERROR:VAR:301:301: suspicious var 'v' = 1152 bytes:301 [nbytes=1152]
  int l;                        /* bits per table (returned in m) */
  register unsigned *p;         /* pointer into c[], b[], or v[] */
  register struct huft *q;      /* points to current table */
  struct huft r;                /* table entry for structure assignment */
  struct huft *u[BMAX];         /* table stack */

Error --->
  unsigned v[N_MAX];            /* values in order of bit length */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/jffs2/zlib.c:4216:huft_build: ERROR:VAR:4216:4216: suspicious var 'v' = 1152 bytes:4216 [nbytes=1152]
  int l;                        /* bits per table (returned in m) */
  register uIntf *p;            /* pointer into c[], b[], or v[] */
  inflate_huft *q;              /* points to current table */
  struct inflate_huft_s r;      /* table entry for structure assignment */
  inflate_huft *u[BMAX];        /* table stack */

Error --->
  uInt v[N_MAX];                /* values in order of bit length */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/devfs/base.c:3154:devfsd_read: ERROR:VAR:3154:3154: suspicious var 'info' = 1056 bytes:3154 [nbytes=1056]
			    loff_t *ppos)
{
    int done = FALSE;
    int ival;
    loff_t pos, devname_offset, tlen, rpos;

Error --->
    struct devfsd_notify_struct info;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/cdrom/cdrom.c:815:cdrom_number_of_slots: ERROR:VAR:815:815: suspicious var 'info' = 1032 bytes:815 [nbytes=1032]
 */
int cdrom_number_of_slots(struct cdrom_device_info *cdi) 
{
	int status;
	int nslots = 1;

Error --->
	struct cdrom_changer_info info;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/cdrom/cdrom.c:857:cdrom_select_disc: ERROR:VAR:857:857: suspicious var 'info' = 1032 bytes:857 [nbytes=1032]
	return cdi->ops->generic_packet(cdi, &cgc);
}

int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
{

Error --->
	struct cdrom_changer_info info;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/cdrom/cdrom.c:1612:cdrom_ioctl: ERROR:VAR:1612:1612: suspicious var 'info' = 1032 bytes:1612 [nbytes=1032]
			cdi->options |= CDO_AUTO_CLOSE | CDO_AUTO_EJECT;
		return 0;
		}

	case CDROM_MEDIA_CHANGED: {

Error --->
		struct cdrom_changer_info info;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/cdrom/cdrom.c:791:cdrom_slot_status: ERROR:VAR:791:791: suspicious var 'info' = 1032 bytes:791 [nbytes=1032]
	return cdo->generic_packet(cdi, &cgc);
}

static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
{

Error --->
	struct cdrom_changer_info info;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/fs/nfs/nfsroot.c:238:root_nfs_name: ERROR:VAR:238:238: suspicious var 'buf' = 1024 bytes:238 [nbytes=1024]
/*
 *  Prepare the NFS data structure and parse all options.
 */
static int __init root_nfs_name(char *name)
{

Error --->
	char buf[NFS_MAXPATHLEN];
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/wan/cycx_x25.c:983:hex_dump: ERROR:VAR:983:983: suspicious var 'hex' = 1024 bytes:983 [nbytes=1024]
			 card->devname, cmd->command);
}
#ifdef CYCLOMX_X25_DEBUG
static void hex_dump(char *msg, unsigned char *p, int len)
{

Error --->
	unsigned char hex[1024],
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.4-ac8/net/bridge/br_ioctl.c:86:br_ioctl_device: ERROR:VAR:86:86: suspicious var 'indices' = 1024 bytes:86 [nbytes=1024]
	}

	case BRCTL_GET_PORT_LIST:
	{
		int i;

Error --->
		int indices[256];

