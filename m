Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbUKIDqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbUKIDqB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 22:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbUKIDqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 22:46:01 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:56053 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261200AbUKIDpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 22:45:49 -0500
Subject: Re: [RFC/PATCH 0/4] cpus, nodes, and the device model: dynamic cpu
	registration
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, rusty@rustcorp.com.au,
       mochel@digitalimplant.org, anton@samba.org
In-Reply-To: <20041104170902.A8747@unix-os.sc.intel.com>
References: <20041024094551.28808.28284.87316@biclops>
	 <20041104170902.A8747@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Mon, 08 Nov 2004 21:45:48 -0600
Message-Id: <1099971948.8723.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 17:09 -0800, Ashok Raj wrote:
> On Sun, Oct 24, 2004 at 03:42:10AM -0600, Nathan Lynch wrote:
> > 
> > Finally, I've added two new interfaces which wrap all this up --
> > cpu_add() and cpu_remove().  These carry out the necessary update to
> > cpu_present_map and take care of the cpu device registration.  These
> > are meant to be invoked from the platform-specific code which
> > discovers and removes processors.
> 
> I think you want the device registration that create the sysfs file to the 
> arch code.

No, I don't think the arch code should be registering the cpu devices
(or the node devices).  There is very little that is arch-specific about
these, and the same code is more or less duplicated between the
architectures.

>  If you look at the ACPI extensions to support physical cpu hotplug
> we need to keep track of the acpi->logical association. so all we really need
> is a bit off the bitmap, but the cpu is not yet ready for operation yet.

I see your point here, though, and I'm slightly embarrassed I forgot
that ppc64 has similar needs.  What is needed is an arch-specific
__cpu_add which is called from cpu_add after the new cpu's bit has been
reserved, and which sets up the architecture's physical<->logical
associations or whatever.  This follows the convention established in
the existing cpu code and keeps the manipulation of cpu_present_map in
one place.

I'll incorporate this in my next attempt.


Nathan

