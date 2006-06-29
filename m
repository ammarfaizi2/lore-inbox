Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWF2RO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWF2RO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWF2RO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:14:28 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:38025 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1750896AbWF2RO0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:14:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 3/7] powerpc: Add QE library qe_lib--common files
Date: Thu, 29 Jun 2006 20:14:15 +0300
Message-ID: <75B28D1B75754E4BAEAF634C9498EC9009904E@zil05exm11.fsl.freescale.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/7] powerpc: Add QE library qe_lib--common files
Thread-Index: AcabmcEK1/kOnAW1RHGOIjcjyqrwJQABYjAg
From: "Gridish Shlomi-RM96313" <gridish@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: "Li Yang-r58472" <LeoLi@freescale.com>,
       "Paul Mackerras" <paulus@samba.org>, <linuxppc-dev@ozlabs.org>,
       <linux-kernel@vger.kernel.org>,
       "Chu hanjin-r52514" <Hanjin.Chu@freescale.com>,
       "Phillips Kim-R1AAHA" <Kim.Phillips@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I agree.
Note that the code is already has 'USE_RHEAP' flag so it can be used
instead of the MM when the RHEAP will be fixed.
Shlomi
 

-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org] 
Sent: Thursday, June 29, 2006 19:33
To: Gridish Shlomi-RM96313
Cc: Li Yang-r58472; Paul Mackerras; linuxppc-dev@ozlabs.org;
linux-kernel@vger.kernel.org; Chu hanjin-r52514; Phillips Kim-R1AAHA
Subject: Re: [PATCH 3/7] powerpc: Add QE library qe_lib--common files


On Jun 29, 2006, at 11:06 AM, Gridish Shlomi-RM96313 wrote:

> Hi all,
>
> The reason why I chose  to work with MM and not with RHEAP is that,
> apparently, there is a BUG in the RHEAP module,
> it is not allocating correctly blocks that require alignments grater
> than 8.
> The usage of MM is only a temporary solution till RHEAP is fixed.
>
> Regards,
> Shlomi

Will fix rheap than.  We aren't going to merge in QE support with a  
new memory allocator.

- kumar

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Wednesday, June 28, 2006 22:20
> To: Li Yang-r58472
> Cc: 'Paul Mackerras'; linuxppc-dev@ozlabs.org;
> 'linux-kernel@vger.kernel.org'; Chu hanjin-r52514; Gridish
> Shlomi-RM96313; Phillips Kim-R1AAHA
> Subject: Re: [PATCH 3/7] powerpc: Add QE library qe_lib--common files
>
> Nack, remove the mm allocation code and just use rheap.
>
> - k
>
> On Jun 28, 2006, at 9:23 AM, Li Yang-r58472 wrote:
>
>>
>> Signed-off-by: Shlomi Gridish <gridish@freescale.com>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
>>
>> ---
>>  arch/powerpc/Kconfig                   |   12
>>  arch/powerpc/sysdev/Makefile           |    1
>>  arch/powerpc/sysdev/ipic.c             |    2
>>  arch/powerpc/sysdev/qe_lib/Kconfig     |  315 +++++++++++++
>>  arch/powerpc/sysdev/qe_lib/Makefile    |    8
>>  arch/powerpc/sysdev/qe_lib/mm.c        |  770 +++++++++++++++++++++
>> +++++++++++
>>  arch/powerpc/sysdev/qe_lib/mm.h        |    6
>>  arch/powerpc/sysdev/qe_lib/qe.c        |  181 ++++++++
>>  arch/powerpc/sysdev/qe_lib/qe_common.c |  401 +++++++++++++++++
>>  arch/powerpc/sysdev/qe_lib/qe_ic.c     |  487 ++++++++++++++++++++
>>  arch/powerpc/sysdev/qe_lib/qe_ic.h     |   83 +++
>>  arch/powerpc/sysdev/qe_lib/qe_io.c     |  275 +++++++++++
>>  12 files changed, 2541 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 6729c98..6d4fc0b 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -334,6 +334,16 @@ config APUS
>>  	  <http://linux-apus.sourceforge.net/>.
>>  endchoice
>>
>> +config QUICC_ENGINE
>> +	bool
>> +	depends on MPC836x
>> +	default y
>> +	help
>> +	  The QE(QUICC Engine) is a new generation of coprocessor on
>> +	  Freescale embedded CPUs(like CPM  in older chips).  Selecting
>> +	  this option means that you wish to build a kernel for a
> machine
>> +	  with QE coprocessor on it.
>> +
>>  config PPC_PSERIES
>>  	depends on PPC_MULTIPLATFORM && PPC64
>>  	bool "  IBM pSeries & new (POWER5-based) iSeries"
>> @@ -993,6 +1003,8 @@ # XXX source "arch/ppc/8xx_io/Kconfig"
>>
>>  # XXX source "arch/ppc/8260_io/Kconfig"
>>
>> +source "arch/powerpc/sysdev/qe_lib/Kconfig"
>> +
>>  source "arch/powerpc/platforms/iseries/Kconfig"
>>
>>  source "lib/Kconfig"
>> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/
>> Makefile
>> index 4c2b356..cd1d5cc 100644
>> --- a/arch/powerpc/sysdev/Makefile
>> +++ b/arch/powerpc/sysdev/Makefile
>> @@ -8,3 +8,4 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
>>  obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
>>  obj-$(CONFIG_PPC_83xx)		+= ipic.o
>>  obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
>> +obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
>> diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
>> index 8f01e0f..dbeccba 100644
>> --- a/arch/powerpc/sysdev/ipic.c
>> +++ b/arch/powerpc/sysdev/ipic.c
>> @@ -537,12 +537,14 @@ void ipic_set_highest_priority(unsigned
>>
>>  void ipic_set_default_priority(void)
>>  {
>> +#ifdef CONFIG_MPC834x
>>  	ipic_set_priority(MPC83xx_IRQ_TSEC1_TX, 0);
>>  	ipic_set_priority(MPC83xx_IRQ_TSEC1_RX, 1);
>>  	ipic_set_priority(MPC83xx_IRQ_TSEC1_ERROR, 2);
>>  	ipic_set_priority(MPC83xx_IRQ_TSEC2_TX, 3);
>>  	ipic_set_priority(MPC83xx_IRQ_TSEC2_RX, 4);
>>  	ipic_set_priority(MPC83xx_IRQ_TSEC2_ERROR, 5);
>> +#endif
>>  	ipic_set_priority(MPC83xx_IRQ_USB2_DR, 6);
>>  	ipic_set_priority(MPC83xx_IRQ_USB2_MPH, 7);
>>
>> diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/
>> sysdev/qe_lib/Kconfig
>> new file mode 100644
>> index 0000000..6105237
>> --- /dev/null
>> +++ b/arch/powerpc/sysdev/qe_lib/Kconfig
>> @@ -0,0 +1,315 @@
>> +#
>> +# QE Communication options
>> +#
>> +
>> +menu "QE Options"
>> +	depends on QUICC_ENGINE
>> +	
>> +config UCC1
>> +	bool "Enable QE UCC1"
>> +
>> +choice
>> +	prompt "UCC1 speed selection"
>> +	depends on UCC1
>> +	default UCC1_SLOW
>> +
>> +	config UCC1_SLOW
>> +		bool "UCC1 is slow"
>> +	config UCC1_FAST
>> +		bool "UCC1 is fast"
>> +endchoice
>> +
>> +menu "UCC1 Protocols options"
>> +	depends on UCC1
>> +
>> +	choice
>> +		prompt "UCC1 Slow Protocols selection"
>> +		depends on UCC1_SLOW
>> +		default UCC1_UART
>> +
>> +		config UCC1_UART
>> +			bool "UCC1 is UART"
>> +	endchoice
>> +
>> +	choice
>> +		prompt "UCC1 Fast Protocols selection"
>> +		depends on UCC1_FAST
>> +		default UCC1_GETH
>> +
>> +		config UCC1_GETH
>> +			bool "UCC1 is GETH"
>> +	endchoice
>> +endmenu
>> +
>> +config UCC2
>> +	bool "Enable QE UCC2"
>> +
>> +choice
>> +	prompt "UCC2 speed selection"
>> +	depends on UCC2
>> +	default UCC2_SLOW
>> +
>> +	config UCC2_SLOW
>> +		bool "UCC2 is slow"
>> +	config UCC2_FAST
>> +		bool "UCC2 is fast"
>> +endchoice
>> +
>> +menu "UCC2 Protocols options"
>> +	depends on UCC2
>> +
>> +	choice
>> +		prompt "UCC2 Slow Protocols selection"
>> +		depends on UCC2_SLOW
>> +		default UCC2_UART
>> +
>> +		config UCC2_UART
>> +			bool "UCC2 is UART"
>> +	endchoice
>> +
>> +	choice
>> +		prompt "UCC2 Fast Protocols selection"
>> +		depends on UCC2_FAST
>> +		default UCC2_GETH
>> +
>> +		config UCC2_GETH
>> +			bool "UCC2 is GETH"
>> +	endchoice
>> +endmenu
>> +
>> +config UCC3
>> +	bool "Enable QE UCC3"
>> +
>> +choice
>> +	prompt "UCC3 speed selection"
>> +	depends on UCC3
>> +	default UCC3_SLOW
>> +
>> +	config UCC3_SLOW
>> +		bool "UCC3 is slow"
>> +	config UCC3_FAST
>> +		bool "UCC3 is fast"
>> +endchoice
>> +
>> +menu "UCC3 Protocols options"
>> +	depends on UCC3
>> +
>> +	choice
>> +		prompt "UCC3 Slow Protocols selection"
>> +		depends on UCC3_SLOW
>> +		default UCC3_UART
>> +
>> +		config UCC3_UART
>> +			bool "UCC3 is UART"
>> +        endchoice
>> +
>> +	config UCC3_GETH
>> +		depends on UCC3_FAST
>> +		bool "UCC3 is GETH"
>> +
>> +	config UCC3_ATM
>> +		depends on UCC3_FAST && !UCC3_GETH
>> +		tristate "UCC3 is ATM"
>> +endmenu
>> +
>> +config UCC4
>> +	bool "Enable QE UCC4"
>> +
>> +choice
>> +	prompt "UCC4 speed selection"
>> +	depends on UCC4
>> +	default UCC4_SLOW
>> +
>> +	config UCC4_SLOW
>> +		bool "UCC4 is slow"
>> +	config UCC4_FAST
>> +		bool "UCC4 is fast"
>> +endchoice
>> +
>> +menu "UCC4 Protocols options"
>> +	depends on UCC4
>> +
>> +	choice
>> +		prompt "UCC4 Slow Protocols selection"
>> +		depends on UCC4_SLOW
>> +		default UCC4_UART
>> +
>> +		config UCC4_UART
>> +			bool "UCC4 is UART"
>> +	endchoice
>> +
>> +	choice
>> +		prompt "UCC4 Fast Protocols selection"
>> +		depends on UCC4_FAST
>> +		default UCC4_GETH
>> +
>> +		config UCC4_GETH
>> +			bool "UCC4 is GETH"
>> +	endchoice
>> +endmenu
>> +
>> +config UCC5
>> +	bool "Enable QE UCC5"
>> +
>> +choice
>> +	prompt "UCC5 speed selection"
>> +	depends on UCC5
>> +	default UCC5_SLOW
>> +
>> +	config UCC5_SLOW
>> +		bool "UCC5 is slow"
>> +	config UCC5_FAST
>> +		bool "UCC5 is fast"
>> +endchoice
>> +
>> +menu "UCC5 Protocols options"
>> +	depends on UCC5
>> +
>> +	choice
>> +		prompt "UCC5 Slow Protocols selection"
>> +		depends on UCC5_SLOW
>> +		default UCC5_UART
>> +
>> +		config UCC5_UART
>> +			bool "UCC5 is UART"
>> +	endchoice
>> +
>> +	choice
>> +		prompt "UCC5 Fast Protocols selection"
>> +		depends on UCC5_FAST
>> +		default UCC5_GETH
>> +
>> +		config UCC5_GETH
>> +			bool "UCC5 is GETH"
>> +	endchoice
>> +endmenu
>> +
>> +config UCC6
>> +	bool "Enable QE UCC6"
>> +
>> +choice
>> +	prompt "UCC6 speed selection"
>> +	depends on UCC6
>> +	default UCC6_SLOW
>> +
>> +	config UCC6_SLOW
>> +		bool "UCC6 is slow"
>> +	config UCC6_FAST
>> +		bool "UCC6 is fast"
>> +endchoice
>> +
>> +menu "UCC6 Protocols options"
>> +	depends on UCC6
>> +
>> +	choice
>> +		prompt "UCC6 Slow Protocols selection"
>> +		depends on UCC6_SLOW
>> +		default UCC6_UART
>> +
>> +		config UCC6_UART
>> +			bool "UCC6 is UART"
>> +	endchoice
>> +
>> +	choice
>> +		prompt "UCC6 Fast Protocols selection"
>> +		depends on UCC6_FAST
>> +		default UCC6_GETH
>> +
>> +		config UCC6_GETH
>> +			bool "UCC6 is GETH"
>> +	endchoice
>> +endmenu
>> +
>> +config UCC7
>> +	bool "Enable QE UCC7"
>> +
>> +choice
>> +	prompt "UCC7 speed selection"
>> +	depends on UCC7
>> +	default UCC7_SLOW
>> +
>> +	config UCC7_SLOW
>> +		bool "UCC7 is slow"
>> +	config UCC7_FAST
>> +		bool "UCC7 is fast"
>> +endchoice
>> +
>> +menu "UCC7 Protocols options"
>> +	depends on UCC7
>> +
>> +	choice
>> +		prompt "UCC7 Slow Protocols selection"
>> +		depends on UCC7_SLOW
>> +		default UCC7_UART
>> +
>> +		config UCC7_UART
>> +			bool "UCC7 is UART"
>> +	endchoice
>> +
>> +	choice
>> +		prompt "UCC7 Fast Protocols selection"
>> +		depends on UCC7_FAST
>> +		default UCC7_GETH
>> +
>> +		config UCC7_GETH
>> +			bool "UCC7 is GETH"
>> +	endchoice
>> +endmenu
>> +
>> +config UCC8
>> +	bool "Enable QE UCC8"
>> +
>> +choice
>> +	prompt "UCC8 speed selection"
>> +	depends on UCC8
>> +	default UCC8_SLOW
>> +
>> +	config UCC8_SLOW
>> +		bool "UCC8 is slow"
>> +	config UCC8_FAST
>> +		bool "UCC8 is fast"
>> +endchoice
>> +
>> +menu "UCC8 Protocols options"
>> +	depends on UCC8
>> +
>> +	choice
>> +		prompt "UCC8 Slow Protocols selection"
>> +		depends on UCC8_SLOW
>> +		default UCC8_UART
>> +
>> +		config UCC8_UART
>> +			bool "UCC8 is UART"
>> +	endchoice
>> +
>> +	choice
>> +		prompt "UCC8 Fast Protocols selection"
>> +		depends on UCC8_FAST
>> +		default UCC8_GETH
>> +
>> +		config UCC8_GETH
>> +			bool "UCC8 is GETH"
>> +	endchoice
>> +endmenu
>> +
>> +config UCC
>> +	depends on UCC1 || UCC2 || UCC3 || UCC4 || UCC5 || UCC6 || UCC7
>
>> || UCC8
>> +	default y
>> +	bool
>> +
>> +config UCC_SLOW
>> +	depends on UCC1_SLOW || UCC2_SLOW || UCC3_SLOW || UCC4_SLOW ||
>> UCC5_SLOW || UCC6_SLOW || UCC7_SLOW || UCC8_SLOW
>> +	default y
>> +	bool
>> +
>> +config UCC_FAST
>> +	depends on UCC1_FAST || UCC2_FAST || UCC3_FAST || UCC4_FAST ||
>> UCC5_FAST || UCC6_FAST || UCC7_FAST || UCC8_FAST
>> +	default y
>> +	bool
>> +
>> +config UCC_GETH_CONF
>> +	depends on UCC1_GETH || UCC2_GETH || UCC3_GETH || UCC4_GETH ||
>> UCC5_GETH || UCC6_GETH || UCC7_GETH || UCC8_GETH
>> +	default y
>> +	bool
>> +endmenu
>> +
>> diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/arch/powerpc/
>> sysdev/qe_lib/Makefile
>> new file mode 100644
>> index 0000000..c04a70c
>> --- /dev/null
>> +++ b/arch/powerpc/sysdev/qe_lib/Makefile
>> @@ -0,0 +1,8 @@
>> +#
>> +# Makefile for the linux ppc-specific parts of QE
>> +#
>> +obj-$(CONFIG_QUICC_ENGINE)+= qe_common.o mm.o qe.o qe_ic.o qe_io.o
>> +
>> +obj-$(CONFIG_UCC)	+= ucc.o
>> +obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
>> +obj-$(CONFIG_UCC_FAST)	+= ucc_fast.o ucc_slow.o
>> diff --git a/arch/powerpc/sysdev/qe_lib/mm.c b/arch/powerpc/sysdev/
>> qe_lib/mm.c
>> new file mode 100644
>> index 0000000..58984ba
>> --- /dev/null
>> +++ b/arch/powerpc/sysdev/qe_lib/mm.c
>> @@ -0,0 +1,770 @@
>> +/*
>> + * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights
>> reserved.
>> + *
>> + * Author: Shlomi Gridish <gridish@freescale.com>
>> + *
>> + * Description:
>> + * QE Memory Manager.
>> + *
>> + * Changelog:
>> + * Jun 28, 2006 Li Yang <LeoLi@freescale.com>
>> + * - Reorganized as qe_lib
>> + * - Merged to powerpc arch; add device tree support
>> + * - Style fixes
>> + *
>> + * This program is free software; you can redistribute  it and/or
>> modify it
>> + * under  the terms of  the GNU General  Public License as
>> published by the
>> + * Free Software Foundation;  either version 2 of the  License, or
>> (at your
>> + * option) any later version.
>> + */
>> +#include <linux/errno.h>
>> +#include <linux/sched.h>
>> +#include <linux/kernel.h>
>> +#include <linux/param.h>
>> +#include <linux/string.h>
>> +#include <linux/mm.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/bootmem.h>
>> +#include <linux/module.h>
>> +#include <asm/irq.h>
>> +#include <asm/page.h>
>> +#include <asm/pgtable.h>
>> +
>> +#include "mm.h"
>> +
>> +#define MAX_ALIGNMENT   20
>> +#define MAX_NAME_LEN    50
>> +
>> +#define MAKE_ALIGNED(adr, align) ( ((u32)adr + (align - 1)) & (~
>> (align - 1)) )
>> +
>> +/* mem_block_t data stucutre defines parameters of the Memory
>> Block */
>> +typedef struct mem_block {
>> +	struct mem_block *next;	/* Pointer to the next memory block */
>> +
>> +	u32 base;		/* base address of the memory block */
>> +	u32 end;		/* end address of the memory block */
>> +} mem_block_t;
>> +
>> +/* free_block_t data stucutre defines parameters of the Free  
>> Block */
>> +typedef struct free_block {
>> +	struct free_block *next;	/* Pointer to the next free
> block */
>> +
>> +	u32 base;		/* base address of the block */
>> +	u32 end;		/* end address of the block */
>> +} free_block_t;
>> +
>> +/* busy_block_t data stucutre defines parameters of the Busy
>> Block  */
>> +typedef struct busy_block {
>> +	struct busy_block *next;	/* Pointer to the next free
> block */
>> +
>> +	u32 base;		/* base address of the block */
>> +	u32 end;		/* end address of the block */
>> +	char name[MAX_NAME_LEN];
>> +} busy_block_t;
>> +
>> +/* mm_t data structure defines parameters of the MM object */
>> +typedef struct mm {
>> +	mem_block_t *mem_blocks;    /* List of memory blocks (Memory
>> list) */
>> +	busy_block_t *busy_blocks;	/* List of busy blocks (Busy
> list) */
>> +	free_block_t *free_blocks[MAX_ALIGNMENT + 1];/* align lists of
> free
>> +							blocks (Free
> lists) */
>> +} mm_t;
>> +
>> +/
>> *********************************************************************

>> *
>> + *                     MM internal routines
>> set                       *
>> +
>> *********************************************************************

>> *
>
>> /
>> +
>> +/****************************************************************
>> + *  Routine:   mem_block_init
>> + *
>> + *  Description:
>> + *      Initializes a new memory block of "size" bytes and started
>> + *      from "base" address.
>> + *
>> + *  Arguments:
>> + *      mem_blk- handle to the mem_blk object
>> + *      base    - base address of the memory block
>> + *      size    - size of the memory block
>> + *
>> + *  Return value:
>> + *      0 is returned on success. E_NOMEMORY is returned
>> + *      if can't allocate memory for mem_blk object.
>> + ****************************************************************/
>> +static int mem_block_init(void **mem_blk, u32 base, u32 size)
>> +{
>> +	mem_block_t *p_mem_blk;
>> +
>> +	p_mem_blk = (mem_block_t *) kmalloc(sizeof(mem_block_t),
>> GFP_KERNEL);
>> +	if (!p_mem_blk)
>> +		return -ENOMEM;
>> +
>> +	p_mem_blk->base = base;
>> +	p_mem_blk->end = base + size;
>> +	p_mem_blk->next = 0;
>> +
>> +	*mem_blk = p_mem_blk;
>> +
>> +	return (0);
>> +}
>> +
>> +/****************************************************************
>> + *  Routine:   free_block_init
>> + *
>> + *  Description:
>> + *      Initializes a new free block of of "size" bytes and
>> + *      started from "base" address.
>> + *
>> + *  Arguments:
>> + *      FreeBlock - handle to the FreeBlock object
>> + *      base      - base address of the free block
>> + *      size      - size of the free block
>> + *
>> + *  Return value:
>> + *      0 is returned on success. E_NOMEMORY is returned
>> + *      if can't allocate memory for a free block.
>> + ****************************************************************/
>> +static int free_block_init(void **FreeBlock, u32 base, u32 size)
>> +{
>> +	free_block_t *p_free_blk;
>> +
>> +	p_free_blk = (free_block_t *) kmalloc(sizeof(free_block_t),
>> GFP_KERNEL);
>> +	if (!p_free_blk)
>> +		return -ENOMEM;
>> +
>> +	p_free_blk->base = base;
>> +	p_free_blk->end = base + size;
>> +	p_free_blk->next = 0;
>> +
>> +	*FreeBlock = p_free_blk;
>> +
>> +	return (0);
>> +}
>> +
>> +/****************************************************************
>> + *  Routine:   busy_block_init
>> + *
>> + *  Description:
>> + *      Initializes a new busy block of "size" bytes and started
>> + *      rom "base" address. Each busy block has a name that
>> + *      specified the purpose of the memory allocation.
>> + *
>> + *  Arguments:
>> + *      BusyBlock - handle to the BusyBlock object
>> + *      base      - base address of the busy block
>> + *      size      - size of the busy block
>> + *      name      - name that specified the busy block
>> + *
>> + *  Return value:
>> + *      0 is returned on success. E_NOMEMORY is returned
>> + *      if can't allocate memory for busy block.
>> + ****************************************************************/
>> +static int busy_block_init(void **BusyBlock, u32 base, u32 size,
>> char *name)
>> +{
>> +	busy_block_t *p_busy_blk;
>> +	int n, NameLen;
>> +
>> +	p_busy_blk = (busy_block_t *) kmalloc(sizeof(busy_block_t),
>> GFP_KERNEL);
>> +	if (!p_busy_blk)
>> +		return -ENOMEM;
>> +
>> +	p_busy_blk->base = base;
>> +	p_busy_blk->end = base + size;
>> +	NameLen = (int)strlen(name);
>> +	n = (NameLen > MAX_NAME_LEN - 1) ? MAX_NAME_LEN - 1 : NameLen;
>> +	strncpy(p_busy_blk->name, name, (u32) n);
>> +	p_busy_blk->name[n] = '\0';
>> +	p_busy_blk->next = 0;
>> +
>> +	*BusyBlock = p_busy_blk;
>> +
>> +	return (0);
>> +}
>> +
>> +/****************************************************************
>> + *  Routine:    add_free
>> + *
>> + *  Description:
>> + *      Adds a new free block to the free lists. It updates each
>> + *      free list to include a new free block.
>> + *      Note, that all free block in each free list are ordered
>> + *      by their base address.
>> + *
>> + *  Arguments:
>> + *      p_mm  - pointer to the MM object
>> + *      base  - base address of a given free block
>> + *      end   - end address of a given free block
>> + *
>> + *  Return value:
>> + *
>> + *
>> + ****************************************************************/
>> +static int add_free(mm_t * p_mm, u32 base, u32 end)
>> +{
>> +	free_block_t *p_prev_blk, *p_curr_blk, *p_new_blk;
>> +	u32 align;
>> +	int i;
>> +	u32 align_base;
>> +
>> +	/* Updates free lists to include  a just released block */
>> +	for (i = 0; i <= MAX_ALIGNMENT; i++) {
>> +		p_prev_blk = p_new_blk = 0;
>> +		p_curr_blk = p_mm->free_blocks[i];
>> +
>> +		align = (u32) (0x1 << i);
>> +		align_base = MAKE_ALIGNED(base, align);
>> +
>> +		/* Goes to the next free list if there is no block to
> free */
>> +		if (align_base >= end)
>> +			continue;
>> +
>> +		/* Looks for a free block that should be updated */
>> +		while (p_curr_blk) {
>> +			if (align_base <= p_curr_blk->end) {
>> +				if (end > p_curr_blk->end) {
>> +					free_block_t *p_NextB;
>> +					while (p_curr_blk->next
>> +					       && end >
> p_curr_blk->next->end) {
>> +						p_NextB =
> p_curr_blk->next;
>> +						p_curr_blk->next =
>> +
> p_curr_blk->next->next;
>> +						kfree(p_NextB);
>> +					}
>> +
>> +					p_NextB = p_curr_blk->next;
>> +					if (!p_NextB
>> +					    || (p_NextB
>> +						&& end < p_NextB->base))
> {
>> +						p_curr_blk->end = end;
>> +					} else {
>> +						p_curr_blk->end =
> p_NextB->end;
>> +						p_curr_blk->next =
>> +						    p_NextB->next;
>> +						kfree(p_NextB);
>> +					}
>> +				} else if (end < p_curr_blk->base
>> +					   && ((end - align_base) >=
> align)) {
>> +					if (free_block_init
>> +					    ((void *)&p_new_blk,
> align_base,
>> +					     end - align_base) != 0)
>> +						return -ENOMEM;
>> +					p_new_blk->next = p_curr_blk;
>> +					if (p_prev_blk)
>> +						p_prev_blk->next =
> p_new_blk;
>> +					else
>> +						p_mm->free_blocks[i] =
>> +						    p_new_blk;
>> +					break;
>> +				}
>> +
>> +				if (align_base < p_curr_blk->base
>> +				    && end >= p_curr_blk->base)
>> +					p_curr_blk->base = align_base;
>> +
>> +				/* if size of the free block is less
> then
>> +				 * alignment deletes that free block
> from
>> +				 * the free list. */
>> +				if ((p_curr_blk->end - p_curr_blk->base)
> <
>> +				    align) {
>> +					if (p_prev_blk)
>> +						p_prev_blk->next =
>> +						    p_curr_blk->next;
>> +					else
>> +						p_mm->free_blocks[i] =
>> +						    p_curr_blk->next;
>> +					kfree(p_curr_blk);
>> +				}
>> +				break;
>> +			} else {
>> +				p_prev_blk = p_curr_blk;
>> +				p_curr_blk = p_curr_blk->next;
>> +			}
>> +		}
>> +
>> +		/* If no free block found to be updated, insert a new
> free block
>> +		 * to the end of the free list. */
>> +		if (!p_curr_blk && ((end - base) % align == 0)) {
>> +			if (free_block_init
>> +			    ((void *)&p_new_blk, align_base, end - base)
> != 0)
>> +				return -ENOMEM;
>> +			if (p_prev_blk)
>> +				p_prev_blk->next = p_new_blk;
>> +			else
>> +				p_mm->free_blocks[i] = p_new_blk;
>> +		}
>> +
>> +		/* Update boundaries of the new free block */
>> +		if (align == 1 && !p_new_blk) {
>> +			if (p_curr_blk && base > p_curr_blk->base)
>> +				base = p_curr_blk->base;
>> +			if (p_curr_blk && end < p_curr_blk->end)
>> +				end = p_curr_blk->end;
>> +		}
>> +	}
>> +
>> +	return (0);
>> +}
>> +
>> +/****************************************************************
>> + *  Routine:      cut_free
>> + *
>> + *  Description:
>> + *      Cuts a free block from hold_base to hold_end from the free
>> lists.
>> + *      That is, it updates all free lists of the MM object do
>> + *      not include a block of memory from hold_base to hold_end.
>> + *      For each free lists it seek for a free block that holds
>> + *      either hold_base or hold_end. If such block is found it
>> updates it.
>> + *
>> + *  Arguments:
>> + *      p_mm            - pointer to the MM object
>> + *      hold_base        - base address of the allocated block
>> + *      hold_end         - end address of the allocated block
>> + *
>> + *  Return value:
>> + *      0 is returned on success,
>> + *      otherwise returns an error code.
>> + *
>> + ****************************************************************/
>> +static int cut_free(mm_t * p_mm, u32 hold_base, u32 hold_end)
>> +{
>> +	free_block_t *p_prev_blk, *p_curr_blk, *p_new_blk;
>> +	u32 align_base, base, end, align;
>> +	int i;
>> +
>> +	for (i = 0; i <= MAX_ALIGNMENT; i++) {
>> +		p_prev_blk = p_new_blk = 0;
>> +		p_curr_blk = p_mm->free_blocks[i];
>> +
>> +		align = (u32) 0x1 << i;
>> +		align_base = MAKE_ALIGNED(hold_end, align);
>> +
>> +		while (p_curr_blk) {
>> +			base = p_curr_blk->base;
>> +			end = p_curr_blk->end;
>> +
>> +			if (hold_base <= base && hold_end <= end
>> +			    && hold_end > base) {
>> +				if (align_base >= end
>> +				    || (align_base < end
>> +					&& (end - align_base) < align))
> {
>> +					if (p_prev_blk)
>> +						p_prev_blk->next =
>> +						    p_curr_blk->next;
>> +					else
>> +						p_mm->free_blocks[i] =
>> +						    p_curr_blk->next;
>> +					kfree(p_curr_blk);
>> +				} else {
>> +					p_curr_blk->base = align_base;
>> +				}
>> +				break;
>> +			} else if (hold_base > base && hold_end <= end)
> {
>> +				if ((hold_base - base) >= align) {
>> +					if (align_base < end
>> +					    && (end - align_base) >=
> align) {
>> +						if (free_block_init
>> +						    ((void *)&p_new_blk,
>> +						     align_base,
>> +						     (end - align_base))
> != 0)
>> +							return -ENOMEM;
>> +						p_new_blk->next =
>> +						    p_curr_blk->next;
>> +						p_curr_blk->next =
> p_new_blk;
>> +					}
>> +					p_curr_blk->end = hold_base;
>> +				} else if (align_base < end
>> +					   && (end - align_base) >=
> align) {
>> +					p_curr_blk->base = align_base;
>> +				} else {
>> +					if (p_prev_blk)
>> +						p_prev_blk->next =
>> +						    p_curr_blk->next;
>> +					else
>> +						p_mm->free_blocks[i] =
>> +						    p_curr_blk->next;
>> +					kfree(p_curr_blk);
>> +				}
>> +				break;
>> +			} else {
>> +				p_prev_blk = p_curr_blk;
>> +				p_curr_blk = p_curr_blk->next;
>> +			}
>> +		}
>> +	}
>> +
>> +	return (0);
>> +}
>> +
>> +/****************************************************************
>> + *  Routine:     add_busy
>> + *
>> + *  Description:
>> + *      Adds a new busy block to the list of busy blocks. Note,
>> + *      that all busy blocks are ordered by their base address in
>> + *      the busy list.
>> + *
>> + *  Arguments:
>> + *      MM              - handler to the MM object
>> + *      p_new_busy_blk      - pointer to the a busy block
>> + *
>> + *  Return value:
>> + *      None.
>> + *
>> + ****************************************************************/
>> +static void add_busy(mm_t * p_mm, busy_block_t * p_new_busy_blk)
>> +{
>> +	busy_block_t *p_cur_busy_blk, *p_prev_busy_blk;
>> +
>> +	/* finds a place of a new busy block in the list of busy blocks
> */
>> +	p_prev_busy_blk = 0;
>> +	p_cur_busy_blk = p_mm->busy_blocks;
>> +
>> +	while (p_cur_busy_blk && p_new_busy_blk->base > p_cur_busy_blk-
>>> base) {
>> +		p_prev_busy_blk = p_cur_busy_blk;
>> +		p_cur_busy_blk = p_cur_busy_blk->next;
>> +	}
>> +
>> +	/* insert the new busy block into the list of busy blocks */
>> +	if (p_cur_busy_blk)
>> +		p_new_busy_blk->next = p_cur_busy_blk;
>> +	if (p_prev_busy_blk)
>> +		p_prev_busy_blk->next = p_new_busy_blk;
>> +	else
>> +		p_mm->busy_blocks = p_new_busy_blk;
>> +
>> +}
>> +
>> +/****************************************************************
>> + *  Routine:     get_greater_align
>> + *
>> + *  Description:
>> + *      Allocates a block of memory according to the given size
>> + *      and the alignment. That routine is called from the mm_get
>> + *      routine if the required alignment is grater then
>> MAX_ALIGNMENT.
>> + *      In that case, it goes over free blocks of 64 byte align list
>> + *      and checks if it has the required size of bytes of the
>> required
>> + *      alignment. If no blocks found returns ILLEGAL_BASE.
>> + *      After the block is found and data is allocated, it calls
>> + *      the internal cut_free routine to update all free lists
>> + *      do not include a just allocated block. Of course, each
>> + *      free list contains a free blocks with the same alignment.
>> + *      It is also creates a busy block that holds
>> + *      information about an allocated block.
>> + *
>> + *  Arguments:
>> + *      MM              - handle to the MM object
>> + *      size            - size of the MM
>> + *      align       - index as a power of two defines
>> + *                        a required alignment that is grater then
>> 64.
>> + *      name            - the name that specifies an allocated  
>> block.
>> + *
>> + *  Return value:
>> + *      base address of an allocated block.
>> + *      ILLEGAL_BASE if can't allocate a block
>> + *
>> + ****************************************************************/
>> +static int get_greater_align(void *MM, u32 size, int align, char
>> *name)
>> +{
>> +	mm_t *p_mm = (mm_t *) MM;
>> +	free_block_t *p_free_blk;
>> +	busy_block_t *p_new_busy_blk;
>> +	u32 hold_base, hold_end, align_base = 0;
>> +	u32 ret;
>> +
>> +	/* goes over free blocks of the 64 byte alignment list
>> +	 * and look for a block of the suitable size and
>> +	 * base address according to the alignment.
>> +	 */
>> +	p_free_blk = p_mm->free_blocks[MAX_ALIGNMENT];
>> +
>> +	while (p_free_blk) {
>> +		align_base = MAKE_ALIGNED(p_free_blk->base, align);
>> +
>> +		/* the block is found if the aligned base inside the
> block
>> +		 * and has the anough size.
>> +		 */
>> +		if (align_base >= p_free_blk->base &&
>> +		    align_base < p_free_blk->end &&
>> +		    size <= (p_free_blk->end - align_base))
>> +			break;
>> +		else
>> +			p_free_blk = p_free_blk->next;
>> +	}
>> +
>> +	/* If such block isn't found */
>> +	if (!p_free_blk)
>> +		return -EBUSY;
>> +
>> +	hold_base = align_base;
>> +	hold_end = align_base + size;
>> +
>> +	/* init a new busy block */
>> +	if ((ret =
>> +	     busy_block_init((void *)&p_new_busy_blk, hold_base, size,
>> +			     name)) != 0)
>> +		return ret;
>> +
>> +	/* calls Update routine to update a lists of free blocks */
>> +	if ((ret = cut_free(MM, hold_base, hold_end)) != 0)
>> +		return ret;
>> +
>> +	/* insert the new busy block into the list of busy blocks */
>> +	add_busy(p_mm, p_new_busy_blk);
>> +
>> +	return (hold_base);
>> +}
>> +
>> +/
>> *********************************************************************

>> *
>> + *                     MM API routines
>> set                            *
>> +
>> *********************************************************************

>> *
>
>> /
>> +int mm_init(void **MM, u32 base, u32 size)
>> +{
>> +	mm_t *p_mm;
>> +	int i;
>> +	u32 new_base, new_size;
>> +
>> +	/* Initializes a new MM object */
>> +	p_mm = (mm_t *) kmalloc(sizeof(mm_t), GFP_KERNEL);
>> +	if (p_mm == 0)
>> +		return -ENOMEM;
>> +
>> +	/* initializes a new memory block */
>> +	if (mem_block_init((void *)&p_mm->mem_blocks, base, size) != 0)
>> +		return -ENOMEM;
>> +
>> +	/* A busy list is empty */
>> +	p_mm->busy_blocks = 0;
>> +
>> +	/*Initializes a new free block for each free list */
>> +	for (i = 0; i <= MAX_ALIGNMENT; i++) {
>> +		new_base = MAKE_ALIGNED(base, (0x1 << i));
>> +		new_size = size - (new_base - base);
>> +		if (free_block_init((void *)&p_mm->free_blocks[i],
>> +				    new_base, new_size) != 0)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	*MM = p_mm;
>> +
>> +	return (0);
>> +}
>> +
>> +EXPORT_SYMBOL(mm_init);
>> +
>> +void mm_free(void *MM)
>> +{
>> +	mm_t *p_mm = (mm_t *) MM;
>> +	mem_block_t *p_mem_blk;
>> +	busy_block_t *p_busy_blk;
>> +	free_block_t *p_free_blk;
>> +	void *p_blk;
>> +	int i;
>> +
>> +	if (!p_mm)
>> +		return;
>> +
>> +	/* release memory allocated for busy blocks */
>> +	p_busy_blk = p_mm->busy_blocks;
>> +	while (p_busy_blk) {
>> +		p_blk = p_busy_blk;
>> +		p_busy_blk = p_busy_blk->next;
>> +		kfree(p_blk);
>> +	}
>> +
>> +	/* release memory allocated for free blocks */
>> +	for (i = 0; i <= MAX_ALIGNMENT; i++) {
>> +		p_free_blk = p_mm->free_blocks[i];
>> +		while (p_free_blk) {
>> +			p_blk = p_free_blk;
>> +			p_free_blk = p_free_blk->next;
>> +			kfree(p_blk);
>> +		}
>> +	}
>> +
>> +	/* release memory allocated for memory blocks */
>> +	p_mem_blk = p_mm->mem_blocks;
>> +	while (p_mem_blk) {
>> +		p_blk = p_mem_blk;
>> +		p_mem_blk = p_mem_blk->next;
>> +		kfree(p_blk);
>> +	}
>> +
>> +	/* release memory allocated for MM object itself */
>> +	kfree(p_mm);
>> +}
>> +
>> +EXPORT_SYMBOL(mm_free);
>> +
>> +void *mm_get(void *MM, u32 size, int align, char *name)
>> +{
>> +	mm_t *p_mm = (mm_t *) MM;
>> +	free_block_t *p_free_blk;
>> +	busy_block_t *p_new_busy_blk;
>> +	u32 hold_base, hold_end;
>> +	u32 i = 0, j = (u32) align;
>> +	u32 ret;
>> +
>> +	if (!p_mm)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	/* checks that align value is grater then zero */
>> +	if (align == 0)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	/* checks if alignment is a power of two,
>> +	 * if it correct and if the required size
>> +	 * is multiple of the given alignment.
>> +	 */
>> +	while ((j & 0x1) == 0) {
>> +		i++;
>> +		j = j >> 1;
>> +	}
>> +
>> +	/* if the given alignment isn't power of two, returns an error
> */
>> +	if (j != 1)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (i > MAX_ALIGNMENT)
>> +		return ERR_PTR(get_greater_align(MM, size, align,
> name));
>> +
>> +	/* look for a block of the size grater or equal to the
>> +	 * required size.
>> +	 */
>> +	p_free_blk = p_mm->free_blocks[i];
>> +	while (p_free_blk && (p_free_blk->end - p_free_blk->base) <
> size)
>> +		p_free_blk = p_free_blk->next;
>> +
>> +	/* If such block is found */
>> +	if (!p_free_blk)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	hold_base = p_free_blk->base;
>> +	hold_end = hold_base + size;
>> +
>> +	/* init a new busy block */
>> +	if ((ret =
>> +	     busy_block_init((void *)&p_new_busy_blk, hold_base, size,
>> +			     name)) != 0)
>> +		return ERR_PTR(ret);
>> +
>> +	/* calls Update routine to update a lists of free blocks */
>> +	if ((ret = cut_free(MM, hold_base, hold_end)) != 0)
>> +		return ERR_PTR(ret);
>> +
>> +	/* insert the new busy block into the list of busy blocks */
>> +	add_busy(p_mm, p_new_busy_blk);
>> +
>> +	return (void *)(hold_base);
>> +}
>> +
>> +EXPORT_SYMBOL(mm_get);
>> +
>> +void *mm_get_force(void *MM, u32 base, u32 size, char *name)
>> +{
>> +	mm_t *p_mm = (mm_t *) MM;
>> +	free_block_t *p_free_blk;
>> +	busy_block_t *p_new_busy_blk;
>> +	int blk_is_free = 0;
>> +	u32 ret;
>> +
>> +	p_free_blk = p_mm->free_blocks[0];/* The biggest free blocks are
> in
>> +					     the free list with
> alignment 1 */
>> +	while (p_free_blk) {
>> +		if (base >= p_free_blk->base
>> +		    && (base + size) <= p_free_blk->end) {
>> +			blk_is_free = 1;
>> +			break;
>> +		} else
>> +			p_free_blk = p_free_blk->next;
>> +	}
>> +
>> +	if (!blk_is_free)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	/* init a new busy block */
>> +	if ((ret =
>> +	     busy_block_init((void *)&p_new_busy_blk, base, size, name))
> !
>> = 0)
>> +		return ERR_PTR(ret);
>> +
>> +	/* calls Update routine to update a lists of free blocks */
>> +	if ((ret = cut_free(MM, base, base + size)) != 0)
>> +		return ERR_PTR(ret);
>> +
>> +	/* insert the new busy block into the list of busy blocks */
>> +	add_busy(p_mm, p_new_busy_blk);
>> +	return (void *)(base);
>> +}
>> +
>> +EXPORT_SYMBOL(mm_get_force);
>> +
>> +int mm_put(void *MM, u32 base)
>> +{
>> +	mm_t *p_mm = (mm_t *) MM;
>> +	busy_block_t *p_busy_blk, *p_prev_busy_blk;
>> +	u32 size;
>> +	u32 ret;
>> +
>> +	if (!p_mm)
>> +		return -EINVAL;
>> +
>> +	/* Look for a busy block that have the given base value.
>> +	 * That block will be returned back to the memory.
>> +	 */
>> +	p_prev_busy_blk = 0;
>> +	p_busy_blk = p_mm->busy_blocks;
>> +	while (p_busy_blk && base != p_busy_blk->base) {
>> +		p_prev_busy_blk = p_busy_blk;
>> +		p_busy_blk = p_busy_blk->next;
>> +	}
>> +
>> +	if (!p_busy_blk)
>> +		return -EINVAL;
>> +
>> +	if ((ret = add_free(p_mm, p_busy_blk->base, p_busy_blk->end)) !=
> 0)
>> +		return ret;
>> +
>> +	/* removes a busy block form the list of busy blocks */
>> +	if (p_prev_busy_blk)
>> +		p_prev_busy_blk->next = p_busy_blk->next;
>> +	else
>> +		p_mm->busy_blocks = p_busy_blk->next;
>> +
>> +	size = p_busy_blk->end - p_busy_blk->base;
>> +
>> +	kfree(p_busy_blk);
>> +
>> +	return (0);
>> +}
>> +
>> +EXPORT_SYMBOL(mm_put);
>> +
>> +void mm_dump(void *MM)
>> +{
>> +	mm_t *p_mm = (mm_t *) MM;
>> +	free_block_t *p_free_blk;
>> +	busy_block_t *p_busy_blk;
>> +	int i;
>> +
>> +	p_busy_blk = p_mm->busy_blocks;
>> +	printk(KERN_INFO "List of busy blocks:\n");
>> +	while (p_busy_blk) {
>> +		printk(KERN_INFO "\t0x%08x: (%s: b=0x%08x, e=0x%08x)\n",
>> +		       (u32) p_busy_blk, p_busy_blk->name,
> p_busy_blk->base,
>> +		       p_busy_blk->end);
>> +		p_busy_blk = p_busy_blk->next;
>> +	}
>> +
>> +	printk(KERN_INFO "Lists of free blocks according to
> alignment:\n");
>> +	for (i = 0; i <= MAX_ALIGNMENT; i++) {
>> +		printk(KERN_INFO "%d alignment:\n", (0x1 << i));
>> +		p_free_blk = p_mm->free_blocks[i];
>> +		while (p_free_blk) {
>> +			printk(KERN_INFO "\t0x%08x: (b=0x%08x,
> e=0x%08x)\n",
>> +			       (u32) p_free_blk, p_free_blk->base,
>> +			       p_free_blk->end);
>> +			p_free_blk = p_free_blk->next;
>> +		}
>> +		printk(KERN_INFO "\n");
>> +	}
>> +}
>> +
>> +EXPORT_SYMBOL(mm_dump);
>> diff --git a/arch/powerpc/sysdev/qe_lib/mm.h b/arch/powerpc/sysdev/
>> qe_lib/mm.h
>> new file mode 100644
>> index 0000000..ab30080
>> --- /dev/null
>> +++ b/arch/powerpc/sysdev/qe_lib/mm.h
>> @@ -0,0 +1,6 @@
>> +int mm_init ( void **MM, u32 base, u32 size );
>> +void mm_free (void * MM);
>> +void *mm_get ( void * MM, u32 size, int align, char* name );
>> +void *mm_get_force ( void * MM, u32 base, u32 size, char* name );
>> +int mm_put ( void * MM, u32 base );
>> +void mm_dump ( void * MM );
>> diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/
>> qe_lib/qe.c
>> new file mode 100644
>> index 0000000..0fbb54c
>> --- /dev/null
>> +++ b/arch/powerpc/sysdev/qe_lib/qe.c
>> @@ -0,0 +1,181 @@
>> +/*
>> + * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights
>> reserved.
>> + *
>> + * Author: Li Yang <LeoLi@freescale.com>
>> + *
>> + * Description:
>> + * FSL QE SOC setup.
>> + *
>> + * Changelog:
>> + * Jun 21, 2006	Initial version
>> + *
>> + * This program is free software; you can redistribute  it and/or
>> modify it
>> + * under  the terms of  the GNU General  Public License as
>> published by the
>> + * Free Software Foundation;  either version 2 of the  License, or
>> (at your
>> + * option) any later version.
>> + */
>> +
>> +#include <linux/config.h>
>> +#include <linux/stddef.h>
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/errno.h>
>> +#include <linux/major.h>
>> +#include <linux/delay.h>
>> +#include <linux/irq.h>
>> +#include <linux/module.h>
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/fsl_devices.h>
>> +
>> +#include <asm/system.h>
>> +#include <asm/atomic.h>
>> +#include <asm/io.h>
>> +#include <asm/irq.h>
>> +#include <asm/prom.h>
>> +#include <sysdev/fsl_soc.h>
>> +#include <mm/mmu_decl.h>
>> +
>> +static phys_addr_t qebase = -1;
>> +
>> +phys_addr_t get_qe_base(void)
>> +{
>> +	struct device_node *qe;
>> +
>> +	if (qebase != -1)
>> +		return qebase;
>> +
>> +	qe = of_find_node_by_type(NULL, "qe");
>> +	if (qe) {
>> +		unsigned int size;
>> +		void *prop = get_property(qe, "reg", &size);
>> +		qebase = of_translate_address(qe, prop);
>> +		of_node_put(qe);
>> +	};
>> +
>> +	return qebase;
>> +}
>> +
>> +EXPORT_SYMBOL(get_qe_base);
>> +
>> +static int __init ucc_geth_of_init(void)
>> +{
>> +	struct device_node *np;
>> +	unsigned int i, ucc_num;
>> +	struct platform_device *ugeth_dev;
>> +	struct resource res;
>> +	int ret;
>> +
>> +	for (np = NULL, i = 0;
>> +	     (np = of_find_compatible_node(np, "network", "ucc_geth"))
> !=
>> NULL;
>> +	     i++) {
>> +		struct resource r[2];
>> +		struct device_node *phy, *mdio;
>> +		struct ucc_geth_platform_data ugeth_data;
>> +		unsigned int *id;
>> +		char *model;
>> +		void *mac_addr;
>> +		phandle *ph;
>> +
>> +		memset(r, 0, sizeof(r));
>> +		memset(&ugeth_data, 0, sizeof(ugeth_data));
>> +
>> +		ret = of_address_to_resource(np, 0, &r[0]);
>> +		if (ret)
>> +			goto err;
>> +
>> +		ugeth_data.phy_reg_addr = r[0].start;
>> +		r[1].start = np->intrs[0].line;
>> +		r[1].end = np->intrs[0].line;
>> +		r[1].flags = IORESOURCE_IRQ;
>> +
>> +		model = get_property(np, "model", NULL);
>> +		ucc_num = *((u32 *) get_property(np, "device-id",
> NULL));
>> +		if ((strstr(model, "UCC") == NULL) ||
>> +				(ucc_num < 1) || (ucc_num > 8)) {
>> +			ret = -ENODEV;
>> +			goto err;
>> +		}
>> +		
>> +		ugeth_dev =
>> +		    platform_device_register_simple("ucc_geth", ucc_num
> - 1,
>> +				    &r[0], np->n_intrs + 1);
>> +
>> +		if (IS_ERR(ugeth_dev)) {
>> +			ret = PTR_ERR(ugeth_dev);
>> +			goto err;
>> +		}
>> +
>> +		mac_addr = get_property(np, "mac-address", NULL);
>> +		
>> +		memcpy(ugeth_data.mac_addr, mac_addr, 6);
>> +
>> +		ugeth_data.rx_clock = *((u32 *) get_property(np,
> "rx-clock",
>> +					NULL));
>> +		ugeth_data.tx_clock = *((u32 *) get_property(np,
> "tx-clock",
>> +					NULL));
>> +
>> +		ph = (phandle *) get_property(np, "phy-handle", NULL);
>> +		phy = of_find_node_by_phandle(*ph);
>> +
>> +		if (phy == NULL) {
>> +			ret = -ENODEV;
>> +			goto unreg;
>> +		}
>> +
>> +		mdio = of_get_parent(phy);
>> +
>> +		id = (u32 *) get_property(phy, "reg", NULL);
>> +		ret = of_address_to_resource(mdio, 0, &res);
>> +		if (ret) {
>> +			of_node_put(phy);
>> +			of_node_put(mdio);
>> +			goto unreg;
>> +		}
>> +		
>> +		ugeth_data.phy_id = *id;
>> +		ugeth_data.phy_interrupt = phy->intrs[0].line;
>> +		ugeth_data.phy_interface = *((u32 *) get_property(phy,
>> +					"interface", NULL));
>> +
>> +		/* FIXME: Work around for early chip rev.
> */
>> +		/* There's a bug in initial chip rev(s) in the RGMII ac
> */
>> +		/* timing.
> */
>> +		/* The following compensates by writing to the reserved
> */
>> +		/* QE Port Output Hold Registers (CPOH1?).
> */	
>> +		if ((ugeth_data.phy_interface == ENET_1000_RGMII) ||
>> +				(ugeth_data.phy_interface ==
> ENET_100_RGMII) ||
>> +				(ugeth_data.phy_interface ==
> ENET_10_RGMII)) {
>> +			u32 *tmp_reg = (u32 *) ioremap(get_immrbase()
>> +					+ 0x14A8, 0x4);
>> +			u32 tmp_val = in_be32(tmp_reg);
>> +			if (ucc_num == 1)
>> +				out_be32(tmp_reg, tmp_val | 0x00003000);
>> +			else if (ucc_num == 2)
>> +				out_be32(tmp_reg, tmp_val | 0x0c000000);
>> +			iounmap(tmp_reg);
>> +		}
>> +		
>> +		if (phy->intrs[0].line != 0)
>> +			ugeth_data.board_flags |=
> FSL_UGETH_BRD_HAS_PHY_INTR;
>> +
>> +		of_node_put(phy);
>> +		of_node_put(mdio);
>> +
>> +		ret =
>> +		    platform_device_add_data(ugeth_dev, &ugeth_data,
>> +					     sizeof(struct
>> +
> ucc_geth_platform_data));
>> +		if (ret)
>> +			goto unreg;
>> +	}
>> +
>> +	return 0;
>> +
>> +unreg:
>> +	platform_device_unregister(ugeth_dev);
>> +err:
>> +	return ret;
>> +}
>> +
>> +arch_initcall(ucc_geth_of_init);
>> diff --git a/arch/powerpc/sysdev/qe_lib/qe_common.c b/arch/powerpc/
>> sysdev/qe_lib/qe_common.c
>> new file mode 100644
>> index 0000000..cd0aca9
>> --- /dev/null
>> +++ b/arch/powerpc/sysdev/qe_lib/qe_common.c
>> @@ -0,0 +1,401 @@
>> +/*
>> + * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights
>> reserved.
>> + *
>> + * Author: Shlomi Gridish <gridish@freescale.com>
>> + *
>> + * Description:
>> + * General Purpose functions for the global management of the
>> + * QUICC Engine (QE).
>> + *
>> + * Changelog:
>> + * Jun 28, 2006	Li Yang <LeoLi@freescale.com>
>> + * - Reorganized as qe_lib
>> + * - Merged to powerpc arch; add device tree support
>> + * - Style fixes
>> + *
>> + * This program is free software; you can redistribute  it and/or
>> modify it
>> + * under  the terms of  the GNU General  Public License as
>> published by the
>> + * Free Software Foundation;  either version 2 of the  License, or
>> (at your
>> + * option) any later version.
>> + */
>> +#undef USE_RHEAP
>> +#include <linux/errno.h>
>> +#include <linux/sched.h>
>> +#include <linux/kernel.h>
>> +#include <linux/param.h>
>> +#include <linux/string.h>
>> +#include <linux/mm.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/bootmem.h>
>> +#include <linux/module.h>
>> +#include <linux/delay.h>
>> +#include <asm/irq.h>
>> +#include <asm/page.h>
>> +#include <asm/pgtable.h>
>> +#include <asm/immap_qe.h>
>> +#include <asm/qe.h>
>> +#include <asm/prom.h>
>> +#ifdef USE_RHEAP
>> +#include <asm/rheap.h>
>> +#else
>> +#include "mm.h"
>> +#endif				/* USE_RHEAP */
>> +
>> +/* QE snum state
>> +*/
>> +typedef enum qe_snum_state {
>> +	QE_SNUM_STATE_USED,	/* used */
>> +	QE_SNUM_STATE_FREE	/* free */
>> +} qe_snum_state_e;
>> +
>> +/* QE snum
>> +*/
>> +typedef struct qe_snum {
>> +	u8 num;			/* snum  */
>> +	qe_snum_state_e state;	/* state */
>> +} qe_snum_t;
>> +
>> +/* We allocate this here because it is used almost exclusively for
>> + * the communication processor devices.
>> + */
>> +EXPORT_SYMBOL(qe_immr);
>> +qe_map_t *qe_immr = NULL;
>> +static qe_snum_t snums[QE_NUM_OF_SNUM];	/* Dynamically allocated
>
>> SNUMs  */
>> +
>> +static void qe_snums_init(void);
>> +static void qe_muram_init(void);
>> +static int qe_sdma_init(void);
>> +
>> +void qe_reset(void)
>> +{
>> +	if (qe_immr == NULL)
>> +		qe_immr = (qe_map_t *) ioremap(get_qe_base(),
> QE_IMMAP_SIZE);
>> +
>> +	qe_snums_init();
>> +
>> +	qe_issue_cmd(QE_RESET, QE_CR_SUBBLOCK_INVALID,
>> +		     (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
>> +
>> +	/* Reclaim the MURAM memory for our use. */
>> +	qe_muram_init();
>> +
>> +#ifdef USE_RHEAP
>> +	if (qe_sdma_init())
>> +		panic("sdma init failed!");
>> +#endif				/* USE_RHEAP */
>> +}
>> +
>> +EXPORT_SYMBOL(qe_issue_cmd);
>> +int qe_issue_cmd(uint cmd, uint device, u8 mcn_protocol, u32
>> cmd_input)
>> +{
>> +	unsigned long flags;
>> +	u32 cecr;
>> +	u8 mcn_shift = 0, dev_shift = 0;
>> +
>> +	local_irq_save(flags);
>> +	if (cmd == QE_RESET) {
>> +		out_be32(&qe_immr->cp.cecr, (u32) (cmd | QE_CR_FLG));
>> +	} else {
>> +		if (cmd == QE_ASSIGN_PAGE) {
>> +			/* Here device is the SNUM, not sub-block */
>> +			dev_shift = QE_CR_SNUM_SHIFT;
>> +		} else if (cmd == QE_ASSIGN_RISC) {
>> +			/* Here device is the SNUM, and mcnProtocol is
>> +			 * e_QeCmdRiscAssignment value */
>> +			dev_shift = QE_CR_SNUM_SHIFT;
>> +			mcn_shift = QE_CR_MCN_RISC_ASSIGN_SHIFT;
>> +		} else {
>> +			if (device == QE_CR_SUBBLOCK_USB)
>> +				mcn_shift = QE_CR_MCN_USB_SHIFT;
>> +			else
>> +				mcn_shift = QE_CR_MCN_NORMAL_SHIFT;
>> +		}
>> +
>> +		out_be32(&qe_immr->cp.cecdr,
>> +			 immrbar_virt_to_phys((void *)cmd_input));
>> +		out_be32(&qe_immr->cp.cecr,
>> +			 (cmd | QE_CR_FLG | ((u32) device << dev_shift)
> | (u32)
>> +			  mcn_protocol << mcn_shift));
>> +	}
>> +
>> +	/* wait for the QE_CR_FLG to clear */
>> +	do {
>> +		cecr = in_be32(&qe_immr->cp.cecr);
>> +	} while (cecr & QE_CR_FLG);
>> +	local_irq_restore(flags);
>> +
>> +	return 0;
>> +}
>> +
>> +/* Set a baud rate generator. This needs lots of work. There are
>> + * 16 BRGs, which can be connected to the QE channels or output
>> + * as clocks. The BRGs are in two different block of internal
>> + * memory mapped space.
>> + * The baud rate clock is the system clock divided by something.
>> + * It was set up long ago during the initial boot phase and is
>> + * is given to us.
>> + * Baud rate clocks are zero-based in the driver code (as that maps
>> + * to port numbers). Documentation uses 1-based numbering.
>> + */
>> +static unsigned int brg_clk = 0;
>> +
>> +unsigned int get_brg_clk(void)
>> +{
>> +	struct device_node *qe;
>> +	if (brg_clk)
>> +		return brg_clk;
>> +
>> +	qe = of_find_node_by_type(NULL, "qe");
>> +	if (qe) {
>> +		unsigned int size;
>> +		u32 *prop = (u32 *) get_property(qe, "brg-frequency",
> &size);
>> +		brg_clk = *prop;
>> +		of_node_put(qe);
>> +	};
>> +	return brg_clk;
>> +}
>> +
>> +/* This function is used by UARTS, or anything else that uses a 16x
>> + * oversampled clock.
>> + */
>> +void qe_setbrg(uint brg, uint rate)
>> +{
>> +	volatile uint *bp;
>> +	u32 divisor;
>> +	int div16 = 0;
>> +
>> +	bp = (uint *) & qe_immr->brg.brgc1;
>> +	bp += brg;
>> +
>> +	divisor = (get_brg_clk() / rate);
>> +	if (divisor > QE_BRGC_DIVISOR_MAX + 1) {
>> +		div16 = 1;
>> +		divisor /= 16;
>> +	}
>> +
>> +	*bp = ((divisor - 1) << QE_BRGC_DIVISOR_SHIFT) | QE_BRGC_ENABLE;
>> +	if (div16)
>> +		*bp |= QE_BRGC_DIV16;
>> +}
>> +
>> +static void qe_snums_init(void)
>> +{
>> +	int i;
>> +
>> +	/* Initialize the SNUMs array. */
>> +	for (i = 0; i < QE_NUM_OF_SNUM; i++)
>> +		snums[i].state = QE_SNUM_STATE_FREE;
>> +
>> +	/* Initialize SNUMs (thread serial numbers) according to QE
>> +	 * spec chapter 4, SNUM table */
>> +	i = 0;
>> +	snums[i++].num = 0x04;
>> +	snums[i++].num = 0x05;
>> +	snums[i++].num = 0x0C;
>> +	snums[i++].num = 0x0D;
>> +	snums[i++].num = 0x14;
>> +	snums[i++].num = 0x15;
>> +	snums[i++].num = 0x1C;
>> +	snums[i++].num = 0x1D;
>> +	snums[i++].num = 0x24;
>> +	snums[i++].num = 0x25;
>> +	snums[i++].num = 0x2C;
>> +	snums[i++].num = 0x2D;
>> +	snums[i++].num = 0x34;
>> +	snums[i++].num = 0x35;
>> +	snums[i++].num = 0x88;
>> +	snums[i++].num = 0x89;
>> +	snums[i++].num = 0x98;
>> +	snums[i++].num = 0x99;
>> +	snums[i++].num = 0xA8;
>> +	snums[i++].num = 0xA9;
>> +	snums[i++].num = 0xB8;
>> +	snums[i++].num = 0xB9;
>> +	snums[i++].num = 0xC8;
>> +	snums[i++].num = 0xC9;
>> +	snums[i++].num = 0xD8;
>> +	snums[i++].num = 0xD9;
>> +	snums[i++].num = 0xE8;
>> +	snums[i++].num = 0xE9;
>> +}
>> +
>> +int qe_get_snum(void)
>> +{
>> +	unsigned long flags;
>> +	int snum = -EBUSY;
>> +	int i;
>> +
>> +	local_irq_save(flags);
>> +	for (i = 0; i < QE_NUM_OF_SNUM; i++) {
>> +		if (snums[i].state == QE_SNUM_STATE_FREE) {
>> +			snums[i].state = QE_SNUM_STATE_USED;
>> +			snum = snums[i].num;
>> +			break;
>> +		}
>> +	}
>> +	local_irq_restore(flags);
>> +
>> +	return snum;
>> +}
>> +
>> +EXPORT_SYMBOL(qe_get_snum);
>> +
>> +void qe_put_snum(u8 snum)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < QE_NUM_OF_SNUM; i++) {
>> +		if (snums[i].num == snum) {
>> +			snums[i].state = QE_SNUM_STATE_FREE;
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +EXPORT_SYMBOL(qe_put_snum);
>> +
>> +static int qe_sdma_init(void)
>> +{
>> +	sdma_t *sdma = &qe_immr->sdma;
>> +	uint sdma_buf_offset;
>> +
>> +	if (!sdma)
>> +		return -ENODEV;
>> +
>> +	/* allocate 2 internal temporary buffers (512 bytes size each)
> for
>> +	 * the SDMA */
>> +	sdma_buf_offset = qe_muram_alloc(512 * 2, 64);
>> +	if (IS_MURAM_ERR(sdma_buf_offset))
>> +		return -ENOMEM;
>> +
>> +	out_be32(&sdma->sdebcr, sdma_buf_offset & QE_SDEBCR_BA_MASK);
>> +	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 >>
>> +					QE_SDMR_CEN_SHIFT)));
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * muram_alloc / muram_free bits.
>> + */
>> +static spinlock_t qe_muram_lock;
>> +#ifdef USE_RHEAP
>> +/* 16 blocks should be enough to satisfy all requests
>> + * until the memory subsystem goes up... */
>> +static rh_block_t qe_boot_muram_rh_block[16];
>> +static rh_info_t qe_muram_info;
>> +#else
>> +static void *mm = NULL;
>> +#endif				/* USE_RHEAP */
>> +
>> +static void qe_muram_init(void)
>> +{
>> +	spin_lock_init(&qe_muram_lock);
>> +
>> +#ifdef USE_RHEAP
>> +	/* initialize the info header */
>> +	rh_init(&qe_muram_info, 1,
>> +		sizeof(qe_boot_muram_rh_block) /
>> +		sizeof(qe_boot_muram_rh_block[0]),
> qe_boot_muram_rh_block);
>> +
>> +	/* Attach the usable muram area */
>> +	/* XXX: This is actually crap. QE_DATAONLY_BASE and
>> +	 * QE_DATAONLY_SIZE is only a subset of the available muram. It
>> +	 * varies with the processor and the microcode patches
> activated.
>> +	 * But the following should be at least safe.
>> +	 */
>> +	rh_attach_region(&qe_muram_info,
>> +			 (void *)QE_MURAM_DATAONLY_BASE,
>> +			 QE_MURAM_DATAONLY_SIZE);
>> +#else
>> +#endif				/* USE_RHEAP */
>> +}
>> +
>> +/* This function returns an index into the MURAM area.
>> + */
>> +uint qe_muram_alloc(uint size, uint align)
>> +{
>> +	void *start;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&qe_muram_lock, flags);
>> +#ifdef USE_RHEAP
>> +	qe_muram_info.alignment = align;
>> +	start = rh_alloc(&qe_muram_info, size, "QE");
>> +#else
>> +	if (!mm) {
>> +		mm_init(&mm, (u32)
> qe_muram_addr(QE_MURAM_DATAONLY_BASE),
>> +			QE_MURAM_DATAONLY_SIZE);
>> +		if (qe_sdma_init())
>> +			panic("sdma init failed!");
>> +
>> +	}
>> +	start = mm_get(mm, (u32) size, (int)align, "QE");
>> +	if (!IS_MURAM_ERR((u32) start))
>> +		start = (void *)((u32) start - (u32) qe_immr->muram);
>> +#endif				/* USE_RHEAP */
>> +	spin_unlock_irqrestore(&qe_muram_lock, flags);
>> +
>> +	return (uint) start;
>> +}
>> +
>> +EXPORT_SYMBOL(qe_muram_alloc);
>> +
>> +int qe_muram_free(uint offset)
>> +{
>> +	int ret;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&qe_muram_lock, flags);
>> +#ifdef USE_RHEAP
>> +	ret = rh_free(&qe_muram_info, (void *)offset);
>> +#else
>> +	ret = mm_put(mm, (u32) qe_muram_addr(offset));
>> +#endif				/* USE_RHEAP */
>> +	spin_unlock_irqrestore(&qe_muram_lock, flags);
>> +
>> +	return ret;
>> +}
>> +
>> +EXPORT_SYMBOL(qe_muram_free);
>> +
>> +/* not sure if this is ever needed */
>> +uint qe_muram_alloc_fixed(uint offset, uint size, uint align)
>> +{
>> +	void *start;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&qe_muram_lock, flags);
>> +#ifdef USE_RHEAP
>> +	qe_muram_info.alignment = align;
>> +	start =
>> +	    rh_alloc_fixed(&qe_muram_info, (void *)offset, size,
>> "commproc");
>> +#else
>> +	start = mm_get_force(mm, (u32) offset, (u32) size, "QE");
>> +	if (!IS_MURAM_ERR((u32) start))
>> +		start = (void *)((u32) start - (u32) qe_immr->muram);
>> +#endif				/* USE_RHEAP */
>> +	spin_unlock_irqrestore(&qe_muram_lock, flags);
>> +
>> +	return (uint) start;
>> +}
>> +
>> +EXPORT_SYMBOL(qe_muram_alloc_fixed);
>> +
>> +void qe_muram_dump(void)
>> +{
>> +#ifdef USE_RHEAP
>> +	rh_dump(&qe_muram_info);
>> +#else
>> +	mm_dump(mm);
>> +#endif				/* USE_RHEAP */
>> +}
>> +
>> +EXPORT_SYMBOL(qe_muram_dump);
>> +
>> +void *qe_muram_addr(uint offset)
>> +{
>> +	return (void *)&qe_immr->muram[offset];
>> +}
>> +
>> +EXPORT_SYMBOL(qe_muram_addr);
>> diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/
>> sysdev/qe_lib/qe_ic.c
>> new file mode 100644
>> index 0000000..465630e
>> --- /dev/null
>> +++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
>> @@ -0,0 +1,487 @@
>> +/*
>> + * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights
>> reserved.
>> + *
>> + * Author: Shlomi Gridish <gridish@freescale.com>
>> + *
>> + * Description:
>> + * QE Interrupt Controller routines implementations.
>> + *
>> + * Changelog:
>> + * Jun 28, 2006 Li Yang <LeoLi@freescale.com>
>> + * - Reorganized as qe_lib
>> + * - Merged to powerpc arch; add device tree support
>> + * - Style fixes
>> + *
>> + * This program is free software; you can redistribute  it and/or
>> modify it
>> + * under  the terms of  the GNU General  Public License as
>> published by the
>> + * Free Software Foundation;  either version 2 of the  License, or
>> (at your
>> + * option) any later version.
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/errno.h>
>> +#include <linux/reboot.h>
>> +#include <linux/slab.h>
>> +#include <linux/stddef.h>
>> +#include <linux/sched.h>
>> +#include <linux/signal.h>
>> +#include <linux/sysdev.h>
>> +#include <linux/interrupt.h>
>> +
>> +#include <asm/irq.h>
>> +#include <asm/io.h>
>> +#include <asm/qe_ic.h>
>> +
>> +#include "qe_ic.h"
>> +
>> +static struct qe_ic_private p_qe_ic;
>> +static struct qe_ic_private *primary_qe_ic;
>> +
>> +static struct qe_ic_info qe_ic_info[] = {
>> +	[1] = {
>> +	       .mask = 0x00008000,
>> +	       .qimr = 1,
>> +	       .pri_code = 0},
>> +	[2] = {
>> +	       .mask = 0x00004000,
>> +	       .qimr = 1,
>> +	       .pri_code = 1},
>> +	[3] = {
>> +	       .mask = 0x00002000,
>> +	       .qimr = 1,
>> +	       .pri_code = 2},
>> +	[10] = {
>> +		.mask = 0x00000040,
>> +		.qimr = 1,
>> +		.pri_code = 1},
>> +	[11] = {
>> +		.mask = 0x00000020,
>> +		.qimr = 1,
>> +		.pri_code = 2},
>> +	[12] = {
>> +		.mask = 0x00000010,
>> +		.qimr = 1,
>> +		.pri_code = 3},
>> +	[13] = {
>> +		.mask = 0x00000008,
>> +		.qimr = 1,
>> +		.pri_code = 4},
>> +	[14] = {
>> +		.mask = 0x00000004,
>> +		.qimr = 1,
>> +		.pri_code = 5},
>> +	[15] = {
>> +		.mask = 0x00000002,
>> +		.qimr = 1,
>> +		.pri_code = 6},
>> +	[20] = {
>> +		.mask = 0x10000000,
>> +		.qimr = 0,
>> +		.pri_code = 3},
>> +	[25] = {
>> +		.mask = 0x00800000,
>> +		.qimr = 0,
>> +		.pri_code = 0},
>> +	[26] = {
>> +		.mask = 0x00400000,
>> +		.qimr = 0,
>> +		.pri_code = 1},
>> +	[27] = {
>> +		.mask = 0x00200000,
>> +		.qimr = 0,
>> +		.pri_code = 2},
>> +	[28] = {
>> +		.mask = 0x00100000,
>> +		.qimr = 0,
>> +		.pri_code = 3},
>> +	[32] = {
>> +		.mask = 0x80000000,
>> +		.qimr = 1,
>> +		.pri_code = 0},
>> +	[33] = {
>> +		.mask = 0x40000000,
>> +		.qimr = 1,
>> +		.pri_code = 1},
>> +	[34] = {
>> +		.mask = 0x20000000,
>> +		.qimr = 1,
>> +		.pri_code = 2},
>> +	[35] = {
>> +		.mask = 0x10000000,
>> +		.qimr = 1,
>> +		.pri_code = 3},
>> +	[36] = {
>> +		.mask = 0x08000000,
>> +		.qimr = 1,
>> +		.pri_code = 4},
>> +	[40] = {
>> +		.mask = 0x00800000,
>> +		.qimr = 1,
>> +		.pri_code = 0},
>> +	[41] = {
>> +		.mask = 0x00400000,
>> +		.qimr = 1,
>> +		.pri_code = 1},
>> +	[42] = {
>> +		.mask = 0x00200000,
>> +		.qimr = 1,
>> +		.pri_code = 2},
>> +	[43] = {
>> +		.mask = 0x00100000,
>> +		.qimr = 1,
>> +		.pri_code = 3},
>> +};
>> +
>> +struct hw_interrupt_type qe_ic = {
>> +	.typename = "QE IC",
>> +	.enable = qe_ic_enable_irq,
>> +	.disable = qe_ic_disable_irq,
>> +	.ack = qe_ic_disable_irq_and_ack,
>> +	.end = qe_ic_end_irq,
>> +};
>> +
>> +static int qe_ic_get_low_irq(struct pt_regs *regs)
>> +{
>> +	struct qe_ic_private *p_qe_ic = primary_qe_ic;
>> +	int irq = -1;
>> +
>> +	/* get the low byte of SIVEC to get the interrupt source vector.
> */
>> +	irq = (in_be32(&p_qe_ic->regs->qivec) >> 24) >> 2;
>> +
>> +	if (irq == 0)		/* 0 --> no irq is pending */
>> +		return -1;
>> +
>> +	return irq + p_qe_ic->irq_offset;
>> +}
>> +
>> +static int qe_ic_get_high_irq(struct pt_regs *regs)
>> +{
>> +	struct qe_ic_private *p_qe_ic = primary_qe_ic;
>> +	int irq = -1;
>> +
>> +	/* get the high byte of SIVEC to get the interrupt source
> vector. */
>> +	irq = (in_be32(&p_qe_ic->regs->qhivec) >> 24) >> 2;
>> +
>> +	if (irq == 0)		/* 0 --> no irq is pending */
>> +		return -1;
>> +
>> +	return irq + p_qe_ic->irq_offset;
>> +}
>> +
>> +static irqreturn_t qe_ic_cascade_low(int irq, void *dev_id,
>> +				     struct pt_regs *regs)
>> +{
>> +	while ((irq = qe_ic_get_low_irq(regs)) >= 0)
>> +		__do_IRQ(irq, regs);
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t qe_ic_cascade_high(int irq, void *dev_id,
>> +				      struct pt_regs *regs)
>> +{
>> +	while ((irq = qe_ic_get_high_irq(regs)) >= 0)
>> +		__do_IRQ(irq, regs);
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static struct irqaction qe_ic_low_irqaction = {
>> +	.handler = qe_ic_cascade_low,
>> +	.flags = SA_INTERRUPT,
>> +	.mask = CPU_MASK_NONE,
>> +	.name = "qe_ic_cascade_low",
>> +};
>> +
>> +static struct irqaction qe_ic_high_irqaction = {
>> +	.handler = qe_ic_cascade_high,
>> +	.flags = SA_INTERRUPT,
>> +	.mask = CPU_MASK_NONE,
>> +	.name = "qe_ic_cascade_high",
>> +};
>> +
>> +int qe_ic_init(phys_addr_t phys_addr,
>> +	       unsigned int flags, unsigned int irq_offset)
>> +{
>> +	struct qe_ic_map *regs;
>> +	u8 grp, pri, shift = 0;
>> +	u32 tmp_qicr = 0, tmp_qricr = 0, tmp_qicnr = 0, tmp_mask;
>> +	int i, high_hctive = 0;
>> +	const u32 high_signal = 2;
>> +
>> +	primary_qe_ic = &p_qe_ic;
>> +	memset(primary_qe_ic, 0, sizeof(struct qe_ic_private));
>> +
>> +	/* initialize QE interrupt controller registers */
>> +	primary_qe_ic->regs = regs =
>> +	    (struct qe_ic_map *)ioremap(phys_addr, QE_IC_SIZE);
>> +	primary_qe_ic->irq_offset = irq_offset;
>> +
>> +	/* default priority scheme is grouped. If spread mode is    */
>> +	/* required, configure sicr accordingly.                    */
>> +	if (flags & QE_IC_SPREADMODE_GRP_W)
>> +		tmp_qicr |= QICR_GWCC;
>> +	if (flags & QE_IC_SPREADMODE_GRP_X)
>> +		tmp_qicr |= QICR_GXCC;
>> +	if (flags & QE_IC_SPREADMODE_GRP_Y)
>> +		tmp_qicr |= QICR_GYCC;
>> +	if (flags & QE_IC_SPREADMODE_GRP_Z)
>> +		tmp_qicr |= QICR_GZCC;
>> +	if (flags & QE_IC_SPREADMODE_GRP_RISCA)
>> +		tmp_qicr |= QICR_GRTA;
>> +	if (flags & QE_IC_SPREADMODE_GRP_RISCB)
>> +		tmp_qicr |= QICR_GRTB;
>> +
>> +	/* choose destination signal for highest priority interrupt */
>> +	if (flags & QE_IC_HIGH_SIGNAL) {
>> +		tmp_qicr |= (high_signal << QICR_HPIT_SHIFT);
>> +		high_hctive = 1;
>> +	}
>> +
>> +	out_be32(&regs->qicr, tmp_qicr);
>> +
>> +	tmp_mask = (1 << QE_IC_GRP_W_DEST_SIGNAL_SHIFT);
>> +	/* choose destination signal for highest priority interrupt in
> each
>> +	 * group */
>> +	for (grp = 0; grp < NUM_OF_QE_IC_GROUPS; grp++) {
>> +		/* the first 2 priorities in each group have a choice of
>> +		 * destination signal */
>> +		for (pri = 0; pri <= 1; pri++) {
>> +			if (flags & ((tmp_mask << (grp << 1)) << pri)) {
>> +				/* indicate whether QE High signal is
>> +				 * required */
>> +				if (!high_hctive)
>> +					high_hctive = 1;
>> +
>> +				/* The location of the bits relevant to
>> +				 * priority 0 in the   */
>> +				/* registers is always 2 bits left
> comparing
>> +				 * to priority 1. */
>> +				if (pri == 0)
>> +					shift = 2;
>> +
>> +				switch (grp) {
>> +				case (QE_IC_GRP_W):
>> +					shift += QICNR_WCC1T_SHIFT;
>> +					tmp_qicnr |= high_signal <<
> shift;
>> +					break;
>> +				case (QE_IC_GRP_X):
>> +					shift += QICNR_XCC1T_SHIFT;
>> +					tmp_qicnr |= high_signal <<
> shift;
>> +					break;
>> +				case (QE_IC_GRP_Y):
>> +					shift += QICNR_YCC1T_SHIFT;
>> +					tmp_qicnr |= high_signal <<
> shift;
>> +					break;
>> +				case (QE_IC_GRP_Z):
>> +					shift += QICNR_ZCC1T_SHIFT;
>> +					tmp_qicnr |= high_signal <<
> shift;
>> +					break;
>> +				case (QE_IC_GRP_RISCA):
>> +					shift += QRICR_RTA1T_SHIFT;
>> +					tmp_qricr |= high_signal <<
> shift;
>> +					break;
>> +				case (QE_IC_GRP_RISCB):
>> +					shift += QRICR_RTB1T_SHIFT;
>> +					tmp_qricr |= high_signal <<
> shift;
>> +					break;
>> +				default:
>> +					break;
>> +				}
>> +			}
>> +		}
>> +	}
>> +
>> +	if (tmp_qicnr)
>> +		out_be32(&regs->qicnr, tmp_qicnr);
>> +	if (tmp_qricr)
>> +		out_be32(&regs->qricr, tmp_qricr);
>> +
>> +	for (i = primary_qe_ic->irq_offset;
>> +	     i < (NR_QE_IC_INTS + primary_qe_ic->irq_offset); i++) {
>> +		irq_desc[i].handler = &qe_ic;
>> +		irq_desc[i].status = IRQ_LEVEL;
>> +	}
>> +
>> +	/* register QE_IC interrupt controller in the a higher hirarchy
>> +	 * controller */
>> +	setup_irq(IRQ_QE_LOW, &qe_ic_low_irqaction);
>> +
>> +	if (high_hctive)
>> +		/* register QE_IC high interrupt source in the higher
>> +		 * hirarchy controller */
>> +		setup_irq(IRQ_QE_HIGH, &qe_ic_high_irqaction);
>> +
>> +	printk("QE IC (%d IRQ sources) at %p\n", NR_QE_IC_INTS,
>> +	       primary_qe_ic->regs);
>> +	return 0;
>> +}
>> +
>> +void qe_ic_free(void)
>> +{
>> +}
>> +
>> +void qe_ic_enable_irq(unsigned int irq)
>> +{
>> +	struct qe_ic_private *p_qe_ic = primary_qe_ic;
>> +	unsigned int src = irq - p_qe_ic->irq_offset;
>> +	u32 qimr;
>> +
>> +	if (qe_ic_info[src].qimr) {
>> +		qimr = in_be32(&((struct qe_ic_private
> *)p_qe_ic)->regs->qimr);
>> +		out_be32(&((struct qe_ic_private *)p_qe_ic)->regs->qimr,
>> +			 qimr | (qe_ic_info[src].mask));
>> +	} else {
>> +		qimr = in_be32(&((struct qe_ic_private
> *)p_qe_ic)->regs->qrimr);
>> +		out_be32(&((struct qe_ic_private
> *)p_qe_ic)->regs->qrimr,
>> +			 qimr | (qe_ic_info[src].mask));
>> +	}
>> +}
>> +
>> +void qe_ic_disable_irq(unsigned int irq)
>> +{
>> +	struct qe_ic_private *p_qe_ic = primary_qe_ic;
>> +	unsigned int src = irq - p_qe_ic->irq_offset;
>> +	u32 qimr;
>> +
>> +	if (qe_ic_info[src].qimr) {
>> +		qimr = in_be32(&((struct qe_ic_private
> *)p_qe_ic)->regs->qimr);
>> +		out_be32(&((struct qe_ic_private *)p_qe_ic)->regs->qimr,
>> +			 qimr & ~(qe_ic_info[src].mask));
>> +	} else {
>> +		qimr = in_be32(&((struct qe_ic_private
> *)p_qe_ic)->regs->qrimr);
>> +		out_be32(&((struct qe_ic_private
> *)p_qe_ic)->regs->qrimr,
>> +			 qimr & ~(qe_ic_info[src].mask));
>> +	}
>> +}
>> +
>> +void qe_ic_disable_irq_and_ack(unsigned int irq)
>> +{
>> +	qe_ic_disable_irq(irq);
>> +}
>> +
>> +void qe_ic_end_irq(unsigned int irq)
>> +{
>> +
>> +	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))
>> +	    && irq_desc[irq].action)
>> +		qe_ic_enable_irq(irq);
>> +}
>> +
>> +void qe_ic_modify_highest_priority(unsigned int irq)
>> +{
>> +	struct qe_ic_private *p_qe_ic = primary_qe_ic;
>> +	unsigned int src = irq - p_qe_ic->irq_offset;
>> +	u32 tmp_qicr = 0;
>> +
>> +	tmp_qicr = in_be32(&p_qe_ic->regs->qicr);
>> +	out_be32(&p_qe_ic->regs->qicr, (u32) (tmp_qicr | ((u8) src <<
> 24)));
>> +}
>> +
>> +void qe_ic_modify_priority(enum qe_ic_grp_id grp,
>> +			   unsigned int pri0,
>> +			   unsigned int pri1,
>> +			   unsigned int pri2,
>> +			   unsigned int pri3,
>> +			   unsigned int pri4,
>> +			   unsigned int pri5,
>> +			   unsigned int pri6, unsigned int pri7)
>> +{
>> +	struct qe_ic_private *p_qe_ic = primary_qe_ic;
>> +	volatile u32 *p_qip = 0;
>> +	u32 tmp_qip = 0;
>> +	u8 tmp_array[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
>> +	signed char code_array[8], i = 0, j = 0;
>> +
>> +	code_array[0] = (signed char)(pri0 ? qe_ic_info[pri0].pri_code :
>
>> -1);
>> +	code_array[1] = (signed char)(pri1 ? qe_ic_info[pri1].pri_code :
>
>> -1);
>> +	code_array[2] = (signed char)(pri2 ? qe_ic_info[pri2].pri_code :
>
>> -1);
>> +	code_array[3] = (signed char)(pri3 ? qe_ic_info[pri3].pri_code :
>
>> -1);
>> +	code_array[4] = (signed char)(pri4 ? qe_ic_info[pri4].pri_code :
>
>> -1);
>> +	code_array[5] = (signed char)(pri5 ? qe_ic_info[pri5].pri_code :
>
>> -1);
>> +	code_array[6] = (signed char)(pri6 ? qe_ic_info[pri6].pri_code :
>
>> -1);
>> +	code_array[7] = (signed char)(pri7 ? qe_ic_info[pri7].pri_code :
>
>> -1);
>> +
>> +	for (i = 0; i < 8; i++) {
>> +		if (code_array[i] == -1)
>> +			break;
>> +		tmp_array[code_array[i]] = 1;
>> +	}
>> +
>> +	for (; i < 8; i++) {
>> +		while (tmp_array[j] && j < 8)
>> +			j++;
>> +		code_array[i] = j;
>> +		tmp_array[j] = 1;
>> +	}
>> +
>> +	tmp_qip = (u32) (code_array[0] << QIPCC_SHIFT_PRI0 |
>> +			 code_array[1] << QIPCC_SHIFT_PRI1 |
>> +			 code_array[2] << QIPCC_SHIFT_PRI2 |
>> +			 code_array[3] << QIPCC_SHIFT_PRI3 |
>> +			 code_array[4] << QIPCC_SHIFT_PRI4 |
>> +			 code_array[5] << QIPCC_SHIFT_PRI5 |
>> +			 code_array[6] << QIPCC_SHIFT_PRI6 |
>> +			 code_array[7] << QIPCC_SHIFT_PRI7);
>> +
>> +	switch (grp) {
>> +	case (QE_IC_GRP_W):
>> +		p_qip = &(p_qe_ic->regs->qipwcc);
>> +		break;
>> +	case (QE_IC_GRP_X):
>> +		p_qip = &(p_qe_ic->regs->qipxcc);
>> +		break;
>> +	case (QE_IC_GRP_Y):
>> +		p_qip = &(p_qe_ic->regs->qipycc);
>> +		break;
>> +	case (QE_IC_GRP_Z):
>> +		p_qip = &(p_qe_ic->regs->qipzcc);
>> +		break;
>> +	case (QE_IC_GRP_RISCA):
>> +		p_qip = &(p_qe_ic->regs->qiprta);
>> +		break;
>> +	case (QE_IC_GRP_RISCB):
>> +		p_qip = &(p_qe_ic->regs->qiprtb);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	out_be32(p_qip, tmp_qip);
>> +}
>> +
>> +void qe_ic_dump_regs(void)
>> +{
>> +	struct qe_ic_private *p_qe_ic = primary_qe_ic;
>> +
>> +	printk(KERN_INFO "QE IC registars:\n");
>> +	printk(KERN_INFO "Base address: 0x%08x\n", (u32) p_qe_ic->regs);
>> +	printk(KERN_INFO "qicr  : addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qicr,
> in_be32(&p_qe_ic->regs->qicr));
>> +	printk(KERN_INFO "qivec : addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qivec, in_be32(&p_qe_ic->regs-
>>> qivec));
>> +	printk(KERN_INFO "qripnr: addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qripnr, in_be32(&p_qe_ic->regs-
>>> qripnr));
>> +	printk(KERN_INFO "qipnr : addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qipnr, in_be32(&p_qe_ic->regs-
>>> qipnr));
>> +	printk(KERN_INFO "qipxcc: addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qipxcc, in_be32(&p_qe_ic->regs-
>>> qipxcc));
>> +	printk(KERN_INFO "qipycc: addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qipycc, in_be32(&p_qe_ic->regs-
>>> qipycc));
>> +	printk(KERN_INFO "qipwcc: addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qipwcc, in_be32(&p_qe_ic->regs-
>>> qipwcc));
>> +	printk(KERN_INFO "qipzcc: addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qipzcc, in_be32(&p_qe_ic->regs-
>>> qipzcc));
>> +	printk(KERN_INFO "qimr  : addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qimr,
> in_be32(&p_qe_ic->regs->qimr));
>> +	printk(KERN_INFO "qrimr : addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qrimr, in_be32(&p_qe_ic->regs-
>>> qrimr));
>> +	printk(KERN_INFO "qicnr : addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qicnr, in_be32(&p_qe_ic->regs-
>>> qicnr));
>> +	printk(KERN_INFO "qiprta: addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qiprta, in_be32(&p_qe_ic->regs-
>>> qiprta));
>> +	printk(KERN_INFO "qiprtb: addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qiprtb, in_be32(&p_qe_ic->regs-
>>> qiprtb));
>> +	printk(KERN_INFO "qricr : addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qricr, in_be32(&p_qe_ic->regs-
>>> qricr));
>> +	printk(KERN_INFO "qhivec: addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & p_qe_ic->regs->qhivec, in_be32(&p_qe_ic->regs-
>>> qhivec));
>> +}
>> diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.h b/arch/powerpc/
>> sysdev/qe_lib/qe_ic.h
>> new file mode 100644
>> index 0000000..6662ad2
>> --- /dev/null
>> +++ b/arch/powerpc/sysdev/qe_lib/qe_ic.h
>> @@ -0,0 +1,83 @@
>> +/*
>> + * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights
>> reserved.
>> + *
>> + * Author: Shlomi Gridish <gridish@freescale.com>
>> + *
>> + * Description:
>> + * QE IC private definitions and structure.
>> + *
>> + * Changelog:
>> + * Jun 21, 2006 Li Yang <LeoLi@freescale.com>
>> + * - Style fix; port to powerpc arch
>> + *
>> + * This program is free software; you can redistribute  it and/or
>> modify it
>> + * under  the terms of  the GNU General  Public License as
>> published by the
>> + * Free Software Foundation;  either version 2 of the  License, or
>> (at your
>> + * option) any later version.
>> + */
>> +#ifndef __QE_IC_H__
>> +#define __QE_IC_H__
>> +
>> +typedef struct qe_ic_map {
>> +	volatile u32 qicr;
>> +	volatile u32 qivec;
>> +	volatile u32 qripnr;
>> +	volatile u32 qipnr;
>> +	volatile u32 qipxcc;
>> +	volatile u32 qipycc;
>> +	volatile u32 qipwcc;
>> +	volatile u32 qipzcc;
>> +	volatile u32 qimr;
>> +	volatile u32 qrimr;
>> +	volatile u32 qicnr;
>> +	volatile u8 res0[0x4];
>> +	volatile u32 qiprta;
>> +	volatile u32 qiprtb;
>> +	volatile u8 res1[0x4];
>> +	volatile u32 qricr;
>> +	volatile u8 res2[0x20];
>> +	volatile u32 qhivec;
>> +	volatile u8 res3[0x1C];
>> +} __attribute__ ((packed)) qe_ic_map_t;
>> +
>> +
>> +#define QE_IC_SIZE sizeof(struct qe_ic_map)
>> +
>> +/* Interrupt priority registers */
>> +#define QIPCC_SHIFT_PRI0        29
>> +#define QIPCC_SHIFT_PRI1        26
>> +#define QIPCC_SHIFT_PRI2        23
>> +#define QIPCC_SHIFT_PRI3        20
>> +#define QIPCC_SHIFT_PRI4        13
>> +#define QIPCC_SHIFT_PRI5        10
>> +#define QIPCC_SHIFT_PRI6        7
>> +#define QIPCC_SHIFT_PRI7        4
>> +
>> +/* QICR priority modes */
>> +#define QICR_GWCC               0x00040000
>> +#define QICR_GXCC               0x00020000
>> +#define QICR_GYCC               0x00010000
>> +#define QICR_GZCC               0x00080000
>> +#define QICR_GRTA               0x00200000
>> +#define QICR_GRTB               0x00400000
>> +#define QICR_HPIT_SHIFT         8
>> +
>> +/* QICNR */
>> +#define QICNR_WCC1T_SHIFT       20
>> +#define QICNR_ZCC1T_SHIFT       28
>> +#define QICNR_YCC1T_SHIFT       12
>> +#define QICNR_XCC1T_SHIFT       4
>> +
>> +/* QRICR */
>> +#define QRICR_RTA1T_SHIFT       20
>> +#define QRICR_RTB1T_SHIFT       28
>> +
>> +struct qe_ic_private {
>> +	struct qe_ic_map *regs;
>> +	unsigned int irq_offset;
>> +} qe_ic_private_t;
>> +
>> +extern struct hw_interrupt_type qe_ic;
>> +extern int qe_ic_get_irq(struct pt_regs *regs);
>> +
>> +#endif				/* __QE_IC_H__ */
>> diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/
>> sysdev/qe_lib/qe_io.c
>> new file mode 100644
>> index 0000000..a943c27
>> --- /dev/null
>> +++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
>> @@ -0,0 +1,275 @@
>> +/*
>> + * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights
>> reserved.
>> + *
>> + * Author: Li Yang <LeoLi@freescale.com>
>> + *
>> + * Description:
>> + * QE Parallel I/O ports configuration routines.  Based on code from
>> + * Shlomi Gridish <gridish@freescale.com>
>> + *
>> + * Changelog:
>> + * Jun 21, 2006	Initial version
>> + *
>> + * This program is free software; you can redistribute  it and/or
>> modify it
>> + * under  the terms of  the GNU General  Public License as
>> published by the
>> + * Free Software Foundation;  either version 2 of the  License, or
>> (at your
>> + * option) any later version.
>> + */
>> +
>> +#include <linux/config.h>
>> +#include <linux/stddef.h>
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/errno.h>
>> +#include <linux/module.h>
>> +
>> +#include <asm/io.h>
>> +#include <asm/prom.h>
>> +#include <sysdev/fsl_soc.h>
>> +#undef DEBUG
>> +
>> +#define NUM_OF_PINS     32
>> +#define NUM_OF_PAR_IOS  7
>> +
>> +typedef struct par_io {
>> +	struct {
>> +		u32 cpodr;	/* Open drain register */
>> +		u32 cpdata;	/* Data register */
>> +		u32 cpdir1;	/* Direction register */
>> +		u32 cpdir2;	/* Direction register */
>> +		u32 cppar1;	/* Pin assignment register */
>> +		u32 cppar2;	/* Pin assignment register */
>> +	} io_regs[NUM_OF_PAR_IOS];
>> +} par_io_t;
>> +
>> +typedef struct qe_par_io {
>> +	u8 res[0xc];
>> +	u32 cepier;		/* QE ports interrupt event register */
>> +	u32 cepimr;		/* QE ports mask event register */
>> +	u32 cepicr;		/* QE ports control event register */
>> +} qe_par_io_t;
>> +
>> +static int qe_irq_ports[NUM_OF_PAR_IOS][NUM_OF_PINS] = {
>> +	/* 0-7 */          /* 8-15 */      /* 16 - 23 */     /* 24 - 31
> */
>> +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1, 1,0,0,0,0,0,0,0,
>> 0,0,0,0,0,1,1,0},
>> +	{0,0,0,1,0,1,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0,
>> 0,0,1,1,0,0,0,0},
>> +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
>> 0,0,0,1,1,1,0,0},
>> +	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 1,1,0,0,0,0,0,0,
>> 0,0,1,1,0,0,0,0},
>> +	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0,
>> 1,1,1,1,0,0,0,1},
>> +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,1,0,0,0,
>> 0,0,0,0,0,0,0,0},
>> +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
> 0,0,0,0,0,0,0,1}
>> +};
>> +
>> +
>> +static u8 get_irq_num(u8 port, u8 pin)
>> +{
>> +	int i, j;
>> +	u8 num = 0;
>> +
>> +	if (qe_irq_ports[port][pin] == 0)
>> +		return -1;
>> +	for (j = 0; j <= port; j++)
>> +		for (i = 0; i < pin; i++)
>> +			if (qe_irq_ports[j][i])
>> +				num++;
>> +	return num;
>> +}
>> +
>> +static par_io_t *par_io = NULL;
>> +static qe_par_io_t *qe_par_io = NULL;
>> +
>> +int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
>> +		      int assignment, int has_irq)
>> +{
>> +	u32 pinMask1bit, pinMask2bits, newMask2bits, tmp_val;
>> +
>> +	if (!par_io) {
>> +		par_io = (par_io_t *) ioremap(get_immrbase() + 0x1400,
>> +					      sizeof(par_io_t));
>> +		qe_par_io = (qe_par_io_t *) ioremap(get_immrbase() +
> 0xC00,
>> +
> sizeof(qe_par_io_t));
>> +
>> +		/* clear event bits in the event register of the QE
> ports */
>> +		out_be32(&qe_par_io->cepier, 0xFFFFFFFF);
>> +	}
>> +
>> +	/* calculate pin location for single and 2 bits  information */
>> +	pinMask1bit = (u32) (1 << (NUM_OF_PINS - (pin + 1)));
>> +
>> +	/* Set open drain, if required */
>> +	tmp_val = in_be32(&par_io->io_regs[port].cpodr);
>> +	if (open_drain)
>> +		out_be32(&par_io->io_regs[port].cpodr, pinMask1bit |
> tmp_val);
>> +	else
>> +		out_be32(&par_io->io_regs[port].cpodr, ~pinMask1bit &
> tmp_val);
>> +
>> +	/* define direction */
>> +	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
>> +	    in_be32(&par_io->io_regs[port].cpdir2) :
>> +	    in_be32(&par_io->io_regs[port].cpdir1);
>> +
>> +	/* get all bits mask for 2 bit per port */
>> +	pinMask2bits = (u32) (0x3 <<
>> +			      (NUM_OF_PINS -
>> +			       (pin % (NUM_OF_PINS / 2) + 1) * 2));
>> +
>> +	/* Get the final mask we need for the right definition */
>> +	newMask2bits = (u32) (dir <<
>> +			      (NUM_OF_PINS -
>> +			       (pin % (NUM_OF_PINS / 2) + 1) * 2));
>> +
>> +	/* clear and set 2 bits mask */
>> +	if (pin > (NUM_OF_PINS / 2) - 1) {
>> +		out_be32(&par_io->io_regs[port].cpdir2,
>> +			 ~pinMask2bits & tmp_val);
>> +		tmp_val &= ~pinMask2bits;
>> +		out_be32(&par_io->io_regs[port].cpdir2, newMask2bits |
> tmp_val);
>> +	} else {
>> +		out_be32(&par_io->io_regs[port].cpdir1,
>> +			 ~pinMask2bits & tmp_val);
>> +		tmp_val &= ~pinMask2bits;
>> +		out_be32(&par_io->io_regs[port].cpdir1, newMask2bits |
> tmp_val);
>> +	}
>> +	/* define pin assignment */
>> +	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
>> +	    in_be32(&par_io->io_regs[port].cppar2) :
>> +	    in_be32(&par_io->io_regs[port].cppar1);
>> +
>> +	newMask2bits = (u32) (assignment << (NUM_OF_PINS -
>> +			(pin % (NUM_OF_PINS / 2) + 1) * 2));
>> +	/* clear and set 2 bits mask */
>> +	if (pin > (NUM_OF_PINS / 2) - 1) {
>> +		out_be32(&par_io->io_regs[port].cppar2,
>> +			 ~pinMask2bits & tmp_val);
>> +		tmp_val &= ~pinMask2bits;
>> +		out_be32(&par_io->io_regs[port].cppar2, newMask2bits |
> tmp_val);
>> +	} else {
>> +		out_be32(&par_io->io_regs[port].cppar1,
>> +			 ~pinMask2bits & tmp_val);
>> +		tmp_val &= ~pinMask2bits;
>> +		out_be32(&par_io->io_regs[port].cppar1, newMask2bits |
> tmp_val);
>> +	}
>> +
>> +	/* Set interrupt mask if the pin generates interrupt */
>> +	if (has_irq) {
>> +		int irq = get_irq_num(port, pin);
>> +		u32 mask = 0;
>> +
>> +		if (irq == -1) {
>> +			printk(KERN_WARNING "Port %d, pin %d is can't be
> "
>> +					"interrupt\n", port, pin);
>> +			return -EINVAL;
>> +		}
>> +		mask = 0x80000000 >> irq;
>> +
>> +		tmp_val = in_be32(&qe_par_io->cepimr);
>> +		out_be32(&qe_par_io->cepimr, mask | tmp_val);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +EXPORT_SYMBOL(par_io_config_pin);
>> +
>> +int par_io_data_set(u8 port, u8 pin, u8 val)
>> +{
>> +	u32 pin_mask, tmp_val;
>> +
>> +	if (port >= NUM_OF_PAR_IOS)
>> +		return -EINVAL;
>> +	if (pin >= NUM_OF_PINS)
>> +		return -EINVAL;
>> +	/* calculate pin location */
>> +	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - pin));
>> +
>> +	tmp_val = in_be32(&par_io->io_regs[port].cpdata);
>> +
>> +	if (val == 0)		/* clear  */
>> +		out_be32(&par_io->io_regs[port].cpdata, ~pin_mask &
> tmp_val);
>> +	else			/* set */
>> +		out_be32(&par_io->io_regs[port].cpdata, pin_mask |
> tmp_val);
>> +
>> +	return 0;
>> +}
>> +
>> +EXPORT_SYMBOL(par_io_data_set);
>> +
>> +int par_io_of_config(struct device_node *np)
>> +{
>> +	struct device_node *pio;
>> +	phandle *ph;
>> +	int pio_map_len;
>> +	unsigned int *pio_map;
>> +	
>> +	ph = (phandle *) get_property(np, "pio-handle", NULL);
>> +	if (ph == 0) {
>> +		printk(KERN_ERR "pio-handle not available \n");
>> +		return -1;
>> +	}
>> +		
>> +	pio = of_find_node_by_phandle(*ph);
>> +
>> +	pio_map = (unsigned int *)
>> +		get_property(pio, "pio-map", &pio_map_len);
>> +	if (pio_map == NULL) {
>> +		printk(KERN_ERR "pio-map is not set! \n");
>> +		return -1;
>> +	}
>> +	pio_map_len /= sizeof(unsigned int);
>> +	if ((pio_map_len % 6) != 0) {
>> +		printk(KERN_ERR "pio-map format wrong! \n");
>> +		return -1;
>> +	}
>> +
>> +	while (pio_map_len > 0) {
>> +		par_io_config_pin((u8) pio_map[0], (u8) pio_map[1],
>> +				(int) pio_map[2], (int) pio_map[3],
>> +				(int) pio_map[4], (int) pio_map[5]);
>> +		pio_map += 6;
>> +		pio_map_len -= 6;
>> +	}
>> +	of_node_put(pio);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(par_io_of_config);
>> +
>> +#ifdef DEBUG
>> +static void dump_par_io(void)
>> +{
>> +	int i;
>> +
>> +	printk(KERN_INFO "PAR IO registars:\n");
>> +	printk(KERN_INFO "Base address: 0x%08x\n", (u32) par_io);
>> +	for (i = 0; i < NUM_OF_PAR_IOS; i++) {
>> +		printk(KERN_INFO "cpodr[%d] : addr - 0x%08x, val -
> 0x%08x\n",
>> +		       i, (u32) & par_io->io_regs[i].cpodr,
>> +		       in_be32(&par_io->io_regs[i].cpodr));
>> +		printk(KERN_INFO "cpdata[%d]: addr - 0x%08x, val -
> 0x%08x\n",
>> +		       i, (u32) & par_io->io_regs[i].cpdata,
>> +		       in_be32(&par_io->io_regs[i].cpdata));
>> +		printk(KERN_INFO "cpdir1[%d]: addr - 0x%08x, val -
> 0x%08x\n",
>> +		       i, (u32) & par_io->io_regs[i].cpdir1,
>> +		       in_be32(&par_io->io_regs[i].cpdir1));
>> +		printk(KERN_INFO "cpdir2[%d]: addr - 0x%08x, val -
> 0x%08x\n",
>> +		       i, (u32) & par_io->io_regs[i].cpdir2,
>> +		       in_be32(&par_io->io_regs[i].cpdir2));
>> +		printk(KERN_INFO "cppar1[%d]: addr - 0x%08x, val -
> 0x%08x\n",
>> +		       i, (u32) & par_io->io_regs[i].cppar1,
>> +		       in_be32(&par_io->io_regs[i].cppar1));
>> +		printk(KERN_INFO "cppar2[%d]: addr - 0x%08x, val -
> 0x%08x\n",
>> +		       i, (u32) & par_io->io_regs[i].cppar2,
>> +		       in_be32(&par_io->io_regs[i].cppar2));
>> +	}
>> +
>> +	printk(KERN_INFO "QE PAR IO registars:\n");
>> +	printk(KERN_INFO "Base address: 0x%08x\n", (u32) qe_par_io);
>> +	printk(KERN_INFO "cepier : addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & qe_par_io->cepier, in_be32(&qe_par_io->cepier));
>> +	printk(KERN_INFO "cepimr : addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & qe_par_io->cepimr, in_be32(&qe_par_io->cepimr));
>> +	printk(KERN_INFO "cepicr : addr - 0x%08x, val - 0x%08x\n",
>> +	       (u32) & qe_par_io->cepicr, in_be32(&qe_par_io->cepicr));
>> +}
>> +
>> +EXPORT_SYMBOL(dump_par_io);
>> +#endif
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-
>> kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>

