Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSFKAdx>; Mon, 10 Jun 2002 20:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316592AbSFKAdw>; Mon, 10 Jun 2002 20:33:52 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:31496 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316588AbSFKAdv>;
	Mon, 10 Jun 2002 20:33:51 -0400
Date: Mon, 10 Jun 2002 17:30:04 -0700
From: Greg KH <greg@kroah.com>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 54 missing null pointer checks in 2.4.17
Message-ID: <20020611003004.GF5202@kroah.com>
In-Reply-To: <200206100355.UAA17040@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 13 May 2002 22:08:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 08:55:22PM -0700, Dawson Engler wrote:
> ---------------------------------------------------------
> [BUG]
> /u2/engler/mc/oses/linux/2.4.17/drivers/hotplug/cpqphp_proc.c:156:cpqhp_proc_create_ctrl: ERROR:NULL:155:156:Using ptr "(*ctrl).proc_entry" illegally! set by 'create_proc_entry':155 [COUNTER=create_proc_entry:155] [fit=7] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=88] [counter=4] [z = 0.287018923940967] [fn-z = -4.35889894354067]
> int cpqhp_proc_create_ctrl (struct controller *ctrl)
> {
> 	strcpy(ctrl->proc_name, "hpca");
> 	ctrl->proc_name[3] = 'a' + ctrl->bus;
> 
> Start --->
> 	ctrl->proc_entry = create_proc_entry(ctrl->proc_name, S_IFREG | S_IRUGO, ctrl_proc_root);
> Error --->
> 	ctrl->proc_entry->data = ctrl;
> 	ctrl->proc_entry->read_proc = &read_ctrl;
> 
> 	strcpy(ctrl->proc_name2, "slot_a");
> ---------------------------------------------------------
> [BUG]
> /u2/engler/mc/oses/linux/2.4.17/drivers/hotplug/cpqphp_proc.c:162:cpqhp_proc_create_ctrl: ERROR:NULL:161:162:Using ptr "(*ctrl).proc_entry2" illegally! set by 'create_proc_entry':161 [COUNTER=create_proc_entry:161] [fit=7] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=88] [counter=4] [z = 0.287018923940967] [fn-z = -4.35889894354067]
> 	ctrl->proc_entry->data = ctrl;
> 	ctrl->proc_entry->read_proc = &read_ctrl;
> 
> 	strcpy(ctrl->proc_name2, "slot_a");
> 	ctrl->proc_name2[5] = 'a' + ctrl->bus;
> Start --->
> 	ctrl->proc_entry2 = create_proc_entry(ctrl->proc_name2, S_IFREG | S_IRUGO, ctrl_proc_root);
> Error --->
> 	ctrl->proc_entry2->data = ctrl;
> 	ctrl->proc_entry2->read_proc = &read_dev;
> 
> 	return 0;
> ---------------------------------------------------------

Ah, good catch, I'll go fix these two.

thanks,

greg k-h
