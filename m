Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVCCXQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVCCXQb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVCCXHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:07:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34706 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262718AbVCCXFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:05:33 -0500
Date: Thu, 3 Mar 2005 18:05:23 -0500
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
       Rene Rebe <rene@exactcode.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
Message-ID: <20050303230523.GB5448@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
	Rene Rebe <rene@exactcode.de>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <422751D9.2060603@exactcode.de> <422756DC.6000405@pobox.com> <16935.36862.137151.499468@cargo.ozlabs.ibm.com> <20050303224515.GA16567@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303224515.GA16567@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 02:45:15PM -0800, Greg KH wrote:
 > On Fri, Mar 04, 2005 at 09:30:22AM +1100, Paul Mackerras wrote:
 > > Jeff Garzik writes:
 > > > Rene Rebe wrote:
 > > > > Hi,
 > > > > 
 > > > > 
 > > > > --- linux-2.6.11/drivers/md/raid6altivec.uc.vanilla    2005-03-02 
 > > > > 16:44:56.407107752 +0100
 > > > > +++ linux-2.6.11/drivers/md/raid6altivec.uc    2005-03-02 
 > > > > 16:45:22.424152560 +0100
 > > > > @@ -108,7 +108,7 @@
 > > > >  int raid6_have_altivec(void)
 > > > >  {
 > > > >      /* This assumes either all CPUs have Altivec or none does */
 > > > > -    return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
 > > > > +    return cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC;
 > > > 
 > > > 
 > > > I nominate this as a candidate for linux-2.6.11 release branch.  :)
 > > 
 > > No.  Unfortunately if you fix ppc64 here you will break ppc, and vice
 > > versa.  Yes, we are going to reconcile the cur_cpu_spec definitions
 > > between ppc and ppc64. :)
 > 
 > Fine, dueling arches, who wins?  :)
 > 
 > So, what do I do, just ignore the patch?  Or do you have a fix?

until its fixed properly, how about this ?

+#ifdef CONFIG_PPC64
     return cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC;
+#else
+    return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
+#endif


Brings about an interesting conundrum with teh 2.6.x.y branch.
If fixing something properly is invasive, would we want to allow
band-aids to get things working ? This would make things more difficult
wrt Linus being able to pull the previous .y branch into his current
tree, but bitkeepers conflict resolution is really unsurpassed for
such situations in my experience.

		Dave

