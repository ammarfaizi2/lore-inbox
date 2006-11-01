Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946952AbWKAR2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946952AbWKAR2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946953AbWKAR2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:28:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:8850 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1946952AbWKAR23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:28:29 -0500
Subject: Re: [PATCH] Add get_range, allows a hyhpenated range to get_options
From: Derek Fults <dfults@sgi.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
In-Reply-To: <20061101085722.18430d23.randy.dunlap@oracle.com>
References: <1162398157.9524.490.camel@lnx-dfults.americas.sgi.com>
	 <20061101085722.18430d23.randy.dunlap@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Nov 2006 11:29:04 -0600
Message-Id: <1162402145.9524.501.camel@lnx-dfults.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 08:57 -0800, Randy Dunlap wrote:
> On Wed, 01 Nov 2006 10:22:36 -0600 Derek Fults wrote:
> 
> > This allows a hyphenated range of positive numbers in the string passed
> > to command line helper function, get_options.    
> > Currently the command line option "isolcpus=" takes as its argument a
> > list of cpus.  
> > Format: <cpu number>,...,<cpu number>
> > This can get extremely long when isolating the majority of cpus on a
> > large system.  Valid values of <cpu_number>  include all cpus, 0 to
> > "number of CPUs in system - 1".
> > 
> > Signed-off-by: Derek Fults <dfults@sgi.com>  
> > 
> > Index: linux/lib/cmdline.c
> > ===================================================================
> > --- linux.orig/lib/cmdline.c	2006-09-19 22:42:06.000000000 -0500
> > +++ linux/lib/cmdline.c	2006-11-01 10:16:09.988659834 -0600
> > @@ -16,6 +16,21 @@
> >  #include <linux/kernel.h>
> >  #include <linux/string.h>
> >  
> > +/* If a hyphen was found in get_option, this will handle the 
> > + * range of numbers given. 
> 
> Still have trailing whitespace in the patch (2 lines above).
> 
> I think that this comment should explain that the M-N range
> is handled by expanding it to an array of [M, M+1, ..., N].
> 
How's this for a description?

/* If a hyphen was found in get_option, this will handle the
 * range of numbers, M-N.  This will expand the range and insert
 * the values[M, M+1, ..., N] into the ints array in get_options.
 */

Thanks,
Derek
