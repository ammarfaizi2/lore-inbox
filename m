Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVCSK44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVCSK44 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 05:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVCSK44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 05:56:56 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:55431 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262442AbVCSK4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 05:56:52 -0500
Date: Sat, 19 Mar 2005 10:56:32 +0000
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, Paul Mackerras <paulus@samba.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, riel@redhat.com, Ian.Pratt@cl.cam.ac.uk,
       kurt@garloff.de
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
Message-ID: <20050319105632.GH31328@cl.cam.ac.uk>
References: <E1DBsgI-0001Cg-00@mta1.cl.cam.ac.uk> <m1k6o40x0p.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k6o40x0p.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 03:07:18AM -0700, Eric W. Biederman wrote:
> For this specific case there may be another resolution but could
> you please, please look at marking the missing pages PG_reserved
> and not hacking phys_to_virt.
> 
> At this point anything short of explicitly introducing an intermediate
> step say virt_to_logical() logical_to_virt() will be extremely
> confusing and lead to very hard to spot bugs.  Silently changing
> the semantics of functions is bad.

We also use the additional level of indirection to implement suspend/
resume and relocation of virtual machines between physical machines  --
you won't get the same sparse allocation of memory on the target machine.
Also, this will make it much easier to support hot plug memory at the
hypervisor level since it will be able to substitute memory with very
little support from the OS running in the virtual machine.
I agree that adding an additional step would make this much cleaner.

    christian

