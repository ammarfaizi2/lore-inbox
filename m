Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753818AbWKMNKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbWKMNKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 08:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754591AbWKMNKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 08:10:19 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:33655 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1753818AbWKMNKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 08:10:18 -0500
Date: Mon, 13 Nov 2006 14:09:26 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Srinivasa Ds <srinivasa@in.ibm.com>
Cc: anton@au1.ibm.com, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cpu_hotplug on IBM JS20 system
Message-ID: <20061113130926.GD7085@osiris.boeblingen.de.ibm.com>
References: <45586EB5.40409@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45586EB5.40409@in.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since we are not supported by hardware for cpu hotplug. I have developed
> the patch which will disable cpu hotplug on IBM bladecentre JS20. Please
> let me know your comments on this please.

> +extern  int cpu_hotplug_disabled;
> +extern  struct mutex cpu_add_remove_lock;
[...]
> +	if(rtas_stop_self_args.token == RTAS_UNKNOWN_SERVICE) {
> +		mutex_lock(&cpu_add_remove_lock);
> +		cpu_hotplug_disabled = 1;
> +		mutex_unlock(&cpu_add_remove_lock);
> +	}
> +
>  #endif /* CONFIG_HOTPLUG_CPU */
>  #ifdef CONFIG_RTAS_ERROR_LOGGING
>  	rtas_last_error_token = rtas_token("rtas-last-error");

You should add a function to kernel/cpu.c which you can call in order to
disable cpu hotplug instead of exporting its private data structures.
