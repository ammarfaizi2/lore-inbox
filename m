Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266065AbUHIFKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbUHIFKr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 01:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUHIFKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 01:10:47 -0400
Received: from mailhub.hp.com ([192.151.27.10]:1766 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S266065AbUHIFKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 01:10:45 -0400
Subject: Re: [PATCH] cleanup ACPI numa warnings
From: Alex Williamson <alex.williamson@hp.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092027151.6496.13709.camel@nighthawk>
References: <1091738798.22406.9.camel@tdi>
	 <1091739702.31490.245.camel@nighthawk> <1091741142.22406.28.camel@tdi>
	 <249150000.1091763309@[10.10.2.4]>
	 <20040805205059.3fb67b71.rddunlap@osdl.org>
	 <20040807105729.6adea633.pj@sgi.com>
	 <20040808143631.7c18cae9.rddunlap@osdl.org>
	 <1092025184.2292.26.camel@localhost.localdomain>
	 <1092027151.6496.13709.camel@nighthawk>
Content-Type: text/plain
Date: Sun, 08 Aug 2004 23:10:38 -0600
Message-Id: <1092028238.2211.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-08 at 21:52 -0700, Dave Hansen wrote:
> On Sun, 2004-08-08 at 21:19, Alex Williamson wrote:
> >    Ok, I was all set to switch to static inlines, but it doesn't work.
> > Compiling w/ debug on, _dbg is undefined, which is part of the
> > ACPI_DB_INFO macro, but it only gets setup by the ACPI_FUNCTION_NAME
> > macro.  Guess I got lucky by choosing to do it as a macro.  IMHO, it
> > doesn't really make sense to make the static inline functions more
> > complicated or hide where they're getting called to make this all work.
> > So, I think the choices are to stick with the ugly macros or put #ifdefs
> > around the code and essentially leave it the way it is.  Sorry I didn't
> > give it a more thorough look when originally questioned.  Better ideas?
> > Thanks,
> 
> That code is already pretty hideous, so perhaps my original question
> doesn't have that much impact.  The attached patch at least uses inline
> functions.  It still has the #ifdefs, but what else do you expect for
> debugging code?  Is this a feasible approach?

   If you build with CONFIG_ACPI_DEBUG=y, you'll see the problem I was
trying to describe above with this approach.

drivers/acpi/numa.c: In function `acpi_print_srat_processor_affinity':
drivers/acpi/numa.c:44: error: `_dbg' undeclared (first use in this function)
drivers/acpi/numa.c:44: error: (Each undeclared identifier is reported only once
drivers/acpi/numa.c:44: error: for each function it appears in.)
drivers/acpi/numa.c: At top level:
drivers/acpi/numa.c:48: error: parse error before '}' token
drivers/acpi/numa.c: In function `acpi_print_srat_memory_affinity':
drivers/acpi/numa.c:52: error: `_dbg' undeclared (first use in this function)
drivers/acpi/numa.c: At top level:
drivers/acpi/numa.c:58: error: parse error before '}' token
make[2]: *** [drivers/acpi/numa.o] Error 1
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2


