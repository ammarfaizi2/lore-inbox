Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWEJWAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWEJWAS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWEJWAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:00:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932305AbWEJWAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:00:15 -0400
Date: Wed, 10 May 2006 15:00:01 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Brice Goglin <brice@myri.com>
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>
Subject: Re: [PATCH 3/6] myri10ge - Driver header files
Message-ID: <20060510150001.0ddd4797@localhost.localdomain>
In-Reply-To: <44625CD2.8040100@myri.com>
References: <446259A0.8050504@myri.com>
	<44625CD2.8040100@myri.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006 23:36:18 +0200
Brice Goglin <brice@myri.com> wrote:

> [PATCH 3/6] myri10ge - Driver header files
> 
> myri10ge driver header files.
> myri10ge_mcp.h is the generic header, while myri10ge_mcp_gen_header.h
> is automatically generated from our firmware image.

Then clean it up after the auto generation.
Auto generated code still gets maintained by humans.

> Signed-off-by: Brice Goglin <brice@myri.com>
> Signed-off-by: Andrew J. Gallatin <gallatin@myri.com>
> 
>  myri10ge_mcp.h            |  233 ++++++++++++++++++++++++++++++++++++++++++++++
>  myri10ge_mcp_gen_header.h |   73 ++++++++++++++
>  2 files changed, 306 insertions(+)
> 
> --- /dev/null	2006-04-21 00:45:09.064430000 -0700
> +++ linux-mm/drivers/net/myri10ge/myri10ge_mcp.h	2006-04-21 08:20:59.000000000 -0700
> @@ -0,0 +1,233 @@
> +#ifndef _myri10ge_mcp_h
> +#define _myri10ge_mcp_h
> +
> +#define MYRI10GE_MCP_MAJOR	1
> +#define MYRI10GE_MCP_MINOR	4
> +

Major/Minor for what. You don't have a character device.

> +#ifdef MYRI10GE_MCP
> +typedef signed char          int8_t;
> +typedef signed short        int16_t;
> +typedef signed int          int32_t;
> +typedef signed long long    int64_t;
> +typedef unsigned char       uint8_t;
> +typedef unsigned short     uint16_t;
> +typedef unsigned int       uint32_t;
> +typedef unsigned long long uint64_t;
> +#endif

Use u8 u16 u32


> +/* 8 Bytes */
> +typedef struct
> +{
> +  uint32_t high;
> +  uint32_t low;
> +} mcp_dma_addr_t;

Run this through scripts/Lindent and get indentation right

> +/* 16 Bytes */
> +typedef struct
> +{
> +  uint16_t checksum;
> +  uint16_t length;
> +} mcp_slot_t;
> +
> +/* 64 Bytes */
> +typedef struct
> +{
> +  uint32_t cmd;
> +  uint32_t data0;	/* will be low portion if data > 32 bits */
> +  /* 8 */
> +  uint32_t data1;	/* will be high portion if data > 32 bits */
> +  uint32_t data2;	/* currently unused.. */
> +  /* 16 */
> +  mcp_dma_addr_t response_addr;
> +  /* 24 */
> +  uint8_t pad[40];
> +} mcp_cmd_t;
> +
> +/* 8 Bytes */
> +typedef struct
> +{
> +  uint32_t data;
> +  uint32_t result;
> +} mcp_cmd_response_t;
> +
> +
> +
> +/* 
> +   flags used in mcp_kreq_ether_send_t:
> +
> +   The SMALL flag is only needed in the first segment. It is raised
> +   for packets that are total less or equal 512 bytes.
> +
> +   The CKSUM flag must be set in all segments.
> +
> +   The PADDED flags is set if the packet needs to be padded, and it
> +   must be set for all segments.
> +
> +   The  MYRI10GE_MCP_ETHER_FLAGS_ALIGN_ODD must be set if the cumulative
> +   length of all previous segments was odd.
> +*/
> +
> +
> +#define MYRI10GE_MCP_ETHER_FLAGS_SMALL      0x1
> +#define MYRI10GE_MCP_ETHER_FLAGS_TSO_HDR    0x1
> +#define MYRI10GE_MCP_ETHER_FLAGS_FIRST      0x2
> +#define MYRI10GE_MCP_ETHER_FLAGS_ALIGN_ODD  0x4
> +#define MYRI10GE_MCP_ETHER_FLAGS_CKSUM      0x8
> +#define MYRI10GE_MCP_ETHER_FLAGS_TSO_LAST   0x8
> +#define MYRI10GE_MCP_ETHER_FLAGS_NO_TSO     0x10
> +#define MYRI10GE_MCP_ETHER_FLAGS_TSO_CHOP   0x10
> +#define MYRI10GE_MCP_ETHER_FLAGS_TSO_PLD    0x20
> +
> +#define MYRI10GE_MCP_ETHER_SEND_SMALL_SIZE  1520
> +#define MYRI10GE_MCP_ETHER_MAX_MTU          9400
> +
> +typedef union mcp_pso_or_cumlen
> +{
> +  uint16_t pseudo_hdr_offset;
> +  uint16_t cum_len;
> +} mcp_pso_or_cumlen_t;
> +
> +#define	MYRI10GE_MCP_ETHER_MAX_SEND_DESC 12
> +#define MYRI10GE_MCP_ETHER_PAD	    2
> +
> +/* 16 Bytes */
> +typedef struct
> +{
> +  uint32_t addr_high;
> +  uint32_t addr_low;
> +  uint16_t pseudo_hdr_offset;
> +  uint16_t length;
> +  uint8_t  pad;
> +  uint8_t  rdma_count;
> +  uint8_t  cksum_offset; 	/* where to start computing cksum */
> +  uint8_t  flags;	       	/* as defined above */
> +} mcp_kreq_ether_send_t;
> +
> +/* 8 Bytes */
> +typedef struct
> +{
> +  uint32_t addr_high;
> +  uint32_t addr_low;
> +} mcp_kreq_ether_recv_t;
> +
> +
> +/* Commands */
> +
> +#define MYRI10GE_MCP_CMD_OFFSET 0xf80000
> +
> +typedef enum {
> +  MYRI10GE_MCP_CMD_NONE = 0,
> +  /* Reset the mcp, it is left in a safe state, waiting
> +     for the driver to set all its parameters */
> +  MYRI10GE_MCP_CMD_RESET,
> +
> +  /* get the version number of the current firmware..
> +     (may be available in the eeprom strings..? */
> +  MYRI10GE_MCP_GET_MCP_VERSION,
> +
> +
> +  /* Parameters which must be set by the driver before it can
> +     issue MYRI10GE_MCP_CMD_ETHERNET_UP. They persist until the next
> +     MYRI10GE_MCP_CMD_RESET is issued */
> +
> +  MYRI10GE_MCP_CMD_SET_INTRQ_DMA,
> +  MYRI10GE_MCP_CMD_SET_BIG_BUFFER_SIZE,	/* in bytes, power of 2 */
> +  MYRI10GE_MCP_CMD_SET_SMALL_BUFFER_SIZE,	/* in bytes */
> +  
> +
> +  /* Parameters which refer to lanai SRAM addresses where the 
> +     driver must issue PIO writes for various things */
> +
> +  MYRI10GE_MCP_CMD_GET_SEND_OFFSET,
> +  MYRI10GE_MCP_CMD_GET_SMALL_RX_OFFSET,
> +  MYRI10GE_MCP_CMD_GET_BIG_RX_OFFSET,
> +  MYRI10GE_MCP_CMD_GET_IRQ_ACK_OFFSET,
> +  MYRI10GE_MCP_CMD_GET_IRQ_DEASSERT_OFFSET,
> +
> +  /* Parameters which refer to rings stored on the MCP,
> +     and whose size is controlled by the mcp */
> +
> +  MYRI10GE_MCP_CMD_GET_SEND_RING_SIZE,	/* in bytes */
> +  MYRI10GE_MCP_CMD_GET_RX_RING_SIZE,		/* in bytes */
> +
> +  /* Parameters which refer to rings stored in the host,
> +     and whose size is controlled by the host.  Note that
> +     all must be physically contiguous and must contain 
> +     a power of 2 number of entries.  */
> +
> +  MYRI10GE_MCP_CMD_SET_INTRQ_SIZE, 	/* in bytes */
> +
> +  /* command to bring ethernet interface up.  Above parameters
> +     (plus mtu & mac address) must have been exchanged prior
> +     to issuing this command  */
> +  MYRI10GE_MCP_CMD_ETHERNET_UP,
> +
> +  /* command to bring ethernet interface down.  No further sends
> +     or receives may be processed until an MYRI10GE_MCP_CMD_ETHERNET_UP
> +     is issued, and all interrupt queues must be flushed prior
> +     to ack'ing this command */
> +
> +  MYRI10GE_MCP_CMD_ETHERNET_DOWN,
> +
> +  /* commands the driver may issue live, without resetting
> +     the nic.  Note that increasing the mtu "live" should
> +     only be done if the driver has already supplied buffers
> +     sufficiently large to handle the new mtu.  Decreasing
> +     the mtu live is safe */
> +
> +  MYRI10GE_MCP_CMD_SET_MTU,
> +  MYRI10GE_MCP_CMD_GET_INTR_COAL_DELAY_OFFSET,  /* in microseconds */
> +  MYRI10GE_MCP_CMD_SET_STATS_INTERVAL,   /* in microseconds */
> +  MYRI10GE_MCP_CMD_SET_STATS_DMA,
> +
> +  MYRI10GE_MCP_ENABLE_PROMISC,
> +  MYRI10GE_MCP_DISABLE_PROMISC,
> +  MYRI10GE_MCP_SET_MAC_ADDRESS,
> +
> +  MYRI10GE_MCP_ENABLE_FLOW_CONTROL,
> +  MYRI10GE_MCP_DISABLE_FLOW_CONTROL,
> +
> +  /* do a DMA test
> +     data0,data1 = DMA address
> +     data2       = RDMA length (MSH), WDMA length (LSH)
> +     command return data = repetitions (MSH), 0.5-ms ticks (LSH)
> +  */
> +  MYRI10GE_MCP_DMA_TEST
> +} myri10ge_mcp_cmd_type_t;
> +
> +
> +typedef enum {
> +  MYRI10GE_MCP_CMD_OK = 0,
> +  MYRI10GE_MCP_CMD_UNKNOWN,
> +  MYRI10GE_MCP_CMD_ERROR_RANGE,
> +  MYRI10GE_MCP_CMD_ERROR_BUSY,
> +  MYRI10GE_MCP_CMD_ERROR_EMPTY,
> +  MYRI10GE_MCP_CMD_ERROR_CLOSED,
> +  MYRI10GE_MCP_CMD_ERROR_HASH_ERROR,
> +  MYRI10GE_MCP_CMD_ERROR_BAD_PORT,
> +  MYRI10GE_MCP_CMD_ERROR_RESOURCES
> +} myri10ge_mcp_cmd_status_t;
> +
> +
> +/* 32 Bytes */
> +typedef struct
> +{
> +  uint32_t send_done_count;
> +
> +  uint32_t link_up;
> +  uint32_t dropped_link_overflow;
> +  uint32_t dropped_link_error_or_filtered;
> +  uint32_t dropped_runt;
> +  uint32_t dropped_overrun;
> +  uint32_t dropped_no_small_buffer;
> +  uint32_t dropped_no_big_buffer;
> +  uint32_t rdma_tags_available;
> +
> +  uint8_t tx_stopped;
> +  uint8_t link_down;
> +  uint8_t stats_updated;
> +  uint8_t valid;
> +} mcp_irq_data_t;
> +
> +
> +#endif /* _myri10ge_mcp_h */
> --- /dev/null	2006-04-21 00:45:09.064430000 -0700
> +++ linux-mm/drivers/net/myri10ge/myri10ge_mcp_gen_header.h	2006-04-21 08:22:06.000000000 -0700
> @@ -0,0 +1,73 @@
> +#ifndef _myri10ge_mcp_gen_header_h
> +#define _myri10ge_mcp_gen_header_h
> +
> +/* this file define a standard header used as a first entry point to
> +   exchange information between firmware/driver and driver.  The
> +   header structure can be anywhere in the mcp. It will usually be in
> +   the .data section, because some fields needs to be initialized at
> +   compile time.
> +   The 32bit word at offset MX_HEADER_PTR_OFFSET in the mcp must
> +   contains the location of the header. 
> +
> +   Typically a MCP will start with the following:
> +   .text
> +     .space 52    ! to help catch MEMORY_INT errors
> +     bt start     ! jump to real code
> +     nop
> +     .long _gen_mcp_header
> +   
> +   The source will have a definition like:
> +
> +   mcp_gen_header_t gen_mcp_header = {
> +      .header_length = sizeof(mcp_gen_header_t),
> +      .mcp_type = MCP_TYPE_XXX,
> +      .version = "something $Id: mcp_gen_header.h,v 1.1 2005/12/23 02:10:44 gallatin Exp $",
> +      .mcp_globals = (unsigned)&Globals
> +   };
> +*/
> +
> +
> +#define MCP_HEADER_PTR_OFFSET  0x3c
> +
> +#define MCP_TYPE_MX 0x4d582020 /* "MX  " */
> +#define MCP_TYPE_PCIE 0x70636965 /* "PCIE" pcie-only MCP */
> +#define MCP_TYPE_ETH 0x45544820 /* "ETH " */
> +#define MCP_TYPE_MCP0 0x4d435030 /* "MCP0" */
> +
> +
> +typedef struct mcp_gen_header {
> +  /* the first 4 fields are filled at compile time */
> +  unsigned header_length;
> +  unsigned mcp_type;
> +  char version[128];
> +  unsigned mcp_globals; /* pointer to mcp-type specific structure */
> +
> +  /* filled by the MCP at run-time */
> +  unsigned sram_size;
> +  unsigned string_specs;  /* either the original STRING_SPECS or a superset */
> +  unsigned string_specs_len;
> +
> +  /* Fields above this comment are guaranteed to be present.
> +
> +     Fields below this comment are extensions added in later versions
> +     of this struct, drivers should compare the header_length against
> +     offsetof(field) to check wether a given MCP implements them.
> +
> +     Never remove any field.  Keep everything naturally align.
> +  */
> +} mcp_gen_header_t;
> +
> +/* Macro to create a simple mcp header */
> +#define MCP_GEN_HEADER_DECL(type, version_str, global_ptr)	\
> +  struct mcp_gen_header mcp_gen_header = {			\
> +    sizeof (struct mcp_gen_header),				\
> +    (type),							\
> +    version_str,						\
> +    (global_ptr),						\
> +    SRAM_SIZE,							\
> +    (unsigned int) STRING_SPECS,				\
> +    256								\
> +  }
> +
> +

Ugly macro.
