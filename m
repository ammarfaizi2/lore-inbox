Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbTEAUlp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbTEAUlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:41:45 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:16051 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262440AbTEAUlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:41:44 -0400
Date: Thu, 1 May 2003 13:53:59 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 5 potential user-pointer errors that allow arbitrary
 reads from kernel
In-Reply-To: <20030501205219.GA3616@kroah.com>
Message-ID: <Pine.GSO.4.44.0305011353180.28997-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks!

On Thu, 1 May 2003, Greg KH wrote:

> On Wed, Apr 30, 2003 at 09:39:18PM -0700, Junfeng Yang wrote:
> > ---------------------------------------------------------
> > [BUG] proc_dir_entry.write_proc can take tainted inputs
> >
> > /home/junfeng/linux-2.5.63/drivers/usb/media/vicam.c:1117:vicam_write_proc_gain:
> > ERROR:TAINTED:1117:1117: passing tainted ptr 'buffer' to simple_strtoul
> > [Callstack:
> > /home/junfeng/linux-2.5.63/net/core/pktgen.c:991:vicam_write_proc_gain((tainted
> > 1))]
> >
> > static int vicam_write_proc_gain(struct file *file, const char *buffer,
> > 				unsigned long count, void *data)
> > {
> > 	struct vicam_camera *cam = (struct vicam_camera *)data;
> >
> >
> > Error --->
> > 	cam->gain = simple_strtoul(buffer, NULL, 10);
>
> Real bug, I'll fix this.
>
> > ---------------------------------------------------------
> > [BUG] proc_dir_entry.write_proc can take tainted inputs
> >
> > /home/junfeng/linux-2.5.63/drivers/usb/media/vicam.c:1107:vicam_write_proc_shutter:
> > ERROR:TAINTED:1107:1107: passing tainted ptr 'buffer' to simple_strtoul
> > [Callstack:
> > /home/junfeng/linux-2.5.63/net/core/pktgen.c:991:vicam_write_proc_shutter((tainted
> > 1))]
> >
> > static int vicam_write_proc_shutter(struct file *file, const char *buffer,
> > 				unsigned long count, void *data)
> > {
> > 	struct vicam_camera *cam = (struct vicam_camera *)data;
> >
> >
> > Error --->
> > 	cam->shutter_speed = simple_strtoul(buffer, NULL, 10);
>
> Again, real bug, I'll fix it.
>
> thanks,
>
> greg k-h
>

