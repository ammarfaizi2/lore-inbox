Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbTEAUiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbTEAUiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:38:11 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:53129 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262438AbTEAUiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:38:10 -0400
Date: Thu, 1 May 2003 13:52:19 -0700
From: Greg KH <greg@kroah.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mc@stanford.edu
Subject: Re: [CHECKER] 5 potential user-pointer errors that allow arbitrary reads from kernel
Message-ID: <20030501205219.GA3616@kroah.com>
References: <Pine.GSO.4.44.0304302131150.22117-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0304302131150.22117-100000@elaine24.Stanford.EDU>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 09:39:18PM -0700, Junfeng Yang wrote:
> ---------------------------------------------------------
> [BUG] proc_dir_entry.write_proc can take tainted inputs
> 
> /home/junfeng/linux-2.5.63/drivers/usb/media/vicam.c:1117:vicam_write_proc_gain:
> ERROR:TAINTED:1117:1117: passing tainted ptr 'buffer' to simple_strtoul
> [Callstack:
> /home/junfeng/linux-2.5.63/net/core/pktgen.c:991:vicam_write_proc_gain((tainted
> 1))]
> 
> static int vicam_write_proc_gain(struct file *file, const char *buffer,
> 				unsigned long count, void *data)
> {
> 	struct vicam_camera *cam = (struct vicam_camera *)data;
> 
> 
> Error --->
> 	cam->gain = simple_strtoul(buffer, NULL, 10);

Real bug, I'll fix this.

> ---------------------------------------------------------
> [BUG] proc_dir_entry.write_proc can take tainted inputs
> 
> /home/junfeng/linux-2.5.63/drivers/usb/media/vicam.c:1107:vicam_write_proc_shutter:
> ERROR:TAINTED:1107:1107: passing tainted ptr 'buffer' to simple_strtoul
> [Callstack:
> /home/junfeng/linux-2.5.63/net/core/pktgen.c:991:vicam_write_proc_shutter((tainted
> 1))]
> 
> static int vicam_write_proc_shutter(struct file *file, const char *buffer,
> 				unsigned long count, void *data)
> {
> 	struct vicam_camera *cam = (struct vicam_camera *)data;
> 
> 
> Error --->
> 	cam->shutter_speed = simple_strtoul(buffer, NULL, 10);

Again, real bug, I'll fix it.

thanks,

greg k-h
