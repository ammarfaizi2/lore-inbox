Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbUBUBzo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 20:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUBUBzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 20:55:44 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:57798 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261476AbUBUBzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 20:55:42 -0500
Date: Fri, 20 Feb 2004 20:55:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Andreas Schwab <schwab@suse.de>, greg@kroah.com,
       linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH]2.6.3-rc2 MSI Support for IA64
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024040580FB@orsmsx404.jf.intel.com>
Message-ID: <Pine.LNX.4.58.0402202054050.7734@montezuma.fsmlabs.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024040580FB@orsmsx404.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004, Nguyen, Tom L wrote:

> Friday, Feb. 20, 2004 8:55 AM, Andreas Schwab wrote:
>
> >> @@ -316,6 +310,19 @@
> >>  	return current_vector;
> >>  }
> >>
> >> +int ia64_alloc_vector(void)
> >> +{
> >> +	static int next_vector = IA64_FIRST_DEVICE_VECTOR;
> >> +
> >> +	if (next_vector > IA64_LAST_DEVICE_VECTOR)
> >> +		/* XXX could look for sharable vectors instead of panic'ing... */
> >> +		panic("ia64_alloc_vector: out of interrupt vectors!");
> >> +
> >> +	nr_alloc_vectors++;
> >> +
> >> +	return next_vector++;
> >> +}
> >> +
>
> > IMHO this should be CONFIG_IA64 only.
>
> To avoid some #ifdef statements as possible, "ia64_platform"
> defined in the header file "msi.h" is set to TRUE only if
> setting CONFIG_IA64 to 'Y'. The setting of ia64_platform
> to TRUE will execute function ia64_alloc_vector.
>
> This API is only used in assign_msi_vector()in msi.c:
>
> 	vector = (ia64_platform ? ia64_alloc_vector() :
> 		assign_irq_vector(MSI_AUTO));

I think we should just come up with a standard name here, i'm biased and
think it should be assign_irq_vector ;)

