Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWBJMNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWBJMNX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWBJMNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:13:23 -0500
Received: from cantor.suse.de ([195.135.220.2]:16535 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750895AbWBJMNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:13:22 -0500
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Date: Fri, 10 Feb 2006 13:10:58 +0100
User-Agent: KMail/1.8.2
Cc: ashok.raj@intel.com, ntl@pobox.com, dada1@cosmosbay.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
References: <20060209160808.GL18730@localhost.localdomain> <200602101102.25437.ak@muc.de> <20060210024222.67db06f3.akpm@osdl.org>
In-Reply-To: <20060210024222.67db06f3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101310.59889.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 11:42, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > On Thursday 09 February 2006 19:04, Andrew Morton wrote:
> > > Ashok Raj <ashok.raj@intel.com> wrote:
> > > >
> > > > The problem was with ACPI just simply looking at the namespace doesnt
> > > >  exactly give us an idea of how many processors are possible in this platform.
> > > 
> > > We need to fix this asap - the performance penalty for HOTPLUG_CPU=y,
> > > NR_CPUS=lots will be appreciable.
> > 
> > What is this performance penalty exactly? 
> 
> All those for_each_cpu() loops will hit NR_CPUS cachelines instead of
> hweight(cpu_possible_map) cachelines.

But are there any in real fast paths? iirc they are mostly in initialization,
where it doesn't matter too much.

-Andi
