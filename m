Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWFFXZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWFFXZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWFFXZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:25:23 -0400
Received: from terminus.zytor.com ([192.83.249.54]:27356 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751348AbWFFXZW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:25:22 -0400
Message-ID: <44860ED7.10608@zytor.com>
Date: Tue, 06 Jun 2006 16:25:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: linux-kernel@vger.kernel.org, iss_storagedev@hp.com,
       Mike Miller <mike.miller@hp.com>
Subject: Re: kinit problem with cciss root device
References: <200606061640.48644.bjorn.helgaas@hp.com>
In-Reply-To: <200606061640.48644.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> 
> So you might consider something like the "drain output" hunk below,
> which allowed all the useful messages to get out.
> 

Hm.  That's rather ugly.  Anyone knows if TCFLSB works on /dev/console?

> 
> Index: work-mm8/usr/kinit/kinit.c
> ===================================================================
> --- work-mm8.orig/usr/kinit/kinit.c	2006-06-05 19:04:46.000000000 -0600
> +++ work-mm8/usr/kinit/kinit.c	2006-06-06 14:19:59.000000000 -0600
> @@ -317,5 +317,10 @@
>  	if (mnt_sysfs)
>  		umount2("/sys", 0);
>  
> +	/*
> +	 * Allow time for messages to drain before kernel panics
> +	 * because init is exiting.
> +	 * */
> +	sleep(10);
>  	exit(ret);
>  }

	-hpa
