Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVF2PgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVF2PgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVF2PgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:36:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:57218 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261358AbVF2Pcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:32:35 -0400
Subject: Re: [PATCH 10/13]: PCI Err: PPC64-specific recovery infrastructure
From: John Rose <johnrose@austin.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Me Notes <johnrose@us.ibm.com>
In-Reply-To: <20050628235956.GA6455@austin.ibm.com>
References: <20050628235956.GA6455@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1120058918.19616.4.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Jun 2005 10:28:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend, dropped cc's)

Hi Linas-

The new functions eeh_report_error, eeh_report_reset,
eeh_report_resume, eeh_report_failure, eeh_reset_device, and
handle_eeh_events do not belong in this driver, imho.  Most of them
have nothing to do with PCI hotplug (eeh_report_*).  The ones that do
are clients of the enable/disable functionality, and as such are not
part of the actual hotplug implementation.  In my mind, it makes sense
to logically separate things when poissible.  I'm currently making an
effort to reduce bloat in this driver, and this would add to it.

The functions eeh_report_*, along with the handling routines, could
just as easily exist in the kernel or in a 3rd module
(drivers/pci/hotplug/rpaphp_pcierr.ko?).  You've suggested the third
module idea before, and I think it makes more sense than lumping this
in w/ rpaphp.  You could export [enable,disable]_slot from rpaphp, and
have a module dependency, similar to rpadlpar_io.

Thanks-
John

On Tue, 2005-06-28 at 18:59, Linas Vepstas wrote:
> pci-err-10-ppc64.patch
> 
> Implements ppc64-specific parts of detecting PCI bus errors,
> (via calls to the firmware to ask the hardware pci bridges)
> and the related mechanisms for reseting the affects PCI
> slots (again, via firmware calls).
> 
> Signed-off-by: Linas Vepstas <linas@linas.org>
> 
> ______________________________________________________________________
> _______________________________________________
> Linuxppc64-dev mailing list
> Linuxppc64-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc64-dev

