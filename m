Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbUKOOHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbUKOOHH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbUKOOHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:07:00 -0500
Received: from emulex.emulex.com ([138.239.112.1]:6816 "EHLO emulex.emulex.com")
	by vger.kernel.org with ESMTP id S261598AbUKOOE5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:04:57 -0500
From: James.Smart@Emulex.Com
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [2.6 patch] SCSI: misc possible cleanups
Date: Mon, 15 Nov 2004 08:57:08 -0500
Message-ID: <0B1E13B586976742A7599D71A6AC733C12E6F2@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] SCSI: misc possible cleanups
Thread-Index: AcTKuf4RYniC31V/THqAeWOfs9esbQAYOXrA
To: <bunk@stusta.de>, <James.Bottomley@SteelEye.com>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't back out the additions to scsi_transport.c!!!

These were hard-fought additions, and required by our driver, which we should call for upstream approval in the near future.

-- James S


> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org
> [mailto:linux-scsi-owner@vger.kernel.org]On Behalf Of Adrian Bunk
> Sent: Sunday, November 14, 2004 9:05 PM
> To: James.Bottomley@SteelEye.com
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [2.6 patch] SCSI: misc possible cleanups
> 
> 
> This patch below does:
> - remove unused code
> - make global code without external users static
> 
> It is meant for review and not for being applied immediately.
> It should simply demonstrate with users are possible with the current 
> in-kernel users today.
> 
> 
> diffstat output:
>  drivers/scsi/constants.c          |   58 --------
>  drivers/scsi/hosts.c              |   44 +++---
>  drivers/scsi/scsi.c               |    2 
>  drivers/scsi/scsi.h               |    8 -
>  drivers/scsi/scsi_debug.c         |    2 
>  drivers/scsi/scsi_error.c         |    5 
>  drivers/scsi/scsi_lib.c           |    5 
>  drivers/scsi/scsi_syms.c          |    1 
>  drivers/scsi/scsi_transport_fc.c  |  202 
> ------------------------------
>  drivers/scsi/scsi_transport_spi.c |    4 
>  include/scsi/scsi_dbg.h           |    2 
>  include/scsi/scsi_device.h        |    1 
>  include/scsi/scsi_eh.h            |    2 
>  include/scsi/scsi_host.h          |    1 
>  include/scsi/scsi_transport_fc.h  |    4 
>  15 files changed, 32 insertions(+), 309 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.10-rc1-mm5-full/include/scsi/scsi_dbg.h.old	
> 2004-11-13 17:20:08.000000000 +0100
> +++ linux-2.6.10-rc1-mm5-full/include/scsi/scsi_dbg.h	
> 2004-11-13 17:20:23.000000000 +0100
> @@ -8,8 +8,6 @@
>  extern void __scsi_print_command(unsigned char *);
>  extern void scsi_print_sense(const char *, struct scsi_cmnd *);
>  extern void scsi_print_req_sense(const char *, struct 
> scsi_request *);
> -extern void scsi_print_driverbyte(int);
> -extern void scsi_print_hostbyte(int);
>  extern void scsi_print_status(unsigned char);
>  extern int scsi_print_msg(const unsigned char *);
>  extern const char *scsi_sense_key_string(unsigned char);
> --- linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi.h.old	
> 2004-11-13 17:20:35.000000000 +0100
> +++ linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi.h	
> 2004-11-13 17:20:51.000000000 +0100
> @@ -80,14 +80,6 @@
>  {
>  	return scsi_print_req_sense(devclass, req);
>  }
> -static inline void print_driverbyte(int scsiresult)
> -{
> -	return scsi_print_driverbyte(scsiresult);
> -}
> -static inline void print_hostbyte(int scsiresult)
> -{
> -	return scsi_print_hostbyte(scsiresult);
> -}
>  static inline void print_status(unsigned char status)
>  {
>  	return scsi_print_status(status);
> --- linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi_syms.c.old	
> 2004-11-13 21:47:26.000000000 +0100
> +++ linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi_syms.c	
> 2004-11-13 21:47:32.000000000 +0100
> @@ -28,7 +28,6 @@
>  EXPORT_SYMBOL(scsi_add_host);
>  EXPORT_SYMBOL(scsi_scan_host);
>  EXPORT_SYMBOL(scsi_remove_host);
> -EXPORT_SYMBOL(scsi_host_get);
>  EXPORT_SYMBOL(scsi_host_put);
>  EXPORT_SYMBOL(scsi_host_lookup);
>  EXPORT_SYMBOL(scsi_register);
> --- linux-2.6.10-rc1-mm5-full/drivers/scsi/constants.c.old	
> 2004-11-13 17:21:03.000000000 +0100
> +++ linux-2.6.10-rc1-mm5-full/drivers/scsi/constants.c	
> 2004-11-13 17:21:46.000000000 +0100
> @@ -1136,61 +1136,3 @@
>      __scsi_print_command(cmd->cmnd);
>  }
>  
> -#if (CONSTANTS & CONST_HOST)
> -static const char * hostbyte_table[]={
> -"DID_OK", "DID_NO_CONNECT", "DID_BUS_BUSY", "DID_TIME_OUT", 
> "DID_BAD_TARGET", 
> -"DID_ABORT", "DID_PARITY", "DID_ERROR", "DID_RESET", "DID_BAD_INTR",
> -"DID_PASSTHROUGH", "DID_SOFT_ERROR", "DID_IMM_RETRY", NULL};
> -
> -void scsi_print_hostbyte(int scsiresult)
> -{   static int maxcode=0;
> -    int i;
> -   
> -    if(!maxcode) {
> -	for(i=0;hostbyte_table[i];i++) ;
> -	maxcode=i-1;
> -    }
> -    printk("Hostbyte=0x%02x",host_byte(scsiresult));
> -    if(host_byte(scsiresult)>maxcode) {
> -	printk("is invalid "); 
> -	return;
> -    }
> -    printk("(%s) ",hostbyte_table[host_byte(scsiresult)]);
> -}
> -#else
> -void scsi_print_hostbyte(int scsiresult)
> -{   printk("Hostbyte=0x%02x ",host_byte(scsiresult));
> -}
> -#endif
> -
> -#if (CONSTANTS & CONST_DRIVER)
> -static const char * driverbyte_table[]={
> -"DRIVER_OK", "DRIVER_BUSY", "DRIVER_SOFT",  "DRIVER_MEDIA", 
> "DRIVER_ERROR", 
> -"DRIVER_INVALID", "DRIVER_TIMEOUT", "DRIVER_HARD",NULL };
> -
> -static const char * driversuggest_table[]={"SUGGEST_OK",
> -"SUGGEST_RETRY", "SUGGEST_ABORT", "SUGGEST_REMAP", "SUGGEST_DIE",
> -unknown,unknown,unknown, "SUGGEST_SENSE",NULL};
> -
> -
> -void scsi_print_driverbyte(int scsiresult)
> -{   static int driver_max=0,suggest_max=0;
> -    int i,dr=driver_byte(scsiresult)&DRIVER_MASK, 
> -	su=(driver_byte(scsiresult)&SUGGEST_MASK)>>4;
> -
> -    if(!driver_max) {
> -        for(i=0;driverbyte_table[i];i++) ;
> -        driver_max=i;
> -	for(i=0;driversuggest_table[i];i++) ;
> -	suggest_max=i;
> -    }
> -    printk("Driverbyte=0x%02x",driver_byte(scsiresult));
> -    printk("(%s,%s) ",
> -	dr<driver_max  ? driverbyte_table[dr]:"invalid",
> -	su<suggest_max ? driversuggest_table[su]:"invalid");
> -}
> -#else
> -void scsi_print_driverbyte(int scsiresult)
> -{   printk("Driverbyte=0x%02x ",driver_byte(scsiresult));
> -}
> -#endif
> --- linux-2.6.10-rc1-mm5-full/include/scsi/scsi_host.h.old	
> 2004-11-13 21:47:47.000000000 +0100
> +++ linux-2.6.10-rc1-mm5-full/include/scsi/scsi_host.h	
> 2004-11-13 21:47:38.000000000 +0100
> @@ -528,7 +528,6 @@
>  extern int __must_check scsi_add_host(struct Scsi_Host *, 
> struct device *);
>  extern void scsi_scan_host(struct Scsi_Host *);
>  extern void scsi_remove_host(struct Scsi_Host *);
> -extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);
>  extern void scsi_host_put(struct Scsi_Host *t);
>  extern struct Scsi_Host *scsi_host_lookup(unsigned short);
>  
> --- linux-2.6.10-rc1-mm5-full/drivers/scsi/hosts.c.old	
> 2004-11-13 21:47:54.000000000 +0100
> +++ linux-2.6.10-rc1-mm5-full/drivers/scsi/hosts.c	
> 2004-11-13 21:49:48.000000000 +0100
> @@ -60,7 +60,7 @@
>   * @shost:	pointer to struct Scsi_Host
>   * recovery:	recovery requested to run.
>   **/
> -void scsi_host_cancel(struct Scsi_Host *shost, int recovery)
> +static void scsi_host_cancel(struct Scsi_Host *shost, int recovery)
>  {
>  	set_bit(SHOST_CANCEL, &shost->shost_state);
>  	device_for_each_child(&shost->shost_gendev, &recovery,
> @@ -326,6 +326,27 @@
>  }
>  
>  /**
> + * scsi_host_get - inc a Scsi_Host ref count
> + * @shost:	Pointer to Scsi_Host to inc.
> + **/
> +static struct Scsi_Host *scsi_host_get(struct Scsi_Host *shost)
> +{
> +	if (test_bit(SHOST_DEL, &shost->shost_state) ||
> +		!get_device(&shost->shost_gendev))
> +		return NULL;
> +	return shost;
> +}
> +
> +/**
> + * scsi_host_put - dec a Scsi_Host ref count
> + * @shost:	Pointer to Scsi_Host to dec.
> + **/
> +void scsi_host_put(struct Scsi_Host *shost)
> +{
> +	put_device(&shost->shost_gendev);
> +}
> +
> +/**
>   * scsi_host_lookup - get a reference to a Scsi_Host by host no
>   *
>   * @hostnum:	host number to locate
> @@ -352,27 +373,6 @@
>  	return shost;
>  }
>  
> -/**
> - * scsi_host_get - inc a Scsi_Host ref count
> - * @shost:	Pointer to Scsi_Host to inc.
> - **/
> -struct Scsi_Host *scsi_host_get(struct Scsi_Host *shost)
> -{
> -	if (test_bit(SHOST_DEL, &shost->shost_state) ||
> -		!get_device(&shost->shost_gendev))
> -		return NULL;
> -	return shost;
> -}
> -
> -/**
> - * scsi_host_put - dec a Scsi_Host ref count
> - * @shost:	Pointer to Scsi_Host to dec.
> - **/
> -void scsi_host_put(struct Scsi_Host *shost)
> -{
> -	put_device(&shost->shost_gendev);
> -}
> -
>  int scsi_init_hosts(void)
>  {
>  	return class_register(&shost_class);
> --- linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi.c.old	
> 2004-11-13 23:17:39.000000000 +0100
> +++ linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi.c	
> 2004-11-13 23:17:53.000000000 +0100
> @@ -90,7 +90,7 @@
>  /*
>   * Data declarations.
>   */
> -unsigned long scsi_pid;
> +static unsigned long scsi_pid;
>  static unsigned long serial_number;
>  
>  /*
> --- linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi_debug.c.old	
> 2004-11-13 23:18:30.000000000 +0100
> +++ linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi_debug.c	
> 2004-11-13 23:18:38.000000000 +0100
> @@ -1781,7 +1781,7 @@
>  device_initcall(scsi_debug_init);
>  module_exit(scsi_debug_exit);
>  
> -void pseudo_0_release(struct device * dev)
> +static void pseudo_0_release(struct device * dev)
>  {
>  	if (SCSI_DEBUG_OPT_NOISE & scsi_debug_opts)
>  		printk(KERN_INFO "scsi_debug: 
> pseudo_0_release() called\n");
> --- linux-2.6.10-rc1-mm5-full/include/scsi/scsi_eh.h.old	
> 2004-11-13 23:19:12.000000000 +0100
> +++ linux-2.6.10-rc1-mm5-full/include/scsi/scsi_eh.h	
> 2004-11-13 23:19:22.000000000 +0100
> @@ -33,8 +33,6 @@
>  extern void scsi_report_bus_reset(struct Scsi_Host *, int);
>  extern void scsi_report_device_reset(struct Scsi_Host *, int, int);
>  extern int scsi_block_when_processing_errors(struct scsi_device *);
> -extern int scsi_normalize_sense(const u8 *sense_buffer, int sb_len,
> -		struct scsi_sense_hdr *sshdr);
>  extern int scsi_request_normalize_sense(struct scsi_request *sreq,
>  		struct scsi_sense_hdr *sshdr);
>  extern int scsi_command_normalize_sense(struct scsi_cmnd *cmd,
> --- linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi_error.c.old	
> 2004-11-13 23:19:30.000000000 +0100
> +++ linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi_error.c	
> 2004-11-13 23:20:02.000000000 +0100
> @@ -1863,8 +1863,8 @@
>   * Return value:
>   *	1 if valid sense data information found, else 0;
>   **/
> -int scsi_normalize_sense(const u8 *sense_buffer, int sb_len,
> -                         struct scsi_sense_hdr *sshdr)
> +static int scsi_normalize_sense(const u8 *sense_buffer, int sb_len,
> +				struct scsi_sense_hdr *sshdr)
>  {
>  	if (!sense_buffer || !sb_len || (sense_buffer[0] & 
> 0x70) != 0x70)
>  		return 0;
> @@ -1902,7 +1902,6 @@
>  
>  	return 1;
>  }
> -EXPORT_SYMBOL(scsi_normalize_sense);
>  
>  int scsi_request_normalize_sense(struct scsi_request *sreq,
>  				 struct scsi_sense_hdr *sshdr)
> --- linux-2.6.10-rc1-mm5-full/include/scsi/scsi_device.h.old	
> 2004-11-13 23:20:22.000000000 +0100
> +++ linux-2.6.10-rc1-mm5-full/include/scsi/scsi_device.h	
> 2004-11-13 23:20:28.000000000 +0100
> @@ -219,7 +219,6 @@
>  extern int scsi_device_set_state(struct scsi_device *sdev,
>  				 enum scsi_device_state state);
>  extern int scsi_device_quiesce(struct scsi_device *sdev);
> -extern void scsi_device_resume(struct scsi_device *sdev);
>  extern void scsi_target_quiesce(struct scsi_target *);
>  extern void scsi_target_resume(struct scsi_target *);
>  extern const char *scsi_device_state_name(enum scsi_device_state);
> --- linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi_lib.c.old	
> 2004-11-13 23:20:35.000000000 +0100
> +++ linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi_lib.c	
> 2004-11-13 23:21:02.000000000 +0100
> @@ -43,7 +43,7 @@
>  #endif
>  
>  #define SP(x) { x, "sgpool-" #x } 
> -struct scsi_host_sg_pool scsi_sg_pools[] = { 
> +static struct scsi_host_sg_pool scsi_sg_pools[] = { 
>  	SP(8),
>  	SP(16),
>  	SP(32),
> @@ -1755,14 +1755,13 @@
>   *
>   *	Must be called with user context, may sleep.
>   **/
> -void
> +static void
>  scsi_device_resume(struct scsi_device *sdev)
>  {
>  	if(scsi_device_set_state(sdev, SDEV_RUNNING))
>  		return;
>  	scsi_run_queue(sdev->request_queue);
>  }
> -EXPORT_SYMBOL(scsi_device_resume);
>  
>  static int
>  device_quiesce_fn(struct device *dev, void *data)
> --- 
> linux-2.6.10-rc1-mm5-full/include/scsi/scsi_transport_f
> c.h.old	2004-11-13 23:21:51.000000000 +0100
> +++ 
> linux-2.6.10-rc1-mm5-full/include/scsi/scsi_transport_fc.h	
> 2004-11-13 23:35:14.000000000 +0100
> @@ -83,9 +83,5 @@
>  
>  struct scsi_transport_template *fc_attach_transport(struct 
> fc_function_template *);
>  void fc_release_transport(struct scsi_transport_template *);
> -int fc_target_block(struct scsi_target *starget);
> -void fc_target_unblock(struct scsi_target *starget);
> -int fc_host_block(struct Scsi_Host *shost);
> -void fc_host_unblock(struct Scsi_Host *shost);
>  
>  #endif /* SCSI_TRANSPORT_FC_H */
> --- 
> linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi_transport_f
> c.c.old	2004-11-13 23:22:23.000000000 +0100
> +++ 
> linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi_transport_fc.c	
> 2004-11-13 23:40:02.000000000 +0100
> @@ -52,12 +52,12 @@
>  
>  #define to_fc_internal(tmpl)	container_of(tmpl, struct 
> fc_internal, t)
>  
> -struct class fc_transport_class = {
> +static struct class fc_transport_class = {
>  	.name = "fc_transport",
>  	.release = transport_class_release,
>  };
>  
> -struct class fc_host_class = {
> +static struct class fc_host_class = {
>  	.name = "fc_host",
>  	.release = host_class_release,
>  };
> @@ -325,204 +325,6 @@
>  EXPORT_SYMBOL(fc_release_transport);
>  
>  
> -
> -/**
> - * fc_device_block - called by target functions to block a 
> scsi device
> - * @dev:	scsi device
> - * @data:	unused
> - **/
> -static int fc_device_block(struct device *dev, void *data)
> -{
> -	scsi_internal_device_block(to_scsi_device(dev));
> -	return 0;
> -}
> -
> -/**
> - * fc_device_unblock - called by target functions to unblock 
> a scsi device
> - * @dev:	scsi device
> - * @data:	unused
> - **/
> -static int fc_device_unblock(struct device *dev, void *data)
> -{
> -	scsi_internal_device_unblock(to_scsi_device(dev));
> -	return 0;
> -}
> -
> -/**
> - * fc_timeout_blocked_tgt - Timeout handler for blocked scsi targets
> - *			 that fail to recover in the alloted time.
> - * @data:	scsi target that failed to reappear in the alloted time.
> - **/
> -static void fc_timeout_blocked_tgt(unsigned long data)
> -{
> -	struct scsi_target *starget = (struct scsi_target *)data;
> -
> -	dev_printk(KERN_ERR, &starget->dev, 
> -		"blocked target time out: target resuming\n");
> -
> -	/* 
> -	 * set the device going again ... if the scsi lld didn't
> -	 * unblock this device, then IO errors will probably
> -	 * result if the host still isn't ready.
> -	 */
> -	device_for_each_child(&starget->dev, NULL, fc_device_unblock);
> -}
> -
> -/**
> - * fc_target_block - block a target by temporarily putting 
> all its scsi devices
> - *		into the SDEV_BLOCK state.
> - * @starget:	scsi target managed by this fc scsi lldd.
> - *
> - * scsi lldd's with a FC transport call this routine to 
> temporarily stop all
> - * scsi commands to all devices managed by this scsi target.  Called 
> - * from interrupt or normal process context.
> - *
> - * Returns zero if successful or error if not
> - *
> - * Notes:       
> - *	The timeout and timer types are extracted from the fc transport 
> - *	attributes from the caller's target pointer.  This 
> routine assumes no
> - *	locks are held on entry.
> - **/
> -int
> -fc_target_block(struct scsi_target *starget)
> -{
> -	int timeout = fc_starget_dev_loss_tmo(starget);
> -	struct timer_list *timer = &fc_starget_dev_loss_timer(starget);
> -
> -	if (timeout < 0 || timeout > SCSI_DEVICE_BLOCK_MAX_TIMEOUT)
> -		return -EINVAL;
> -
> -	device_for_each_child(&starget->dev, NULL, fc_device_block);
> -
> -	/* The scsi lld blocks this target for the timeout 
> period only. */
> -	timer->data = (unsigned long)starget;
> -	timer->expires = jiffies + timeout * HZ;
> -	timer->function = fc_timeout_blocked_tgt;
> -	add_timer(timer);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(fc_target_block);
> -
> -/**
> - * fc_target_unblock - unblock a target following a 
> fc_target_block request.
> - * @starget:	scsi target managed by this fc scsi lldd.	
> - *
> - * scsi lld's with a FC transport call this routine to 
> restart IO to all 
> - * devices associated with the caller's scsi target 
> following a fc_target_block
> - * request.  Called from interrupt or normal process context.
> - *
> - * Notes:       
> - *	This routine assumes no locks are held on entry.
> - **/
> -void
> -fc_target_unblock(struct scsi_target *starget)
> -{
> -	/* 
> -	 * Stop the target timer first. Take no action on the del_timer
> -	 * failure as the state machine state change will validate the
> -	 * transaction. 
> -	 */
> -	del_timer_sync(&fc_starget_dev_loss_timer(starget));
> -
> -	device_for_each_child(&starget->dev, NULL, fc_device_unblock);
> -}
> -EXPORT_SYMBOL(fc_target_unblock);
> -
> -/**
> - * fc_timeout_blocked_host - Timeout handler for blocked scsi hosts
> - *			 that fail to recover in the alloted time.
> - * @data:	scsi host that failed to recover its devices in 
> the alloted
> - *		time.
> - **/
> -static void fc_timeout_blocked_host(unsigned long data)
> -{
> -	struct Scsi_Host *shost = (struct Scsi_Host *)data;
> -	struct scsi_device *sdev;
> -
> -	dev_printk(KERN_ERR, &shost->shost_gendev, 
> -		"blocked host time out: host resuming\n");
> -
> -	shost_for_each_device(sdev, shost) {
> -		/* 
> -		 * set the device going again ... if the scsi lld didn't
> -		 * unblock this device, then IO errors will probably
> -		 * result if the host still isn't ready.
> -		 */
> -		scsi_internal_device_unblock(sdev);
> -	}
> -}
> -
> -/**
> - * fc_host_block - block all scsi devices managed by the 
> calling host temporarily 
> - *		by putting each device in the SDEV_BLOCK state.
> - * @shost:	scsi host pointer that contains all scsi device 
> siblings.
> - *
> - * scsi lld's with a FC transport call this routine to 
> temporarily stop all
> - * scsi commands to all devices managed by this host.  Called 
> - * from interrupt or normal process context.
> - *
> - * Returns zero if successful or error if not
> - *
> - * Notes:
> - *	The timeout and timer types are extracted from the fc transport 
> - *	attributes from the caller's host pointer.  This 
> routine assumes no
> - *	locks are held on entry.
> - **/
> -int
> -fc_host_block(struct Scsi_Host *shost)
> -{
> -	struct scsi_device *sdev;
> -	int timeout = fc_host_link_down_tmo(shost);
> -	struct timer_list *timer = &fc_host_link_down_timer(shost);
> -
> -	if (timeout < 0 || timeout > SCSI_DEVICE_BLOCK_MAX_TIMEOUT)
> -		return -EINVAL;
> -
> -	shost_for_each_device(sdev, shost) {
> -		scsi_internal_device_block(sdev);
> -	}
> -
> -	/* The scsi lld blocks this host for the timeout period only. */
> -	timer->data = (unsigned long)shost;
> -	timer->expires = jiffies + timeout * HZ;
> -	timer->function = fc_timeout_blocked_host;
> -	add_timer(timer);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(fc_host_block);
> -
> -/**
> - * fc_host_unblock - unblock all devices managed by this 
> host following a 
> - *		fc_host_block request.
> - * @shost:	scsi host containing all scsi device siblings 
> to unblock.
> - *
> - * scsi lld's with a FC transport call this routine to 
> restart IO to all scsi
> - * devices managed by the specified scsi host following an 
> fc_host_block 
> - * request.  Called from interrupt or normal process context.
> - *
> - * Notes:       
> - *	This routine assumes no locks are held on entry.
> - **/
> -void
> -fc_host_unblock(struct Scsi_Host *shost)
> -{
> -	struct scsi_device *sdev;
> -
> -	/* 
> -	 * Stop the host timer first. Take no action on the del_timer
> -	 * failure as the state machine state change will validate the
> -	 * transaction.
> -	 */
> -	del_timer_sync(&fc_host_link_down_timer(shost));
> -	shost_for_each_device(sdev, shost) {
> -		scsi_internal_device_unblock(sdev);
> -	}
> -}
> -EXPORT_SYMBOL(fc_host_unblock);
> -
>  MODULE_AUTHOR("Martin Hicks");
>  MODULE_DESCRIPTION("FC Transport Attributes");
>  MODULE_LICENSE("GPL");
> --- 
> linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi_transport_sp
> i.c.old	2004-11-13 23:41:04.000000000 +0100
> +++ 
> linux-2.6.10-rc1-mm5-full/drivers/scsi/scsi_transport_spi.c	
> 2004-11-13 23:41:25.000000000 +0100
> @@ -119,12 +119,12 @@
>  }
>  
>  
> -struct class spi_transport_class = {
> +static struct class spi_transport_class = {
>  	.name = "spi_transport",
>  	.release = transport_class_release,
>  };
>  
> -struct class spi_host_class = {
> +static struct class spi_host_class = {
>  	.name = "spi_host",
>  	.release = host_class_release,
>  };
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
