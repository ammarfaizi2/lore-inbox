Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWBJKNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWBJKNr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWBJKNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:13:47 -0500
Received: from cantor.suse.de ([195.135.220.2]:12680 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750848AbWBJKNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:13:46 -0500
From: Andi Kleen <ak@muc.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Date: Fri, 10 Feb 2006 11:13:12 +0100
User-Agent: KMail/1.8.2
Cc: Nathan Lynch <ntl@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Eric Dumazet <dada1@cosmosbay.com>, riel@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       76306.1226@compuserve.com, wli@holomorphy.com,
       Paul Jackson <pj@sgi.com>, jbeulich@novell.com,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
References: <200602051959.k15JxoHK001630@hera.kernel.org> <20060209173726.GA39278@muc.de> <20060210100521.GA9307@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060210100521.GA9307@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101113.13632.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[putting some Xen people into cc]

On Friday 10 February 2006 11:05, Heiko Carstens wrote:
> > > > powerpc/ppc64, for instance, determines the number of possible cpus
> > > > from information exported by firmware (and I'm mystified as to why
> > > > other platforms don't do this).  So it's typical to have a kernel an a
> > > > pSeries partition with NR_CPUS=128, but cpu_possible_map = 0xff.
> > > 
> > > Simply because there is no such interface on s390. The only thing we know
> > > for sure is that if we are running under z/VM the user is free to
> > > configure up to 63 additional virtual cpus on the fly...
> > 
> > x86-64 had the same problem, but we now require that you 
> > boot with additional_cpus=... for how many you want. Default is 0
> > (used to be half available CPUs but that lead to confusion)
> 
> So introducing the additional_cpus kernel parameter seems to be the way
> to go (for XEN probably too). Even though it seems to be a bit odd if the
> user specifies both maxcpus=... and additional_cpus=...

With additional_cpus you don't need maxcpus. They are added together.

Also for Xen it's probably not needed by default, but the hypervisor can somehow
pass it (it doesn't make sense to have more vcpus than real cpus
and that should be relatively small number, so the memory waste
shouldn't be that bad). 

On x86-64 there is also a new firmware
way to specify it, but current machines don't support that yet.

-Andi
