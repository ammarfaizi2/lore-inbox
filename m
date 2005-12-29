Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbVL2Abc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVL2Abc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVL2Abc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:31:32 -0500
Received: from dsl092-073-214.bos1.dsl.speakeasy.net ([66.92.73.214]:50138
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S932561AbVL2Abb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:31:31 -0500
Date: Wed, 28 Dec 2005 19:30:25 -0500
From: Sonny Rao <sonny@burdell.org>
To: Nathan Lynch <ntl@pobox.com>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, clameter@sgi.com, anton@samba.org,
       shai@scalex86.org, sonnyrao@us.ibm.com, alokk@calsoftinc.com
Subject: Re: cpu hotplug oops on 2.6.15-rc5
Message-ID: <20051229003025.GA30666@kevlar.burdell.org>
References: <20051219051659.GA6299@kevlar.burdell.org> <20051222092743.GE3915@localhost.localdomain> <20051222173700.GA5723@localhost.localdomain> <20051222175311.GA22393@kevlar.burdell.org> <20051222183750.GA3704@localhost.localdomain> <20051222194511.GB24385@kevlar.burdell.org> <20051228193012.GF12674@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228193012.GF12674@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 01:30:12PM -0600, Nathan Lynch wrote:
> I wonder if this is related to the problem Sonny is seeing -- powerpc's
> definitions of cpu_to_node et al. are not being used.  The culprit is
> some too-clever preprocessor usage in asm-generic/topology.h, for
> example:
> 
> 
> #ifndef cpu_to_node
> #define cpu_to_node(cpu)	(0)
> #endif
> 
> But asm-powerpc/topology.h has cpu_to_node defined as a static inline
> (which does not make it a preprocessor symbol), so we get the generic
> - and incorrect - definition.
> 
> Does removing the #include of asm-generic/topology.h from the bottom
> of asm-powerpc/topology.h have any effect?

Hi, no it doesn't make a difference.  That include is protected by
CONFIG_NUMA as well, so it never gets hit.  At Anton's suggestion I
even put in an #error into asm-generic/topology.h to make sure it
wasn't an issue -- it didn't hit.

Sonny
