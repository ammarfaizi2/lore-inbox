Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316836AbSFVEzI>; Sat, 22 Jun 2002 00:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316837AbSFVEzI>; Sat, 22 Jun 2002 00:55:08 -0400
Received: from holomorphy.com ([66.224.33.161]:1733 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316836AbSFVEzH>;
	Sat, 22 Jun 2002 00:55:07 -0400
Date: Fri, 21 Jun 2002 21:54:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Matthew D. Pitts" <mpitts@suite224.net>
Cc: Rob Landley <landley@trommello.org>,
       Martin Dalecki <dalecki@evision-ventures.com>,
       Linus Torvalds <torvalds@transmeta.com>, Cort Dougan <cort@fsmlabs.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin.Bligh@us.ibm.com, colpatch@us.ibm.com, cleverdj@us.ibm.com
Subject: Re: (RFC)i386 arch autodetect( was Re: latest linus-2.5 BK broken )
Message-ID: <20020622045414.GF22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Matthew D. Pitts" <mpitts@suite224.net>,
	Rob Landley <landley@trommello.org>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Cort Dougan <cort@fsmlabs.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Benjamin LaHaise <bcrl@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin.Bligh@us.ibm.com, colpatch@us.ibm.com, cleverdj@us.ibm.com
References: <Pine.LNX.4.44.0206201428481.8225-100000@home.transmeta.com> <3D125032.3040809@evision-ventures.com> <200206220300.g5M30VO354182@pimout4-int.prodigy.net> <000c01c219a0$ffc72c20$adf583d0@pcs686>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <000c01c219a0$ffc72c20$adf583d0@pcs686>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 11:57:57PM -0400, Matthew D. Pitts wrote:
> Is there any plan to rewrite the i386 architecture to support auto-detection
> of cpu's? Given the nature of the discussion here, that is something I would
> love to tackle.

Probably more urgent are APIC drivers as it seems too many people are
trying to stuff flat bitmasks into ICR2 and other places directly and
breaking things. Also, the understanding of the fact that if flat
logical mode is being used that no cpu's beyond #7 can be addressed
would be nice to have, if only for a more graceful failure mode than
deadlock in flush_tlb_all() and/or cpu wakeup code when more cpu's
than the configured APIC mode can address are present. Perhaps afterward
a dynamic understanding of when the clustered hierarchical destination
format is required can be explored, involving dynamically switching
between flat destination format with logical ID's and clustered
hierarchical destination format with logical ID's and physical ID's for
cluster-local IPI's. On the NUMA-Q, the arrangement of cluster ID's is
dynamically configurable allowing one to configure each cluster so that
the broadcast cluster ID clashes only with the local cluster, and so
64 cpu's may be addressed as cluster-local IPI's may be done physically.

Cheers,
Bill
