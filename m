Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268313AbUHKXw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268313AbUHKXw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268324AbUHKXvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:51:43 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:30444 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268390AbUHKXhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:37:09 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200408112335.i7BNZvrp140066@fsgi900.americas.sgi.com>
Subject: Re: Altix I/O code reorganization - 20 of 21
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Date: Wed, 11 Aug 2004 18:35:56 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/11 17:54:44-05:00 pfg@sgi.com 
#   code clean up
# 
# include/asm-ia64/sn/xtalk/xbow_info.h
#   2004/08/11 17:54:30-05:00 pfg@sgi.com +0 -2
#    
# 
# include/asm-ia64/sn/xtalk/xbow.h
#   2004/08/11 17:54:30-05:00 pfg@sgi.com +48 -408
#    c
# 
diff -Nru a/include/asm-ia64/sn/xtalk/xbow.h b/include/asm-ia64/sn/xtalk/xbow.h
--- a/include/asm-ia64/sn/xtalk/xbow.h	2004-08-11 17:55:11 -05:00
+++ b/include/asm-ia64/sn/xtalk/xbow.h	2004-08-11 17:55:11 -05:00
@@ -12,15 +12,6 @@
  * xbow.h - header file for crossbow chip and xbow section of xbridge
  */
 
-#include <asm/types.h>
-#include <asm/sn/xtalk/xtalk.h>
-#include <asm/sn/xtalk/xwidget.h>
-#include <asm/sn/xtalk/xswitch.h>
-#ifndef __ASSEMBLY__
-#include <asm/sn/xtalk/xbow_info.h>
-#endif
-
-
 #define	XBOW_DRV_PREFIX	"xbow_"
 
 /* The crossbow chip supports 8 8/16 bits I/O ports, numbered 0x8 through 0xf.
@@ -52,9 +43,6 @@
 
 #define MAX_XBOW_NAME 	16
 
-#ifndef __ASSEMBLY__
-typedef uint32_t      xbowreg_t;
-
 /* Register set for each xbow link */
 typedef volatile struct xb_linkregs_s {
 /* 
@@ -62,27 +50,27 @@
  * gets twiddled (i.e. references to 0x4 actually go to 0x0 and vv.)
  * That's why we put the register first and filler second.
  */
-    xbowreg_t               link_ibf;
-    xbowreg_t               filler0;	/* filler for proper alignment */
-    xbowreg_t               link_control;
-    xbowreg_t               filler1;
-    xbowreg_t               link_status;
-    xbowreg_t               filler2;
-    xbowreg_t               link_arb_upper;
-    xbowreg_t               filler3;
-    xbowreg_t               link_arb_lower;
-    xbowreg_t               filler4;
-    xbowreg_t               link_status_clr;
-    xbowreg_t               filler5;
-    xbowreg_t               link_reset;
-    xbowreg_t               filler6;
-    xbowreg_t               link_aux_status;
-    xbowreg_t               filler7;
+    uint32_t               link_ibf;
+    uint32_t               filler0;	/* filler for proper alignment */
+    uint32_t               link_control;
+    uint32_t               filler1;
+    uint32_t               link_status;
+    uint32_t               filler2;
+    uint32_t               link_arb_upper;
+    uint32_t               filler3;
+    uint32_t               link_arb_lower;
+    uint32_t               filler4;
+    uint32_t               link_status_clr;
+    uint32_t               filler5;
+    uint32_t               link_reset;
+    uint32_t               filler6;
+    uint32_t               link_aux_status;
+    uint32_t               filler7;
 } xb_linkregs_t;
 
 typedef volatile struct xbow_s {
     /* standard widget configuration                       0x000000-0x000057 */
-    widget_cfg_t            xb_widget;  /* 0x000000 */
+    struct widget_cfg            xb_widget;  /* 0x000000 */
 
     /* helper fieldnames for accessing bridge widget */
 
@@ -104,40 +92,40 @@
  * That's why we put the register first and filler second.
  */
     /* xbow-specific widget configuration                  0x000058-0x0000FF */
-    xbowreg_t               xb_wid_arb_reload;  /* 0x00005C */
-    xbowreg_t               _pad_000058;
-    xbowreg_t               xb_perf_ctr_a;      /* 0x000064 */
-    xbowreg_t               _pad_000060;
-    xbowreg_t               xb_perf_ctr_b;      /* 0x00006c */
-    xbowreg_t               _pad_000068;
-    xbowreg_t               xb_nic;     /* 0x000074 */
-    xbowreg_t               _pad_000070;
+    uint32_t               xb_wid_arb_reload;  /* 0x00005C */
+    uint32_t               _pad_000058;
+    uint32_t               xb_perf_ctr_a;      /* 0x000064 */
+    uint32_t               _pad_000060;
+    uint32_t               xb_perf_ctr_b;      /* 0x00006c */
+    uint32_t               _pad_000068;
+    uint32_t               xb_nic;     /* 0x000074 */
+    uint32_t               _pad_000070;
 
     /* Xbridge only */
-    xbowreg_t               xb_w0_rst_fnc;      /* 0x00007C */
-    xbowreg_t               _pad_000078;
-    xbowreg_t               xb_l8_rst_fnc;      /* 0x000084 */
-    xbowreg_t               _pad_000080;
-    xbowreg_t               xb_l9_rst_fnc;      /* 0x00008c */
-    xbowreg_t               _pad_000088;
-    xbowreg_t               xb_la_rst_fnc;      /* 0x000094 */
-    xbowreg_t               _pad_000090;
-    xbowreg_t               xb_lb_rst_fnc;      /* 0x00009c */
-    xbowreg_t               _pad_000098;
-    xbowreg_t               xb_lc_rst_fnc;      /* 0x0000a4 */
-    xbowreg_t               _pad_0000a0;
-    xbowreg_t               xb_ld_rst_fnc;      /* 0x0000ac */
-    xbowreg_t               _pad_0000a8;
-    xbowreg_t               xb_le_rst_fnc;      /* 0x0000b4 */
-    xbowreg_t               _pad_0000b0;
-    xbowreg_t               xb_lf_rst_fnc;      /* 0x0000bc */
-    xbowreg_t               _pad_0000b8;
-    xbowreg_t               xb_lock;            /* 0x0000c4 */
-    xbowreg_t               _pad_0000c0;
-    xbowreg_t               xb_lock_clr;        /* 0x0000cc */
-    xbowreg_t               _pad_0000c8;
+    uint32_t               xb_w0_rst_fnc;      /* 0x00007C */
+    uint32_t               _pad_000078;
+    uint32_t               xb_l8_rst_fnc;      /* 0x000084 */
+    uint32_t               _pad_000080;
+    uint32_t               xb_l9_rst_fnc;      /* 0x00008c */
+    uint32_t               _pad_000088;
+    uint32_t               xb_la_rst_fnc;      /* 0x000094 */
+    uint32_t               _pad_000090;
+    uint32_t               xb_lb_rst_fnc;      /* 0x00009c */
+    uint32_t               _pad_000098;
+    uint32_t               xb_lc_rst_fnc;      /* 0x0000a4 */
+    uint32_t               _pad_0000a0;
+    uint32_t               xb_ld_rst_fnc;      /* 0x0000ac */
+    uint32_t               _pad_0000a8;
+    uint32_t               xb_le_rst_fnc;      /* 0x0000b4 */
+    uint32_t               _pad_0000b0;
+    uint32_t               xb_lf_rst_fnc;      /* 0x0000bc */
+    uint32_t               _pad_0000b8;
+    uint32_t               xb_lock;            /* 0x0000c4 */
+    uint32_t               _pad_0000c0;
+    uint32_t               xb_lock_clr;        /* 0x0000cc */
+    uint32_t               _pad_0000c8;
     /* end of Xbridge only */
-    xbowreg_t               _pad_0000d0[12];
+    uint32_t               _pad_0000d0[12];
 
     /* Link Specific Registers, port 8..15                 0x000100-0x000300 */
     xb_linkregs_t           xb_link_raw[MAX_XBOW_PORTS];
@@ -145,20 +133,6 @@
 
 } xbow_t;
 
-/* Configuration structure which describes each xbow link */
-typedef struct xbow_cfg_s {
-    int			    xb_port;	/* port number (0-15) */
-    int			    xb_flags;	/* port software flags */
-    short		    xb_shift;	/* shift for arb reg (mask is 0xff) */
-    short		    xb_ul;	/* upper or lower arb reg */
-    int			    xb_pad;	/* use this later (pad to ptr align) */
-    xb_linkregs_t	   *xb_linkregs;	/* pointer to link registers */
-    widget_cfg_t	   *xb_widget;	/* pointer to widget registers */
-    char		    xb_name[MAX_XBOW_NAME];	/* port name */
-    xbowreg_t		    xb_sh_arb_upper;	/* shadow upper arb register */
-    xbowreg_t		    xb_sh_arb_lower;	/* shadow lower arb register */
-} xbow_cfg_t;
-
 #define XB_FLAGS_EXISTS		0x1	/* device exists */
 #define XB_FLAGS_MASTER		0x2
 #define XB_FLAGS_SLAVE		0x0
@@ -166,9 +140,6 @@
 #define XB_FLAGS_16BIT		0x8
 #define XB_FLAGS_8BIT		0x0
 
-/* get xbow config information for port p */
-#define XB_CONFIG(p)	xbow_cfg[xb_ports[p]]
-
 /* is widget port number valid?  (based on version 7.0 of xbow spec) */
 #define XBOW_WIDGET_IS_VALID(wid) ((wid) >= XBOW_PORT_8 && (wid) <= XBOW_PORT_F)
 
@@ -179,8 +150,6 @@
 /* offset of arbitration register, given source widget id */
 #define XBOW_ARB_OFF(wid) 	(XBOW_ARB_IS_UPPER(wid) ? 0x1c : 0x24)
 
-#endif				/* __ASSEMBLY__ */
-
 #define	XBOW_WID_ID		WIDGET_ID
 #define	XBOW_WID_STAT		WIDGET_STATUS
 #define	XBOW_WID_ERR_UPPER	WIDGET_ERR_UPPER_ADDR
@@ -343,333 +312,4 @@
 
 #define XBOW_WAR_ENABLED(pv, widid) ((1 << XWIDGET_REV_NUM(widid)) & pv)
 
-#ifndef __ASSEMBLY__
-/*
- * XBOW Widget 0 Register formats.
- * Format for many of these registers are similar to the standard
- * widget register format described as part of xtalk specification
- * Standard widget register field format description is available in
- * xwidget.h
- * Following structures define the format for xbow widget 0 registers
- */
-/*
- * Xbow Widget 0 Command error word
- */
-typedef union xbw0_cmdword_u {
-    xbowreg_t               cmdword;
-    struct {
-	uint32_t              rsvd:8,		/* Reserved */
-                                barr:1,         /* Barrier operation */
-                                error:1,        /* Error Occured */
-                                vbpm:1,         /* Virtual Backplane message */
-                                gbr:1,  /* GBR enable ?                 */
-                                ds:2,   /* Data size                    */
-                                ct:1,   /* Is it a coherent transaction */
-                                tnum:5,         /* Transaction Number */
-                                pactyp:4,       /* Packet type: */
-                                srcid:4,        /* Source ID number */
-                                destid:4;       /* Desination ID number */
-
-    } xbw0_cmdfield;
-} xbw0_cmdword_t;
-
-#define	xbcmd_destid	xbw0_cmdfield.destid
-#define	xbcmd_srcid	xbw0_cmdfield.srcid
-#define	xbcmd_pactyp	xbw0_cmdfield.pactyp
-#define	xbcmd_tnum	xbw0_cmdfield.tnum
-#define	xbcmd_ct	xbw0_cmdfield.ct
-#define	xbcmd_ds	xbw0_cmdfield.ds
-#define	xbcmd_gbr	xbw0_cmdfield.gbr
-#define	xbcmd_vbpm	xbw0_cmdfield.vbpm
-#define	xbcmd_error	xbw0_cmdfield.error
-#define	xbcmd_barr	xbw0_cmdfield.barr
-
-/*
- * Values for field PACTYP in xbow error command word
- */
-#define	XBCMDTYP_READREQ	0	/* Read Request   packet  */
-#define	XBCMDTYP_READRESP	1	/* Read Response packet   */
-#define	XBCMDTYP_WRREQ_RESP	2	/* Write Request with response    */
-#define	XBCMDTYP_WRRESP		3	/* Write Response */
-#define	XBCMDTYP_WRREQ_NORESP	4	/* Write request with  No Response */
-#define	XBCMDTYP_FETCHOP	6	/* Fetch & Op packet      */
-#define	XBCMDTYP_STOREOP	8	/* Store & Op packet      */
-#define	XBCMDTYP_SPLPKT_REQ	0xE	/* Special packet request */
-#define	XBCMDTYP_SPLPKT_RESP	0xF	/* Special packet response        */
-
-/*
- * Values for field ds (datasize) in xbow error command word
- */
-#define	XBCMDSZ_DOUBLEWORD	0
-#define	XBCMDSZ_QUARTRCACHE	1
-#define	XBCMDSZ_FULLCACHE	2
-
-/*
- * Xbow widget 0 Status register format.
- */
-
-typedef union xbw0_status_u {
-    xbowreg_t               statusword;
-    struct {
-       uint32_t		mult_err:1,	/* Multiple error occurred */
-                                connect_tout:1, /* Connection timeout   */
-                                xtalk_err:1,    /* Xtalk pkt with error bit */
-                                /* End of Xbridge only */
-                                w0_arb_tout,    /* arbiter timeout err */
-                                w0_recv_tout,   /* receive timeout err */
-                                /* Xbridge only */
-                                regacc_err:1,   /* Reg Access error     */
-                                src_id:4,       /* source id. Xbridge only */
-                                resvd1:13,
-                                wid0intr:1;     /* Widget 0 err intr */
-    } xbw0_stfield;
-} xbw0_status_t;
-
-#define	xbst_linkXintr		xbw0_stfield.linkXintr
-#define	xbst_w0intr		xbw0_stfield.wid0intr
-#define	xbst_regacc_err		xbw0_stfield.regacc_err
-#define	xbst_xtalk_err		xbw0_stfield.xtalk_err
-#define	xbst_connect_tout	xbw0_stfield.connect_tout
-#define	xbst_mult_err		xbw0_stfield.mult_err
-#define xbst_src_id		xbw0_stfield.src_id	    /* Xbridge only */
-#define xbst_w0_recv_tout	xbw0_stfield.w0_recv_tout   /* Xbridge only */
-#define xbst_w0_arb_tout	xbw0_stfield.w0_arb_tout    /* Xbridge only */
-
-/*
- * Xbow widget 0 Control register format
- */
-
-typedef union xbw0_ctrl_u {
-    xbowreg_t               ctrlword;
-    struct {
-	uint32_t              
-				resvd3:1,
-                                conntout_intr:1,
-                                xtalkerr_intr:1,
-                                w0_arg_tout_intr:1,     /* Xbridge only */
-                                w0_recv_tout_intr:1,    /* Xbridge only */
-                                accerr_intr:1,
-                                enable_w0_tout_cntr:1,  /* Xbridge only */
-                                enable_watchdog:1,      /* Xbridge only */
-                                resvd1:24;
-    } xbw0_ctrlfield;
-} xbw0_ctrl_t;
-
-typedef union xbow_linkctrl_u {
-    xbowreg_t               xbl_ctrlword;
-    struct {
-	uint32_t 		srcto_intr:1,
-                                maxto_intr:1, 
-                                rsvd3:1,
-                                trx_retry_intr:1, 
-                                rcv_err_intr:1, 
-                                trx_max_retry_intr:1,
-                                trxov_intr:1, 
-                                rcvov_intr:1,
-                                bwalloc_intr:1, 
-                                rsvd2:7, 
-                                obuf_intr:1,
-                                idest_intr:1, 
-                                llp_credit:5, 
-                                force_badllp:1,
-                                send_bm8:1, 
-                                inbuf_level:3, 
-                                perf_mode:2,
-                                rsvd1:1, 
-       		                alive_intr:1;
-
-    } xb_linkcontrol;
-} xbow_linkctrl_t;
-
-#define	xbctl_accerr_intr	(xbw0_ctrlfield.accerr_intr)
-#define	xbctl_xtalkerr_intr	(xbw0_ctrlfield.xtalkerr_intr)
-#define	xbctl_cnntout_intr	(xbw0_ctrlfield.conntout_intr)
-
-#define	XBW0_CTRL_ACCERR_INTR	(1 << 5)
-#define	XBW0_CTRL_XTERR_INTR	(1 << 2)
-#define	XBW0_CTRL_CONNTOUT_INTR	(1 << 1)
-
-/*
- * Xbow Link specific Registers structure definitions.
- */
-
-typedef union xbow_linkX_status_u {
-    xbowreg_t               linkstatus;
-    struct {
-	uint32_t               pkt_toutsrc:1,
-                                pkt_toutconn:1, /* max_req_tout in Xbridge */
-                                pkt_toutdest:1, /* reserved in Xbridge */
-                                llp_xmitretry:1,
-                                llp_rcverror:1,
-                                llp_maxtxretry:1,
-                                llp_txovflow:1,
-                                llp_rxovflow:1,
-                                bw_errport:8,   /* BW allocation error port   */
-                                ioe:1,          /* Input overallocation error */
-                                illdest:1,
-                                merror:1,
-                                resvd1:12,
-				alive:1;
-    } xb_linkstatus;
-} xbwX_stat_t;
-
-#define	link_alive		xb_linkstatus.alive
-#define	link_multierror		xb_linkstatus.merror
-#define	link_illegal_dest	xb_linkstatus.illdest
-#define	link_ioe		xb_linkstatus.ioe
-#define link_max_req_tout	xb_linkstatus.pkt_toutconn  /* Xbridge */
-#define link_pkt_toutconn	xb_linkstatus.pkt_toutconn  /* Xbow */
-#define link_pkt_toutdest	xb_linkstatus.pkt_toutdest
-#define	link_pkt_toutsrc	xb_linkstatus.pkt_toutsrc
-
-typedef union xbow_aux_linkX_status_u {
-    xbowreg_t               aux_linkstatus;
-    struct {
-	uint32_t 		rsvd2:4,
-                                bit_mode_8:1,
-                                wid_present:1,
-                                fail_mode:1,
-                                rsvd1:1,
-                                to_src_loc:8,
-                                tx_retry_cnt:8,
-				rx_err_cnt:8;
-    } xb_aux_linkstatus;
-} xbow_aux_link_status_t;
-
-typedef union xbow_perf_count_u {
-    xbowreg_t               xb_counter_val;
-    struct {
-        uint32_t 		count:20,
-                                link_select:3,
-				rsvd:9;
-    } xb_perf;
-} xbow_perfcount_t;
-
-#define XBOW_COUNTER_MASK	0xFFFFF
-
-extern int              xbow_widget_present(xbow_t * xbow, int port);
-
-extern xwidget_intr_preset_f xbow_intr_preset;
-extern xswitch_reset_link_f xbow_reset_link;
-void                    xbow_mlreset(xbow_t *);
-
-/* ========================================================================
- */
-
-#ifdef	MACROFIELD_LINE
-/*
- * This table forms a relation between the byte offset macros normally
- * used for ASM coding and the calculated byte offsets of the fields
- * in the C structure.
- *
- * See xbow_check.c xbow_html.c for further details.
- */
-#ifndef MACROFIELD_LINE_BITFIELD
-#define MACROFIELD_LINE_BITFIELD(m)	/* ignored */
-#endif
-
-struct macrofield_s     xbow_macrofield[] =
-{
-
-    MACROFIELD_LINE(XBOW_WID_ID, xb_wid_id)
-    MACROFIELD_LINE(XBOW_WID_STAT, xb_wid_stat)
-    MACROFIELD_LINE_BITFIELD(XB_WID_STAT_LINK_INTR(0xF))
-    MACROFIELD_LINE_BITFIELD(XB_WID_STAT_LINK_INTR(0xE))
-    MACROFIELD_LINE_BITFIELD(XB_WID_STAT_LINK_INTR(0xD))
-    MACROFIELD_LINE_BITFIELD(XB_WID_STAT_LINK_INTR(0xC))
-    MACROFIELD_LINE_BITFIELD(XB_WID_STAT_LINK_INTR(0xB))
-    MACROFIELD_LINE_BITFIELD(XB_WID_STAT_LINK_INTR(0xA))
-    MACROFIELD_LINE_BITFIELD(XB_WID_STAT_LINK_INTR(0x9))
-    MACROFIELD_LINE_BITFIELD(XB_WID_STAT_LINK_INTR(0x8))
-    MACROFIELD_LINE_BITFIELD(XB_WID_STAT_WIDGET0_INTR)
-    MACROFIELD_LINE_BITFIELD(XB_WID_STAT_REG_ACC_ERR)
-    MACROFIELD_LINE_BITFIELD(XB_WID_STAT_XTALK_ERR)
-    MACROFIELD_LINE_BITFIELD(XB_WID_STAT_MULTI_ERR)
-    MACROFIELD_LINE(XBOW_WID_ERR_UPPER, xb_wid_err_upper)
-    MACROFIELD_LINE(XBOW_WID_ERR_LOWER, xb_wid_err_lower)
-    MACROFIELD_LINE(XBOW_WID_CONTROL, xb_wid_control)
-    MACROFIELD_LINE_BITFIELD(XB_WID_CTRL_REG_ACC_IE)
-    MACROFIELD_LINE_BITFIELD(XB_WID_CTRL_XTALK_IE)
-    MACROFIELD_LINE(XBOW_WID_REQ_TO, xb_wid_req_timeout)
-    MACROFIELD_LINE(XBOW_WID_INT_UPPER, xb_wid_int_upper)
-    MACROFIELD_LINE(XBOW_WID_INT_LOWER, xb_wid_int_lower)
-    MACROFIELD_LINE(XBOW_WID_ERR_CMDWORD, xb_wid_err_cmdword)
-    MACROFIELD_LINE(XBOW_WID_LLP, xb_wid_llp)
-    MACROFIELD_LINE(XBOW_WID_STAT_CLR, xb_wid_stat_clr)
-    MACROFIELD_LINE(XBOW_WID_ARB_RELOAD, xb_wid_arb_reload)
-    MACROFIELD_LINE(XBOW_WID_PERF_CTR_A, xb_perf_ctr_a)
-    MACROFIELD_LINE(XBOW_WID_PERF_CTR_B, xb_perf_ctr_b)
-    MACROFIELD_LINE(XBOW_WID_NIC, xb_nic)
-    MACROFIELD_LINE(XB_LINK_REG_BASE(8), xb_link(8))
-    MACROFIELD_LINE(XB_LINK_IBUF_FLUSH(8), xb_link(8).link_ibf)
-    MACROFIELD_LINE(XB_LINK_CTRL(8), xb_link(8).link_control)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_LINKALIVE_IE)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_PERF_CTR_MODE_MSK)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_IBUF_LEVEL_MSK)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_8BIT_MODE)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_BAD_LLP_PKT)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_WIDGET_CR_MSK)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_ILLEGAL_DST_IE)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_OALLOC_IBUF_IE)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_BNDWDTH_ALLOC_IE)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_RCV_CNT_OFLOW_IE)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_XMT_CNT_OFLOW_IE)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_XMT_MAX_RTRY_IE)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_RCV_IE)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_XMT_RTRY_IE)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_MAXREQ_TOUT_IE)
-    MACROFIELD_LINE_BITFIELD(XB_CTRL_SRC_TOUT_IE)
-    MACROFIELD_LINE(XB_LINK_STATUS(8), xb_link(8).link_status)
-    MACROFIELD_LINE_BITFIELD(XB_STAT_LINKALIVE)
-    MACROFIELD_LINE_BITFIELD(XB_STAT_MULTI_ERR)
-    MACROFIELD_LINE_BITFIELD(XB_STAT_ILLEGAL_DST_ERR)
-    MACROFIELD_LINE_BITFIELD(XB_STAT_OALLOC_IBUF_ERR)
-    MACROFIELD_LINE_BITFIELD(XB_STAT_BNDWDTH_ALLOC_ID_MSK)
-    MACROFIELD_LINE_BITFIELD(XB_STAT_RCV_CNT_OFLOW_ERR)
-    MACROFIELD_LINE_BITFIELD(XB_STAT_XMT_CNT_OFLOW_ERR)
-    MACROFIELD_LINE_BITFIELD(XB_STAT_XMT_MAX_RTRY_ERR)
-    MACROFIELD_LINE_BITFIELD(XB_STAT_RCV_ERR)
-    MACROFIELD_LINE_BITFIELD(XB_STAT_XMT_RTRY_ERR)
-    MACROFIELD_LINE_BITFIELD(XB_STAT_MAXREQ_TOUT_ERR)
-    MACROFIELD_LINE_BITFIELD(XB_STAT_SRC_TOUT_ERR)
-    MACROFIELD_LINE(XB_LINK_ARB_UPPER(8), xb_link(8).link_arb_upper)
-    MACROFIELD_LINE_BITFIELD(XB_ARB_RR_MSK << XB_ARB_RR_SHFT(0xb))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_GBR_MSK << XB_ARB_GBR_SHFT(0xb))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_RR_MSK << XB_ARB_RR_SHFT(0xa))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_GBR_MSK << XB_ARB_GBR_SHFT(0xa))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_RR_MSK << XB_ARB_RR_SHFT(0x9))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_GBR_MSK << XB_ARB_GBR_SHFT(0x9))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_RR_MSK << XB_ARB_RR_SHFT(0x8))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_GBR_MSK << XB_ARB_GBR_SHFT(0x8))
-    MACROFIELD_LINE(XB_LINK_ARB_LOWER(8), xb_link(8).link_arb_lower)
-    MACROFIELD_LINE_BITFIELD(XB_ARB_RR_MSK << XB_ARB_RR_SHFT(0xf))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_GBR_MSK << XB_ARB_GBR_SHFT(0xf))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_RR_MSK << XB_ARB_RR_SHFT(0xe))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_GBR_MSK << XB_ARB_GBR_SHFT(0xe))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_RR_MSK << XB_ARB_RR_SHFT(0xd))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_GBR_MSK << XB_ARB_GBR_SHFT(0xd))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_RR_MSK << XB_ARB_RR_SHFT(0xc))
-    MACROFIELD_LINE_BITFIELD(XB_ARB_GBR_MSK << XB_ARB_GBR_SHFT(0xc))
-    MACROFIELD_LINE(XB_LINK_STATUS_CLR(8), xb_link(8).link_status_clr)
-    MACROFIELD_LINE(XB_LINK_RESET(8), xb_link(8).link_reset)
-    MACROFIELD_LINE(XB_LINK_AUX_STATUS(8), xb_link(8).link_aux_status)
-    MACROFIELD_LINE_BITFIELD(XB_AUX_STAT_RCV_CNT)
-    MACROFIELD_LINE_BITFIELD(XB_AUX_STAT_XMT_CNT)
-    MACROFIELD_LINE_BITFIELD(XB_AUX_LINKFAIL_RST_BAD)
-    MACROFIELD_LINE_BITFIELD(XB_AUX_STAT_PRESENT)
-    MACROFIELD_LINE_BITFIELD(XB_AUX_STAT_PORT_WIDTH)
-    MACROFIELD_LINE_BITFIELD(XB_AUX_STAT_TOUT_DST)
-    MACROFIELD_LINE(XB_LINK_REG_BASE(0x8), xb_link(0x8))
-    MACROFIELD_LINE(XB_LINK_REG_BASE(0x9), xb_link(0x9))
-    MACROFIELD_LINE(XB_LINK_REG_BASE(0xA), xb_link(0xA))
-    MACROFIELD_LINE(XB_LINK_REG_BASE(0xB), xb_link(0xB))
-    MACROFIELD_LINE(XB_LINK_REG_BASE(0xC), xb_link(0xC))
-    MACROFIELD_LINE(XB_LINK_REG_BASE(0xD), xb_link(0xD))
-    MACROFIELD_LINE(XB_LINK_REG_BASE(0xE), xb_link(0xE))
-    MACROFIELD_LINE(XB_LINK_REG_BASE(0xF), xb_link(0xF))
-};				/* xbow_macrofield[] */
-
-#endif				/* MACROFIELD_LINE */
-
-#endif				/* __ASSEMBLY__ */
 #endif                          /* _ASM_IA64_SN_XTALK_XBOW_H */
diff -Nru a/include/asm-ia64/sn/xtalk/xbow_info.h b/include/asm-ia64/sn/xtalk/xbow_info.h
--- a/include/asm-ia64/sn/xtalk/xbow_info.h	2004-08-11 17:55:11 -05:00
+++ b/include/asm-ia64/sn/xtalk/xbow_info.h	2004-08-11 17:55:11 -05:00
@@ -8,8 +8,6 @@
 #ifndef _ASM_IA64_SN_XTALK_XBOW_INFO_H
 #define _ASM_IA64_SN_XTALK_XBOW_INFO_H
 
-#include <linux/types.h>
-
 #define XBOW_PERF_MODES	       0x03
 
 typedef struct xbow_link_status {
