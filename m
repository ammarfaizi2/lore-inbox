Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTJPVfM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbTJPVfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:35:11 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15262 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263130AbTJPVfG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:35:06 -0400
Message-ID: <3F8F0EFB.7090002@us.ibm.com>
Date: Thu, 16 Oct 2003 14:34:51 -0700
From: Mike Christie <mikenc@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
CC: linux-kernel@vger.kernel.org, Brard Roudier <groudier@free.fr>
Subject: Re: [patch][1/3] qlogic: use scsi_host_alloc instead scsi_register
References: <20031016015213.GA1765@cathedrallabs.org>
In-Reply-To: <20031016015213.GA1765@cathedrallabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aristeu Sergio Rozanski Filho wrote:

> --- linux/drivers/scsi/qlogicfas.c.orig	2003-10-15 23:41:52.000000000 -0200
> +++ linux/drivers/scsi/qlogicfas.c	2003-10-15 23:41:28.000000000 -0200
> @@ -671,7 +671,7 @@
>  	if (qlirq >= 0 && !request_irq(qlirq, do_ql_ihandl, 0, "qlogicfas", NULL))
>  		host->can_queue = 1;
>  #endif
> -	hreg = scsi_register(host, 0);	/* no host data */
> +	hreg = scsi_host_alloc(host, 0);	/* no host data */
>  	if (!hreg)

I think this will break the non-PCMCIA version now. scsi_register also 
adds the host to the template's legacy_hosts list. With your patch 
init_this_scsi_driver will call the template's detect function then 
never call scsi_add_host and scsi_scan_host because that list is empty.


Mike

