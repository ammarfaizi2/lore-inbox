Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVB1V6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVB1V6C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVB1V5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:57:48 -0500
Received: from avexch01.qlogic.com ([198.70.193.200]:11089 "EHLO
	avexch01.qlogic.com") by vger.kernel.org with ESMTP id S261770AbVB1V4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:56:23 -0500
Date: Mon, 28 Feb 2005 13:56:45 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/qla2xxx/: cleanups
Message-ID: <20050228215645.GB9215@plap.qlogic.org>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20050228210024.GM4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228210024.GM4021@stusta.de>
Organization: QLogic Corporation
X-Operating-System: Linux 2.6.8-24.11-default
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 28 Feb 2005 21:56:18.0913 (UTC) FILETIME=[5531BD10:01C51DE0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005, Adrian Bunk wrote:

> This patch contains the following cleanups:
> - make needlessly global code static

As Christoph mentioned, the firmware images are auto-generated, so I'd
rather hold off on those deltas.  Besides, I'm hoping in the near
future to drop the firmware from the distribution and begin to use the
request_firmware() interface exclusively.

> - kill the unused global *_version and *_version_str variables
>   in the firmware files
> 

The driver is also going through some significant overhauling with the
fc_remote_port stuffs -- where most internal queueing is stripped from
the driver.  

> -static __inline__ void qla2x00_add_timer_to_cmd(srb_t *, int);
> -static __inline__ void qla2x00_delete_timer_from_cmd(srb_t *);
> -
> -/**************************************************************************
> -*   qla2x00_add_timer_to_cmd
> -*
> -* Description:
> -*       Creates a timer for the specified command. The timeout is usually
> -*       the command time from kernel minus 2 secs.
> -*
> -* Input:
> -*     sp - pointer to validate
> -*
> -* Returns:
> -*     None.
> -**************************************************************************/
> -static inline void
> -qla2x00_add_timer_to_cmd(srb_t *sp, int timeout)
> -{
> -	init_timer(&sp->timer);
> -	sp->timer.expires = jiffies + timeout * HZ;
> -	sp->timer.data = (unsigned long) sp;
> -	sp->timer.function = (void (*) (unsigned long))qla2x00_cmd_timeout;
> -	add_timer(&sp->timer);
> -}
> -
> -/**************************************************************************
> -*   qla2x00_delete_timer_from_cmd
> -*
> -* Description:
> -*       Delete the timer for the specified command.
> -*
> -* Input:
> -*     sp - pointer to validate
> -*
> -* Returns:
> -*     None.
> -**************************************************************************/
> -static inline void 
> -qla2x00_delete_timer_from_cmd(srb_t *sp)
> -{
> -	if (sp->timer.function != NULL) {
> -		del_timer(&sp->timer);
> -		sp->timer.function =  NULL;
> -		sp->timer.data = (unsigned long) NULL;
> -	}
> -}
> -

these codes will be dropped from the driver.

>  /*
>   * SRB allocation cache
>   */
> -char srb_cachep_name[16];
> -kmem_cache_t *srb_cachep;
> +static char srb_cachep_name[16];
> +static kmem_cache_t *srb_cachep;
>  
>  /*
>   * Stats for all adpaters.
> @@ -47,13 +47,12 @@
>  /*
>   * Ioctl related information.
>   */
> -int num_hosts;
> -int apiHBAInstance;
> +static int num_hosts;
>  
>  /*
>   * Module parameter information and variables
>   */
> -int ql2xmaxqdepth;
> +static int ql2xmaxqdepth;
>  module_param(ql2xmaxqdepth, int, S_IRUGO|S_IWUSR);
>  MODULE_PARM_DESC(ql2xmaxqdepth,
>  		"Maximum queue depth to report for target devices.");
> @@ -69,13 +68,13 @@
>  		"Maximum number of command retries to a port that returns"
>  		"a PORT-DOWN status.");
>  
> -int ql2xretrycount = 20;
> +static int ql2xretrycount = 20;
>  module_param(ql2xretrycount, int, S_IRUGO|S_IWUSR);
>  MODULE_PARM_DESC(ql2xretrycount,
>  		"Maximum number of mid-layer retries allowed for a command.  "
>  		"Default value is 20, ");
>  
> -int displayConfig;
> +static int displayConfig;
>  module_param(displayConfig, int, S_IRUGO|S_IWUSR);
>  MODULE_PARM_DESC(displayConfig,
>  		"If 1 then display the configuration used in /etc/modprobe.conf.");
> @@ -100,7 +99,7 @@
>  		"ZIO: Waiting time for Firmware before it generates an "
>  		"interrupt to the host to notify completion of request.");
>  
> -int ConfigRequired;
> +static int ConfigRequired;
>  module_param(ConfigRequired, int, S_IRUGO|S_IRUSR);
>  MODULE_PARM_DESC(ConfigRequired,
>  		"If 1, then only configured devices passed in through the"
> @@ -119,7 +118,7 @@
>  		"target returns a <NOT READY> status.  Default is 10 "
>  		"iterations.");
>  
> -int ql2xdoinitscan = 1;
> +static int ql2xdoinitscan = 1;
>  module_param(ql2xdoinitscan, int, S_IRUGO|S_IWUSR);
>  MODULE_PARM_DESC(ql2xdoinitscan,
>  		"Signal mid-layer to perform scan after driver load: 0 -- no "
> @@ -163,6 +162,8 @@

I'll queue-up these for the next set of patches.

Thanks,
Andrew Vasquez
