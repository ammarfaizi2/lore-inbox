Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262498AbREXXK1>; Thu, 24 May 2001 19:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262501AbREXXKH>; Thu, 24 May 2001 19:10:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:521 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262498AbREXXKC>; Thu, 24 May 2001 19:10:02 -0400
Subject: Re: [CHECKER] error path memory leaks in 2.4.4 and 2.4.4-ac8
To: engler@csl.Stanford.EDU (Dawson Engler)
Date: Fri, 25 May 2001 00:07:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <200105242107.OAA29730@csl.Stanford.EDU> from "Dawson Engler" at May 24, 2001 02:07:35 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1534C7-0005lu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [BUG]
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/block/cciss.c:613:cciss_ioctl: ERROR:INVERSE:605:613: UNREVERSED 'buff' on error path! set by 'kmalloc':605 [nbytes=1] [rank=easy] [type=SECURITY]
> 		/* Check kmalloc limits */

Real

> /u2/engler/mc/oses/linux/2.4.4-ac8/fs/freevxfs/vxfs_super.c:182:vxfs_read_super: ERROR:INVERSE:159:182: UNREVERSED 'infp' on error path! set by 'kmalloc':159 [nbytes=36] [rank=easy]
> 	struct vxfs_sb		*rsbp;

Fixed

> /u2/engler/mc/oses/linux/2.4.4-ac8/fs/cmsfs/cmsfsvfs.c:729:cmsfs_lookup: ERROR:INVERSE:665:729: UNREVERSED 'cmsinode' on error path! set by 'kmalloc':665 [nbytes=124] [rank=easy]

Fixed - real bug

> [BUG]
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/media/video/zr36120.c:1202:zoran_ioctl: ERROR:INVERSE:1198:1202: UNREVERSED 'vcp' on error path! set by 'vmalloc':1198 [nbytes=20] [rank=easy] [type=SECURITY]
> 			return -EDOM;   /* Too many! */

Real bug but already fixed in -ac

> [BUG]
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/mtd/mtdchar.c:314:mtd_ioctl: ERROR:INVERSE:309:314: UNREVERSED 'databuf' on error path! set by 'kmalloc':309 [nbytes=0] [rank=easy] [type=SECURITY]

Real bug - already fixed in -ac

> [BUG] hidden in macro.
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/wan/lmc/lmc_main.c:510:lmc_ioctl: ERROR:INVERSE:503:510: UNREVERSED 'data' on error path! set by 'kmalloc':503 [nbytes=1] [rank=easy] [type=SECURITY]
>                     if(xc.data == 0x0){

Real bug -fixed

> [BUG] security hole
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/isdn_ppp.c:788:isdn_ppp_write: ERROR:INVERSE:781:788: UNREVERSED 'skb' on error path! set by 'alloc_skb':781 [nbytes=168] [rank=hard] [type=SECURITY]
> 			 * we need to reserve enought space in front of

Real bug - fixed

> [BUG] frees it below.
> /u2/engler/mc/oses/linux/2.4.4-ac8/net/wanrouter/wanproc.c:271:router_proc_read: ERROR:INVERSE:262:271: UNREVERSED 'page' on error path! set by 'kmalloc':262 [nbytes=1] [rank=hard] [type=SECURITY]
> 			

Real bug - already fixed in -ac

> ---------------------------------------------------------
> [BUG]  looks like they are supposed to release the request.
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/scsi_ioctl.c:324:scsi_ioctl_send_command: ERROR:INVERSE:304:324: UNREVERSED 'SRpnt' on error path! set by 'scsi_allocate_request':304 [nbytes=216] [rank=hard] [type=SECURITY]
> 	}

Looks like it - harder to fix so queued to look at

> 
> [BUG]
>
/u2/engler/mc/oses/linux/2.4.4-ac8/net/irda/irlan/irlan_common.c:227:irlan_open: ERROR:INVERSE:216:227: UNREVERSED 'self' on error path! set by 'kmalloc':216 [nbytes=976] [rank=easy]

Yes - although if that assert triggers that is the _least_ of our worries


> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/telephony/ixj.c:4484:ixj_build_filter_cadence: ERROR:INVERSE:4478:4484: UNREVERSED 'lcp' on error path! set by 'kmalloc':4478 [nbytes=32] [rank=easy]
>
Fixed
 
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c:118:ahc_linux_pci_dev_probe: ERROR:INVERSE:112:118: UNREVERSED 'name' on error path! set by 'kmalloc':112 [nbytes=1] [rank=easy]
> 	 */

Disagree

> 	ahc = ahc_alloc(NULL, name);

ahc_alloc frees name on error

> /u2/engler/mc/oses/linux/2.4.4-ac8/net/wanrouter/wanmain.c:803:device_new_if: ERROR:INVERSE:794:803: UNREVERSED 'pppdev' on error path! set by 'kmalloc':794 [nbytes=84] [rank=easy]
> 

Fixed

> [BUG]
> /u2/engler/mc/oses/linux/2.4.4-ac8/fs/jffs/jffs_fm.c:50:jffs_build_begin: ERROR:INVERSE:39:50: UNREVERSED 'fmc' on error path! set by 'kmalloc':39 [nbytes=76] [rank=easy]
> 	struct jffs_fmcontrol *fmc;
Fixed

> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/pcmcia/aironet4500_cs.c:265:awc_attach: ERROR:INVERSE:209:265: UNREVERSED 'dev' on error path! set by 'kmalloc':209 [nbytes=376] [rank=med]
> 	link->conf.ConfigIndex = 1;

Looks right. Queued for pcmcia folk

