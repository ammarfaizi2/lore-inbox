Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTEAFdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 01:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTEAFdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 01:33:40 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:24240 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262308AbTEAFdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 01:33:39 -0400
Date: Wed, 30 Apr 2003 22:45:55 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 5 potential user-pointer errors that allow arbitrary
 reads from kernel
In-Reply-To: <Pine.GSO.4.44.0304302131150.22117-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0304302241130.22562-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also, please note the word "Callstack" in the error reports doesn't really
mean an actual call here. It means "functions are linked together if they
are assigned to the same structure field".

for example, the following error report is catched in this way:

net/core/pktgen.c:proc_write treats its second arguemtn as tainted.
we take it as a good code example, and require that all the other
functions that are assigned to proc_dir_entry.write_proc must treat its
second argument as tainted.

sorry for the confusions.

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
>
> 	return count;
> }

