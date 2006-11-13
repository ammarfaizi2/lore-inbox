Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWKMR5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWKMR5z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbWKMR5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:57:55 -0500
Received: from mga05.intel.com ([192.55.52.89]:63813 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1753379AbWKMR5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:57:54 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,418,1157353200"; 
   d="scan'208"; a="15227549:sNHT32821290"
Date: Mon, 13 Nov 2006 09:34:47 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061113093447.B17720@unix-os.sc.intel.com>
References: <20061111151414.GA32507@elte.hu> <200611111620.24551.ak@suse.de> <20061112175050.A17720@unix-os.sc.intel.com> <20061113084315.GB25604@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061113084315.GB25604@elte.hu>; from mingo@elte.hu on Mon, Nov 13, 2006 at 09:43:16AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 09:43:16AM +0100, Ingo Molnar wrote:
> 
> * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> 
> > There is an issue of using clustered mode along with cpu hotplug. More 
> > details are at the below link.
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=113261865814107&w=2
> 
> ok, to make sure i understand this right: it is not safe to switch any 
> local APIC in the system into clustered APIC mode on the E850x chipset 
> /at all/, because if one of the CPUs gets an INIT/startup IPI message 
> its local APIC will default to logical flat mode and might confuse the 
> chipset?

"at all" is not quite correct. We are fine as long as all the cpus are up
in clustered APIC mode before the IO-APIC RTE's are programmed.

Once the IO-APIC subsystem is up and running and later if the cpu comes online
then we have a window between the INIT/startup IPI message and the place
where we program the DFR and LDR, with in which the IO-APIC will interpret
the logical mode in RTE as 'logical flat' and will probably result in missing
the interrupt.

thanks,
suresh
> 
> on large systems that have their APIC IDs set up to group CPUs amongst 
> different clusters and hence triggered cluster mode, the chipset does 
> not get confused by this, correct?
> 
> 	Ingo
