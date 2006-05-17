Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWEQQI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWEQQI0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 12:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWEQQI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 12:08:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29603 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750775AbWEQQI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 12:08:26 -0400
Date: Wed, 17 May 2006 09:06:45 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       Christian.Limpach@cl.cam.ac.uk, xen-devel@lists.xensource.com,
       ian.pratt@xensource.com, zaitcev@redhat.com
Subject: Re: [RFC PATCH 08/35] Add Xen-specific memory management
 definitions
Message-Id: <20060517090645.0b72bd2d.zaitcev@redhat.com>
In-Reply-To: <20060509085151.047254000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
	<20060509085151.047254000@sous-sol.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 May 2006 00:00:08 -0700, Chris Wright <chrisw@sous-sol.org> wrote:

> +static inline unsigned long pfn_to_mfn(unsigned long pfn)
> +{
> +#ifndef CONFIG_XEN_SHADOW_MODE
> +	if (xen_feature(XENFEAT_auto_translated_physmap))
> +		return pfn;
> +	return phys_to_machine_mapping[(unsigned int)(pfn)] &
> +		~FOREIGN_FRAME_BIT;
> +#else
> +	return pfn;
> +#endif
> +}

Why do we need several modes in Linux guests?

If a significant tradeoff exists (for example, between performance
and maximum addressable memory), then we need to think about the
real issue instead of throwing config options into the pot.

-- Pete
