Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVAYAar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVAYAar (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVAYAaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:30:15 -0500
Received: from mta01.pge.com ([131.89.129.71]:36258 "EHLO mta01.pge.com")
	by vger.kernel.org with ESMTP id S261729AbVAXXUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:20:36 -0500
Date: Mon, 24 Jan 2005 15:12:44 -0800
From: Edward Peschko <esp5@pge.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: gcc@gcc.gnu.org, binutils@sources.redhat.com, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Re: forestalling GNU incompatibility - proposal for binary relative dynamic linking
Message-ID: <20050124231244.GB19422@venus>
References: <20050124222449.GB16078@venus> <200501241808.52092.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501241808.52092.vapier@gentoo.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 06:08:52PM -0500, Mike Frysinger wrote:
> On Monday 24 January 2005 05:24 pm, Edward Peschko wrote:
> > After spending *two weeks* on various ways of building glibc,
> > I'm convinced that the gnu/linux toolchain is in great danger of
> > losing interoperability.
> 
> sounds like what you want is already being tackled by OSDL and their Binary 
> Regression Testing group ...
> http://groups.osdl.org/apps/group_public/workgroup.php?wg_abbrev=binary_sig
> http://www.osdl.org/docs/isv_issues_and_binary_testing.pdf
> -mike

well of course the osdl is going to focus on this, but they need tools
and functionality to do it correctly.. 

In particular, the statement 'Vendor lock-in (at any level) is not 
desirable' is false - there *is* vendor lock-in, and the suggestion 
of relative pathing for LD_LIBRARY_PATH is just one way to migrate 
back to doing things the right way.


Distributions are basically hoist by their own petard - they need to 
support old legacy executables, which have nonstandard glibc's. And since
they need to support legacy executables in the past, they need 
to support them in the future.


What I'd envision is that the distributions split basically into two: 
executables using the old style glibc/libraries, and executables using the 
new, standard glibcs. There would be two paths,


	/usr/bin

and

	/usr/standard/bin


The first directory would contain old executables which haven't been ported to
the standard glibc. The second would contain executables that have. The relative
pathing in LD_LIBRARY_PATH would insure that each tree used the correct libraries.


In the process of making /usr/standard/bin, linux vendors would need
to make their rpms both path-neutral and build clean. However, they would
*not* need to hold up their release process until everything is ported - 
they could pick and choose which applications were the most important to 
port. Ultimately, /usr/standard/bin would go away, and be moved back to 
/usr/bin, and perhaps the cycle could begin again, with upgrades going into 
a new /usr/standard/bin.

Ed

