Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263079AbRFEBmo>; Mon, 4 Jun 2001 21:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263080AbRFEBme>; Mon, 4 Jun 2001 21:42:34 -0400
Received: from tree1.Stanford.EDU ([171.64.15.228]:56502 "EHLO
	tree1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263079AbRFEBmR>; Mon, 4 Jun 2001 21:42:17 -0400
From: Dawson R Engler <engler@Stanford.EDU>
Message-Id: <200106050141.f551fbK08405@tree1.Stanford.EDU>
Subject: Re: [PATCH] fs/devfs/base.c
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 4 Jun 2001 18:41:37 -0700 (PDT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        aki.jain@Stanford.EDU (Akash Jain), alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, su.class.cs99q@nntp.stanford.edu
In-Reply-To: <E156o6c-0005AB-00@the-village.bc.nu> from "Alan Cox" at Jun 04, 2001 06:47:40 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have a very large number of violators of 1K of stack, and very few of 2K 
> right now.

Yeah, there's 25 that we know in 2.4.5-ac4 of that allocate a single
large var -- one of 4k, a few of 3k, looks like 8 of 2k, and then a tail
of 1Ks.  This isn't counting the functions that in aggregate have large
allocations, or have deep call chains.

Dawson

# BUGs	|	File Name
5	|	drivers/message/i2o/i2o_proc.c
4	|	drivers/cdrom/cdrom.c
2	|	net/irda/af_irda.c
1	|	fs/nfs/nfsroot.c
1	|	drivers/sound/emu10k1/audio.c
1	|	drivers/scsi/qlogicfc.c
1	|	arch/i386/kernel/nmi.c
1	|	drivers/net/wan/cycx_x25.c
1	|	drivers/block/cpqarray.c
1	|	drivers/media/video/w9966.c
1	|	arch/i386/kernel/setup.c
1	|	fs/devfs/base.c
1	|	drivers/net/ewrk3.c
1	|	net/wanrouter/wanmain.c
1	|	net/bridge/br_ioctl.c
1	|	drivers/cdrom/optcd.c
1	|	drivers/atm/iphase.c

#
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/emu10k1/audio.c:906:emu10k1_audio_ioctl: ERROR:VAR:906:906: suspicious var 'buf' = 4016 bytes:906 [nbytes=4016]

		break;

	case SNDCTL_COPR_LOAD:
		{

Error --->
			copr_buffer buf;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/message/i2o/i2o_proc.c:955:i2o_proc_read_drivers_stored: ERROR:VAR:955:955: suspicious var 'result' = 3596 bytes:955 [nbytes=3596]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		i2o_driver_store_table dst[MAX_I2O_MODULES];

Error --->
	} result;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/ewrk3.c:1639:ewrk3_ioctl: ERROR:VAR:1639:1639: suspicious var 'tmp' = 3072 bytes:1639 [nbytes=3072]
	int i, j, status = 0;
	u_char csr;
	union {
		u_char addr[HASH_TABLE_LEN * ETH_ALEN];
		u_short val[(HASH_TABLE_LEN * ETH_ALEN) >> 1];

Error --->
	} tmp;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/qlogicfc.c:867:isp2x00_make_portdb: ERROR:VAR:867:867: suspicious var 'temp' = 3072 bytes:867 [nbytes=3072]
static int isp2x00_make_portdb(struct Scsi_Host *host)
{

	short param[8];
	int i, j;

Error --->
	struct id_name_map temp[QLOGICFC_MAX_ID + 1];
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/message/i2o/i2o_proc.c:840:i2o_proc_read_ddm_table: ERROR:VAR:840:840: suspicious var 'result' = 2828 bytes:840 [nbytes=2828]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		i2o_exec_execute_ddm_table ddm_table[MAX_I2O_MODULES];

Error --->
	} result;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/cdrom/optcd.c:1625:cdromread: ERROR:VAR:1625:1625: suspicious var 'buf' = 2646 bytes:1625 [nbytes=2646]

static int cdromread(unsigned long arg, int blocksize, int cmd)
{
	int status;
	struct cdrom_msf msf;

Error --->
	char buf[CD_FRAMESIZE_RAWER];
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/message/i2o/i2o_proc.c:2261:i2o_proc_read_lan_mcast_addr: ERROR:VAR:2261:2261: suspicious var 'result' = 2060 bytes:2261 [nbytes=2060]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		u8  mc_addr[256][8];

Error --->
	} result;	
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/message/i2o/i2o_proc.c:1044:i2o_proc_read_groups: ERROR:VAR:1044:1044: suspicious var 'result' = 2060 bytes:1044 [nbytes=2060]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		i2o_group_info group[256];

Error --->
	} result;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/message/i2o/i2o_proc.c:2492:i2o_proc_read_lan_alt_addr: ERROR:VAR:2492:2492: suspicious var 'result' = 2060 bytes:2492 [nbytes=2060]
		u8  block_status;
		u8  error_info_size;
		u16 row_count;
		u16 more_flag;
		u8  alt_addr[256][8];

Error --->
	} result;	
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/media/video/w9966.c:921:w9966_v4l_read: ERROR:VAR:921:921: suspicious var 'tbuf' = 2048 bytes:921 [nbytes=2048]
	}
	
	while(dleft > 0)
	{
		unsigned long tsize = (dleft > W9966_RBUFFER) ? W9966_RBUFFER : dleft;

Error --->
		unsigned char tbuf[W9966_RBUFFER];
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/atm/iphase.c:2768:ia_ioctl: ERROR:VAR:2768:2768: suspicious var 'regs_local' = 2048 bytes:2768 [nbytes=2048]
             ia_cmds.status = 0;
             ia_cmds.len = 0x80;
             break;
          case MEMDUMP_FFL:
          {  

Error --->
             ia_regs_t       regs_local;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/arch/i386/kernel/setup.c:579:sanitize_e820_map: ERROR:VAR:579:579: function stack consumes 1840 bytes:579 [nbytes=1840]
			{
				if (overlap_list[i] == change_point[chgidx]->pbios)
					overlap_list[i] = overlap_list[overlap_entries-1];
			}
			overlap_entries--;

Error --->
		}
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/net/irda/af_irda.c:1743:irda_setsockopt: ERROR:VAR:1743:1743: suspicious var 'ias_opt' = 1356 bytes:1743 [nbytes=1356]
static int irda_setsockopt(struct socket *sock, int level, int optname, 
			   char *optval, int optlen)
{
 	struct sock *sk = sock->sk;
	struct irda_sock *self;

Error --->
	struct irda_ias_set	ias_opt;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/net/irda/af_irda.c:1981:irda_getsockopt: ERROR:VAR:1981:1981: suspicious var 'ias_opt' = 1356 bytes:1981 [nbytes=1356]
{
	struct sock *sk = sock->sk;
	struct irda_sock *self;
	struct irda_device_list list;
	struct irda_device_info *discoveries;

Error --->
	struct irda_ias_set	ias_opt;	/* IAS get/query params */
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/block/cpqarray.c:1196:ida_ioctl: ERROR:VAR:1196:1196: suspicious var 'my_io' = 1296 bytes:1196 [nbytes=1296]
	int dsk  = MINOR(inode->i_rdev) >> NWD_SHIFT;
	int error;
	int diskinfo[4];
	struct hd_geometry *geo = (struct hd_geometry *)arg;
	ida_ioctl_t *io = (ida_ioctl_t*)arg;

Error --->
	ida_ioctl_t my_io;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/net/wanrouter/wanmain.c:765:device_new_if: ERROR:VAR:765:765: suspicious var 'conf' = 1272 bytes:765 [nbytes=1272]
 *	o register network interface
 */

static int device_new_if (wan_device_t *wandev, wanif_conf_t *u_conf)
{

Error --->
	wanif_conf_t conf;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/fs/devfs/base.c:3155:devfsd_read: ERROR:VAR:3155:3155: suspicious var 'info' = 1056 bytes:3155 [nbytes=1056]
			    loff_t *ppos)
{
    int done = FALSE;
    int ival;
    loff_t pos, devname_offset, tlen, rpos;

Error --->
    struct devfsd_notify_struct info;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/cdrom/cdrom.c:815:cdrom_number_of_slots: ERROR:VAR:815:815: suspicious var 'info' = 1032 bytes:815 [nbytes=1032]
 */
int cdrom_number_of_slots(struct cdrom_device_info *cdi) 
{
	int status;
	int nslots = 1;

Error --->
	struct cdrom_changer_info info;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/cdrom/cdrom.c:1612:cdrom_ioctl: ERROR:VAR:1612:1612: suspicious var 'info' = 1032 bytes:1612 [nbytes=1032]
			cdi->options |= CDO_AUTO_CLOSE | CDO_AUTO_EJECT;
		return 0;
		}

	case CDROM_MEDIA_CHANGED: {

Error --->
		struct cdrom_changer_info info;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/cdrom/cdrom.c:791:cdrom_slot_status: ERROR:VAR:791:791: suspicious var 'info' = 1032 bytes:791 [nbytes=1032]
	return cdo->generic_packet(cdi, &cgc);
}

static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
{

Error --->
	struct cdrom_changer_info info;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/cdrom/cdrom.c:857:cdrom_select_disc: ERROR:VAR:857:857: suspicious var 'info' = 1032 bytes:857 [nbytes=1032]
	return cdi->ops->generic_packet(cdi, &cgc);
}

int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
{

Error --->
	struct cdrom_changer_info info;
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/arch/i386/kernel/nmi.c:47:check_nmi_watchdog: ERROR:VAR:47:47: suspicious var 'tmp' = 1024 bytes:47 [nbytes=1024]
#define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
#define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED

int __init check_nmi_watchdog (void)
{

Error --->
	irq_cpustat_t tmp[NR_CPUS];
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/net/bridge/br_ioctl.c:86:br_ioctl_device: ERROR:VAR:86:86: suspicious var 'indices' = 1024 bytes:86 [nbytes=1024]
	}

	case BRCTL_GET_PORT_LIST:
	{
		int i;

Error --->
		int indices[256];
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/fs/nfs/nfsroot.c:238:root_nfs_name: ERROR:VAR:238:238: suspicious var 'buf' = 1024 bytes:238 [nbytes=1024]
/*
 *  Prepare the NFS data structure and parse all options.
 */
static int __init root_nfs_name(char *name)
{

Error --->
	char buf[NFS_MAXPATHLEN];
---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/wan/cycx_x25.c:983:hex_dump: ERROR:VAR:983:983: suspicious var 'hex' = 1024 bytes:983 [nbytes=1024]
			 card->devname, cmd->command);
}
#ifdef CYCLOMX_X25_DEBUG
static void hex_dump(char *msg, unsigned char *p, int len)
{

Error --->
	unsigned char hex[1024],

