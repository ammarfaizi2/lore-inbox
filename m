Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbUKIDpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUKIDpw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 22:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUKIDpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 22:45:52 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:442 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261168AbUKIDpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 22:45:46 -0500
Subject: Re: [RFC/PATCH 1/4] dynamic cpu registration - core changes
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, rusty@rustcorp.com.au,
       mochel@digitalimplant.org, anton@samba.org
In-Reply-To: <20041104175125.A9271@unix-os.sc.intel.com>
References: <20041024094551.28808.28284.87316@biclops>
	 <20041024094559.28808.12445.63352@biclops>
	 <20041104175125.A9271@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Mon, 08 Nov 2004 21:45:47 -0600
Message-Id: <1099971947.8723.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 17:51 -0800, Ashok Raj wrote:
> On Sun, Oct 24, 2004 at 05:42:17AM -0400, Nathan Lynch wrote:
> > 
> > +	/* XXX FIXME: cpu->no_control is always zero...
> > +	 * Maybe should introduce an arch-overridable "hotpluggable" map.
> > +	 */

> Iam getting obsessed with these __attribute__((weak)) these days...:-)
> 
> simple solution seems like you can have a platform_prefilter() and post_filter() declared
> in the core with weak atteibute, and let the platform that cares about this provide an override
> function. So if you need to hang off additional files for platform this can be handy. so for
> ppc64, based on LPAR or not, you can add these no_control flag before the file is created?

I'm not sure using weak symbols is the way to take care of the
'no_control' field.  I think having the arch implement a
__register_cpu(struct cpu*) helper which sets the the 'no_control'
attribute should be sufficient.  E.g. IA64 and i386 implementations of
__register_cpu would set no_control=1 if the cpu is the boot processor.

With respect to the general issue of adding sysfs attributes to the cpu
devices, that's simply a matter of coding up a sysdev_driver as I did in
the node and ppc64 code in the other patches.


Nathan

