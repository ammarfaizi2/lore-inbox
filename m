Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUK2Ayy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUK2Ayy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 19:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUK2Ayy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 19:54:54 -0500
Received: from ozlabs.org ([203.10.76.45]:21952 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261611AbUK2Ayw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 19:54:52 -0500
Date: Mon, 29 Nov 2004 11:50:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc64-dev@ozlabs.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PPC64] Tweaks to ppc64 cpu sysfs information
Message-ID: <20041129005033.GB4155@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc64-dev@ozlabs.org,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041126035959.GK11370@zax> <1101679091.25347.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101679091.25347.9.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 08:58:11AM +1100, Paul 'Rusty' Russell wrote:
> On Fri, 2004-11-26 at 14:59 +1100, David Gibson wrote:
> > Andrew, please apply:
> > 
> > Currently the ppc64 sysfs code registers an entry for each possible
> > cpu in sysfs, rather than just online cpus.  That makes sense, since
> > the sysfs entries are needed to control onlining of the cpus.
> > However, this is done even if CONFIG_HOTPLUG_CPU is not set, or if it
> > is not a hotplug capable (DLPAR) machine, which is a bit misleading.
> > Secondly it also registers all the other sysfs entries (mostly
> > performance monitoring controls) on all possible cpus, although they
> > are quite meaningless on non-online cpus.
> 
> Surely if !CONFIG_HOTPLUG_CPU, then online == possible?  If not, it
> should be.  That would solve part of the problem.

No, it's not.  Yes, it probably should be.  I thought about, but
wasn't sure what other consequences that might have.  I figured my
patch would definitely fix some things, and there's actually less
overlap with setting online==possible than you might think, partly
because my patch will do the right thing if we ever have systems with
some CPUs on/offlineable and others not.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
