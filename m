Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269373AbUINMSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269373AbUINMSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269370AbUINMRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:17:30 -0400
Received: from outmx004.isp.belgacom.be ([195.238.2.101]:8640 "EHLO
	outmx004.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S269342AbUINL6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:58:10 -0400
Message-ID: <4146DD11.8070307@246tNt.com>
Date: Tue, 14 Sep 2004 13:59:13 +0200
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/9] Small updates for Freescale MPC52xx
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/14 11:34:48+02:00 tnt@246tNt.com
#   ppc: Freescale MPC52xx hardware definitions misc updates/fix
#   
#   Mainly this includes :
#    - Remove the 'volatile' keyword in structs defining hardware 
registers sets.
#      This keyword is useless and can even be harmful if it makes 
someone believes
#      it's sufficient to access a register like a variable. It's not ! 
And the
#      registers must be accessed with the appropriate in_be/out_be. So 
we remove
#      this keyword as it's wrong and misleading.
#    - Some fixes to SDMA
#    - Add SRAM unit
#    - Remove of useless #define
#   
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# include/asm-ppc/mpc52xx_psc.h
#   2004/09/14 11:34:35+02:00 tnt@246tNt.com +78 -78
#   ppc: Freescale MPC52xx hardware definitions misc updates/fix
#
# include/asm-ppc/mpc52xx.h
#   2004/09/14 11:34:35+02:00 tnt@246tNt.com +164 -157
#   ppc: Freescale MPC52xx hardware definitions misc updates/fix
#
diff -Nru a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
--- a/include/asm-ppc/mpc52xx.h 2004-09-14 12:47:58 +02:00
+++ b/include/asm-ppc/mpc52xx.h 2004-09-14 12:47:58 +02:00
@@ -42,6 +42,7 @@
 #define MPC52xx_MBAR_VIRT      0xf0000000      /* Virt address */

 #define MPC52xx_MMAP_CTL       (MPC52xx_MBAR + 0x0000)
+#define MPC52xx_SDRAM          (MPC52xx_MBAR + 0x0100)
 #define MPC52xx_CDM            (MPC52xx_MBAR + 0x0200)
 #define MPC52xx_SFTRST         (MPC52xx_MBAR + 0x0220)
 #define MPC52xx_SFTRST_BIT     0x01000000
@@ -71,10 +72,6 @@
 /* SRAM used for SDMA */
 #define MPC52xx_SRAM           (MPC52xx_MBAR + 0x8000)
 #define MPC52xx_SRAM_SIZE      (16*1024)
-#define MPC52xx_SDMA_MAX_TASKS 16
-
-       /* Memory allocation block size */
-#define MPC52xx_SDRAM_UNIT     0x8000          /* 32K byte */
 
 
 /* 
======================================================================== */
@@ -137,136 +134,145 @@
 
 /* Memory Mapping Control */
 struct mpc52xx_mmap_ctl {
-       volatile u32    mbar;           /* MMAP_CTRL + 0x00 */
+       u32     mbar;           /* MMAP_CTRL + 0x00 */
 
-       volatile u32    cs0_start;      /* MMAP_CTRL + 0x04 */
-       volatile u32    cs0_stop;       /* MMAP_CTRL + 0x08 */
-       volatile u32    cs1_start;      /* MMAP_CTRL + 0x0c */
-       volatile u32    cs1_stop;       /* MMAP_CTRL + 0x10 */
-       volatile u32    cs2_start;      /* MMAP_CTRL + 0x14 */
-       volatile u32    cs2_stop;       /* MMAP_CTRL + 0x18 */
-       volatile u32    cs3_start;      /* MMAP_CTRL + 0x1c */
-       volatile u32    cs3_stop;       /* MMAP_CTRL + 0x20 */
-       volatile u32    cs4_start;      /* MMAP_CTRL + 0x24 */
-       volatile u32    cs4_stop;       /* MMAP_CTRL + 0x28 */
-       volatile u32    cs5_start;      /* MMAP_CTRL + 0x2c */
-       volatile u32    cs5_stop;       /* MMAP_CTRL + 0x30 */
+       u32     cs0_start;      /* MMAP_CTRL + 0x04 */
+       u32     cs0_stop;       /* MMAP_CTRL + 0x08 */
+       u32     cs1_start;      /* MMAP_CTRL + 0x0c */
+       u32     cs1_stop;       /* MMAP_CTRL + 0x10 */
+       u32     cs2_start;      /* MMAP_CTRL + 0x14 */
+       u32     cs2_stop;       /* MMAP_CTRL + 0x18 */
+       u32     cs3_start;      /* MMAP_CTRL + 0x1c */
+       u32     cs3_stop;       /* MMAP_CTRL + 0x20 */
+       u32     cs4_start;      /* MMAP_CTRL + 0x24 */
+       u32     cs4_stop;       /* MMAP_CTRL + 0x28 */
+       u32     cs5_start;      /* MMAP_CTRL + 0x2c */
+       u32     cs5_stop;       /* MMAP_CTRL + 0x30 */
 
-       volatile u32    sdram0;         /* MMAP_CTRL + 0x34 */
-       volatile u32    sdram1;         /* MMAP_CTRL + 0X38 */
+       u32     sdram0;         /* MMAP_CTRL + 0x34 */
+       u32     sdram1;         /* MMAP_CTRL + 0X38 */
 
-       volatile u32    reserved[4];    /* MMAP_CTRL + 0x3c .. 0x48 */
+       u32     reserved[4];    /* MMAP_CTRL + 0x3c .. 0x48 */
 
-       volatile u32    boot_start;     /* MMAP_CTRL + 0x4c */
-       volatile u32    boot_stop;      /* MMAP_CTRL + 0x50 */
+       u32     boot_start;     /* MMAP_CTRL + 0x4c */
+       u32     boot_stop;      /* MMAP_CTRL + 0x50 */
       
-       volatile u32    ipbi_ws_ctrl;   /* MMAP_CTRL + 0x54 */
+       u32     ipbi_ws_ctrl;   /* MMAP_CTRL + 0x54 */
       
-       volatile u32    cs6_start;      /* MMAP_CTRL + 0x58 */
-       volatile u32    cs6_stop;       /* MMAP_CTRL + 0x5c */
-       volatile u32    cs7_start;      /* MMAP_CTRL + 0x60 */
-       volatile u32    cs7_stop;       /* MMAP_CTRL + 0x60 */
+       u32     cs6_start;      /* MMAP_CTRL + 0x58 */
+       u32     cs6_stop;       /* MMAP_CTRL + 0x5c */
+       u32     cs7_start;      /* MMAP_CTRL + 0x60 */
+       u32     cs7_stop;       /* MMAP_CTRL + 0x60 */
+};
+
+/* SDRAM control */
+struct mpc52xx_sdram {
+       u32     mode;           /* SDRAM + 0x00 */
+       u32     ctrl;           /* SDRAM + 0x04 */
+       u32     config1;        /* SDRAM + 0x08 */
+       u32     config2;        /* SDRAM + 0x0c */
 };
 
 /* Interrupt controller */
 struct mpc52xx_intr {
-       volatile u32    per_mask;       /* INTR + 0x00 */
-       volatile u32    per_pri1;       /* INTR + 0x04 */
-       volatile u32    per_pri2;       /* INTR + 0x08 */
-       volatile u32    per_pri3;       /* INTR + 0x0c */
-       volatile u32    ctrl;           /* INTR + 0x10 */
-       volatile u32    main_mask;      /* INTR + 0x14 */
-       volatile u32    main_pri1;      /* INTR + 0x18 */
-       volatile u32    main_pri2;      /* INTR + 0x1c */
-       volatile u32    reserved1;      /* INTR + 0x20 */
-       volatile u32    enc_status;     /* INTR + 0x24 */
-       volatile u32    crit_status;    /* INTR + 0x28 */
-       volatile u32    main_status;    /* INTR + 0x2c */
-       volatile u32    per_status;     /* INTR + 0x30 */
-       volatile u32    reserved2;      /* INTR + 0x34 */
-       volatile u32    per_error;      /* INTR + 0x38 */
+       u32     per_mask;       /* INTR + 0x00 */
+       u32     per_pri1;       /* INTR + 0x04 */
+       u32     per_pri2;       /* INTR + 0x08 */
+       u32     per_pri3;       /* INTR + 0x0c */
+       u32     ctrl;           /* INTR + 0x10 */
+       u32     main_mask;      /* INTR + 0x14 */
+       u32     main_pri1;      /* INTR + 0x18 */
+       u32     main_pri2;      /* INTR + 0x1c */
+       u32     reserved1;      /* INTR + 0x20 */
+       u32     enc_status;     /* INTR + 0x24 */
+       u32     crit_status;    /* INTR + 0x28 */
+       u32     main_status;    /* INTR + 0x2c */
+       u32     per_status;     /* INTR + 0x30 */
+       u32     reserved2;      /* INTR + 0x34 */
+       u32     per_error;      /* INTR + 0x38 */
 };
 
 /* SDMA */
 struct mpc52xx_sdma {
-       volatile u32    taskBar;        /* SDMA + 0x00 */
-       volatile u32    currentPointer; /* SDMA + 0x04 */
-       volatile u32    endPointer;     /* SDMA + 0x08 */
-       volatile u32    variablePointer;/* SDMA + 0x0c */
-
-       volatile u8     IntVect1;       /* SDMA + 0x10 */
-       volatile u8     IntVect2;       /* SDMA + 0x11 */
-       volatile u16    PtdCntrl;       /* SDMA + 0x12 */
+       u32     taskBar;        /* SDMA + 0x00 */
+       u32     currentPointer; /* SDMA + 0x04 */
+       u32     endPointer;     /* SDMA + 0x08 */
+       u32     variablePointer;/* SDMA + 0x0c */
+
+       u8      IntVect1;       /* SDMA + 0x10 */
+       u8      IntVect2;       /* SDMA + 0x11 */
+       u16     PtdCntrl;       /* SDMA + 0x12 */
 
-       volatile u32    IntPend;        /* SDMA + 0x14 */
-       volatile u32    IntMask;        /* SDMA + 0x18 */
+       u32     IntPend;        /* SDMA + 0x14 */
+       u32     IntMask;        /* SDMA + 0x18 */
       
-       volatile u16    tcr[16];        /* SDMA + 0x1c .. 0x3a */
+       u16     tcr[16];        /* SDMA + 0x1c .. 0x3a */
 
-       volatile u8     ipr[31];        /* SDMA + 0x3c .. 5b */
+       u8      ipr[32];        /* SDMA + 0x3c .. 5b */
 
-       volatile u32    res1;           /* SDMA + 0x5c */
-       volatile u32    task_size0;     /* SDMA + 0x60 */
-       volatile u32    task_size1;     /* SDMA + 0x64 */
-       volatile u32    MDEDebug;       /* SDMA + 0x68 */
-       volatile u32    ADSDebug;       /* SDMA + 0x6c */
-       volatile u32    Value1;         /* SDMA + 0x70 */
-       volatile u32    Value2;         /* SDMA + 0x74 */
-       volatile u32    Control;        /* SDMA + 0x78 */
-       volatile u32    Status;         /* SDMA + 0x7c */
+       u32     cReqSelect;     /* SDMA + 0x5c */
+       u32     task_size0;     /* SDMA + 0x60 */
+       u32     task_size1;     /* SDMA + 0x64 */
+       u32     MDEDebug;       /* SDMA + 0x68 */
+       u32     ADSDebug;       /* SDMA + 0x6c */
+       u32     Value1;         /* SDMA + 0x70 */
+       u32     Value2;         /* SDMA + 0x74 */
+       u32     Control;        /* SDMA + 0x78 */
+       u32     Status;         /* SDMA + 0x7c */
+       u32     PTDDebug;       /* SDMA + 0x80 */
 };
 
 /* GPT */
 struct mpc52xx_gpt {
-       volatile u32    mode;           /* GPTx + 0x00 */
-       volatile u32    count;          /* GPTx + 0x04 */
-       volatile u32    pwm;            /* GPTx + 0x08 */
-       volatile u32    status;         /* GPTx + 0X0c */
+       u32     mode;           /* GPTx + 0x00 */
+       u32     count;          /* GPTx + 0x04 */
+       u32     pwm;            /* GPTx + 0x08 */
+       u32     status;         /* GPTx + 0X0c */
 };

 /* RTC */
 struct mpc52xx_rtc {
-       volatile u32    time_set;       /* RTC + 0x00 */
-       volatile u32    date_set;       /* RTC + 0x04 */
-       volatile u32    stopwatch;      /* RTC + 0x08 */
-       volatile u32    int_enable;     /* RTC + 0x0c */
-       volatile u32    time;           /* RTC + 0x10 */
-       volatile u32    date;           /* RTC + 0x14 */
-       volatile u32    stopwatch_intr; /* RTC + 0x18 */
-       volatile u32    bus_error;      /* RTC + 0x1c */
-       volatile u32    dividers;       /* RTC + 0x20 */
+       u32     time_set;       /* RTC + 0x00 */
+       u32     date_set;       /* RTC + 0x04 */
+       u32     stopwatch;      /* RTC + 0x08 */
+       u32     int_enable;     /* RTC + 0x0c */
+       u32     time;           /* RTC + 0x10 */
+       u32     date;           /* RTC + 0x14 */
+       u32     stopwatch_intr; /* RTC + 0x18 */
+       u32     bus_error;      /* RTC + 0x1c */
+       u32     dividers;       /* RTC + 0x20 */
 };

 /* GPIO */
 struct mpc52xx_gpio {
-       volatile u32    port_config;    /* GPIO + 0x00 */
-       volatile u32    simple_gpioe;   /* GPIO + 0x04 */
-       volatile u32    simple_ode;     /* GPIO + 0x08 */
-       volatile u32    simple_ddr;     /* GPIO + 0x0c */
-       volatile u32    simple_dvo;     /* GPIO + 0x10 */
-       volatile u32    simple_ival;    /* GPIO + 0x14 */
-       volatile u8     outo_gpioe;     /* GPIO + 0x18 */
-       volatile u8     reserved1[3];   /* GPIO + 0x19 */
-       volatile u8     outo_dvo;       /* GPIO + 0x1c */
-       volatile u8     reserved2[3];   /* GPIO + 0x1d */
-       volatile u8     sint_gpioe;     /* GPIO + 0x20 */
-       volatile u8     reserved3[3];   /* GPIO + 0x21 */
-       volatile u8     sint_ode;       /* GPIO + 0x24 */
-       volatile u8     reserved4[3];   /* GPIO + 0x25 */
-       volatile u8     sint_ddr;       /* GPIO + 0x28 */
-       volatile u8     reserved5[3];   /* GPIO + 0x29 */
-       volatile u8     sint_dvo;       /* GPIO + 0x2c */
-       volatile u8     reserved6[3];   /* GPIO + 0x2d */
-       volatile u8     sint_inten;     /* GPIO + 0x30 */
-       volatile u8     reserved7[3];   /* GPIO + 0x31 */
-       volatile u16    sint_itype;     /* GPIO + 0x34 */
-       volatile u16    reserved8;      /* GPIO + 0x36 */
-       volatile u8     gpio_control;   /* GPIO + 0x38 */
-       volatile u8     reserved9[3];   /* GPIO + 0x39 */
-       volatile u8     sint_istat;     /* GPIO + 0x3c */
-       volatile u8     sint_ival;      /* GPIO + 0x3d */
-       volatile u8     bus_errs;       /* GPIO + 0x3e */
-       volatile u8     reserved10;     /* GPIO + 0x3f */
+       u32     port_config;    /* GPIO + 0x00 */
+       u32     simple_gpioe;   /* GPIO + 0x04 */
+       u32     simple_ode;     /* GPIO + 0x08 */
+       u32     simple_ddr;     /* GPIO + 0x0c */
+       u32     simple_dvo;     /* GPIO + 0x10 */
+       u32     simple_ival;    /* GPIO + 0x14 */
+       u8      outo_gpioe;     /* GPIO + 0x18 */
+       u8      reserved1[3];   /* GPIO + 0x19 */
+       u8      outo_dvo;       /* GPIO + 0x1c */
+       u8      reserved2[3];   /* GPIO + 0x1d */
+       u8      sint_gpioe;     /* GPIO + 0x20 */
+       u8      reserved3[3];   /* GPIO + 0x21 */
+       u8      sint_ode;       /* GPIO + 0x24 */
+       u8      reserved4[3];   /* GPIO + 0x25 */
+       u8      sint_ddr;       /* GPIO + 0x28 */
+       u8      reserved5[3];   /* GPIO + 0x29 */
+       u8      sint_dvo;       /* GPIO + 0x2c */
+       u8      reserved6[3];   /* GPIO + 0x2d */
+       u8      sint_inten;     /* GPIO + 0x30 */
+       u8      reserved7[3];   /* GPIO + 0x31 */
+       u16     sint_itype;     /* GPIO + 0x34 */
+       u16     reserved8;      /* GPIO + 0x36 */
+       u8      gpio_control;   /* GPIO + 0x38 */
+       u8      reserved9[3];   /* GPIO + 0x39 */
+       u8      sint_istat;     /* GPIO + 0x3c */
+       u8      sint_ival;      /* GPIO + 0x3d */
+       u8      bus_errs;       /* GPIO + 0x3e */
+       u8      reserved10;     /* GPIO + 0x3f */
 };

 #define MPC52xx_GPIO_PSC_CONFIG_UART_WITHOUT_CD        4
@@ -275,68 +281,69 @@

 /* XLB Bus control */
 struct mpc52xx_xlb {
-       volatile u8 reserved[0x40];
-       volatile u32 config;            /* XLB + 0x40 */
-       volatile u32 version;           /* XLB + 0x44 */
-       volatile u32 status;            /* XLB + 0x48 */
-       volatile u32 int_enable;        /* XLB + 0x4c */
-       volatile u32 addr_capture;      /* XLB + 0x50 */
-       volatile u32 bus_sig_capture;   /* XLB + 0x54 */
-       volatile u32 addr_timeout;      /* XLB + 0x58 */
-       volatile u32 data_timeout;      /* XLB + 0x5c */
-       volatile u32 bus_act_timeout;   /* XLB + 0x60 */
-       volatile u32 master_pri_enable; /* XLB + 0x64 */
-       volatile u32 master_priority;   /* XLB + 0x68 */
-       volatile u32 base_address;      /* XLB + 0x6c */
-       volatile u32 snoop_window;      /* XLB + 0x70 */
+       u8      reserved[0x40];
+       u32     config;                 /* XLB + 0x40 */
+       u32     version;                /* XLB + 0x44 */
+       u32     status;                 /* XLB + 0x48 */
+       u32     int_enable;             /* XLB + 0x4c */
+       u32     addr_capture;           /* XLB + 0x50 */
+       u32     bus_sig_capture;        /* XLB + 0x54 */
+       u32     addr_timeout;           /* XLB + 0x58 */
+       u32     data_timeout;           /* XLB + 0x5c */
+       u32     bus_act_timeout;        /* XLB + 0x60 */
+       u32     master_pri_enable;      /* XLB + 0x64 */
+       u32     master_priority;        /* XLB + 0x68 */
+       u32     base_address;           /* XLB + 0x6c */
+       u32     snoop_window;           /* XLB + 0x70 */
 };

+#define MPC52xx_XLB_CFG_SNOOP          (1 << 15)

 /* Clock Distribution control */
 struct mpc52xx_cdm {
-       volatile u32    jtag_id;        /* MBAR_CDM + 0x00  reg0 read 
only */
-       volatile u32    rstcfg;         /* MBAR_CDM + 0x04  reg1 read 
only */
-       volatile u32    breadcrumb;     /* MBAR_CDM + 0x08  reg2 */
-
-       volatile u8     mem_clk_sel;    /* MBAR_CDM + 0x0c  reg3 byte0 */
-       volatile u8     xlb_clk_sel;    /* MBAR_CDM + 0x0d  reg3 byte1 
read only
 */
-       volatile u8     ipb_clk_sel;    /* MBAR_CDM + 0x0e  reg3 byte2 */
-       volatile u8     pci_clk_sel;    /* MBAR_CDM + 0x0f  reg3 byte3 */
-
-       volatile u8     ext_48mhz_en;   /* MBAR_CDM + 0x10  reg4 byte0 */
-       volatile u8     fd_enable;      /* MBAR_CDM + 0x11  reg4 byte1 */
-       volatile u16    fd_counters;    /* MBAR_CDM + 0x12  reg4 byte2,3 */
-
-       volatile u32    clk_enables;    /* MBAR_CDM + 0x14  reg5 */
-
-       volatile u8     osc_disable;    /* MBAR_CDM + 0x18  reg6 byte0 */
-       volatile u8     reserved0[3];   /* MBAR_CDM + 0x19  reg6 
byte1,2,3 */
-
-       volatile u8     ccs_sleep_enable;/* MBAR_CDM + 0x1c  reg7 byte0 */
-       volatile u8     osc_sleep_enable;/* MBAR_CDM + 0x1d  reg7 byte1 */
-       volatile u8     reserved1;      /* MBAR_CDM + 0x1e  reg7 byte2 */
-       volatile u8     ccs_qreq_test;  /* MBAR_CDM + 0x1f  reg7 byte3 */
-
-       volatile u8     soft_reset;     /* MBAR_CDM + 0x20  u8 byte0 */
-       volatile u8     no_ckstp;       /* MBAR_CDM + 0x21  u8 byte0 */
-       volatile u8     reserved2[2];   /* MBAR_CDM + 0x22  u8 byte1,2,3 */
-
-       volatile u8     pll_lock;       /* MBAR_CDM + 0x24  reg9 byte0 */
-       volatile u8     pll_looselock;  /* MBAR_CDM + 0x25  reg9 byte1 */
-       volatile u8     pll_sm_lockwin; /* MBAR_CDM + 0x26  reg9 byte2 */
-       volatile u8     reserved3;      /* MBAR_CDM + 0x27  reg9 byte3 */
+       u32     jtag_id;        /* MBAR_CDM + 0x00  reg0 read only */
+       u32     rstcfg;         /* MBAR_CDM + 0x04  reg1 read only */
+       u32     breadcrumb;     /* MBAR_CDM + 0x08  reg2 */
+
+       u8      mem_clk_sel;    /* MBAR_CDM + 0x0c  reg3 byte0 */
+       u8      xlb_clk_sel;    /* MBAR_CDM + 0x0d  reg3 byte1 read only */
+       u8      ipb_clk_sel;    /* MBAR_CDM + 0x0e  reg3 byte2 */
+       u8      pci_clk_sel;    /* MBAR_CDM + 0x0f  reg3 byte3 */
+
+       u8      ext_48mhz_en;   /* MBAR_CDM + 0x10  reg4 byte0 */
+       u8      fd_enable;      /* MBAR_CDM + 0x11  reg4 byte1 */
+       u16     fd_counters;    /* MBAR_CDM + 0x12  reg4 byte2,3 */
+
+       u32     clk_enables;    /* MBAR_CDM + 0x14  reg5 */
+
+       u8      osc_disable;    /* MBAR_CDM + 0x18  reg6 byte0 */
+       u8      reserved0[3];   /* MBAR_CDM + 0x19  reg6 byte1,2,3 */
+
+       u8      ccs_sleep_enable;/* MBAR_CDM + 0x1c  reg7 byte0 */
+       u8      osc_sleep_enable;/* MBAR_CDM + 0x1d  reg7 byte1 */
+       u8      reserved1;      /* MBAR_CDM + 0x1e  reg7 byte2 */
+       u8      ccs_qreq_test;  /* MBAR_CDM + 0x1f  reg7 byte3 */
+
+       u8      soft_reset;     /* MBAR_CDM + 0x20  u8 byte0 */
+       u8      no_ckstp;       /* MBAR_CDM + 0x21  u8 byte0 */
+       u8      reserved2[2];   /* MBAR_CDM + 0x22  u8 byte1,2,3 */
+
+       u8      pll_lock;       /* MBAR_CDM + 0x24  reg9 byte0 */
+       u8      pll_looselock;  /* MBAR_CDM + 0x25  reg9 byte1 */
+       u8      pll_sm_lockwin; /* MBAR_CDM + 0x26  reg9 byte2 */
+       u8      reserved3;      /* MBAR_CDM + 0x27  reg9 byte3 */

-       volatile u16    reserved4;      /* MBAR_CDM + 0x28  reg10 byte0,1 */
-       volatile u16    mclken_div_psc1;/* MBAR_CDM + 0x2a  reg10 byte2,3 */
+       u16     reserved4;      /* MBAR_CDM + 0x28  reg10 byte0,1 */
+       u16     mclken_div_psc1;/* MBAR_CDM + 0x2a  reg10 byte2,3 */

-       volatile u16    reserved5;      /* MBAR_CDM + 0x2c  reg11 byte0,1 */
-       volatile u16    mclken_div_psc2;/* MBAR_CDM + 0x2e  reg11 byte2,3 */
+       u16     reserved5;      /* MBAR_CDM + 0x2c  reg11 byte0,1 */
+       u16     mclken_div_psc2;/* MBAR_CDM + 0x2e  reg11 byte2,3 */

-       volatile u16    reserved6;      /* MBAR_CDM + 0x30  reg12 byte0,1 */
-       volatile u16    mclken_div_psc3;/* MBAR_CDM + 0x32  reg12 byte2,3 */
+       u16     reserved6;      /* MBAR_CDM + 0x30  reg12 byte0,1 */
+       u16     mclken_div_psc3;/* MBAR_CDM + 0x32  reg12 byte2,3 */

-       volatile u16    reserved7;      /* MBAR_CDM + 0x34  reg13 byte0,1 */
-       volatile u16    mclken_div_psc6;/* MBAR_CDM + 0x36  reg13 byte2,3 */
+       u16     reserved7;      /* MBAR_CDM + 0x34  reg13 byte0,1 */
+       u16     mclken_div_psc6;/* MBAR_CDM + 0x36  reg13 byte2,3 */
 };

 #endif /* __ASSEMBLY__ */
diff -Nru a/include/asm-ppc/mpc52xx_psc.h b/include/asm-ppc/mpc52xx_psc.h
--- a/include/asm-ppc/mpc52xx_psc.h     2004-09-14 12:47:58 +02:00
+++ b/include/asm-ppc/mpc52xx_psc.h     2004-09-14 12:47:58 +02:00
@@ -95,96 +95,96 @@

 /* Structure of the hardware registers */
 struct mpc52xx_psc {
-       volatile u8             mode;           /* PSC + 0x00 */
-       volatile u8             reserved0[3];
-       union {                                 /* PSC + 0x04 */
-               volatile u16    status;
-               volatile u16    clock_select;
+       u8              mode;           /* PSC + 0x00 */
+       u8              reserved0[3];
+       union {                         /* PSC + 0x04 */
+               u16     status;
+               u16     clock_select;
        } sr_csr;
 #define mpc52xx_psc_status     sr_csr.status
-#define mpc52xx_psc_clock_select       sr_csr.clock_select
-       volatile u16            reserved1;
-       volatile u8             command;        /* PSC + 0x08 */
-volatile u8            reserved2[3];
-       union {                                 /* PSC + 0x0c */
-               volatile u8     buffer_8;
-               volatile u16    buffer_16;
-               volatile u32    buffer_32;
+#define mpc52xx_psc_clock_select sr_csr.clock_select
+       u16             reserved1;
+       u8              command;        /* PSC + 0x08 */
+       u8              reserved2[3];
+       union {                         /* PSC + 0x0c */
+               u8      buffer_8;
+               u16     buffer_16;
+               u32     buffer_32;
        } buffer;
 #define mpc52xx_psc_buffer_8   buffer.buffer_8
 #define mpc52xx_psc_buffer_16  buffer.buffer_16
 #define mpc52xx_psc_buffer_32  buffer.buffer_32
-       union {                                 /* PSC + 0x10 */
-               volatile u8     ipcr;
-               volatile u8     acr;
+       union {                         /* PSC + 0x10 */
+               u8      ipcr;
+               u8      acr;
        } ipcr_acr;
 #define mpc52xx_psc_ipcr       ipcr_acr.ipcr
 #define mpc52xx_psc_acr                ipcr_acr.acr
-       volatile u8             reserved3[3];
-       union {                                 /* PSC + 0x14 */
-               volatile u16    isr;
-               volatile u16    imr;
+       u8              reserved3[3];
+       union {                         /* PSC + 0x14 */
+               u16     isr;
+               u16     imr;
        } isr_imr;
 #define mpc52xx_psc_isr                isr_imr.isr
 #define mpc52xx_psc_imr                isr_imr.imr
-       volatile u16            reserved4;
-       volatile u8             ctur;           /* PSC + 0x18 */
-       volatile u8             reserved5[3];
-       volatile u8             ctlr;           /* PSC + 0x1c */
-       volatile u8             reserved6[3];
-       volatile u16            ccr;            /* PSC + 0x20 */
-       volatile u8             reserved7[14];
-       volatile u8             ivr;            /* PSC + 0x30 */
-       volatile u8             reserved8[3];
-       volatile u8             ip;             /* PSC + 0x34 */
-       volatile u8             reserved9[3];
-       volatile u8             op1;            /* PSC + 0x38 */
-       volatile u8             reserved10[3];
-       volatile u8             op0;            /* PSC + 0x3c */
-       volatile u8             reserved11[3];
-       volatile u32            sicr;           /* PSC + 0x40 */
-       volatile u8             ircr1;          /* PSC + 0x44 */
-       volatile u8             reserved13[3];
-       volatile u8             ircr2;          /* PSC + 0x44 */
-       volatile u8             reserved14[3];
-       volatile u8             irsdr;          /* PSC + 0x4c */
-       volatile u8             reserved15[3];
-       volatile u8             irmdr;          /* PSC + 0x50 */
-       volatile u8             reserved16[3];
-       volatile u8             irfdr;          /* PSC + 0x54 */
-       volatile u8             reserved17[3];
-       volatile u16            rfnum;          /* PSC + 0x58 */
-       volatile u16            reserved18;
-       volatile u16            tfnum;          /* PSC + 0x5c */
-       volatile u16            reserved19;
-       volatile u32            rfdata;         /* PSC + 0x60 */
-       volatile u16            rfstat;         /* PSC + 0x64 */
-       volatile u16            reserved20;
-       volatile u8             rfcntl;         /* PSC + 0x68 */
-       volatile u8             reserved21[5];
-       volatile u16            rfalarm;        /* PSC + 0x6e */
-       volatile u16            reserved22;
-       volatile u16            rfrptr;         /* PSC + 0x72 */
-       volatile u16            reserved23;
-       volatile u16            rfwptr;         /* PSC + 0x76 */
-       volatile u16            reserved24;
-       volatile u16            rflrfptr;       /* PSC + 0x7a */
-       volatile u16            reserved25;
-       volatile u16            rflwfptr;       /* PSC + 0x7e */
-       volatile u32            tfdata;         /* PSC + 0x80 */
-       volatile u16            tfstat;         /* PSC + 0x84 */
-       volatile u16            reserved26;
-       volatile u8             tfcntl;         /* PSC + 0x88 */
-       volatile u8             reserved27[5];
-       volatile u16            tfalarm;        /* PSC + 0x8e */
-       volatile u16            reserved28;
-       volatile u16            tfrptr;         /* PSC + 0x92 */
-       volatile u16            reserved29;
-       volatile u16            tfwptr;         /* PSC + 0x96 */
-       volatile u16            reserved30;
-       volatile u16            tflrfptr;       /* PSC + 0x9a */
-       volatile u16            reserved31;
-       volatile u16            tflwfptr;       /* PSC + 0x9e */
+       u16             reserved4;
+       u8              ctur;           /* PSC + 0x18 */
+       u8              reserved5[3];
+       u8              ctlr;           /* PSC + 0x1c */
+       u8              reserved6[3];
+       u16             ccr;            /* PSC + 0x20 */
+       u8              reserved7[14];
+       u8              ivr;            /* PSC + 0x30 */
+       u8              reserved8[3];
+       u8              ip;             /* PSC + 0x34 */
+       u8              reserved9[3];
+       u8              op1;            /* PSC + 0x38 */
+       u8              reserved10[3];
+       u8              op0;            /* PSC + 0x3c */
+       u8              reserved11[3];
+       u32             sicr;           /* PSC + 0x40 */
+       u8              ircr1;          /* PSC + 0x44 */
+       u8              reserved14[3];
+       u8              irsdr;          /* PSC + 0x4c */
+       u8              reserved15[3];
+       u8              irmdr;          /* PSC + 0x50 */
+       u8              reserved16[3];
+       u8              irfdr;          /* PSC + 0x54 */
+       u8              reserved17[3];
+       u16             rfnum;          /* PSC + 0x58 */
+       u16             reserved18;
+       u16             tfnum;          /* PSC + 0x5c */
+       u16             reserved19;
+       u32             rfdata;         /* PSC + 0x60 */
+       u16             rfstat;         /* PSC + 0x64 */
+       u16             reserved20;
+       u8              rfcntl;         /* PSC + 0x68 */
+       u8              reserved21[5];
+       u16             rfalarm;        /* PSC + 0x6e */
+       u16             reserved22;
+       u16             rfrptr;         /* PSC + 0x72 */
+       u16             reserved23;
+       u16             rfwptr;         /* PSC + 0x76 */
+       u16             reserved24;
+       u16             rflrfptr;       /* PSC + 0x7a */
+       u16             reserved25;
+       u16             rflwfptr;       /* PSC + 0x7e */
+       u32             tfdata;         /* PSC + 0x80 */
+       u16             tfstat;         /* PSC + 0x84 */
+       u16             reserved26;
+       u8              tfcntl;         /* PSC + 0x88 */
+       u8              reserved27[5];
+       u16             tfalarm;        /* PSC + 0x8e */
+       u16             reserved28;
+       u16             tfrptr;         /* PSC + 0x92 */
+       u16             reserved29;
+       u16             tfwptr;         /* PSC + 0x96 */
+       u16             reserved30;
+       u16             tflrfptr;       /* PSC + 0x9a */
+       u16             reserved31;
+       u16             tflwfptr;       /* PSC + 0x9e */
 };



