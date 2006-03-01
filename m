Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWCAKrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWCAKrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWCAKrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:47:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48870 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964920AbWCAKrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:47:15 -0500
Date: Wed, 1 Mar 2006 02:45:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: jgarzik@pobox.com, pavel@ucw.cz, randy_d_dunlap@linux.intel.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
Message-Id: <20060301024559.2f36ecda.akpm@osdl.org>
In-Reply-To: <4405778D.2030001@superbug.co.uk>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
	<20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com>
	<20060228114500.GA4057@elf.ucw.cz>
	<44043B4E.30907@pobox.com>
	<20060228041817.6fc444d2.akpm@osdl.org>
	<4405778D.2030001@superbug.co.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton <James@superbug.co.uk> wrote:
>
> Is there a particular debugging coding style that we should adopt for
>  all the kernel code.

Err, probably.  But we'd need to have a 1000-email argument first.

Right now many subsystems and often many individual drivers go and
implement their own set of debugging macros and knobs to twiddle.  This was
a great source of fun for me in trying to support gcc-2.95.x - each time a
new debug macro got implemented I had to go in there (again) and apply the
gcc-2.95.x-macro-expansion-bug-workaround to it.

Yes, one common toolset with a common way of controlling it would be much
more sensible than the present chaos.  I count 163 separate definitions of
dprintk(), and that's excluding all the non-x86 arch and include dirs.

>  For example,
>  kconfig option in order to compile a module/section of core code for
>  debug work.
>  A sysfs file to then control the debug level for each module.
>  A debug module option, in the cases where a particular level of debug is
>  required at module load time, and before the sysfs entry exists.
>  If particularly fine grained debug control is needed, the module could
>  have multiple entries in the sysfs to control different classes of debug
>  output.
> 

Something like that..   Just don't cc me while you work it out ;)
