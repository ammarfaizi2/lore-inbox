Return-Path: <linux-kernel-owner+w=401wt.eu-S932963AbWLSVtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932963AbWLSVtd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932964AbWLSVtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:49:33 -0500
Received: from mga05.intel.com ([192.55.52.89]:34653 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932963AbWLSVtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:49:32 -0500
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 16:49:32 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,188,1165219200"; 
   d="scan'208"; a="179518747:sNHT22377201"
Date: Tue, 19 Dec 2006 13:12:24 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, vatsa@in.ibm.com,
       clameter@sgi.com, tglx@linutronix.de, arjan@linux.intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch: dynticks: idle load balancing
Message-ID: <20061219131223.E23105@unix-os.sc.intel.com>
References: <20061211155304.A31760@unix-os.sc.intel.com> <20061213224317.GA2986@elte.hu> <20061213231316.GA13849@elte.hu> <20061213150314.B12795@unix-os.sc.intel.com> <20061213233157.GA20470@elte.hu> <20061213151926.C12795@unix-os.sc.intel.com> <20061219201247.GA12648@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061219201247.GA12648@elte.hu>; from mingo@elte.hu on Tue, Dec 19, 2006 at 09:12:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 09:12:48PM +0100, Ingo Molnar wrote:
>  restart:
>  	if (idle_cpu(local_cpu) && notick.load_balancer == local_cpu) {
>  		this_cpu = first_cpu(cpus);
> +		if (unlikely(this_cpu >= NR_CPUS))
> +			return;

oops.

There is window when local_cpu is cleared from notick.cpumask
but the notick.load_balancer still points to local_cpu..
This can also be corrected by first resetting the notick.load_balancer
before clearing that cpu from notick.cpumask in select_notick_load_balancer()

thanks,
suresh
