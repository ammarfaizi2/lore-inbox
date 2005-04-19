Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVDSJKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVDSJKB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 05:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVDSJJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 05:09:57 -0400
Received: from moutng.kundenserver.de ([212.227.126.191]:18121 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261191AbVDSJJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 05:09:35 -0400
Date: Tue, 19 Apr 2005 11:07:14 +0200 (CEST)
From: Armin Schindler <armin@melware.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/isdn/: make some code static
In-Reply-To: <20050419004658.GL5489@stusta.de>
Message-ID: <Pine.LNX.4.61.0504191105550.25138@phoenix.one.melware.de>
References: <20050419004658.GL5489@stusta.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Adrian Bunk wrote:
> This patch makes some needlessly global code static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

For the hardware/eicon part:

Signed-off-by: Armin Schindler <armin@melware.de>

 
> ---
> 
>  drivers/isdn/hardware/eicon/dadapter.c |    2 +-
>  drivers/isdn/hisax/hfc4s8s_l1.c        |    4 ++--
>  drivers/isdn/hysdn/hycapi.c            |   20 +++++++++++---------
>  drivers/isdn/hysdn/hysdn_boot.c        |    4 ++--
>  drivers/isdn/hysdn/hysdn_defs.h        |   12 ------------
>  drivers/isdn/hysdn/hysdn_init.c        |    2 +-
>  drivers/isdn/hysdn/hysdn_proclog.c     |    4 +++-
>  7 files changed, 20 insertions(+), 28 deletions(-)
> 
> --- linux-2.6.12-rc2-mm3-full/drivers/isdn/hisax/hfc4s8s_l1.c.old	2005-04-19 00:32:31.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/drivers/isdn/hisax/hfc4s8s_l1.c	2005-04-19 00:32:46.000000000 +0200
> @@ -1464,7 +1464,7 @@
>  /******************************************/
>  /* disable memory mapped ports / io ports */
>  /******************************************/
> -void
> +static void
>  release_pci_ports(hfc4s8s_hw * hw)
>  {
>  	pci_write_config_word(hw->pdev, PCI_COMMAND, 0);
> @@ -1480,7 +1480,7 @@
>  /*****************************************/
>  /* enable memory mapped ports / io ports */
>  /*****************************************/
> -void
> +static void
>  enable_pci_ports(hfc4s8s_hw * hw)
>  {
>  #ifdef CONFIG_HISAX_HFC4S8S_PCIMEM
> --- linux-2.6.12-rc2-mm3-full/drivers/isdn/hysdn/hysdn_defs.h.old	2005-04-19 00:33:51.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/drivers/isdn/hysdn/hysdn_defs.h	2005-04-19 00:38:25.000000000 +0200
> @@ -227,7 +227,6 @@
>  /*****************/
>  /* exported vars */
>  /*****************/
> -extern int cardmax;		/* number of found cards */
>  extern hysdn_card *card_root;	/* pointer to first card */
>  
>  
> @@ -244,7 +243,6 @@
>  /* hysdn_proclog.c */
>  extern int hysdn_proclog_init(hysdn_card *);	/* init proc log entry */
>  extern void hysdn_proclog_release(hysdn_card *);	/* deinit proc log entry */
> -extern void put_log_buffer(hysdn_card *, char *);	/* output log data */
>  extern void hysdn_addlog(hysdn_card *, char *,...);	/* output data to log */
>  extern void hysdn_card_errlog(hysdn_card *, tErrLogEntry *, int);	/* output card log */
>  
> @@ -278,16 +276,6 @@
>  extern int hycapi_capi_create(hysdn_card *);	/* create a new capi device */
>  extern int hycapi_capi_release(hysdn_card *);	/* delete the device */
>  extern int hycapi_capi_stop(hysdn_card *card);   /* suspend */
> -extern int hycapi_load_firmware(struct capi_ctr *, capiloaddata *);
> -extern void hycapi_reset_ctr(struct capi_ctr *);
> -extern void hycapi_remove_ctr(struct capi_ctr *);
> -extern void hycapi_register_appl(struct capi_ctr *, __u16 appl,
> -				 capi_register_params *);
> -extern void hycapi_release_appl(struct capi_ctr *, __u16 appl);
> -extern u16  hycapi_send_message(struct capi_ctr *, struct sk_buff *skb);
> -extern char *hycapi_procinfo(struct capi_ctr *);
> -extern int hycapi_read_proc(char *page, char **start, off_t off,
> -			    int count, int *eof, struct capi_ctr *card);
>  extern void hycapi_rx_capipkt(hysdn_card * card, uchar * buf, word len);
>  extern void hycapi_tx_capiack(hysdn_card * card);
>  extern struct sk_buff *hycapi_tx_capiget(hysdn_card *card);
> --- linux-2.6.12-rc2-mm3-full/drivers/isdn/hysdn/hycapi.c.old	2005-04-19 00:34:05.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/drivers/isdn/hysdn/hycapi.c	2005-04-19 00:36:34.000000000 +0200
> @@ -42,6 +42,8 @@
>  
>  static hycapi_appl hycapi_applications[CAPI_MAXAPPL];
>  
> +static u16 hycapi_send_message(struct capi_ctr *ctrl, struct sk_buff *skb);
> +
>  static inline int _hycapi_appCheck(int app_id, int ctrl_no)
>  {
>  	if((ctrl_no <= 0) || (ctrl_no > CAPI_MAXCONTR) || (app_id <= 0) ||
> @@ -57,7 +59,7 @@
>  Kernel-Capi callback reset_ctr
>  ******************************/     
>  
> -void 
> +static void 
>  hycapi_reset_ctr(struct capi_ctr *ctrl)
>  {
>  	hycapictrl_info *cinfo = ctrl->driverdata;
> @@ -73,7 +75,7 @@
>  Kernel-Capi callback remove_ctr
>  ******************************/     
>  
> -void 
> +static void 
>  hycapi_remove_ctr(struct capi_ctr *ctrl)
>  {
>  	int i;
> @@ -215,7 +217,7 @@
>  The application is recorded in the internal list.
>  *************************************************************/
>  
> -void 
> +static void 
>  hycapi_register_appl(struct capi_ctr *ctrl, __u16 appl, 
>  		     capi_register_params *rp)
>  {
> @@ -291,7 +293,7 @@
>  registration at controller-level
>  ******************************************************************/
>  
> -void 
> +static void 
>  hycapi_release_appl(struct capi_ctr *ctrl, __u16 appl)
>  {
>  	int chk;
> @@ -364,7 +366,7 @@
>  
>  ***************************************************************/
>  
> -u16 hycapi_send_message(struct capi_ctr *ctrl, struct sk_buff *skb)
> +static u16 hycapi_send_message(struct capi_ctr *ctrl, struct sk_buff *skb)
>  {
>  	__u16 appl_id;
>  	int _len, _len2;
> @@ -437,8 +439,8 @@
>  
>  *********************************************************************/
>  
> -int hycapi_read_proc(char *page, char **start, off_t off,
> -		     int count, int *eof, struct capi_ctr *ctrl)
> +static int hycapi_read_proc(char *page, char **start, off_t off,
> +			    int count, int *eof, struct capi_ctr *ctrl)
>  {
>  	hycapictrl_info *cinfo = (hycapictrl_info *)(ctrl->driverdata);
>  	hysdn_card *card = cinfo->card;
> @@ -485,7 +487,7 @@
>  
>  **************************************************************/
>  
> -int hycapi_load_firmware(struct capi_ctr *ctrl, capiloaddata *data)
> +static int hycapi_load_firmware(struct capi_ctr *ctrl, capiloaddata *data)
>  {
>  #ifdef HYCAPI_PRINTFNAMES
>  	printk(KERN_NOTICE "hycapi_load_firmware\n");    
> @@ -494,7 +496,7 @@
>  }
>  
>  
> -char *hycapi_procinfo(struct capi_ctr *ctrl)
> +static char *hycapi_procinfo(struct capi_ctr *ctrl)
>  {
>  	hycapictrl_info *cinfo = (hycapictrl_info *)(ctrl->driverdata);
>  #ifdef HYCAPI_PRINTFNAMES
> --- linux-2.6.12-rc2-mm3-full/drivers/isdn/hysdn/hysdn_boot.c.old	2005-04-19 00:37:22.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/drivers/isdn/hysdn/hysdn_boot.c	2005-04-19 00:37:37.000000000 +0200
> @@ -53,7 +53,7 @@
>  /*  to be called at start of POF file reading,       */
>  /*  before starting any decryption on any POF record. */
>  /*****************************************************/
> -void
> +static void
>  StartDecryption(struct boot_data *boot)
>  {
>  	boot->Cryptor = CRYPT_STARTTERM;
> @@ -66,7 +66,7 @@
>  /*       to HI and LO boot loader and (all) seq tags, because  */
>  /*       global Cryptor is started for whole POF.              */
>  /***************************************************************/
> -void
> +static void
>  DecryptBuf(struct boot_data *boot, int cnt)
>  {
>  	uchar *bufp = boot->buf.BootBuf;
> --- linux-2.6.12-rc2-mm3-full/drivers/isdn/hysdn/hysdn_init.c.old	2005-04-19 00:38:06.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/drivers/isdn/hysdn/hysdn_init.c	2005-04-19 00:38:12.000000000 +0200
> @@ -34,7 +34,7 @@
>  MODULE_LICENSE("GPL");
>  
>  static char *hysdn_init_revision = "$Revision: 1.6.6.6 $";
> -int cardmax;			/* number of found cards */
> +static int cardmax;		/* number of found cards */
>  hysdn_card *card_root = NULL;	/* pointer to first card */
>  
>  /**********************************************/
> --- linux-2.6.12-rc2-mm3-full/drivers/isdn/hysdn/hysdn_proclog.c.old	2005-04-19 00:38:32.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/drivers/isdn/hysdn/hysdn_proclog.c	2005-04-19 00:38:55.000000000 +0200
> @@ -22,6 +22,8 @@
>  /* the proc subdir for the interface is defined in the procconf module */
>  extern struct proc_dir_entry *hysdn_proc_entry;
>  
> +static void put_log_buffer(hysdn_card * card, char *cp);
> +
>  /*************************************************/
>  /* structure keeping ascii log for device output */
>  /*************************************************/
> @@ -93,7 +95,7 @@
>  /* opened for read got the contents.        */
>  /* Flushes buffers not longer in use.       */
>  /********************************************/
> -void
> +static void
>  put_log_buffer(hysdn_card * card, char *cp)
>  {
>  	struct log_data *ib;
> --- linux-2.6.12-rc2-mm3-full/drivers/isdn/hardware/eicon/dadapter.c.old	2005-04-19 00:40:42.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/drivers/isdn/hardware/eicon/dadapter.c	2005-04-19 00:40:52.000000000 +0200
> @@ -44,7 +44,7 @@
>    Array to held adapter information
>     -------------------------------------------------------------------------- */
>  static DESCRIPTOR  HandleTable[NEW_MAX_DESCRIPTORS];
> -dword Adapters = 0; /* Number of adapters */
> +static dword Adapters = 0; /* Number of adapters */
>  /* --------------------------------------------------------------------------
>    Shadow IDI_DIMAINT
>    and 'shadow' debug stuff
> 
