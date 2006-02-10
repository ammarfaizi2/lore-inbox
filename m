Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWBJKqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWBJKqi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWBJKqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:46:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751339AbWBJKqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:46:37 -0500
Date: Fri, 10 Feb 2006 02:42:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: ashok.raj@intel.com, ntl@pobox.com, dada1@cosmosbay.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060210024222.67db06f3.akpm@osdl.org>
In-Reply-To: <200602101102.25437.ak@muc.de>
References: <20060209160808.GL18730@localhost.localdomain>
	<20060209090321.A9380@unix-os.sc.intel.com>
	<20060209100429.03f0b1c3.akpm@osdl.org>
	<200602101102.25437.ak@muc.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Thursday 09 February 2006 19:04, Andrew Morton wrote:
> > Ashok Raj <ashok.raj@intel.com> wrote:
> > >
> > > The problem was with ACPI just simply looking at the namespace doesnt
> > >  exactly give us an idea of how many processors are possible in this platform.
> > 
> > We need to fix this asap - the performance penalty for HOTPLUG_CPU=y,
> > NR_CPUS=lots will be appreciable.
> 
> What is this performance penalty exactly? 

All those for_each_cpu() loops will hit NR_CPUS cachelines instead of
hweight(cpu_possible_map) cachelines.

> It wastes quite some memory (each possible CPU needs 32K of memory which
> adds quickly up), but it shouldn't impact other CPU use. 
> 
> > 
> > Do any x86 platforms actually support CPU hotplug?
> 
> Xen does.

yup.

> And it's needed for suspend/resume on normal x86 now.

True.
