Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWEIN1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWEIN1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 09:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWEIN1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 09:27:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55944 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932514AbWEIN1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 09:27:05 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 22/35] subarch suport for idle loop (NO_IDLE_HZ for Xen)
Date: Tue, 9 May 2006 15:21:19 +0200
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085156.694312000@sous-sol.org>
In-Reply-To: <20060509085156.694312000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605091521.19910.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +extern void stop_hz_timer(void);
> +extern void start_hz_timer(void);
> +
> +void xen_idle(void);
> +
>  static char * __init machine_specific_memory_setup(void)
>  {
>  	unsigned long max_pfn = xen_start_info->nr_pages;
> @@ -65,4 +70,23 @@ static void __init machine_specific_arch
>  		console_use_vt = 0;
>  		conswitchp = NULL;
>  	}
> +
> +	pm_idle = xen_idle;
> +}
> +
> +void xen_idle(void)

I think that should be in some .c file, not a .h

Probably applies to more of your functions too.

-Andi
