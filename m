Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWCHUmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWCHUmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWCHUmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:42:04 -0500
Received: from kanga.kvack.org ([66.96.29.28]:34980 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932452AbWCHUmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:42:03 -0500
Date: Wed, 8 Mar 2006 15:36:42 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, netdev@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add percpu_counter_mod_bh
Message-ID: <20060308203642.GZ5410@kvack.org>
References: <20060308015808.GA9062@localhost.localdomain> <20060308015934.GB9062@localhost.localdomain> <20060307181301.4dd6aa96.akpm@osdl.org> <20060308202656.GA4493@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308202656.GA4493@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 12:26:56PM -0800, Ravikiran G Thirumalai wrote:
> +static inline void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount)
> +{
> +	local_bh_disable();
> +	fbc->count += amount;
> +	local_bh_enable();
> +}

Please use local_t instead, then you don't have to do the local_bh_disable() 
and enable() and the whole thing collapses down into 1 instruction on x86.

		-ben
