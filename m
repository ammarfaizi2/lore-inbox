Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVCCWgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVCCWgY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVCCWdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:33:55 -0500
Received: from ozlabs.org ([203.10.76.45]:20405 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262703AbVCCWaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:30:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16935.36862.137151.499468@cargo.ozlabs.ibm.com>
Date: Fri, 4 Mar 2005 09:30:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Rene Rebe <rene@exactcode.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
In-Reply-To: <422756DC.6000405@pobox.com>
References: <422751D9.2060603@exactcode.de>
	<422756DC.6000405@pobox.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Rene Rebe wrote:
> > Hi,
> > 
> > 
> > --- linux-2.6.11/drivers/md/raid6altivec.uc.vanilla    2005-03-02 
> > 16:44:56.407107752 +0100
> > +++ linux-2.6.11/drivers/md/raid6altivec.uc    2005-03-02 
> > 16:45:22.424152560 +0100
> > @@ -108,7 +108,7 @@
> >  int raid6_have_altivec(void)
> >  {
> >      /* This assumes either all CPUs have Altivec or none does */
> > -    return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
> > +    return cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC;
> 
> 
> I nominate this as a candidate for linux-2.6.11 release branch.  :)

No.  Unfortunately if you fix ppc64 here you will break ppc, and vice
versa.  Yes, we are going to reconcile the cur_cpu_spec definitions
between ppc and ppc64. :)

Paul.
