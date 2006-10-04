Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161232AbWJDPYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbWJDPYG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbWJDPYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:24:06 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:64224 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161232AbWJDPYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:24:03 -0400
Date: Wed, 4 Oct 2006 17:24:34 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/base: error handling fixes
Message-ID: <20061004172434.1a2ddb71@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061004130554.GA25974@havoc.gtf.org>
References: <20061004130554.GA25974@havoc.gtf.org>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 09:05:54 -0400,
Jeff Garzik <jeff@garzik.org> wrote:

>  static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
> @@ -112,17 +110,18 @@ static int __cpuinit topology_cpu_callba
>  {
>  	unsigned int cpu = (unsigned long)hcpu;
>  	struct sys_device *sys_dev;
> +	int rc = 0;
>  
>  	sys_dev = get_cpu_sysdev(cpu);
>  	switch (action) {
>  	case CPU_ONLINE:
> -		topology_add_dev(sys_dev);
> +		rc = topology_add_dev(sys_dev);
>  		break;
>  	case CPU_DEAD:
>  		topology_remove_dev(sys_dev);
>  		break;
>  	}
> -	return NOTIFY_OK;
> +	return rc ? NOTIFY_BAD : NOTIFY_OK;
>  }

Wouldn't that also require that _cpu_up checked the return code when
doing CPU_ONLINE notification (and clean up on error)?
