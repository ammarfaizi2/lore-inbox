Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVJCBoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVJCBoK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 21:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVJCBoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 21:44:10 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:27948 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932114AbVJCBoJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 21:44:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XjYwdj+3WxRZVd+VuocL8Y+KhGHbe/VOLYm0F2ylx3SbCniYIdDbl3lAHoYyfB5AG7DNIoi4ighUvoA4IB6OL4lER5uJzORlAtOc7+p3UIaLzGKHBALNbWYpcFfLU5/zQLkF5f4/gw11d8QZyFkAFiLB3+PwSnnjc/mJm6kbk+M=
Message-ID: <2cd57c900510021844kc24938es8904dfe888f561d8@mail.gmail.com>
Date: Mon, 3 Oct 2005 09:44:07 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] proc_mkdir() should be used to create procfs directories
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050928213257.GA7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050928213257.GA7992@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/05, Al Viro <viro@ftp.linux.org.uk> wrote:
>         A bunch of create_proc_dir_entry() calls creating directories
> had crept in since the last sweep; converted to proc_mkdir().

I only see create_proc_entry(), no create_proc_dir_entry().

>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ----
> diff -urN RC14-rc2-git6-s390-signal/drivers/char/drm/drm_drv.c RC14-rc2-git6-proc_mkdir/drivers/char/drm/drm_drv.c
> --- RC14-rc2-git6-s390-signal/drivers/char/drm/drm_drv.c        2005-09-05 07:05:14.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/drivers/char/drm/drm_drv.c 2005-09-28 13:02:24.000000000 -0400
> @@ -376,7 +376,7 @@
>                 goto err_p2;
>         }
>
> -       drm_proc_root = create_proc_entry("dri", S_IFDIR, NULL);
> +       drm_proc_root = proc_mkdir("dri", NULL);
>         if (!drm_proc_root) {
>                 DRM_ERROR("Cannot create /proc/dri\n");
>                 ret = -1;
> diff -urN RC14-rc2-git6-s390-signal/drivers/char/drm/drm_proc.c RC14-rc2-git6-proc_mkdir/drivers/char/drm/drm_proc.c
> --- RC14-rc2-git6-s390-signal/drivers/char/drm/drm_proc.c       2005-09-05 07:05:14.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/drivers/char/drm/drm_proc.c        2005-09-28 13:02:24.000000000 -0400
> @@ -95,7 +95,7 @@
>         char                  name[64];
>
>         sprintf(name, "%d", minor);
> -       *dev_root = create_proc_entry(name, S_IFDIR, root);
> +       *dev_root = proc_mkdir(name, root);
>         if (!*dev_root) {
>                 DRM_ERROR("Cannot create /proc/dri/%s\n", name);
>                 return -1;
> diff -urN RC14-rc2-git6-s390-signal/drivers/isdn/divert/divert_procfs.c RC14-rc2-git6-proc_mkdir/drivers/isdn/divert/divert_procfs.c
> --- RC14-rc2-git6-s390-signal/drivers/isdn/divert/divert_procfs.c       2005-06-17 15:48:29.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/drivers/isdn/divert/divert_procfs.c        2005-09-28 13:02:24.000000000 -0400
> @@ -287,12 +287,12 @@
>         init_waitqueue_head(&rd_queue);
>
>  #ifdef CONFIG_PROC_FS
> -       isdn_proc_entry = create_proc_entry("isdn", S_IFDIR | S_IRUGO | S_IXUGO, proc_net);
> +       isdn_proc_entry = proc_mkdir("net/isdn", NULL);
>         if (!isdn_proc_entry)
>                 return (-1);
>         isdn_divert_entry = create_proc_entry("divert", S_IFREG | S_IRUGO, isdn_proc_entry);
>         if (!isdn_divert_entry) {
> -               remove_proc_entry("isdn", proc_net);
> +               remove_proc_entry("net/isdn", NULL);
>                 return (-1);
>         }
>         isdn_divert_entry->proc_fops = &isdn_fops;
> @@ -312,7 +312,7 @@
>
>  #ifdef CONFIG_PROC_FS
>         remove_proc_entry("divert", isdn_proc_entry);
> -       remove_proc_entry("isdn", proc_net);
> +       remove_proc_entry("net/isdn", NULL);
>  #endif /* CONFIG_PROC_FS */
>
>         return (0);
> diff -urN RC14-rc2-git6-s390-signal/drivers/isdn/hardware/eicon/diva_didd.c RC14-rc2-git6-proc_mkdir/drivers/isdn/hardware/eicon/diva_didd.c
> --- RC14-rc2-git6-s390-signal/drivers/isdn/hardware/eicon/diva_didd.c   2005-06-17 15:48:29.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/drivers/isdn/hardware/eicon/diva_didd.c    2005-09-28 13:02:24.000000000 -0400
> @@ -30,8 +30,6 @@
>  static char *DRIVERLNAME = "divadidd";
>  char *DRIVERRELEASE_DIDD = "2.0";
>
> -static char *main_proc_dir = "eicon";
> -
>  MODULE_DESCRIPTION("DIDD table driver for diva drivers");
>  MODULE_AUTHOR("Cytronics & Melware, Eicon Networks");
>  MODULE_SUPPORTED_DEVICE("Eicon diva drivers");
> @@ -89,7 +87,7 @@
>
>  static int DIVA_INIT_FUNCTION create_proc(void)
>  {
> -       proc_net_eicon = create_proc_entry(main_proc_dir, S_IFDIR, proc_net);
> +       proc_net_eicon = proc_mkdir("net/eicon", NULL);
>
>         if (proc_net_eicon) {
>                 if ((proc_didd =
> @@ -105,7 +103,7 @@
>  static void DIVA_EXIT_FUNCTION remove_proc(void)
>  {
>         remove_proc_entry(DRIVERLNAME, proc_net_eicon);
> -       remove_proc_entry(main_proc_dir, proc_net);
> +       remove_proc_entry("net/eicon", NULL);
>  }
>
>  static int DIVA_INIT_FUNCTION divadidd_init(void)
> diff -urN RC14-rc2-git6-s390-signal/drivers/isdn/hardware/eicon/divasproc.c RC14-rc2-git6-proc_mkdir/drivers/isdn/hardware/eicon/divasproc.c
> --- RC14-rc2-git6-s390-signal/drivers/isdn/hardware/eicon/divasproc.c   2005-06-17 15:48:29.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/drivers/isdn/hardware/eicon/divasproc.c    2005-09-28 13:02:24.000000000 -0400
> @@ -381,7 +381,7 @@
>         char tmp[16];
>
>         sprintf(tmp, "%s%d", adapter_dir_name, a->controller);
> -       if (!(de = create_proc_entry(tmp, S_IFDIR, proc_net_eicon)))
> +       if (!(de = proc_mkdir(tmp, proc_net_eicon)))
>                 return (0);
>         a->proc_adapter_dir = (void *) de;
>
> diff -urN RC14-rc2-git6-s390-signal/drivers/isdn/hysdn/hysdn_procconf.c RC14-rc2-git6-proc_mkdir/drivers/isdn/hysdn/hysdn_procconf.c
> --- RC14-rc2-git6-s390-signal/drivers/isdn/hysdn/hysdn_procconf.c       2005-06-17 15:48:29.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/drivers/isdn/hysdn/hysdn_procconf.c        2005-09-28 13:02:24.000000000 -0400
> @@ -394,7 +394,7 @@
>         hysdn_card *card;
>         uchar conf_name[20];
>
> -       hysdn_proc_entry = create_proc_entry(PROC_SUBDIR_NAME, S_IFDIR | S_IRUGO | S_IXUGO, proc_net);
> +       hysdn_proc_entry = proc_mkdir(PROC_SUBDIR_NAME, proc_net);
>         if (!hysdn_proc_entry) {
>                 printk(KERN_ERR "HYSDN: unable to create hysdn subdir\n");
>                 return (-1);
> diff -urN RC14-rc2-git6-s390-signal/drivers/media/video/cpia.c RC14-rc2-git6-proc_mkdir/drivers/media/video/cpia.c
> --- RC14-rc2-git6-s390-signal/drivers/media/video/cpia.c        2005-06-17 15:48:29.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/drivers/media/video/cpia.c 2005-09-28 13:02:24.000000000 -0400
> @@ -1397,7 +1397,7 @@
>
>  static void proc_cpia_create(void)
>  {
> -       cpia_proc_root = create_proc_entry("cpia", S_IFDIR, NULL);
> +       cpia_proc_root = proc_mkdir("cpia", NULL);
>
>         if (cpia_proc_root)
>                 cpia_proc_root->owner = THIS_MODULE;
> diff -urN RC14-rc2-git6-s390-signal/drivers/net/ibmveth.c RC14-rc2-git6-proc_mkdir/drivers/net/ibmveth.c
> --- RC14-rc2-git6-s390-signal/drivers/net/ibmveth.c     2005-09-05 07:05:15.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/drivers/net/ibmveth.c      2005-09-28 13:02:24.000000000 -0400
> @@ -99,7 +99,7 @@
>  static inline void ibmveth_schedule_replenishing(struct ibmveth_adapter*);
>
>  #ifdef CONFIG_PROC_FS
> -#define IBMVETH_PROC_DIR "ibmveth"
> +#define IBMVETH_PROC_DIR "net/ibmveth"
>  static struct proc_dir_entry *ibmveth_proc_dir;
>  #endif
>
> @@ -1010,7 +1010,7 @@
>  #ifdef CONFIG_PROC_FS
>  static void ibmveth_proc_register_driver(void)
>  {
> -       ibmveth_proc_dir = create_proc_entry(IBMVETH_PROC_DIR, S_IFDIR, proc_net);
> +       ibmveth_proc_dir = proc_mkdir(IBMVETH_PROC_DIR, NULL);
>         if (ibmveth_proc_dir) {
>                 SET_MODULE_OWNER(ibmveth_proc_dir);
>         }
> @@ -1018,7 +1018,7 @@
>
>  static void ibmveth_proc_unregister_driver(void)
>  {
> -       remove_proc_entry(IBMVETH_PROC_DIR, proc_net);
> +       remove_proc_entry(IBMVETH_PROC_DIR, NULL);
>  }
>
>  static void *ibmveth_seq_start(struct seq_file *seq, loff_t *pos)
> diff -urN RC14-rc2-git6-s390-signal/drivers/net/irda/vlsi_ir.c RC14-rc2-git6-proc_mkdir/drivers/net/irda/vlsi_ir.c
> --- RC14-rc2-git6-s390-signal/drivers/net/irda/vlsi_ir.c        2005-09-05 07:05:15.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/drivers/net/irda/vlsi_ir.c 2005-09-28 13:02:24.000000000 -0400
> @@ -1875,11 +1875,11 @@
>
>         sirpulse = !!sirpulse;
>
> -       /* create_proc_entry returns NULL if !CONFIG_PROC_FS.
> +       /* proc_mkdir returns NULL if !CONFIG_PROC_FS.
>          * Failure to create the procfs entry is handled like running
>          * without procfs - it's not required for the driver to work.
>          */
> -       vlsi_proc_root = create_proc_entry(PROC_DIR, S_IFDIR, NULL);
> +       vlsi_proc_root = proc_mkdir(PROC_DIR, NULL);
>         if (vlsi_proc_root) {
>                 /* protect registered procdir against module removal.
>                  * Because we are in the module init path there's no race
> diff -urN RC14-rc2-git6-s390-signal/drivers/net/pppoe.c RC14-rc2-git6-proc_mkdir/drivers/net/pppoe.c
> --- RC14-rc2-git6-s390-signal/drivers/net/pppoe.c       2005-09-05 07:05:15.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/drivers/net/pppoe.c        2005-09-28 13:02:24.000000000 -0400
> @@ -1070,7 +1070,7 @@
>  {
>         struct proc_dir_entry *p;
>
> -       p = create_proc_entry("pppoe", S_IRUGO, proc_net);
> +       p = create_proc_entry("net/pppoe", S_IRUGO, NULL);
>         if (!p)
>                 return -ENOMEM;
>
> @@ -1142,7 +1142,7 @@
>         dev_remove_pack(&pppoes_ptype);
>         dev_remove_pack(&pppoed_ptype);
>         unregister_netdevice_notifier(&pppoe_notifier);
> -       remove_proc_entry("pppoe", proc_net);
> +       remove_proc_entry("net/pppoe", NULL);
>         proto_unregister(&pppoe_sk_proto);
>  }
>
> diff -urN RC14-rc2-git6-s390-signal/drivers/net/sk98lin/skge.c RC14-rc2-git6-proc_mkdir/drivers/net/sk98lin/skge.c
> --- RC14-rc2-git6-s390-signal/drivers/net/sk98lin/skge.c        2005-09-22 01:17:30.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/drivers/net/sk98lin/skge.c 2005-09-28 13:02:24.000000000 -0400
> @@ -235,7 +235,7 @@
>   * Extern Function Prototypes
>   *
>   ******************************************************************************/
> -static const char      SKRootName[] = "sk98lin";
> +static const char      SKRootName[] = "net/sk98lin";
>  static struct          proc_dir_entry *pSkRootDir;
>  extern struct  file_operations sk_proc_fops;
>
> @@ -5242,20 +5242,20 @@
>  {
>         int error;
>
> -       pSkRootDir = proc_mkdir(SKRootName, proc_net);
> +       pSkRootDir = proc_mkdir(SKRootName, NULL);
>         if (pSkRootDir)
>                 pSkRootDir->owner = THIS_MODULE;
>
>         error = pci_register_driver(&skge_driver);
>         if (error)
> -               proc_net_remove(SKRootName);
> +               remove_proc_entry(SKRootName, NULL);
>         return error;
>  }
>
>  static void __exit skge_exit(void)
>  {
>         pci_unregister_driver(&skge_driver);
> -       proc_net_remove(SKRootName);
> +       remove_proc_entry(SKRootName, NULL);
>
>  }
>
> diff -urN RC14-rc2-git6-s390-signal/drivers/scsi/sg.c RC14-rc2-git6-proc_mkdir/drivers/scsi/sg.c
> --- RC14-rc2-git6-s390-signal/drivers/scsi/sg.c 2005-09-22 01:17:30.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/drivers/scsi/sg.c  2005-09-28 13:02:24.000000000 -0400
> @@ -2849,8 +2849,7 @@
>         struct proc_dir_entry *pdep;
>         struct sg_proc_leaf * leaf;
>
> -       sg_proc_sgp = create_proc_entry(sg_proc_sg_dirname,
> -                                       S_IFDIR | S_IRUGO | S_IXUGO, NULL);
> +       sg_proc_sgp = proc_mkdir(sg_proc_sg_dirname, NULL);
>         if (!sg_proc_sgp)
>                 return 1;
>         for (k = 0; k < num_leaves; ++k) {
> diff -urN RC14-rc2-git6-s390-signal/drivers/usb/media/vicam.c RC14-rc2-git6-proc_mkdir/drivers/usb/media/vicam.c
> --- RC14-rc2-git6-s390-signal/drivers/usb/media/vicam.c 2005-06-17 15:48:29.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/drivers/usb/media/vicam.c  2005-09-28 13:02:24.000000000 -0400
> @@ -1148,7 +1148,7 @@
>  static void
>  vicam_create_proc_root(void)
>  {
> -       vicam_proc_root = create_proc_entry("video/vicam", S_IFDIR, 0);
> +       vicam_proc_root = proc_mkdir("video/vicam", NULL);
>
>         if (vicam_proc_root)
>                 vicam_proc_root->owner = THIS_MODULE;
> @@ -1181,7 +1181,7 @@
>
>         sprintf(name, "video%d", cam->vdev.minor);
>
> -       cam->proc_dir = create_proc_entry(name, S_IFDIR, vicam_proc_root);
> +       cam->proc_dir = proc_mkdir(name, vicam_proc_root);
>
>         if ( !cam->proc_dir )
>                 return; // FIXME: We should probably return an error here
> diff -urN RC14-rc2-git6-s390-signal/net/core/pktgen.c RC14-rc2-git6-proc_mkdir/net/core/pktgen.c
> --- RC14-rc2-git6-s390-signal/net/core/pktgen.c 2005-09-13 13:29:28.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/net/core/pktgen.c  2005-09-28 13:02:24.000000000 -0400
> @@ -186,7 +186,7 @@
>
>  /* Used to help with determining the pkts on receive */
>  #define PKTGEN_MAGIC 0xbe9be955
> -#define PG_PROC_DIR "pktgen"
> +#define PG_PROC_DIR "net/pktgen"
>
>  #define MAX_CFLOWS  65536
>
> @@ -1476,18 +1476,7 @@
>
>  static int create_proc_dir(void)
>  {
> -        int     len;
> -        /*  does proc_dir already exists */
> -        len = strlen(PG_PROC_DIR);
> -
> -        for (pg_proc_dir = proc_net->subdir; pg_proc_dir; pg_proc_dir=pg_proc_dir->next) {
> -                if ((pg_proc_dir->namelen == len) &&
> -                   (! memcmp(pg_proc_dir->name, PG_PROC_DIR, len)))
> -                        break;
> -        }
> -
> -        if (!pg_proc_dir)
> -                pg_proc_dir = create_proc_entry(PG_PROC_DIR, S_IFDIR, proc_net);
> +       pg_proc_dir = proc_mkdir(PG_PROC_DIR, NULL);
>
>          if (!pg_proc_dir)
>                  return -ENODEV;
> @@ -1497,7 +1486,7 @@
>
>  static int remove_proc_dir(void)
>  {
> -        remove_proc_entry(PG_PROC_DIR, proc_net);
> +        remove_proc_entry(PG_PROC_DIR, NULL);
>          return 0;
>  }
>
> @@ -2908,7 +2897,7 @@
>                  pkt_dev->udp_dst_max = 9;
>
>                  strncpy(pkt_dev->ifname, ifname, 31);
> -                sprintf(pkt_dev->fname, "net/%s/%s", PG_PROC_DIR, ifname);
> +                sprintf(pkt_dev->fname, "%s/%s", PG_PROC_DIR, ifname);
>
>                  if (! pktgen_setup_dev(pkt_dev)) {
>                          printk("pktgen: ERROR: pktgen_setup_dev failed.\n");
> @@ -2981,7 +2970,7 @@
>          spin_lock_init(&t->if_lock);
>         t->cpu = cpu;
>
> -        sprintf(t->fname, "net/%s/%s", PG_PROC_DIR, t->name);
> +        sprintf(t->fname, "%s/%s", PG_PROC_DIR, t->name);
>          t->proc_ent = create_proc_entry(t->fname, 0600, NULL);
>          if (!t->proc_ent) {
>                  printk("pktgen: cannot create %s procfs entry.\n", t->fname);
> @@ -3064,7 +3053,7 @@
>
>         create_proc_dir();
>
> -        sprintf(module_fname, "net/%s/pgctrl", PG_PROC_DIR);
> +        sprintf(module_fname, "%s/pgctrl", PG_PROC_DIR);
>          module_proc_ent = create_proc_entry(module_fname, 0600, NULL);
>          if (!module_proc_ent) {
>                  printk("pktgen: ERROR: cannot create %s procfs entry.\n", module_fname);
> diff -urN RC14-rc2-git6-s390-signal/net/ieee80211/ieee80211_module.c RC14-rc2-git6-proc_mkdir/net/ieee80211/ieee80211_module.c
> --- RC14-rc2-git6-s390-signal/net/ieee80211/ieee80211_module.c  2005-09-08 10:07:30.000000000 -0400
> +++ RC14-rc2-git6-proc_mkdir/net/ieee80211/ieee80211_module.c   2005-09-28 13:02:24.000000000 -0400
> @@ -230,7 +230,7 @@
>         struct proc_dir_entry *e;
>
>         ieee80211_debug_level = debug;
> -       ieee80211_proc = create_proc_entry(DRV_NAME, S_IFDIR, proc_net);
> +       ieee80211_proc = proc_mkdir(DRV_NAME, proc_net);
>         if (ieee80211_proc == NULL) {
>                 IEEE80211_ERROR("Unable to create " DRV_NAME
>                                 " proc directory\n");
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
