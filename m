Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936048AbWK1TjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936048AbWK1TjN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936056AbWK1TjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:39:13 -0500
Received: from mga06.intel.com ([134.134.136.21]:25186 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S936048AbWK1TjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:39:11 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,470,1157353200"; 
   d="scan'208"; a="167500777:sNHT42207214"
Date: Tue, 28 Nov 2006 11:14:15 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mm-commits@vger.kernel.org,
       ak@suse.de, ashok.raj@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] genapic: always use physical delivery mode on > 8 CPUs
Message-ID: <20061128111414.A16460@unix-os.sc.intel.com>
References: <200611140109.kAE19f5e014490@shell0.pdx.osdl.net> <20061127141849.A9978@unix-os.sc.intel.com> <20061128063345.GA19523@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061128063345.GA19523@elte.hu>; from mingo@elte.hu on Tue, Nov 28, 2006 at 07:33:46AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 07:33:46AM +0100, Ingo Molnar wrote:
> -	if (clusters <= 1 && max_cluster <= 8 && cluster_cnt[0] == max_cluster)
> +	if (max_apic < 8)

Patch mostly looks good.  Instead of checking for max_apic, can we use
	cpus_weight(cpu_possible_map) <= 8

This will help where initially system booted with <= 8 cpus and hotplug
potentially can bringup more cpus later..

thanks,
suresh
	
>  		genapic = &apic_flat;
>  	else
> -		genapic = &apic_cluster;
> +force_physflat:
> +		genapic = &apic_physflat;
