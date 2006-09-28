Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965403AbWI1LvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965403AbWI1LvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWI1LvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:51:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:65461 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751855AbWI1LvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:51:03 -0400
Subject: Re: [PATCH] completions: lockdep annotate on stack completions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Jens Axboe <axboe@suse.de>, Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <1159437164.28131.48.camel@taijtu>
References: <1159437164.28131.48.camel@taijtu>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 21:46:57 +1000
Message-Id: <1159444017.9974.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-28 at 11:52 +0200, Peter Zijlstra wrote:
> All on stack DECLARE_COMPLETIONs should be replaced by:
>   DECLARE_COMPLETION_ONSTACK
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Acked-by: Ingo Molnar <mingo@elte.hu>

As far as the powerpc/macintosh bits are concernd, it's fine

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/arm/kernel/ecard.c                      |    2 +-
>  arch/i386/kernel/smpboot.c                   |    2 +-
>  arch/powerpc/platforms/powermac/cpufreq_64.c |    2 +-
>  arch/powerpc/platforms/powermac/nvram.c      |    4 ++--
>  block/as-iosched.c                           |    2 +-
>  block/cfq-iosched.c                          |    2 +-
>  drivers/block/DAC960.c                       |    2 +-
>  drivers/block/cciss.c                        |    6 +++---
>  drivers/block/cciss_scsi.c                   |    2 +-
>  drivers/block/paride/pd.c                    |    2 +-
>  drivers/block/pktcdvd.c                      |    2 +-
>  drivers/ide/ide-tape.c                       |    2 +-
>  drivers/macintosh/smu.c                      |    4 ++--
>  drivers/macintosh/windfarm_smu_controls.c    |    2 +-
>  drivers/macintosh/windfarm_smu_sensors.c     |    2 +-
>  drivers/s390/scsi/zfcp_scsi.c                |    2 +-
>  drivers/scsi/53c700.c                        |    2 +-
>  drivers/scsi/aic7xxx/aic79xx_osm.c           |    4 ++--
>  drivers/scsi/aic7xxx/aic7xxx_osm.c           |    2 +-
>  drivers/scsi/gdth.c                          |    4 ++--
>  drivers/scsi/qla1280.c                       |    4 ++--
>  drivers/usb/gadget/inode.c                   |    2 +-
>  drivers/usb/gadget/omap_udc.c                |    2 +-
>  net/ipv4/ipvs/ip_vs_sync.c                   |    2 +-
>  24 files changed, 31 insertions(+), 31 deletions(-)
> 
> Index: linux-2.6/arch/arm/kernel/ecard.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/kernel/ecard.c
> +++ linux-2.6/arch/arm/kernel/ecard.c
> @@ -295,7 +295,7 @@ ecard_task(void * unused)
>   */
>  static void ecard_call(struct ecard_request *req)
>  {
> -	DECLARE_COMPLETION(completion);
> +	DECLARE_COMPLETION_ONSTACK(completion);
>  
>  	req->complete = &completion;
>  
> Index: linux-2.6/arch/i386/kernel/smpboot.c
> ===================================================================
> --- linux-2.6.orig/arch/i386/kernel/smpboot.c
> +++ linux-2.6/arch/i386/kernel/smpboot.c
> @@ -1058,7 +1058,7 @@ static void __cpuinit do_warm_boot_cpu(v
>  
>  static int __cpuinit __smp_prepare_cpu(int cpu)
>  {
> -	DECLARE_COMPLETION(done);
> +	DECLARE_COMPLETION_ONSTACK(done);
>  	struct warm_boot_cpu_info info;
>  	struct work_struct task;
>  	int	apicid, ret;
> Index: linux-2.6/arch/powerpc/platforms/powermac/cpufreq_64.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/powermac/cpufreq_64.c
> +++ linux-2.6/arch/powerpc/platforms/powermac/cpufreq_64.c
> @@ -104,7 +104,7 @@ static void g5_smu_switch_volt(int speed
>  {
>  	struct smu_simple_cmd	cmd;
>  
> -	DECLARE_COMPLETION(comp);
> +	DECLARE_COMPLETION_ONSTACK(comp);
>  	smu_queue_simple(&cmd, SMU_CMD_POWER_COMMAND, 8, smu_done_complete,
>  			 &comp, 'V', 'S', 'L', 'E', 'W',
>  			 0xff, g5_fvt_cur+1, speed_mode);
> Index: linux-2.6/arch/powerpc/platforms/powermac/nvram.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/powermac/nvram.c
> +++ linux-2.6/arch/powerpc/platforms/powermac/nvram.c
> @@ -195,7 +195,7 @@ static void pmu_nvram_complete(struct ad
>  static unsigned char pmu_nvram_read_byte(int addr)
>  {
>  	struct adb_request req;
> -	DECLARE_COMPLETION(req_complete); 
> +	DECLARE_COMPLETION_ONSTACK(req_complete);
>  	
>  	req.arg = system_state == SYSTEM_RUNNING ? &req_complete : NULL;
>  	if (pmu_request(&req, pmu_nvram_complete, 3, PMU_READ_NVRAM,
> @@ -211,7 +211,7 @@ static unsigned char pmu_nvram_read_byte
>  static void pmu_nvram_write_byte(int addr, unsigned char val)
>  {
>  	struct adb_request req;
> -	DECLARE_COMPLETION(req_complete); 
> +	DECLARE_COMPLETION_ONSTACK(req_complete);
>  	
>  	req.arg = system_state == SYSTEM_RUNNING ? &req_complete : NULL;
>  	if (pmu_request(&req, pmu_nvram_complete, 4, PMU_WRITE_NVRAM,
> Index: linux-2.6/block/as-iosched.c
> ===================================================================
> --- linux-2.6.orig/block/as-iosched.c
> +++ linux-2.6/block/as-iosched.c
> @@ -1828,7 +1828,7 @@ static int __init as_init(void)
>  
>  static void __exit as_exit(void)
>  {
> -	DECLARE_COMPLETION(all_gone);
> +	DECLARE_COMPLETION_ONSTACK(all_gone);
>  	elv_unregister(&iosched_as);
>  	ioc_gone = &all_gone;
>  	/* ioc_gone's update must be visible before reading ioc_count */
> Index: linux-2.6/block/cfq-iosched.c
> ===================================================================
> --- linux-2.6.orig/block/cfq-iosched.c
> +++ linux-2.6/block/cfq-iosched.c
> @@ -2463,7 +2463,7 @@ static int __init cfq_init(void)
>  
>  static void __exit cfq_exit(void)
>  {
> -	DECLARE_COMPLETION(all_gone);
> +	DECLARE_COMPLETION_ONSTACK(all_gone);
>  	elv_unregister(&iosched_cfq);
>  	ioc_gone = &all_gone;
>  	/* ioc_gone's update must be visible before reading ioc_count */
> Index: linux-2.6/drivers/block/DAC960.c
> ===================================================================
> --- linux-2.6.orig/drivers/block/DAC960.c
> +++ linux-2.6/drivers/block/DAC960.c
> @@ -770,7 +770,7 @@ static void DAC960_P_QueueCommand(DAC960
>  static void DAC960_ExecuteCommand(DAC960_Command_T *Command)
>  {
>    DAC960_Controller_T *Controller = Command->Controller;
> -  DECLARE_COMPLETION(Completion);
> +  DECLARE_COMPLETION_ONSTACK(Completion);
>    unsigned long flags;
>    Command->Completion = &Completion;
>  
> Index: linux-2.6/drivers/block/cciss.c
> ===================================================================
> --- linux-2.6.orig/drivers/block/cciss.c
> +++ linux-2.6/drivers/block/cciss.c
> @@ -879,7 +879,7 @@ static int cciss_ioctl(struct inode *ino
>  			char *buff = NULL;
>  			u64bit temp64;
>  			unsigned long flags;
> -			DECLARE_COMPLETION(wait);
> +			DECLARE_COMPLETION_ONSTACK(wait);
>  
>  			if (!arg)
>  				return -EINVAL;
> @@ -997,7 +997,7 @@ static int cciss_ioctl(struct inode *ino
>  			BYTE sg_used = 0;
>  			int status = 0;
>  			int i;
> -			DECLARE_COMPLETION(wait);
> +			DECLARE_COMPLETION_ONSTACK(wait);
>  			__u32 left;
>  			__u32 sz;
>  			BYTE __user *data_ptr;
> @@ -1792,7 +1792,7 @@ static int sendcmd_withirq(__u8 cmd,
>  	u64bit buff_dma_handle;
>  	unsigned long flags;
>  	int return_status;
> -	DECLARE_COMPLETION(wait);
> +	DECLARE_COMPLETION_ONSTACK(wait);
>  
>  	if ((c = cmd_alloc(h, 0)) == NULL)
>  		return -ENOMEM;
> Index: linux-2.6/drivers/block/cciss_scsi.c
> ===================================================================
> --- linux-2.6.orig/drivers/block/cciss_scsi.c
> +++ linux-2.6/drivers/block/cciss_scsi.c
> @@ -766,7 +766,7 @@ cciss_scsi_do_simple_cmd(ctlr_info_t *c,
>  			int direction)
>  {
>  	unsigned long flags;
> -	DECLARE_COMPLETION(wait);
> +	DECLARE_COMPLETION_ONSTACK(wait);
>  
>  	cp->cmd_type = CMD_IOCTL_PEND;		// treat this like an ioctl 
>  	cp->scsi_cmd = NULL;
> Index: linux-2.6/drivers/block/paride/pd.c
> ===================================================================
> --- linux-2.6.orig/drivers/block/paride/pd.c
> +++ linux-2.6/drivers/block/paride/pd.c
> @@ -713,7 +713,7 @@ static void do_pd_request(request_queue_
>  static int pd_special_command(struct pd_unit *disk,
>  		      enum action (*func)(struct pd_unit *disk))
>  {
> -	DECLARE_COMPLETION(wait);
> +	DECLARE_COMPLETION_ONSTACK(wait);
>  	struct request rq;
>  	int err = 0;
>  
> Index: linux-2.6/drivers/block/pktcdvd.c
> ===================================================================
> --- linux-2.6.orig/drivers/block/pktcdvd.c
> +++ linux-2.6/drivers/block/pktcdvd.c
> @@ -348,7 +348,7 @@ static int pkt_generic_packet(struct pkt
>  	char sense[SCSI_SENSE_BUFFERSIZE];
>  	request_queue_t *q;
>  	struct request *rq;
> -	DECLARE_COMPLETION(wait);
> +	DECLARE_COMPLETION_ONSTACK(wait);
>  	int err = 0;
>  
>  	q = bdev_get_queue(pd->bdev);
> Index: linux-2.6/drivers/ide/ide-tape.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/ide-tape.c
> +++ linux-2.6/drivers/ide/ide-tape.c
> @@ -2764,7 +2764,7 @@ static void idetape_add_stage_tail (ide_
>   */
>  static void idetape_wait_for_request (ide_drive_t *drive, struct request *rq)
>  {
> -	DECLARE_COMPLETION(wait);
> +	DECLARE_COMPLETION_ONSTACK(wait);
>  	idetape_tape_t *tape = drive->driver_data;
>  
>  #if IDETAPE_DEBUG_BUGS
> Index: linux-2.6/drivers/macintosh/smu.c
> ===================================================================
> --- linux-2.6.orig/drivers/macintosh/smu.c
> +++ linux-2.6/drivers/macintosh/smu.c
> @@ -870,7 +870,7 @@ int smu_queue_i2c(struct smu_i2c_cmd *cm
>  
>  static int smu_read_datablock(u8 *dest, unsigned int addr, unsigned int len)
>  {
> -	DECLARE_COMPLETION(comp);
> +	DECLARE_COMPLETION_ONSTACK(comp);
>  	unsigned int chunk;
>  	struct smu_cmd cmd;
>  	int rc;
> @@ -917,7 +917,7 @@ static int smu_read_datablock(u8 *dest, 
>  
>  static struct smu_sdbp_header *smu_create_sdb_partition(int id)
>  {
> -	DECLARE_COMPLETION(comp);
> +	DECLARE_COMPLETION_ONSTACK(comp);
>  	struct smu_simple_cmd cmd;
>  	unsigned int addr, len, tlen;
>  	struct smu_sdbp_header *hdr;
> Index: linux-2.6/drivers/macintosh/windfarm_smu_controls.c
> ===================================================================
> --- linux-2.6.orig/drivers/macintosh/windfarm_smu_controls.c
> +++ linux-2.6/drivers/macintosh/windfarm_smu_controls.c
> @@ -56,7 +56,7 @@ static int smu_set_fan(int pwm, u8 id, u
>  {
>  	struct smu_cmd cmd;
>  	u8 buffer[16];
> -	DECLARE_COMPLETION(comp);
> +	DECLARE_COMPLETION_ONSTACK(comp);
>  	int rc;
>  
>  	/* Fill SMU command structure */
> Index: linux-2.6/drivers/macintosh/windfarm_smu_sensors.c
> ===================================================================
> --- linux-2.6.orig/drivers/macintosh/windfarm_smu_sensors.c
> +++ linux-2.6/drivers/macintosh/windfarm_smu_sensors.c
> @@ -67,7 +67,7 @@ static void smu_ads_release(struct wf_se
>  static int smu_read_adc(u8 id, s32 *value)
>  {
>  	struct smu_simple_cmd	cmd;
> -	DECLARE_COMPLETION(comp);
> +	DECLARE_COMPLETION_ONSTACK(comp);
>  	int rc;
>  
>  	rc = smu_queue_simple(&cmd, SMU_CMD_READ_ADC, 1,
> Index: linux-2.6/drivers/s390/scsi/zfcp_scsi.c
> ===================================================================
> --- linux-2.6.orig/drivers/s390/scsi/zfcp_scsi.c
> +++ linux-2.6/drivers/s390/scsi/zfcp_scsi.c
> @@ -301,7 +301,7 @@ zfcp_scsi_command_sync(struct zfcp_unit 
>  		       int use_timer)
>  {
>  	int ret;
> -	DECLARE_COMPLETION(wait);
> +	DECLARE_COMPLETION_ONSTACK(wait);
>  
>  	scpnt->SCp.ptr = (void *) &wait;  /* silent re-use */
>  	scpnt->scsi_done = zfcp_scsi_command_sync_handler;
> Index: linux-2.6/drivers/scsi/53c700.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/53c700.c
> +++ linux-2.6/drivers/scsi/53c700.c
> @@ -1939,7 +1939,7 @@ NCR_700_abort(struct scsi_cmnd * SCp)
>  STATIC int
>  NCR_700_bus_reset(struct scsi_cmnd * SCp)
>  {
> -	DECLARE_COMPLETION(complete);
> +	DECLARE_COMPLETION_ONSTACK(complete);
>  	struct NCR_700_Host_Parameters *hostdata = 
>  		(struct NCR_700_Host_Parameters *)SCp->device->host->hostdata[0];
>  
> Index: linux-2.6/drivers/scsi/aic7xxx/aic79xx_osm.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/aic7xxx/aic79xx_osm.c
> +++ linux-2.6/drivers/scsi/aic7xxx/aic79xx_osm.c
> @@ -646,7 +646,7 @@ ahd_linux_dev_reset(struct scsi_cmnd *cm
>  	struct	ahd_initiator_tinfo *tinfo;
>  	struct	ahd_tmode_tstate *tstate;
>  	unsigned long flags;
> -	DECLARE_COMPLETION(done);
> +	DECLARE_COMPLETION_ONSTACK(done);
>  
>  	reset_scb = NULL;
>  	paused = FALSE;
> @@ -2251,7 +2251,7 @@ done:
>  	if (paused)
>  		ahd_unpause(ahd);
>  	if (wait) {
> -		DECLARE_COMPLETION(done);
> +		DECLARE_COMPLETION_ONSTACK(done);
>  
>  		ahd->platform_data->eh_done = &done;
>  		ahd_unlock(ahd, &flags);
> Index: linux-2.6/drivers/scsi/aic7xxx/aic7xxx_osm.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/aic7xxx/aic7xxx_osm.c
> +++ linux-2.6/drivers/scsi/aic7xxx/aic7xxx_osm.c
> @@ -2335,7 +2335,7 @@ done:
>  	if (paused)
>  		ahc_unpause(ahc);
>  	if (wait) {
> -		DECLARE_COMPLETION(done);
> +		DECLARE_COMPLETION_ONSTACK(done);
>  
>  		ahc->platform_data->eh_done = &done;
>  		ahc_unlock(ahc, &flags);
> Index: linux-2.6/drivers/scsi/gdth.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/gdth.c
> +++ linux-2.6/drivers/scsi/gdth.c
> @@ -724,7 +724,7 @@ int __gdth_execute(struct scsi_device *s
>                     int timeout, u32 *info)
>  {
>      Scsi_Cmnd *scp;
> -    DECLARE_COMPLETION(wait);
> +    DECLARE_COMPLETION_ONSTACK(wait);
>      int rval;
>  
>      scp = kmalloc(sizeof(*scp), GFP_KERNEL);
> @@ -764,7 +764,7 @@ int __gdth_execute(struct scsi_device *s
>  {
>      Scsi_Cmnd *scp = scsi_allocate_device(sdev, 1, FALSE);
>      unsigned bufflen = gdtcmd ? sizeof(gdth_cmd_str) : 0;
> -    DECLARE_COMPLETION(wait);
> +    DECLARE_COMPLETION_ONSTACK(wait);
>      int rval;
>  
>      if (!scp)
> Index: linux-2.6/drivers/scsi/qla1280.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/qla1280.c
> +++ linux-2.6/drivers/scsi/qla1280.c
> @@ -813,7 +813,7 @@ qla1280_error_action(struct scsi_cmnd *c
>  	uint16_t data;
>  	unsigned char *handle;
>  	int result, i;
> -	DECLARE_COMPLETION(wait);
> +	DECLARE_COMPLETION_ONSTACK(wait);
>  	struct timer_list timer;
>  
>  	ha = (struct scsi_qla_host *)(CMD_HOST(cmd)->hostdata);
> @@ -2406,7 +2406,7 @@ qla1280_mailbox_command(struct scsi_qla_
>  	uint16_t *optr, *iptr;
>  	uint16_t __iomem *mptr;
>  	uint16_t data;
> -	DECLARE_COMPLETION(wait);
> +	DECLARE_COMPLETION_ONSTACK(wait);
>  	struct timer_list timer;
>  
>  	ENTER("qla1280_mailbox_command");
> Index: linux-2.6/drivers/usb/gadget/inode.c
> ===================================================================
> --- linux-2.6.orig/drivers/usb/gadget/inode.c
> +++ linux-2.6/drivers/usb/gadget/inode.c
> @@ -342,7 +342,7 @@ fail:
>  static ssize_t
>  ep_io (struct ep_data *epdata, void *buf, unsigned len)
>  {
> -	DECLARE_COMPLETION (done);
> +	DECLARE_COMPLETION_ONSTACK (done);
>  	int value;
>  
>  	spin_lock_irq (&epdata->dev->lock);
> Index: linux-2.6/drivers/usb/gadget/omap_udc.c
> ===================================================================
> --- linux-2.6.orig/drivers/usb/gadget/omap_udc.c
> +++ linux-2.6/drivers/usb/gadget/omap_udc.c
> @@ -2869,7 +2869,7 @@ cleanup0:
>  
>  static int __exit omap_udc_remove(struct platform_device *pdev)
>  {
> -	DECLARE_COMPLETION(done);
> +	DECLARE_COMPLETION_ONSTACK(done);
>  
>  	if (!udc)
>  		return -ENODEV;
> Index: linux-2.6/net/ipv4/ipvs/ip_vs_sync.c
> ===================================================================
> --- linux-2.6.orig/net/ipv4/ipvs/ip_vs_sync.c
> +++ linux-2.6/net/ipv4/ipvs/ip_vs_sync.c
> @@ -836,7 +836,7 @@ static int fork_sync_thread(void *startu
>  
>  int start_sync_thread(int state, char *mcast_ifn, __u8 syncid)
>  {
> -	DECLARE_COMPLETION(startup);
> +	DECLARE_COMPLETION_ONSTACK(startup);
>  	pid_t pid;
>  
>  	if ((state == IP_VS_STATE_MASTER && sync_master_pid) ||
> 

