Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261542AbTCTRn3>; Thu, 20 Mar 2003 12:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbTCTRn3>; Thu, 20 Mar 2003 12:43:29 -0500
Received: from mail.copper.net ([65.247.64.20]:58381 "EHLO mail.copper.net")
	by vger.kernel.org with ESMTP id <S261542AbTCTRmw>;
	Thu, 20 Mar 2003 12:42:52 -0500
Message-ID: <005501c2ef09$c6f93480$54491cd8@CEVE>
From: "george cewe" <gcewe@copper.net>
To: <linux-kernel@vger.kernel.org>
Subject: submission of CAN driver for i82527 chip
Date: Thu, 20 Mar 2003 12:54:36 -0500
Organization: ceve inc
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0052_01C2EEDF.DCC6A9C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0052_01C2EEDF.DCC6A9C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Dear Kernel Maintainer;

Please find enclosed 2 files of a driver for Intel 82527 CAN Controller,
This driver is a simplified version of 'ocan' driver by Allesandro Rubini.

'jcan' is a character driver for kernel 2.4 and up, I inserted it in
linux_root/drivers/char directory.
I tested it on embedded MPC823 platform, but it should be running on other
platforms as well.

This is first time I submit a Linux driver and I would appreciate your
comments.

regards George Cewe.


------=_NextPart_000_0052_01C2EEDF.DCC6A9C0
Content-Type: text/plain;
	name="jcan.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="jcan.h"

/*=0A=
 * jcan.h -- header for the CAN driver=0A=
 *=0A=
 * Copyright (C) 2003 George Cewe <gcewe@copper.net>=0A=
 * Copyright (C) 2003 Advanced Concepts Inc.=0A=
 * Copyright (C) 2002 Alessandro Rubini <rubini@linux.it>=0A=
 * Copyright (C) 2001   Ascensit S.p.A <support@ascensit.com>=0A=
 * Author: Rodolfo Giometti <r.giometti@ascensit.com>=0A=
 *=0A=
 *=0A=
 *   This program is free software; you can redistribute it and/or modify=0A=
 *   it under the terms of the GNU General Public License as published by=0A=
 *   the Free Software Foundation; either version 2 of the License, or=0A=
 *   (at your option) any later version.=0A=
 *=0A=
 *   This program is distributed in the hope that it will be useful,=0A=
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
 *   GNU General Public License for more details.=0A=
 *=0A=
 *   You should have received a copy of the GNU General Public License=0A=
 *   along with this program; if not, write to the Free Software=0A=
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =
02111-1307, USA.=0A=
 */=0A=
=0A=
#ifndef __JCAN_H__=0A=
#define __JCAN_H__=0A=
=0A=
#include <linux/types.h>=0A=
=0A=
#define CAN_READ_BUFS 64       /* read buffer has 64 messages  */=0A=
=0A=
=0A=
#define I527_XTD_XTD	      0x04=0A=
#define I527_XTD_STD	      0x00=0A=
=0A=
/*=0A=
 * data structures used in both kernel and user space (mostly for ioctl)=0A=
 */=0A=
typedef enum=0A=
{  B_100K=0A=
  ,B_125K=0A=
  ,B_250K=0A=
  ,B_500K=0A=
  ,B_1M=0A=
  ,BPS_MAX=0A=
} BPS;=0A=
=0A=
typedef struct =0A=
{=0A=
  __u8 reg;=0A=
  __u8 val;=0A=
} CAN_REG;=0A=
=0A=
#define CAN_MULTIREG_MAX 16=0A=
typedef struct  =0A=
{=0A=
  __u8 first, last;=0A=
  __u8 regs[CAN_MULTIREG_MAX];=0A=
} CAN_MULTIREG;=0A=
=0A=
typedef struct=0A=
{=0A=
  __u8 data[256];=0A=
} CAN_ALLREGS;=0A=
=0A=
typedef struct=0A=
{=0A=
  __u32 m_msg15;=0A=
  __u32 m_xtd;=0A=
  __u16 m_std;=0A=
} CAN_MASKS;=0A=
=0A=
/* This structure is both part of the device structure and arg of ioctl =
*/=0A=
typedef struct=0A=
{=0A=
  __u32 id;=0A=
  __u8  msgobj;   /* 1..15 */=0A=
  __u8  flags;=0A=
  __u8  config;   /* same as config register */=0A=
  __u8  dlc;      /* data length counter */=0A=
  __u8  data[8];=0A=
  __u16 error;    /* also for alignment */=0A=
} CAN_MSG;=0A=
=0A=
/* And these are the message flags */=0A=
#define CAN_MSGFLAG_WRITE    0x01=0A=
#define CAN_MSGFLAG_READ     0x02 /* set either write read */=0A=
#define CAN_MSGFLAG_DOREMOTE 0x04 /* send a remote frame, for reading */=0A=
#define CAN_MSGFLAG_PEEKONLY 0x08 /* used by IOCPEEK */=0A=
=0A=
#define CAN_ERROR_MASK	     0x07   /* Tx error code */=0A=
#define CAN_ERROR_MSGLST     0x10   /* Message lost error */=0A=
#define CAN_ERROR_OVRFLW     0x80   /* Read buffer overflow */=0A=
=0A=
=0A=
/*=0A=
 * ioctl() definitons=0A=
 */=0A=
 =0A=
/* Use 'z' as magic number */=0A=
#define CAN_IOC_MAGIC  'z' /* like other CAN drivers, per =
ioctl-number.txt */=0A=
=0A=
#define CAN_IOCRESET            _IO(CAN_IOC_MAGIC,  0)=0A=
=0A=
/* individual registers */=0A=
#define CAN_IOCREADREG        _IOWR(CAN_IOC_MAGIC,  1, CAN_REG)=0A=
#define CAN_IOCWRITEREG        _IOW(CAN_IOC_MAGIC,  2, CAN_REG)=0A=
=0A=
/* range of registers */=0A=
#define CAN_IOCREADMULTI      _IOWR(CAN_IOC_MAGIC,  3, CAN_MULTIREG)=0A=
#define CAN_IOCWRITEMULTI      _IOW(CAN_IOC_MAGIC,  4, CAN_MULTIREG)=0A=
=0A=
/* one message */=0A=
#define CAN_IOCSETUPMSG        _IOW(CAN_IOC_MAGIC,  5, CAN_MSG)=0A=
#define CAN_IOCWRITEMSG        _IOW(CAN_IOC_MAGIC,  6, CAN_MSG)=0A=
#define CAN_IOCTXMSG           _IOW(CAN_IOC_MAGIC,  7, unsigned long)=0A=
#define CAN_IOCRXMSG          _IOWR(CAN_IOC_MAGIC,  8, CAN_MSG)=0A=
#define CAN_IOCRELEASEMSG      _IOW(CAN_IOC_MAGIC,  9, unsigned long)=0A=
=0A=
/* all registers */=0A=
#define CAN_IOCREADALL         _IOR(CAN_IOC_MAGIC, 10, CAN_ALLREGS)=0A=
=0A=
/* masks, times, bus configuration */=0A=
#define CAN_IOCGETMASKS        _IOR(CAN_IOC_MAGIC, 11, CAN_MASKS)=0A=
#define CAN_IOCSETMASKS        _IOW(CAN_IOC_MAGIC, 12, CAN_MASKS)=0A=
=0A=
#define CAN_IOCGETBPS          _IOR(CAN_IOC_MAGIC, 13, unsigned long)  =0A=
#define CAN_IOCSETBPS          _IOW(CAN_IOC_MAGIC, 14, unsigned long)=0A=
=0A=
#define CAN_IOCGETBUSCONF      _IOR(CAN_IOC_MAGIC, 15, CAN_REG)=0A=
#define CAN_IOCSETBUSCONF      _IOW(CAN_IOC_MAGIC, 16, CAN_REG)=0A=
=0A=
/* misc */=0A=
#define CAN_IOCSOFTRESET       _IO(CAN_IOC_MAGIC,  17)=0A=
=0A=
#define CAN_IOCWRITEQ          _IOW(CAN_IOC_MAGIC, 18, CAN_MSG)=0A=
#define CAN_IOCGIRQCOUNT       _IOR(CAN_IOC_MAGIC, 19, unsigned long)=0A=
=0A=
#define CAN_IOCREQSIGNAL       _IOW(CAN_IOC_MAGIC, 20, unsigned long)=0A=
=0A=
/* I/O ports */=0A=
#define CAN_IOCINPUT          _IOWR(CAN_IOC_MAGIC, 21, CAN_REG)=0A=
#define CAN_IOCOUTPUT          _IOW(CAN_IOC_MAGIC, 22, CAN_REG)=0A=
#define CAN_IOCIOCFG           _IOW(CAN_IOC_MAGIC, 23, CAN_REG)=0A=
=0A=
/* peek (like rx) */=0A=
#define CAN_IOCPEEKMSG        _IOWR(CAN_IOC_MAGIC, 24, CAN_MSG)=0A=
=0A=
#define CAN_IOC_MAXNR                              24=0A=
=0A=
#endif /* __JCAN_H__ */=0A=
=0A=
=0A=
=0A=

------=_NextPart_000_0052_01C2EEDF.DCC6A9C0
Content-Type: text/plain;
	name="jcan.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="jcan.c"

/*=0A=
 * jcan.c -- CAN driver for i82527=0A=
 *=0A=
 * Copyright (C) 2003 George Cewe <gcewe@copper.net>=0A=
 * Copyright (C) 2003 Advanced Concepts Inc.=0A=
 * Copyright (C) 2002 Alessandro Rubini <rubini@linux.it>=0A=
 * Copyright (C) 2002 System SpA <info.electronics@system-group.it>=0A=
 *=0A=
 *   This program is free software; you can redistribute it and/or modify=0A=
 *   it under the terms of the GNU General Public License as published by=0A=
 *   the Free Software Foundation; either version 2 of the License, or=0A=
 *   (at your option) any later version.=0A=
 *=0A=
 *   This program is distributed in the hope that it will be useful,=0A=
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
 *   GNU General Public License for more details.=0A=
 *=0A=
 *   You should have received a copy of the GNU General Public License=0A=
 *   along with this program; if not, write to the Free Software=0A=
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =
02111-1307, USA.=0A=
 *=0A=
 *=0A=
 * This driver is a simplified version of "ocan" driver by Alessandro =
Rubini.=0A=
 * It supports one memory mapped Intel i82527 CAN chip, running under =
J1939=0A=
 * protocol (250kBps, extended message id).=0A=
 * =0A=
 */=0A=
=0A=
#define  __NO_VERSION__=0A=
#include <linux/module.h>=0A=
#include <linux/init.h>=0A=
#include <linux/types.h>=0A=
#include <linux/delay.h>=0A=
#include <linux/poll.h>=0A=
#include <linux/slab.h>=0A=
#include <linux/interrupt.h>=0A=
=0A=
#include <asm/irq.h>=0A=
#include <asm/io.h>=0A=
#ifdef __powerpc__=0A=
#include <asm-ppc/8xx_immap.h>=0A=
#endif=0A=
#include "jcan.h"=0A=
=0A=
/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A=
 * Messaging stuff=0A=
 */=0A=
#undef PDEBUG        /* undef it, just in case */=0A=
=0A=
#ifdef CAN_DEBUG=0A=
#ifdef __KERNEL__=0A=
/* This one if debugging is on, and kernel space */=0A=
#define PDEBUG(fmt, args...) printk(KERN_DEBUG CAN_TEXT fmt,##args)=0A=
#else=0A=
/* This one for user space */=0A=
#define PDEBUG(fmt, args...) fprintf(stdout, fmt, ##args)=0A=
#endif=0A=
#else=0A=
/* nothing */=0A=
#define PDEBUG(fmt, args...) /* nothing */=0A=
#endif /* CAN_DEBUG */=0A=
=0A=
#ifdef CAN_DEBUG=0A=
#define debug 1=0A=
#else=0A=
#define debug 0=0A=
#endif=0A=
=0A=
// base address and interrupt number=0A=
#define IO_ADDR  0xffff0000=0A=
#define IO_RANGE 0x100=0A=
#define IRQ_NUM  SIU_IRQ3=0A=
=0A=
#ifndef CAN_MAJOR=0A=
#define CAN_MAJOR   91   =0A=
#endif=0A=
=0A=
#define CAN_NAME "jcan"=0A=
#define CAN_TEXT "jcan: "=0A=
=0A=
/*=0A=
 * Sysctl constants=0A=
 */=0A=
#define DEV_CAN  2658        /* random for /proc/sys/dev/jcan/ */=0A=
=0A=
/* inside /proc/sys/dev/jcan, each backend can use 100 keys */=0A=
=0A=
/*=0A=
 * minor allocation: each device has 1 general entry point, 15=0A=
 * message-buffer entry points and a few information/error files.=0A=
 * So it will need 5 bits. This accounts for up to eight devices=0A=
 */=0A=
=0A=
#define CAN_DEV_TYPE(minor)     ((minor)&0x1f)=0A=
#define CAN_DEV_TYPE_GENERIC    0  /* 1..15 are the message objects */=0A=
#define CAN_DEV_TYPE_ERROR     16=0A=
#define CAN_DEV_TYPE_IO1       17=0A=
#define CAN_DEV_TYPE_IO2       18=0A=
=0A=
#define CAN_DEV_NUM(minor)    ((minor)>>5) =0A=
=0A=
/* =0A=
 * Device structures=0A=
 */=0A=
=0A=
#define CAN_BUFSIZE   64   /* 64 pointers for msg packets */=0A=
=0A=
// i82527 related definitions =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
#define I527_MSG_OBJS	16 /* 0 is the whole device, 1..15 are objects */=0A=
#define I527_FIRST_OBJ    1=0A=
=0A=
/* 82527 address map (referred from base address) & internal bits.=0A=
   See the 82527 data-sheet page 9 and following */=0A=
#define I527_MAP_SIZE 	           0x100=0A=
#define I527_CTRL_REG		   0x00=0A=
#define I527_CCE		   0x40=0A=
#define I527_EIE		   0x08=0A=
#define I527_SIE		   0x04=0A=
#define I527_IE		           0x02=0A=
#define I527_INIT		   0x01=0A=
=0A=
#define I527_STAT_REG		   0x01=0A=
#define I527_STAT_REG_DEFAULT      0x07=0A=
=0A=
#define I527_CPU_INT_REG	   0x02=0A=
#define I527_RSTST		   0x80=0A=
#define I527_DSC		   0x40=0A=
#define I527_DMC		   0x20=0A=
#define I527_PWD		   0x10=0A=
#define I527_SLEEP		   0x08=0A=
#define I527_MUX		   0x04=0A=
#define I527_CEN		   0x01=0A=
=0A=
/* Reserved                     0x03 */=0A=
#define I527_HI_SPEED_RD	0x04=0A=
#define I527_GMASK_STD		0x06=0A=
#define I527_GMASK_XTD		0x08=0A=
#define I527_MSG15_MASK		0x0c=0A=
=0A=
/* Message 1			0x10 */=0A=
#define I527_MSG_OFF		0x10   /* No size definition here */=0A=
#define I527_MSG_CTRL	   0x00=0A=
#define I527_MSGVAL_R	  0xff7f   /* *********************** */=0A=
#define I527_MSGVAL_S	  0xffbf   /* WARNING!!!              */=0A=
#define I527_TXIE_R	  0xffdf   /* These masks must be     */=0A=
#define I527_TXIE_S	  0xffef   /* &-ed and *NOT* |-ed     */=0A=
#define I527_RXIE_R	  0xfff7   /*                         */=0A=
#define I527_RXIE_S	  0xfffb   /*                         */=0A=
#define I527_INTPND_R	  0xfffd   /*                         */=0A=
#define I527_INTPND_S	  0xfffe   /*                         */=0A=
#define I527_RMTPND_R	  0x7fff   /* WARNING!!!              */=0A=
#define I527_RMTPND_S	  0xbfff   /* These masks must be     */=0A=
#define I527_TXRQST_R	  0xdfff   /* &-ed and *NOT* |-ed     */=0A=
#define I527_TXRQST_S	  0xefff   /*                         */=0A=
#define I527_MSGLST_R	  0xf7ff   /*                         */=0A=
#define I527_MSGLST_S	  0xfbff   /*                         */=0A=
#define I527_CPUUPD_R	  0xf7ff   /* WARNING!!!              */=0A=
#define I527_CPUUPD_S	  0xfbff   /* These masks must be     */=0A=
#define I527_NEWDAT_R	  0xfdff   /* &-ed and *NOT* |-ed     */=0A=
#define I527_NEWDAT_S	  0xfeff   /* *********************** */=0A=
#define I527_MSG_ARBIT	  0x02=0A=
#define I527_MSG_CFG	   0x06=0A=
#define I527_DLC_MASK	   0xf0=0A=
#define I527_DLC_SHIFT	   4=0A=
#define I527_DLC_MASK0	   0x0f=0A=
#define I527_DIR		   0x08=0A=
#define I527_DIR_TX	      0x08=0A=
#define I527_DIR_RX	      0x00=0A=
#define I527_XTD		   0x04=0A=
#define I527_MSG_DATA	0x07   /* 8 bytes */=0A=
#define I527_CLKOUT_REG		0x1f=0A=
#define I527_SL_MASK		   0x30=0A=
#define I527_SL_SHIFT	   4=0A=
#define I527_SL_MASK0	   0x03=0A=
#define I527_CLKDIV_MASK	   0x0f=0A=
#define I527_CLKDIV_SHIFT	   0=0A=
#define I527_CLKDIV_MASK0	   0x0f=0A=
=0A=
/* Message 2			0x20 */=0A=
#define I527_BUSCFG_REG		0x2f=0A=
#define I527_COBY		   0x40=0A=
#define I527_POL		   0x20=0A=
#define I527_DCT1		   0x08=0A=
#define I527_DCR1		   0x02=0A=
#define I527_DCR0		   0x01=0A=
=0A=
/* Message 3			0x30 */=0A=
#define I527_BITT0_REG		0x3f=0A=
#define I527_SJW_MASK           0xc0=0A=
#define I527_SJW_SHIFT          0x06=0A=
#define I527_SJW_MASK0          0x03=0A=
#define I527_BRP_MASK           0x3f=0A=
#define I527_BRP_SHIFT          0=0A=
#define I527_BRP_MASK0          0x3f=0A=
=0A=
/* Message 4			0x40 */=0A=
#define I527_BITT1_REG		0x4f=0A=
#define I527_SPL_MASK           0x80=0A=
#define I527_SPL_SHIFT          7=0A=
#define I527_SPL_MASK0          0x01=0A=
#define I527_TSEG2_MASK         0x70=0A=
#define I527_TSEG2_SHIFT        4=0A=
#define I527_TSEG2_MASK0        0x07=0A=
#define I527_TSEG1_MASK         0x0f=0A=
#define I527_TSEG1_SHIFT        0=0A=
#define I527_TSEG1_MASK0        0x0f=0A=
=0A=
/* Message 5			0x50 */=0A=
#define I527_INT_REG		0x5f=0A=
=0A=
/* Message 6			0x60 */=0A=
/* Reserved                     0x6f */=0A=
=0A=
/* Message 7			0x70 */=0A=
/* Reserved                     0x7f */=0A=
=0A=
/* Message 8			0x80 */=0A=
/* Reserved                     0x8f */=0A=
=0A=
/* Message 9			0x90 */=0A=
#define I527_P1CONF		0x9f=0A=
=0A=
/* Message 10			0xa0 */=0A=
#define I527_P2CONF		0xaf=0A=
=0A=
/* Message 11			0xb0 */=0A=
#define I527_P1IN		0xbf=0A=
=0A=
/* Message 12			0xc0 */=0A=
#define I527_P2IN		0xcf=0A=
=0A=
/* Message 13			0xd0 */=0A=
#define I527_P1OUT		0xdf=0A=
=0A=
/* Message 14			0xe0 */=0A=
#define I527_P2OUT		0xef=0A=
=0A=
/* Message 15			0xf0 */=0A=
#define I527_SER_RST_ADD	0xff=0A=
=0A=
typedef struct=0A=
{=0A=
  __u8 cpuint;=0A=
  __u8 clkout;=0A=
  __u8 bittm0;=0A=
  __u8 bittm1;=0A=
} CAN_BPS; =0A=
=0A=
/*=0A=
 * WARNING:  can_times fields must all be __u8, because I sometimes=0A=
 * iniitalize it from arrays of bytes (for example dev->hal->h_defaults)=0A=
 */=0A=
typedef struct  =0A=
{=0A=
  __u8  t_dsc;=0A=
  __u8  t_dmc;=0A=
  __u8  t_clkout_div;=0A=
  __u8  t_clkout_slew;=0A=
  __u8  t_sjw;=0A=
  __u8  t_spl;=0A=
  __u8  t_brp;=0A=
  __u8  t_tseg1;=0A=
  __u8  t_tseg2;=0A=
} CAN_TIMES;=0A=
=0A=
/* This is the MSGOBJ structure */=0A=
typedef struct =0A=
{=0A=
  u32                          obj_id;  /* current id */=0A=
  struct file                  *owner;  /* someone is waiting for a =
message */=0A=
  volatile u16              obj_flags;  /* object-specific flags */=0A=
  u8                          regbase;  /* register offset */=0A=
  volatile u8                   error;  /* error on message */=0A=
  spinlock_t                     lock;=0A=
  unsigned long                 flags;          =0A=
  wait_queue_head_t            read_q;  /* read queue */=0A=
  struct fasync_struct  *async_read_q;  /* async read queue */=0A=
  wait_queue_head_t           write_q;  /* write queue */=0A=
  struct fasync_struct *async_write_q;  /* async write queue*/=0A=
  volatile int                   head;=0A=
  volatile int                   tail;=0A=
  CAN_MSG                       **msg;   /* allocated using CAN_BUFSIZE =
*/;=0A=
} CAN_MSGOBJ;=0A=
=0A=
/* object flags and error flags, used internally */=0A=
#define CAN_OBJFLAG_WRITE        0x01   /* being used to write/read */=0A=
#define CAN_OBJFLAG_READ         0x02   /* (same values as MSGFLAG) */=0A=
#define CAN_OBJFLAG_REMOTE       0x04   /* remote flag on */=0A=
#define CAN_OBJFLAG_HWBUSY       0x40   /* message is being transmitted =
*/=0A=
#define CAN_OBJFLAG_BUSY         0x80   /* message is in use */=0A=
=0A=
=0A=
/* error notification via signals */=0A=
typedef struct  =0A=
{=0A=
  struct file *file;=0A=
  int signal;=0A=
  pid_t pid;=0A=
} CAN_ERROR;=0A=
#define CAN_NR_ERROR_FILES 4 /* at most 4 processes can get a signal */=0A=
=0A=
typedef struct  =0A=
{=0A=
  u32               base;=0A=
  volatile u32      irq_count;=0A=
  u8                usecount;=0A=
  volatile u8       statusbyte;=0A=
  u8                registered;=0A=
  u8                gotirq;=0A=
  CAN_MSGOBJ       *objs[I527_MSG_OBJS];=0A=
  CAN_ERROR         errorinfo[CAN_NR_ERROR_FILES];=0A=
  wait_queue_head_t error_q;=0A=
  BPS               eBps;=0A=
} CAN_DEV;=0A=
=0A=
=0A=
static kmem_cache_t *gpsCache;     // The memory cache for msg packets=0A=
static CAN_DEV gsDev;              // The device data =0A=
=0A=
static const CAN_BPS gasBps[BPS_MAX] =3D=0A=
{  {0x40, 0x31, 0x03, 0x4d}        // 100k=0A=
  ,{0x40, 0x31, 0x03, 0x49}        // 125k=0A=
  ,{0x40, 0x31, 0x01, 0x49}        // 250k=0A=
  ,{0x40, 0x31, 0x00, 0x49}        // 500k=0A=
  ,{0x40, 0x31, 0x00, 0x14}        // 1M=0A=
};=0A=
=0A=
static spinlock_t can_lock =3D SPIN_LOCK_UNLOCKED;=0A=
=0A=
/////////////////////////////////////////////////////////////////////////=
////=0A=
static int can_readb(CAN_DEV *dev, u_char reg)=0A=
{=0A=
  return readb((volatile unsigned char *)(dev->base + reg));=0A=
}=0A=
=0A=
//-----------------------------------------------------------------------=
----=0A=
static int can_writeb(CAN_DEV *dev, u_char reg, unsigned char val)=0A=
{=0A=
  writeb(val, (volatile unsigned char *)(dev->base + reg));=0A=
  return 0;=0A=
}=0A=
=0A=
/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0A=
 * basic functions use direct methods=0A=
 */=0A=
#define i527_read_reg(dev, reg) \=0A=
                           (can_readb((dev), (reg)))=0A=
=0A=
#define i527_write_reg(dev, reg, value) \=0A=
                           (can_writeb((dev), (reg), (value)))=0A=
=0A=
/*=0A=
 * bit-setting operation and its use=0A=
 */=0A=
extern inline int i527_bits(CAN_DEV *dev, int reg,=0A=
				 int bits, int value)=0A=
{=0A=
    int res =3D i527_read_reg(dev, reg);=0A=
    if (res < 0) return res;=0A=
    res =3D (res & ~bits) | (bits & value);=0A=
    return i527_write_reg(dev, reg, res);=0A=
}=0A=
=0A=
#define can_enable_irq(dev) i527_bits((dev), I527_CTRL_REG, \=0A=
                             I527_EIE|I527_IE, I527_EIE|I527_IE)=0A=
=0A=
#define can_disable_irq(dev) i527_bits((dev), I527_CTRL_REG, \=0A=
                              I527_EIE|I527_IE, 0)=0A=
=0A=
#define can_read_msg_dlc(dev, n) \=0A=
                ((i527_read_msgcfg(dev, n) & I527_DLC_MASK) \=0A=
                      >> I527_DLC_SHIFT)=0A=
=0A=
#define can_write_msg_dlc(dev, n, dlc) \=0A=
                (i527_bits((dev), n * I527_MSG_OFF + I527_MSG_CFG, \=0A=
				 I527_DLC_MASK, (dlc) << I527_DLC_SHIFT))=0A=
=0A=
/*=0A=
 * Enable/disable configuration changes=0A=
 */=0A=
=0A=
/* enable and return previous value */=0A=
extern inline int can_enable_cfg(CAN_DEV *dev)=0A=
{=0A=
    int res =3D  i527_read_reg(dev, I527_CTRL_REG);=0A=
    if (res < 0) return res;=0A=
    if (res & I527_CCE) return I527_CCE;=0A=
    res =3D i527_write_reg(dev, I527_CTRL_REG, res | I527_CCE);=0A=
    if (res < 0) return res;=0A=
    return 0;=0A=
}=0A=
=0A=
/* disable and return previous value */=0A=
extern inline int can_disable_cfg(CAN_DEV *dev)=0A=
{=0A=
    int res =3D  i527_read_reg(dev, I527_CTRL_REG);=0A=
    if (res < 0) return res;=0A=
    if (!(res & I527_CCE)) return 0;=0A=
    res =3D i527_write_reg(dev, I527_CTRL_REG, res & ~I527_CCE);=0A=
    if (res < 0) return res;=0A=
    return I527_CCE;=0A=
}=0A=
=0A=
/* restore previous value */=0A=
extern inline int can_restore_cfg(CAN_DEV *dev, int prev)=0A=
{=0A=
    return i527_bits(dev, I527_CTRL_REG, I527_CCE, prev);=0A=
}=0A=
=0A=
/*=0A=
 * higher level functions (can't be in i82527.h, for strange =
dependencies)=0A=
 */=0A=
=0A=
extern inline int i527_read_msgcfg(CAN_DEV *dev,=0A=
				   CAN_MSGOBJ *obj)=0A=
{=0A=
    return i527_read_reg(dev, obj->regbase + I527_MSG_CFG);=0A=
}=0A=
=0A=
extern inline int i527_write_msgcfg(CAN_DEV *dev,=0A=
				    CAN_MSGOBJ *obj, int val)=0A=
{=0A=
    if (val & ~0xff) return -EINVAL;=0A=
    return  i527_write_reg(dev, obj->regbase + I527_MSG_CFG, val);=0A=
}=0A=
=0A=
extern inline u16 i527_read_std_mask(CAN_DEV *dev)=0A=
{=0A=
    /* errors are ignored, hmm... */=0A=
    u16 ret =3D i527_read_reg(dev, I527_GMASK_STD) << 8=0A=
	|  i527_read_reg(dev, I527_GMASK_STD + 1);=0A=
    return ret;=0A=
}=0A=
 =0A=
extern inline void i527_write_std_mask(CAN_DEV *dev, u16 val)=0A=
{=0A=
    /* errors are ignored, hmm... */=0A=
    i527_write_reg(dev, I527_GMASK_STD,     val >> 8);=0A=
    i527_write_reg(dev, I527_GMASK_STD + 1, val & 0xff);=0A=
}=0A=
=0A=
extern inline u32 i527_read_x_mask(CAN_DEV *dev)=0A=
{=0A=
    /* errors are ignored, hmm... */=0A=
    u32 ret =3D i527_read_reg(dev, I527_GMASK_XTD)  << 24=0A=
	|  i527_read_reg(dev, I527_GMASK_XTD + 1) << 16=0A=
	|  i527_read_reg(dev, I527_GMASK_XTD + 2) << 8=0A=
	|  i527_read_reg(dev, I527_GMASK_XTD + 3);=0A=
    return ret;=0A=
}=0A=
=0A=
extern inline void i527_write_x_mask(CAN_DEV *dev, u32 val)=0A=
{=0A=
    /* errors are ignored, hmm... */=0A=
    i527_write_reg(dev, I527_GMASK_XTD,      val >> 24);=0A=
    i527_write_reg(dev, I527_GMASK_XTD + 1, (val >> 16) & 0xff);=0A=
    i527_write_reg(dev, I527_GMASK_XTD + 2, (val >>  8) & 0xff);=0A=
    i527_write_reg(dev, I527_GMASK_XTD + 3, (val >>  0) & 0xff);=0A=
}=0A=
=0A=
=0A=
extern inline u32 i527_read_15_mask(CAN_DEV *dev)=0A=
{=0A=
    /* errors are ignored, hmm... */=0A=
    u32 ret =3D i527_read_reg(dev, I527_MSG15_MASK)  << 24=0A=
	|  i527_read_reg(dev, I527_MSG15_MASK + 1) << 16=0A=
	|  i527_read_reg(dev, I527_MSG15_MASK + 2) << 8=0A=
	|  i527_read_reg(dev, I527_MSG15_MASK + 3);=0A=
    return ret;=0A=
}=0A=
 =0A=
extern inline void i527_write_15_mask(CAN_DEV *dev,=0A=
					     u32 val)=0A=
{=0A=
    /* errors are ignored, hmm... */=0A=
    i527_write_reg(dev, I527_MSG15_MASK,      val >> 24);=0A=
    i527_write_reg(dev, I527_MSG15_MASK + 1, (val >> 16) & 0xff);=0A=
    i527_write_reg(dev, I527_MSG15_MASK + 2, (val >>  8) & 0xff);=0A=
    i527_write_reg(dev, I527_MSG15_MASK + 3, (val >>  0) & 0xff);=0A=
}=0A=
=0A=
extern inline u16 i527_read_msgctrl(CAN_DEV *dev,=0A=
				    CAN_MSGOBJ *obj)=0A=
{=0A=
    /* FIXME: this is used little-endian, but doesn't need to be 16b */=0A=
=0A=
    /* errors are ignored, hmm... */=0A=
    u16 ret =3D i527_read_reg(dev, obj->regbase + I527_MSG_CTRL)=0A=
	| (i527_read_reg(dev, obj->regbase + I527_MSG_CTRL +1 )=0A=
	   << 8);=0A=
    return ret;=0A=
}=0A=
 =0A=
extern inline void i527_write_msgctrl(CAN_DEV *dev,=0A=
				      CAN_MSGOBJ *obj, u16 val)=0A=
{=0A=
    /* FIXME: this is used little-endian, but doesn't need to be 16b */=0A=
=0A=
    /* errors are ignored, hmm... */=0A=
    i527_write_reg(dev, obj->regbase + I527_MSG_CTRL, val & 0xff);=0A=
    i527_write_reg(dev, obj->regbase + I527_MSG_CTRL + 1, val >> 8);=0A=
}=0A=
=0A=
/* write a single byte of msgctrl, twice as fast as the function above */=0A=
extern inline void i527_msgflag(CAN_DEV *dev,=0A=
				CAN_MSGOBJ *obj, u16 act)=0A=
{=0A=
    if ((act & 0xff) =3D=3D 0xff)=0A=
	i527_write_reg(dev, obj->regbase + I527_MSG_CTRL + 1, act >> 8);=0A=
    else=0A=
	i527_write_reg(dev, obj->regbase + I527_MSG_CTRL, act & 0xff);=0A=
}=0A=
/* same, but for unallocated objects */=0A=
extern inline void i527_msgflag_noobj(CAN_DEV *dev,=0A=
				      int msgnum, u16 act)=0A=
{=0A=
    if ((act & 0xff) =3D=3D 0xff)=0A=
	i527_write_reg(dev, msgnum*I527_MSG_OFF + I527_MSG_CTRL + 1,=0A=
			    act >> 8);=0A=
    else=0A=
	i527_write_reg(dev,  msgnum*I527_MSG_OFF + I527_MSG_CTRL,=0A=
			    act & 0xff);=0A=
}=0A=
/* read a single byte of msgctrl (use the _S flag. Hm....) */=0A=
extern inline int i527_check_msgflag(CAN_DEV *dev,=0A=
				     CAN_MSGOBJ *obj, u16 act)=0A=
{=0A=
    u16 reg;=0A=
    if ((act & 0xff) =3D=3D 0xff) {=0A=
	reg =3D i527_read_reg(dev, obj->regbase + I527_MSG_CTRL + 1);=0A=
	return !((reg << 8) & ~act);=0A=
    }=0A=
    reg =3D i527_read_reg(dev, obj->regbase + I527_MSG_CTRL);=0A=
    return !(reg & ~act);=0A=
}=0A=
=0A=
extern inline u32 i527_read_msgarb(CAN_DEV *dev,=0A=
				   CAN_MSGOBJ *obj)=0A=
{=0A=
    int port =3D obj->regbase + I527_MSG_ARBIT;=0A=
=0A=
    /* errors are ignored, hmm... */=0A=
    u32 ret =3D i527_read_reg(dev, port)  << 24=0A=
	|  i527_read_reg(dev, port + 1) << 16=0A=
	|  i527_read_reg(dev, port + 2) << 8=0A=
	|  i527_read_reg(dev, port + 3);=0A=
    return ret;=0A=
}=0A=
 =0A=
extern inline void i527_write_msgarb(CAN_DEV *dev,=0A=
				     CAN_MSGOBJ *obj, u32 val)=0A=
{=0A=
    int port =3D obj->regbase + I527_MSG_ARBIT;=0A=
=0A=
    i527_write_reg(dev, port,      val >> 24);=0A=
    i527_write_reg(dev, port + 1, (val >> 16) & 0xff);=0A=
    i527_write_reg(dev, port + 2, (val >>  8) & 0xff);=0A=
    i527_write_reg(dev, port + 3, (val >>  0) & 0xff);=0A=
}=0A=
=0A=
extern inline void i527_read_msgdata(CAN_DEV *dev,=0A=
				     CAN_MSGOBJ *obj,=0A=
				     int n, u8 *data)=0A=
{=0A=
    int i;=0A=
    u8 reg =3D obj->regbase + I527_MSG_DATA;=0A=
=0A=
    for (i=3D0; i<n; i++)=0A=
	data[i] =3D i527_read_reg(dev, reg++);=0A=
}=0A=
=0A=
extern inline void i527_write_msgdata(CAN_DEV *dev,=0A=
				      CAN_MSGOBJ *obj,=0A=
				      int n, u8 *data)=0A=
{=0A=
    int i;=0A=
    u8 reg =3D obj->regbase + I527_MSG_DATA;=0A=
    =0A=
    if (!n) return;=0A=
    i527_msgflag(dev, obj, I527_CPUUPD_S); /* CPU updating */=0A=
    for (i=3D0; i<n && i<8; i++)=0A=
	i527_write_reg(dev, reg++, data[i]);=0A=
    i527_msgflag(dev, obj, I527_CPUUPD_R);=0A=
}=0A=
=0A=
/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0A=
 * a collection of quick helper functions (all of them inline)=0A=
 */=0A=
=0A=
/* objects can become allocated items, and allocation is hidden here */=0A=
extern inline CAN_MSGOBJ *lib_findobj(CAN_DEV *dev, int msgnum, int prio)=0A=
{=0A=
  /* msgnum already checked */=0A=
  return dev->objs[msgnum];=0A=
}=0A=
=0A=
/* if/when allocation is there, release them here */=0A=
extern inline void lib_releaseobj(CAN_DEV *dev, int msgnum, CAN_MSGOBJ =
*obj)=0A=
{=0A=
  int i;=0A=
  if (!obj) return;=0A=
  spin_lock(&obj->lock);=0A=
  obj->owner =3D NULL;=0A=
  obj->obj_flags &=3D ~(CAN_OBJFLAG_BUSY | CAN_OBJFLAG_HWBUSY);=0A=
  i527_msgflag(dev, obj, I527_MSGVAL_R & I527_TXIE_R & I527_RXIE_R);=0A=
  for (i=3D0; i<CAN_BUFSIZE; i++)=0A=
    if (obj->msg[i]) {=0A=
      PDEBUG("discarding packet in obj %i\n", msgnum);=0A=
      kmem_cache_free(gpsCache, obj->msg[i]);=0A=
      obj->msg[i] =3D NULL;=0A=
    }=0A=
  obj-> head =3D obj->tail =3D 0;=0A=
  spin_unlock(&obj->lock);=0A=
}=0A=
=0A=
=0A=
/* returns 0 or -EINVAL */=0A=
extern inline int lib_checkmsgnum(int msgnum, int flags)=0A=
{=0A=
  if (msgnum > 0 && msgnum < 15)=0A=
    return 0;=0A=
  if ( (msgnum =3D=3D 15) && !(flags & CAN_MSGFLAG_WRITE) )=0A=
    return 0;=0A=
  printk("lib_checkmsgnum error, num=3D %d\n", msgnum);=0A=
  return -EINVAL;=0A=
}=0A=
=0A=
/* returns either 0 or -EBUSY, adjusts ownership */=0A=
extern inline int lib_setowner(CAN_MSGOBJ *obj,=0A=
			       struct file *filp, int rdwr)=0A=
{=0A=
  spin_lock(&obj->lock);=0A=
  if ( (obj->obj_flags & CAN_OBJFLAG_BUSY) && (obj->owner !=3D filp) ) {=0A=
    spin_unlock(&obj->lock);=0A=
    return -EBUSY;=0A=
  }=0A=
  obj->owner =3D filp;=0A=
  obj->obj_flags =3D=0A=
    (obj->obj_flags & ~(CAN_MSGFLAG_WRITE | CAN_MSGFLAG_READ))=0A=
    | CAN_OBJFLAG_BUSY | rdwr;=0A=
  spin_unlock(&obj->lock);=0A=
  return 0;=0A=
}=0A=
=0A=
=0A=
/* find this file in the errorfiles */=0A=
extern inline CAN_ERROR *lib_findfile(CAN_DEV *dev, struct file *file)=0A=
{=0A=
  CAN_ERROR *info =3D dev->errorinfo;=0A=
  int i;=0A=
=0A=
  for (i =3D 0; i<CAN_NR_ERROR_FILES; i++, info++)=0A=
    if (info->file =3D=3D file)=0A=
      return info;=0A=
  return NULL;=0A=
}=0A=
=0A=
/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0A=
 * Normal management message objects functions=0A=
 */=0A=
=0A=
//-----------------------------------------------------------------------=
----=0A=
static void can_setbps(CAN_DEV *dev, BPS eBps )=0A=
{=0A=
  int j;=0A=
  __u8 nTmp;=0A=
  const CAN_BPS *psBps =3D gasBps + eBps;=0A=
=0A=
  j =3D can_enable_cfg(dev);=0A=
=0A=
  nTmp =3D i527_read_reg(dev, I527_CPU_INT_REG) & ~(I527_DSC|I527_DMC);=0A=
  nTmp |=3D psBps->cpuint;=0A=
  i527_write_reg(dev, I527_CPU_INT_REG, nTmp);=0A=
  i527_write_reg(dev, I527_CLKOUT_REG, psBps->clkout);=0A=
  i527_write_reg(dev, I527_BITT0_REG, psBps->bittm0);=0A=
  i527_write_reg(dev, I527_BITT1_REG, psBps->bittm1);=0A=
=0A=
  PDEBUG("libdrv: index        %lx\n", eBps);=0A=
  PDEBUG("libdrv: cpu_int_reg  %x\n", nTmp);=0A=
  PDEBUG("libdrv: cpu_clk_out  %x\n", psBps->clkout);=0A=
  PDEBUG("libdrv: cpu_bit0_reg %x\n", psBps->bittm0);=0A=
  PDEBUG("libdrv: cpu_bit1_reg %x\n", psBps->bittm1);=0A=
=0A=
  can_restore_cfg(dev, j);=0A=
  dev->eBps =3D eBps;=0A=
}=0A=
=0A=
/*-----------------------------------------------------------------------=
----=0A=
 * full-reset function, called by deviceinit or by ioctl(RESET)=0A=
 =
-------------------------------------------------------------------------=
-*/=0A=
static void can_reset_i82527(CAN_DEV *dev)=0A=
{=0A=
  int i;=0A=
=0A=
  PDEBUG("init/reset of i82527 at 0x%08lx\n", (unsigned long)dev->base);=0A=
=0A=
  i527_write_reg(dev,I527_CTRL_REG,   I527_CCE|I527_INIT);          //41=0A=
  i527_write_reg(dev,I527_CLKOUT_REG, 3 << I527_SL_SHIFT);          //30=0A=
  i527_write_reg(dev, I527_STAT_REG, 0x00);=0A=
  i527_write_reg(dev, I527_P1CONF, 0x00);    /* default is input */=0A=
  i527_write_reg(dev, I527_P2CONF, 0x00);=0A=
=0A=
  i527_write_15_mask(dev, 0xffffffff);=0A=
  i527_write_std_mask(dev, 0xffff);=0A=
  i527_write_x_mask(dev, 0xffffffff);=0A=
=0A=
  /* Turn off all message objects and clear message identifiers */=0A=
  for (i =3D I527_FIRST_OBJ; i < I527_MSG_OBJS; i++) =0A=
  {=0A=
    if (dev->objs[i]) =0A=
    {=0A=
      lib_releaseobj(dev, i, dev->objs[i]); /* useful for reset */=0A=
      i527_write_msgctrl(dev, dev->objs[i],=0A=
			      I527_MSGVAL_R & I527_TXIE_R &=0A=
			      I527_RXIE_R & I527_INTPND_R &=0A=
			      I527_RMTPND_R & I527_TXRQST_R &=0A=
			      I527_MSGLST_R & I527_NEWDAT_R);=0A=
      i527_write_msgarb(dev, dev->objs[i], 0); =0A=
    }=0A=
  }=0A=
=0A=
  /* set default values */=0A=
  i527_write_reg(dev, I527_BUSCFG_REG, 0x4a);=0A=
  can_setbps(dev, B_250K);=0A=
=0A=
  /* Initialization end */=0A=
  i527_write_reg(dev, I527_STAT_REG, I527_STAT_REG_DEFAULT);=0A=
  if (dev->usecount) =0A=
    {=0A=
      can_enable_irq(dev); /* warm reset */=0A=
    } =0A=
  else =0A=
    {=0A=
      i527_write_reg(dev, I527_CTRL_REG, 0); /* cold reset */=0A=
    }=0A=
}=0A=
=0A=
/*-----------------------------------------------------------------------=
----=0A=
 * This is called from ioctl or from the bottom half handler.=0A=
 * It must configure and possibly transmit an object=0A=
 * Everything checkable has already been checked if we get here.=0A=
-------------------------------------------------------------------------=
- */=0A=
static void can_config_and_transmit(CAN_DEV    *dev,=0A=
			            CAN_MSGOBJ *obj,=0A=
			            CAN_MSG    *msg, int flag)=0A=
{=0A=
  int i;=0A=
=0A=
  /* it looks like message 15 fires an interrupt when re-enabled */=0A=
  if (msg->msgobj !=3D 15) =0A=
    i527_msgflag(dev, obj, I527_MSGVAL_R); /* being updated */=0A=
    =0A=
  if (msg->id !=3D obj->obj_id) {=0A=
    i527_write_msgarb(dev, obj, msg->id);=0A=
    obj->obj_id =3D msg->id;=0A=
    PDEBUG("message has new ID 0x%08lx\n", (unsigned long)obj->obj_id);=0A=
  }=0A=
	  =0A=
  /* write DLC and X flag */=0A=
  i =3D (msg->dlc << I527_DLC_SHIFT) | (msg->config & I527_XTD)=0A=
    | (msg->flags & CAN_MSGFLAG_WRITE ? I527_DIR_TX : I527_DIR_RX);=0A=
  i527_write_msgcfg(dev, obj, i);=0A=
=0A=
  /* write data bytes */=0A=
  if (msg->flags & CAN_MSGFLAG_WRITE)=0A=
    i527_write_msgdata(dev, obj, msg->dlc, msg->data);=0A=
=0A=
  /* now set flags: *XIE, MSGVAL; then clear CPUUpd and set newdat */=0A=
  i527_msgflag(dev, obj,=0A=
		    I527_MSGVAL_S & I527_TXIE_S & I527_RXIE_S);=0A=
=0A=
  if (!flag) =0A=
  { /* only setup, no tx */=0A=
    if (msg->flags & CAN_MSGFLAG_WRITE)=0A=
      i527_msgflag(dev, obj, I527_CPUUPD_R & I527_NEWDAT_S);=0A=
    else=0A=
      i527_msgflag(dev, obj, I527_RMTPND_R & I527_MSGLST_R=0A=
			& I527_NEWDAT_R);=0A=
    return;=0A=
  }=0A=
  /* else, tx too */=0A=
  i527_msgflag(dev, obj, I527_CPUUPD_R & I527_NEWDAT_S & I527_TXRQST_S);=0A=
}=0A=
=0A=
=0A=
//IRQ////////////////////////////////////////////////////////////////////=
////=0A=
/* this bottom half does the work of message handling and buffer popping =
*/=0A=
=0A=
//-----------------------------------------------------------------------=
----=0A=
static void can_write_interrupt(CAN_DEV *dev,=0A=
				CAN_MSGOBJ *obj, int objnum)=0A=
{=0A=
  PDEBUG("can_wi: interrupt on objnum %d\n", objnum);=0A=
=0A=
  /* write-irq flushes the queue and then awakes writers */=0A=
=0A=
  i527_msgflag(dev, obj, I527_INTPND_R);=0A=
  /* head and tail access is atomic with HWBUSY access */=0A=
  spin_lock(&obj->lock);=0A=
  if (obj->head =3D=3D obj->tail) =0A=
    {=0A=
      obj->obj_flags &=3D ~CAN_OBJFLAG_HWBUSY;=0A=
      spin_unlock(&obj->lock);=0A=
      wake_up_interruptible(&obj->write_q);=0A=
      if (obj->async_write_q)=0A=
	kill_fasync(&obj->async_write_q, SIGIO, POLLOUT);=0A=
      return;=0A=
    }=0A=
  spin_unlock(&obj->lock);=0A=
=0A=
  /* else push out another packet */=0A=
  can_config_and_transmit(dev, obj, obj->msg[obj->tail], 1 /* tx */);=0A=
  kmem_cache_free(gpsCache, obj->msg[obj->tail]);=0A=
  obj->msg[obj->tail] =3D NULL;=0A=
  obj->tail =3D (obj->tail + 1) % CAN_BUFSIZE;=0A=
  /* possibly awake writers */=0A=
  if ( ((obj->head + CAN_BUFSIZE - obj->tail) % CAN_BUFSIZE)=0A=
       =3D=3D CAN_BUFSIZE/2) =0A=
    {=0A=
      wake_up_interruptible(&obj->write_q);=0A=
      if (obj->async_write_q)=0A=
	kill_fasync(&obj->async_write_q, SIGIO, POLLOUT);=0A=
    }=0A=
}=0A=
=0A=
//-----------------------------------------------------------------------=
----=0A=
static void can_read_interrupt(CAN_DEV *dev,=0A=
			       CAN_MSGOBJ *obj, int objnum)=0A=
{=0A=
  CAN_MSG *msg;=0A=
  int newhead;=0A=
=0A=
  PDEBUG("can_ri: interrupt on objnum %d\n", objnum);=0A=
=0A=
  /* Check for transmission errors */=0A=
  obj->error =3D 0;=0A=
  if (i527_check_msgflag(dev, obj, I527_MSGLST_S)) =0A=
    {=0A=
      obj->error =3D CAN_ERROR_MSGLST;=0A=
      i527_msgflag(dev, obj, I527_MSGLST_R);=0A=
    }=0A=
    =0A=
  if (objnum !=3D 15 ) =0A=
  { /* Argh!!! it wasn't clear *not* to do that for 15 */=0A=
    /* "The CPU should clear the bit before reading data and check it" */=0A=
    i527_msgflag(dev, obj, I527_NEWDAT_R);=0A=
  }=0A=
=0A=
  newhead =3D (obj->head + 1) % CAN_BUFSIZE;=0A=
  if (newhead =3D=3D obj->tail) =0A=
    {=0A=
      /* overflow, discard this message and mark overlow in the previous =
*/=0A=
      //	printk(KERN_ERR CAN_TEXT "overflow for msgobj %i\n", objnum);=0A=
      printk("ov\n");=0A=
      obj->msg[(obj->head+CAN_BUFSIZE-1)%CAN_BUFSIZE]->error=0A=
	|=3D CAN_ERROR_OVRFLW;=0A=
      goto ack_return;=0A=
    }=0A=
    =0A=
  msg =3D kmem_cache_alloc(gpsCache, GFP_ATOMIC);=0A=
  if (!msg) =0A=
  {=0A=
    printk(KERN_ERR CAN_TEXT "out of memory for packet to msgobj %i\n",=0A=
	   objnum);=0A=
    goto ack_return;=0A=
  }=0A=
  obj->msg[obj->head] =3D msg;=0A=
=0A=
  msg->id        =3D i527_read_msgarb(dev, obj);=0A=
  obj->obj_id    =3D 0; /* invalidate, so tx will set it */=0A=
  msg->msgobj    =3D objnum;=0A=
  msg->config    =3D i527_read_msgcfg(dev, obj);=0A=
  msg->dlc       =3D (msg->config & I527_DLC_MASK) >> I527_DLC_SHIFT;=0A=
  msg->flags     =3D CAN_MSGFLAG_READ;=0A=
  msg->error     =3D obj->error;=0A=
  i527_read_msgdata(dev, obj, msg->dlc, msg->data);=0A=
=0A=
  obj->head =3D newhead;=0A=
  i527_msgflag(dev, obj, I527_INTPND_R);=0A=
=0A=
  /* FIXME: should re-check NewDat according to data sheet */=0A=
  if (objnum =3D=3D 15) =0A=
    {=0A=
      i527_msgflag(dev, obj, I527_NEWDAT_R & I527_RMTPND_R);=0A=
    }=0A=
  PDEBUG("%i bytes from 0x%08lx\n", msg->dlc, (long)msg->id);=0A=
=0A=
  /* Wake any reading process */=0A=
  wake_up_interruptible(&obj->read_q);=0A=
    =0A=
  /* Signal any asynchronous reader */=0A=
  if (obj->async_read_q !=3D NULL)=0A=
    kill_fasync(&obj->async_read_q, SIGIO, POLLIN);=0A=
  return;=0A=
=0A=
 ack_return:=0A=
  i527_msgflag(dev, obj, I527_INTPND_R);=0A=
  if (objnum =3D=3D 15) =0A=
    {=0A=
      i527_msgflag(dev, obj, I527_NEWDAT_R & I527_RMTPND_R);=0A=
    }=0A=
}=0A=
=0A=
=0A=
/* map the interrupt register value to the message object */=0A=
static const int irqtab[17] =3D {=0A=
  0, 0, 15, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,=0A=
};=0A=
=0A=
//-----------------------------------------------------------------------=
--=0A=
static void can_bh(unsigned long nNum)=0A=
{=0A=
  CAN_DEV *dev =3D &gsDev;=0A=
  CAN_MSGOBJ *obj =3D NULL;=0A=
  int objnum;=0A=
  int status, irqreg;=0A=
  unsigned long flags;=0A=
=0A=
  spin_lock_irqsave(&can_lock, flags);=0A=
=0A=
  /* Get the interrupt register -- even if we'd done it at hw irq */=0A=
  irqreg =3D i527_read_reg(dev, I527_INT_REG);=0A=
  status =3D i527_read_reg(dev, I527_STAT_REG);=0A=
  PDEBUG("can_bh: interrupt on irq %d\n", irqreg);=0A=
=0A=
  dev->irq_count++;=0A=
=0A=
#ifdef CAN_DEBUG /* needed to avoid "unused variable lec" */=0A=
  /* print some stupid message */=0A=
  if (1) {=0A=
    PDEBUG("{{{ irq for device\n");=0A=
    if (status & 0x80) PDEBUG("status: BusOff\n");=0A=
    if (status & 0x40) PDEBUG("status: Warning\n");=0A=
    if (status & 0x20) PDEBUG("status: Wake\n");=0A=
    if (status & 0x10) PDEBUG("status: RXOK\n");=0A=
    if (status & 0x08) PDEBUG("status: TXOK\n");=0A=
    if ((status & 0x07) !=3D 7) {=0A=
      static char *lec[]=3D{"No","Stuff","Form","Ack","B1","B0","CRC"};=0A=
      PDEBUG("status: LEC: %s Error\n", lec[status&7]);=0A=
    }=0A=
  }=0A=
#endif /* CAN_DEBUG */=0A=
=0A=
  /* Reset the status register */=0A=
  i527_write_reg(dev, I527_STAT_REG, I527_STAT_REG_DEFAULT);=0A=
   =0A=
  do {=0A=
    objnum =3D irqtab[irqreg];=0A=
=0A=
    if (!objnum) =0A=
    {=0A=
      /* awake sleeping readers and send signals */=0A=
      CAN_ERROR *info =3D dev->errorinfo;=0A=
      PDEBUG("Status Register IRQ (0x%02x)\n", status);=0A=
      dev->statusbyte =3D status;=0A=
      wake_up_interruptible(&dev->error_q);=0A=
	   =0A=
      for (objnum =3D 0; objnum < CAN_NR_ERROR_FILES; objnum++, info++)=0A=
	if (info->file)=0A=
	  kill_proc(info->pid, info->signal, 1);=0A=
      printk("jcan: irq objnum =3D 0\n");=0A=
      continue;=0A=
    }=0A=
=0A=
    obj =3D dev->objs[objnum];=0A=
    if (!obj) =0A=
      {=0A=
	printk("jcan: irq obj =3D 0\n");=0A=
	/* object not allocated, clear the interrupt anyways */=0A=
	i527_msgflag_noobj(dev, objnum, I527_INTPND_R);=0A=
	PDEBUG("resetted irq for unallocated device %i\n", objnum);=0A=
	continue;=0A=
      }=0A=
    else=0A=
      PDEBUG("jcan: irq objnum %d\n", objnum);=0A=
=0A=
=0A=
    if (obj->obj_flags & CAN_OBJFLAG_WRITE)=0A=
      can_write_interrupt(dev, obj, objnum);=0A=
    else=0A=
      can_read_interrupt(dev, obj, objnum);=0A=
    udelay(10);                          /* 14 MCLK max, be safe */=0A=
  } =0A=
  while ( (irqreg =3D i527_read_reg(dev, I527_INT_REG)) ); =0A=
=0A=
  spin_unlock_irqrestore(&can_lock, flags);=0A=
  PDEBUG("end of irq}}}\n");=0A=
}=0A=
=0A=
static DECLARE_TASKLET(can_task, can_bh, (unsigned long)0);=0A=
=0A=
/* actual interrupt handling =
--------------------------------------------*/=0A=
static void can_interrupt(int irq, void *dev_id, struct pt_regs *regs)=0A=
{=0A=
  CAN_DEV *dev =3D (CAN_DEV *) dev_id;=0A=
  int irqreg;=0A=
   =0A=
  /* Get the interrupt register's status */=0A=
  irqreg =3D i527_read_reg(dev, I527_INT_REG);=0A=
=0A=
  if (!irqreg) =0A=
    {=0A=
      return;  /* Not us, probably a shared handler */=0A=
    }=0A=
  if (irqreg > 16) =0A=
    {=0A=
      printk(KERN_ERR CAN_TEXT "irq register too high: %i\n", irqreg);=0A=
      return;=0A=
    }=0A=
=0A=
  /* everything else is done at bottom-half time */=0A=
  PDEBUG("can_int  dev %p int_reg %d\n", dev, irqreg);=0A=
  PDEBUG("** HW irq for device %i:\n", irqtab[irqreg]);=0A=
=0A=
  tasklet_schedule(&can_task);  =0A=
}=0A=
=0A=
/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
 * File operations definitions=0A=
 * ------------------------------------------------------- ioctl-------- =
*/=0A=
static int can_ioctl (struct inode *inode, struct file *filp,=0A=
	 	       unsigned int cmd, unsigned long arg)=0A=
{=0A=
#define IOC_BUFSIZE (CAN_READ_BUFS * sizeof(CAN_MSG))=0A=
=0A=
  static unsigned char localbuf[IOC_BUFSIZE];=0A=
  CAN_DEV *dev =3D filp->private_data;=0A=
  CAN_ERROR *info;=0A=
  int size =3D _IOC_SIZE(cmd); /* the size bitfield in cmd */=0A=
  int i, j, retval =3D 0; /* success by default */=0A=
  /* I'm lazy, and I define "alias" names for the buffer */=0A=
  void *karg =3D localbuf;=0A=
  unsigned long *klong =3D karg;=0A=
  CAN_REG *kreg =3D karg;=0A=
  CAN_MSG *kmsg =3D karg;=0A=
  CAN_MULTIREG *kmulti =3D karg;=0A=
  CAN_MASKS *kmasks =3D karg;=0A=
  CAN_MSGOBJ *obj;=0A=
  unsigned char *area;=0A=
=0A=
  /*=0A=
   * extract the type and number bitfields, and don't decode=0A=
   * wrong cmds: return ENOTTY before verify_area()=0A=
   */=0A=
  if (_IOC_TYPE(cmd) !=3D CAN_IOC_MAGIC) return -ENOTTY;=0A=
  if (_IOC_NR(cmd) > CAN_IOC_MAXNR) return -ENOTTY;=0A=
=0A=
  /*=0A=
   * the direction is a bitmask, and VERIFY_WRITE catches R/W=0A=
   * transfers. `Dir' is user-oriented, while=0A=
   * verify_area is kernel-oriented, so the concept of "read" and=0A=
   * "write" is reversed=0A=
   */=0A=
  if (_IOC_DIR(cmd) & _IOC_READ) =0A=
  {=0A=
    if (!access_ok(VERIFY_WRITE, (void *)arg, size))=0A=
      return -EFAULT;=0A=
  }=0A=
  else =0A=
  if (_IOC_DIR(cmd) & _IOC_WRITE) =0A=
  {=0A=
    if (!access_ok(VERIFY_READ, (void *)arg, size))=0A=
      return -EFAULT;=0A=
  }=0A=
=0A=
  PDEBUG("ioctl: %08x %08lx: nr %i, size %i, dir %i\n",=0A=
	 cmd, arg, _IOC_NR(cmd), _IOC_SIZE(cmd), _IOC_DIR(cmd));=0A=
=0A=
  /* first, retrieve data from userspace */=0A=
  if ((_IOC_DIR(cmd) & _IOC_WRITE) && (size <=3D IOC_BUFSIZE))=0A=
    copy_from_user(karg, (void *)arg, size);=0A=
=0A=
  /* and now the big switch... */=0A=
  switch(cmd) =0A=
    {=0A=
    case CAN_IOCRESET:=0A=
    case CAN_IOCSOFTRESET:=0A=
      can_disable_irq(dev);=0A=
      free_irq(IRQ_NUM, (void *)dev);=0A=
      can_reset_i82527(dev);=0A=
      i527_write_reg(dev, I527_STAT_REG, I527_STAT_REG_DEFAULT);=0A=
#ifdef __powerpc__=0A=
      request_8xxirq(IRQ_NUM, can_interrupt, 0, CAN_NAME, (void *)dev); =0A=
#else=0A=
      request_irq(IRQ_NUM, can_interrupt, 0, CAN_NAME, (void *)dev); =0A=
#endif=0A=
      can_enable_irq(dev);=0A=
      break;=0A=
=0A=
    case CAN_IOCGIRQCOUNT:=0A=
      *klong =3D dev->irq_count;=0A=
      break;=0A=
=0A=
    case CAN_IOCREADREG:=0A=
      kreg->val =3D i527_read_reg(dev, kreg->reg & 0xff);=0A=
      break;=0A=
=0A=
    case CAN_IOCWRITEREG:=0A=
      printk("jcan write reg %02x %02x\n", kreg->reg, kreg->val);=0A=
      i527_write_reg(dev, kreg->reg & 0xff, kreg->val);=0A=
      break;=0A=
=0A=
    case CAN_IOCREADMULTI:=0A=
      if (kmulti->last < kmulti->first)=0A=
	return -EINVAL;=0A=
      if (kmulti->last - kmulti->first + 1 > CAN_MULTIREG_MAX)=0A=
	return -EINVAL;=0A=
      for (i=3D0, j=3Dkmulti->first; j<=3Dkmulti->last; i++, j++)=0A=
	kmulti->regs[i] =3D i527_read_reg(dev, j);=0A=
      break;=0A=
=0A=
    case CAN_IOCWRITEMULTI:=0A=
      if (kmulti->last < kmulti->first)=0A=
	return -EINVAL;=0A=
      if (kmulti->last - kmulti->first + 1 > CAN_MULTIREG_MAX)=0A=
	return -EINVAL;=0A=
      i=3D0;=0A=
      for (i=3D0, j=3Dkmulti->first; j <=3D kmulti->last; j++)=0A=
	i527_write_reg(dev, j, kmulti->regs[i++]);=0A=
      break;=0A=
=0A=
    case CAN_IOCREADALL:=0A=
      area =3D kmalloc(256, GFP_USER);=0A=
      if (!area) return -ENOMEM;=0A=
      for (i=3D0; i<256; i++)=0A=
	((u8 *)area)[i] =3D i527_read_reg(dev, i);=0A=
      copy_to_user((void *)arg, area, 256);=0A=
      kfree(area);=0A=
      return 0;=0A=
=0A=
    case CAN_IOCGETMASKS:=0A=
      kmasks->m_msg15 =3D i527_read_15_mask(dev);=0A=
      kmasks->m_xtd =3D   i527_read_x_mask(dev);=0A=
      kmasks->m_std =3D   i527_read_std_mask(dev);=0A=
      break;=0A=
	  =0A=
    case CAN_IOCSETMASKS:=0A=
      i527_write_15_mask(dev,  kmasks->m_msg15);=0A=
      i527_write_x_mask(dev,   kmasks->m_xtd); =0A=
      i527_write_std_mask(dev, kmasks->m_std);=0A=
      break;=0A=
		=0A=
    case CAN_IOCGETBPS:=0A=
      *klong =3D dev->eBps;=0A=
      break;=0A=
=0A=
    case CAN_IOCSETBPS:=0A=
      can_setbps(dev, (BPS)arg );=0A=
      break;=0A=
=0A=
    case CAN_IOCGETBUSCONF:=0A=
      kreg->val =3D i527_read_reg(dev, I527_BUSCFG_REG);=0A=
      break;=0A=
=0A=
    case CAN_IOCSETBUSCONF:=0A=
      j =3D can_enable_cfg(dev);=0A=
      i527_write_reg(dev, I527_BUSCFG_REG, kreg->val);=0A=
      can_restore_cfg(dev, j);=0A=
      break;=0A=
=0A=
    //-----------------------------------------------------------------=0A=
    case CAN_IOCWRITEMSG:=0A=
    case CAN_IOCSETUPMSG: /* copy the msgobj struct to device registers =
*/=0A=
      if (lib_checkmsgnum(kmsg->msgobj, kmsg->flags))=0A=
	return -EINVAL;=0A=
=0A=
      obj =3D lib_findobj(dev, kmsg->msgobj, GFP_USER);=0A=
      if (!obj) return -ENOMEM;=0A=
      if (lib_setowner(obj, filp, kmsg->flags &=0A=
			    (CAN_MSGFLAG_WRITE | CAN_MSGFLAG_READ) ))=0A=
	return -EBUSY;=0A=
=0A=
      /* before we touch the message, ensure it's not transmitting */=0A=
      if (obj->obj_flags & CAN_OBJFLAG_HWBUSY) {=0A=
	if (filp->f_flags & O_NONBLOCK) return -EAGAIN;=0A=
	wait_event_interruptible(obj->write_q,=0A=
				 !(obj->obj_flags &CAN_OBJFLAG_HWBUSY));=0A=
	if (signal_pending(current)) return -ERESTARTSYS;=0A=
      }=0A=
=0A=
      if (cmd =3D=3D CAN_IOCWRITEMSG)=0A=
	obj->obj_flags |=3D CAN_OBJFLAG_HWBUSY;=0A=
      can_config_and_transmit(dev, obj, kmsg,=0A=
			       cmd =3D=3D CAN_IOCWRITEMSG ? 1 : 0);=0A=
      break;=0A=
=0A=
    case CAN_IOCWRITEQ: /* place it in the queue */=0A=
#if 0=0A=
      if (lib_checkmsgnum(kmsg->msgobj, kmsg->flags))=0A=
	return -EINVAL;=0A=
=0A=
      obj =3D lib_findobj(dev, kmsg->msgobj, GFP_USER);=0A=
      if (!obj) return -ENOMEM;=0A=
      if (lib_setowner(obj, filp, kmsg->flags &=0A=
			    (CAN_MSGFLAG_WRITE | CAN_MSGFLAG_READ) ))=0A=
	return -EBUSY;=0A=
=0A=
      /* place the message in the queue */=0A=
      i =3D (obj->head + 1) % CAN_BUFSIZE;=0A=
      if (i =3D=3D obj->tail) {=0A=
	/* queue full: sleep -- no problem with concurrent access */=0A=
	if (filp->f_flags & O_NONBLOCK) return -EAGAIN;=0A=
	wait_event_interruptible(obj->write_q, (i !=3D obj->tail));=0A=
	if (signal_pending(current)) return -ERESTARTSYS;=0A=
      }=0A=
      newmsg =3D kmem_cache_alloc(gpsCache, GFP_USER);=0A=
      if (!newmsg) {=0A=
	printk(KERN_ERR "can't allocate outgoing packet for msg %i\n",=0A=
	       kmsg->msgobj);=0A=
	return -ENOMEM;=0A=
      }=0A=
      spin_lock_bh(obj->lock);=0A=
      /* if already tranmitting, just add this to the queue */=0A=
      if ( obj->obj_flags & CAN_OBJFLAG_HWBUSY ) {=0A=
	*newmsg =3D *kmsg;=0A=
	obj->msg[obj->head] =3D newmsg;=0A=
	obj->head =3D i;=0A=
	spin_unlock_bh(obj->lock);=0A=
	break;=0A=
      } =0A=
      spin_unlock_bh(obj->lock);=0A=
=0A=
      /* not transmitting, can safely begin transmission */=0A=
      obj->obj_flags |=3D CAN_OBJFLAG_HWBUSY;=0A=
      kmem_cache_free(gpsCache, newmsg);=0A=
      can_config_and_transmit(dev, obj, kmsg, 1);=0A=
#endif=0A=
      break;=0A=
=0A=
    //-------------------------------------------------------------------=0A=
    case CAN_IOCTXMSG: /* tx only, no need to call config_and_transmit() =
*/=0A=
      if (lib_checkmsgnum(*klong, CAN_MSGFLAG_WRITE))=0A=
	return -EINVAL;=0A=
      obj =3D lib_findobj(dev, *klong, GFP_USER);=0A=
      if (!obj) return -ENOMEM;=0A=
      if (obj->owner !=3D filp) return -EPERM;=0A=
      if (obj->obj_flags & CAN_OBJFLAG_HWBUSY) {=0A=
	if (filp->f_flags & O_NONBLOCK) return -EAGAIN;=0A=
	wait_event_interruptible(obj->write_q,=0A=
				 !(obj->obj_flags &CAN_OBJFLAG_HWBUSY));=0A=
	if (signal_pending(current)) return -ERESTARTSYS;=0A=
      }=0A=
      obj->obj_flags |=3D CAN_OBJFLAG_HWBUSY;=0A=
      i527_msgflag(dev, obj, I527_CPUUPD_R & I527_NEWDAT_S=0A=
			& I527_TXRQST_S);=0A=
      break;=0A=
=0A=
    =
//--------------------------------------------------------------------=0A=
    case CAN_IOCRXMSG:=0A=
      /* the message must be already configured and owned */=0A=
      if (lib_checkmsgnum(kmsg->msgobj, CAN_MSGFLAG_READ))=0A=
	return -EINVAL;=0A=
      obj =3D lib_findobj(dev, kmsg->msgobj, GFP_USER);=0A=
      if (!obj) return -ENOMEM;=0A=
      if (obj->owner !=3D filp) return -EPERM;=0A=
=0A=
      if (obj->head =3D=3D obj->tail) {=0A=
	if (filp->f_flags & O_NONBLOCK) {=0A=
	  return -EAGAIN;=0A=
	}=0A=
	wait_event_interruptible(obj->read_q, obj->head !=3D obj->tail);=0A=
	if (signal_pending(current))=0A=
	  return -ERESTARTSYS;=0A=
	if (obj->head =3D=3D obj->tail) {=0A=
	  PDEBUG("Argh: no message\n");=0A=
	  return -EFAULT; /* Hmmm.... */=0A=
	}=0A=
      }=0A=
=0A=
      PDEBUG("jcan: received msg\n");=0A=
      i=3D0;=0A=
      while((i < CAN_READ_BUFS) && (obj->head !=3D obj->tail)) =0A=
	{=0A=
	  /* ok, we have a message to pull from the buffer */=0A=
	  *kmsg++ =3D *(obj->msg[obj->tail]);=0A=
	  kmem_cache_free(gpsCache, obj->msg[obj->tail]);=0A=
	  obj->msg[obj->tail] =3D NULL;=0A=
	  obj->tail =3D (obj->tail+1) % CAN_BUFSIZE;=0A=
	  i++;=0A=
	}=0A=
      retval =3D i;=0A=
      size =3D retval * sizeof(CAN_MSG);=0A=
      break;=0A=
=0A=
    case CAN_IOCPEEKMSG: /* similar, but never sleep and use an exact ID =
*/=0A=
#if 0=0A=
      if (lib_checkmsgnum(kmsg->msgobj, CAN_MSGFLAG_READ))=0A=
	return -EINVAL;=0A=
      obj =3D lib_findobj(dev, kmsg->msgobj, GFP_USER);=0A=
      if (!obj) return -ENOMEM;=0A=
      if (obj->owner !=3D filp) return -EPERM;=0A=
=0A=
      for (i =3D obj->tail; i !=3D obj->head; i =3D i+1 % CAN_BUFSIZE) {=0A=
	PDEBUG("peeking item %i (%x %x -- %x %x)\n", i,=0A=
	       obj->msg[i]->id, kmsg->id,=0A=
	       obj->msg[i]->config&I527_XTD,=0A=
	       kmsg->config&I527_XTD);=0A=
	if ((obj->msg[i]->id =3D=3D kmsg->id) &&=0A=
	    ((obj->msg[i]->config&I527_XTD) =3D=3D (kmsg->config&I527_XTD)))=0A=
	  break;=0A=
      }=0A=
      if (i =3D=3D obj->head) return -EAGAIN;=0A=
=0A=
      j =3D kmsg->flags;=0A=
      *kmsg =3D *(obj->msg[i]);=0A=
      PDEBUG("peekonly: %i\n", j&CAN_MSGFLAG_PEEKONLY);=0A=
      if (j & CAN_MSGFLAG_PEEKONLY)=0A=
	break; /* return the data but leave it there */=0A=
      kmem_cache_free(gpsCache, obj->msg[i]);=0A=
=0A=
      /*=0A=
       * remove the packet by shifting pointers: don't touch head=0A=
       * as it is the active end, modified at interrupt time=0A=
       */=0A=
      while (i !=3D obj->tail) {=0A=
	j =3D (i-1 + CAN_BUFSIZE) % CAN_BUFSIZE;=0A=
	PDEBUG("copy %i to %i\n", j, i);=0A=
	obj->msg[i] =3D obj->msg[j];=0A=
	i =3D j;=0A=
      }=0A=
      obj->tail =3D (i+1) % CAN_BUFSIZE;=0A=
#endif=0A=
      break;=0A=
=0A=
    case CAN_IOCRELEASEMSG:=0A=
      if (lib_checkmsgnum(*klong, CAN_MSGFLAG_READ))=0A=
	return -EINVAL;=0A=
      obj =3D lib_findobj(dev, *klong, GFP_USER);=0A=
      if (!obj) return -ENOMEM;=0A=
      if (obj->owner !=3D filp) return -EPERM;=0A=
      lib_releaseobj(dev, *klong, obj);=0A=
      break;=0A=
	  =0A=
    case CAN_IOCREQSIGNAL:=0A=
      if (*klong >=3D SIGRTMIN) return -EINVAL;=0A=
      /* change an entry, if already there */=0A=
      info =3D lib_findfile(dev, filp);=0A=
      if (info) {=0A=
	if (!*klong) info->file =3D NULL;=0A=
	else info->signal =3D *klong;=0A=
	break;=0A=
      }=0A=
      /* look for a free slot */=0A=
      info =3D dev->errorinfo;=0A=
      for (i =3D 0; i<CAN_NR_ERROR_FILES; i++, info++)=0A=
	if (!info->file)=0A=
	  break;=0A=
      if (i =3D=3D CAN_NR_ERROR_FILES) return -EBUSY;=0A=
=0A=
      info->file =3D filp;=0A=
      info->pid =3D current->pid;=0A=
      info->signal =3D *klong;=0A=
      break;=0A=
=0A=
      /*=0A=
       * I/O ports=0A=
       */=0A=
    case CAN_IOCINPUT:=0A=
      if (kreg->reg !=3D 1 && kreg->reg !=3D 2) return -EINVAL;=0A=
      kreg->val =3D i527_read_reg(dev, kreg->reg =3D=3D 1=0A=
				     ? I527_P1IN : I527_P2IN);=0A=
      break;=0A=
=0A=
    case CAN_IOCOUTPUT:=0A=
      if (kreg->reg !=3D 1 && kreg->reg !=3D 2) return -EINVAL;=0A=
      i527_write_reg(dev, kreg->reg =3D=3D 1=0A=
			  ? I527_P1OUT : I527_P2OUT, kreg->val);=0A=
      break;=0A=
=0A=
    case CAN_IOCIOCFG:=0A=
      if (kreg->reg !=3D 1 && kreg->reg !=3D 2) return -EINVAL;=0A=
      i527_write_reg(dev, kreg->reg =3D=3D 1=0A=
			  ? I527_P1CONF : I527_P2CONF, kreg->val);=0A=
      break;=0A=
=0A=
=0A=
    default:=0A=
      PDEBUG("ioctl: no such command\n");=0A=
      return -ENOTTY;=0A=
    }=0A=
  /* finally, copy data to user space and return */=0A=
  if (retval < 0) return retval;=0A=
  if ((_IOC_DIR(cmd) & _IOC_READ) && (size <=3D IOC_BUFSIZE))=0A=
    copy_to_user((void *)arg, karg, size);=0A=
  return retval; /* sometimes, positive is what I want */=0A=
}=0A=
=0A=
=0A=
//-----------------------------------------------------------------------=
--=0A=
static ssize_t can_read(struct file *file, char *buf, =0A=
                         size_t count, loff_t *ppos)=0A=
{=0A=
  //  CAN_DEV *dev =3D (CAN_DEV *) file->private_data;=0A=
  //  int minor =3D MINOR(file->f_dentry->d_inode->i_rdev);=0A=
  //  int num =3D CAN_DEV_TYPE(minor);=0A=
  //  unsigned char status;=0A=
=0A=
  return -ENOSYS; /* FIXME: reimplement write */=0A=
}=0A=
=0A=
//-----------------------------------------------------------------------=
--=0A=
static ssize_t can_write(struct file *file, const char *buf, =0A=
                          size_t count, loff_t *ppos)=0A=
{=0A=
  //  CAN_DEV *dev =3D (CAN_DEV *) file->private_data;=0A=
  //  int minor =3D MINOR(file->f_dentry->d_inode->i_rdev);=0A=
  //  int num =3D CAN_DEV_TYPE(minor);=0A=
=0A=
  return -ENOSYS; /* FIXME: reimplement write */=0A=
=0A=
}=0A=
=0A=
=0A=
//-----------------------------------------------------------------------=
--=0A=
static int can_open(struct inode *inode, struct file *file)=0A=
{=0A=
  int minor =3D MINOR(inode->i_rdev); =0A=
  int num =3D CAN_DEV_TYPE(minor);=0A=
  int accmode =3D file->f_flags & O_ACCMODE;=0A=
=0A=
  /* We cannot open Message Objects 1-15 for both reading and writing */=0A=
  if ((num >=3D 1) && (num < 15) && accmode =3D=3D O_RDWR)=0A=
    return -EACCES;=0A=
=0A=
  /* We cannot open Message Object 15 for writing */=0A=
  if ((num =3D=3D 15) && (accmode !=3D O_RDONLY))=0A=
    return -EACCES;=0A=
=0A=
  /* Set the device's private data */=0A=
  file->private_data =3D &gsDev;=0A=
=0A=
  /* Check for first open for 82527 */=0A=
  if (++(gsDev.usecount) =3D=3D 1) =0A=
    {=0A=
      PDEBUG("first open, enable interrupts\n");=0A=
      i527_write_reg(&gsDev, I527_STAT_REG, I527_STAT_REG_DEFAULT);=0A=
      can_enable_irq(&gsDev);=0A=
    }=0A=
=0A=
  MOD_INC_USE_COUNT;=0A=
  return 0;=0A=
}=0A=
=0A=
//-----------------------------------------------------------------------=
--=0A=
static int can_release(struct inode *inode, struct file *file)=0A=
{=0A=
  CAN_DEV *dev =3D (CAN_DEV *) file->private_data;=0A=
  CAN_MSGOBJ *obj;=0A=
  CAN_ERROR  *info;=0A=
  int i;=0A=
=0A=
  /* independently of the minor number, look for any owned objects */=0A=
  for (i =3D I527_FIRST_OBJ; i < I527_MSG_OBJS; i++) =0A=
    {=0A=
      obj =3D dev->objs[i];=0A=
      if (obj && obj->owner =3D=3D file)=0A=
	lib_releaseobj(dev, i, obj);=0A=
    }=0A=
  /* similarly, release signal notification */=0A=
  info =3D lib_findfile(dev, file);=0A=
  if (info)=0A=
    info->file =3D 0;=0A=
=0A=
  /* Check for last close  for 82527 */=0A=
  if (--(dev->usecount) =3D=3D 0) =0A=
    {=0A=
      PDEBUG("last close, disable interrupts\n");=0A=
      can_disable_irq(dev);=0A=
    }=0A=
=0A=
  MOD_DEC_USE_COUNT;=0A=
  return 0;=0A=
}=0A=
=0A=
/*-----------------------------------------------------------------------=
--=0A=
 * Setup file operations=0A=
 */=0A=
=0A=
static struct file_operations can_fops =3D {=0A=
  ioctl:	can_ioctl,=0A=
  read: 	can_read,=0A=
  write:	can_write,=0A=
  open:	        can_open,=0A=
  release:	can_release,=0A=
};=0A=
=0A=
//-----------------------------------------------------------------------=
--=0A=
static void cleanup_device(CAN_DEV *dev)=0A=
{=0A=
  int i;=0A=
=0A=
  if (dev->gotirq)=0A=
    free_irq(IRQ_NUM, (void *)dev);=0A=
=0A=
  for (i =3D 0; i<I527_MSG_OBJS; i++)=0A=
    if ( dev->objs[i]) =0A=
      {=0A=
        if (dev->objs[i]->msg)=0A=
	  kfree(dev->objs[i]->msg);=0A=
	kfree(dev->objs[i]);=0A=
	dev->objs[i] =3D NULL;=0A=
      }   =0A=
}=0A=
=0A=
//-----------------------------------------------------------------------=
--=0A=
int __init init_device(void)=0A=
{=0A=
  int i;=0A=
  int nRet =3D 0;=0A=
  CAN_DEV *dev =3D &gsDev;=0A=
=0A=
  printk(KERN_INFO CAN_TEXT "setting up device, base %x, irq %i\n",=0A=
	                                            IO_ADDR, IRQ_NUM);=0A=
=0A=
  gpsCache =3D kmem_cache_create("jcan-packet", sizeof(CAN_MSG),=0A=
			       0, SLAB_HWCACHE_ALIGN, NULL, NULL);=0A=
  if (!gpsCache) =0A=
    {=0A=
      printk(KERN_ERR CAN_TEXT "cannot allocate cache for packets\n");=0A=
      return -ENOMEM;=0A=
    }=0A=
=0A=
  memset(dev, 0, sizeof(*dev));=0A=
=0A=
  // Allocate all message objects=0A=
  for (i =3D 1; i<I527_MSG_OBJS; i++) =0A=
    {=0A=
      CAN_MSGOBJ *obj;=0A=
      if (!(obj =3D kmalloc(sizeof(CAN_MSGOBJ), GFP_KERNEL)))=0A=
	break;=0A=
      memset(obj, 0, sizeof(*obj));=0A=
      obj->regbase =3D i * I527_MSG_OFF;=0A=
      spin_lock_init(&obj->lock);=0A=
   =0A=
      dev->objs[i] =3D obj;=0A=
      obj->msg =3D kmalloc(CAN_BUFSIZE * sizeof(CAN_MSG *),=0A=
			 GFP_KERNEL);=0A=
      if (!obj->msg) break;=0A=
      memset(obj->msg, 0, CAN_BUFSIZE * sizeof(CAN_MSG *));=0A=
    }=0A=
  if (i < I527_MSG_OBJS) =0A=
    {=0A=
      nRet =3D -ENOMEM; goto fail;=0A=
    }=0A=
=0A=
  // map device=0A=
  dev->base =3D (long) ioremap(IO_ADDR, IO_RANGE ); =0A=
  if (! dev->base) =0A=
    {=0A=
      printk(KERN_ERR CAN_TEXT "I/O map at 0x%x busy\n", IO_ADDR);   =0A=
      goto fail;=0A=
    }=0A=
  else=0A=
    printk("jcan: remapped to: 0x%lx\n", (long)dev->base);=0A=
=0A=
    /* Wait queue initialization */=0A=
  init_waitqueue_head(&dev->error_q);=0A=
  for (i=3D0; i<I527_MSG_OBJS; i++) =0A=
  {=0A=
    if (dev->objs[i]) =0A=
    {=0A=
      init_waitqueue_head(&dev->objs[i]->read_q);=0A=
      init_waitqueue_head(&dev->objs[i]->write_q);=0A=
    }=0A=
  }=0A=
#ifdef __powerpc__=0A=
  // Make IRQ3 edge sensitive.=0A=
  ((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel |=3D 0x02000000;=0A=
  nRet =3D request_8xxirq(IRQ_NUM, can_interrupt, 0, CAN_NAME, (void =
*)dev); =0A=
#else=0A=
  nRet =3D request_irq(IRQ_NUM, can_interrupt, 0, CAN_NAME, (void =
*)dev); =0A=
#endif=0A=
  if (nRet) =0A=
    {=0A=
      printk(KERN_ERR CAN_TEXT "dev: can't get irq %i\n", IRQ_NUM);=0A=
      goto fail;=0A=
    }=0A=
=0A=
  dev->gotirq =3D 1;=0A=
  can_reset_i82527(dev); /* can't fail */=0A=
=0A=
  /* Register the char device */=0A=
  nRet =3D register_chrdev(CAN_MAJOR, CAN_NAME, &can_fops);=0A=
  if (nRet < 0) =0A=
    {=0A=
      printk(KERN_ERR CAN_TEXT "can't get major %d\n", CAN_MAJOR);=0A=
      goto fail;=0A=
    }=0A=
  dev->registered =3D 1;   =0A=
  return 0; /* success */=0A=
=0A=
 fail:=0A=
  cleanup_device(dev);=0A=
  return nRet;=0A=
}=0A=
=0A=
#ifdef MODULE=0A=
//MODULE_LICENSE("GPL");=0A=
MODULE_AUTHOR("George Cewe");=0A=
MODULE_DESCRIPTION("Driver for i82527 CAN controller");=0A=
=0A=
//-----------------------------------------------------------------------=
-=0A=
static int can_init(void)=0A=
{=0A=
  int nRet;=0A=
=0A=
  nRet =3D init_device();=0A=
=0A=
  if(!nRet)=0A=
    printk(KERN_INFO CAN_TEXT "loaded (%sdebugging mode)\n",=0A=
	                                debug ? "" : "non-");=0A=
  return nRet;=0A=
}=0A=
=0A=
=0A=
//-----------------------------------------------------------------------=
-=0A=
static void can_cleanup(void)=0A=
{=0A=
  cleanup_device(&gsDev);=0A=
=0A=
  if (gsDev.registered) =0A=
      unregister_chrdev(CAN_MAJOR, CAN_NAME);=0A=
=0A=
  if (gpsCache) =0A=
    kmem_cache_destroy(gpsCache);=0A=
=0A=
  printk(KERN_INFO CAN_TEXT "driver removed\n");=0A=
}=0A=
=0A=
module_init(can_init);=0A=
module_exit(can_cleanup);=0A=
=0A=
#endif=0A=

------=_NextPart_000_0052_01C2EEDF.DCC6A9C0--

