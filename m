Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbTJJAzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 20:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTJJAzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 20:55:35 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:63420 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262700AbTJJAzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 20:55:32 -0400
Date: Fri, 10 Oct 2003 01:55:22 +0100
From: Dave Jones <davej@redhat.com>
To: Nuno Monteiro <nmonteiro@uk2.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Re: linking problem with 2.6.0-test6-bk10
Message-ID: <20031010005521.GC25856@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nuno Monteiro <nmonteiro@uk2.net>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <42450.212.113.164.100.1065637962.squirrel@maxproxy1.uk2net.com> <20031008200420.GA23545@redhat.com> <57145.212.113.164.100.1065647937.squirrel@maxproxy3.uk2net.com> <20031009234000.GC4683@hobbes.itsari.int> <20031010004047.GE4683@hobbes.itsari.int> <20031010004224.GH4683@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010004224.GH4683@hobbes.itsari.int>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 01:42:24AM +0100, Nuno Monteiro wrote:

 > Got 5 minutes to look at this today, here is the proper fix. This allows 
 > to compile for Winchip when CONFIG_MTRR is off. The alternative would be
 > to pull in asm/mtrr.h and asm/errno.h, but it seems a bit overkill since
 > we only need mtrr_centaur_report_mcr.
 > 
 > Booted and working fine here on my small gateway box for the past hour.
 > Please apply.
 > 
 > +#ifndef CONFIG_MTRR
 > +static __inline__ void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi) {;}
 > +#endif
 > +

As well as looking pretty ugly, I can't convince myself this is safe.
I think it's going to be better off making that whole code compile out
if MTRRs are disabled. MTRR is a must-have if we want this code to actually
work anyway.

Either change the ifdef at the top of centaur.c to 
#ifdef CONFIG_X86_OOSTORE && CONFIG_MTRR, or futz around it in the
Kconfig, by changing the X86_OOSTORE depends line to

	depends on (MWINCHIP3D || MWINCHIP2 || MWINCHIPC6) && MTRR

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
