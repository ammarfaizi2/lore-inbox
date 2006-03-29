Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWC2Wvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWC2Wvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWC2Wvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:51:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2990 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751025AbWC2Wvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:51:39 -0500
Date: Wed, 29 Mar 2006 17:51:30 -0500
From: Dave Jones <davej@redhat.com>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Move pSeries firmware feature setup into platforms/pseries
Message-ID: <20060329225130.GG452@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michael Ellerman <michael@ellerman.id.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
References: <200603230714.k2N7EmH1021685@hera.kernel.org> <20060329195212.GA19236@redhat.com> <1143671955.23392.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143671955.23392.3.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 09:39:15AM +1100, Michael Ellerman wrote:
 > On Wed, 2006-03-29 at 14:52 -0500, Dave Jones wrote:
 > > On Thu, Mar 23, 2006 at 07:14:49AM +0000, Linux Kernel wrote:
 > >  > commit 1965746bce49ddf001af52c7985e16343c768021
 > >  > tree d311fce31613545f3430582322d66411566f1863
 > >  > parent 0941d57aa7034ef7010bd523752c2e3bee569ef1
 > >  > author Michael Ellerman <michael@ellerman.id.au> Fri, 10 Feb 2006 15:47:36 +1100
 > >  > committer Paul Mackerras <paulus@samba.org> Fri, 10 Feb 2006 16:52:03 +1100
 > >  > 
 > >  > [PATCH] powerpc: Move pSeries firmware feature setup into platforms/pseries
 > >  > 
 > >  > Currently we have some stuff in firmware.h and kernel/firmware.c that is
 > >  > #ifdef CONFIG_PPC_PSERIES. Move it all into platforms/pseries.
 > > 
 > > This (or one of the other firmware patches, I've not narrowed it down that close)
 > > breaks ppc64 oprofile.
 > > 
 > > modpost now complains with..
 > > 
 > > kernel/arch/powerpc/oprofile/oprofile.ko needs unknown symbol ppc64_firmware_features
 > 
 > Hi Dave,
 > 
 > I'm not sure about that patch, but I think the firmware feature stuff
 > has been broken for modules for a while, we weren't exporting
 > ppc64_firmware_features anywhere.

It's bizarre that it's only just started complaining about it.
(I get a nice mail from our buildsystem when a kernel package is built with
 unresolved symbols), and the 2.6.16.1 kernel happily sails through.

 > The fix just got merged in the last day or so:
 > http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d0160bf0b3e87032be8e85f80ddd2f18e107b86f

still broken with that diff. (I just tested -git15)

firmware_has_feature() needs fixing up.

		Dave


-- 
http://www.codemonkey.org.uk
