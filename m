Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268751AbUJEDPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbUJEDPI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 23:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268759AbUJEDPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 23:15:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:1279 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S268751AbUJEDMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 23:12:53 -0400
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
	memory placement
From: Matthew Helsley <matthltc@us.ibm.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, dipankar@in.ibm.com,
       Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, efocht@hpce.nec.com,
       Martin Bligh <mbligh@aracnet.com>, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       Matthew Dobson <colpatch@us.ibm.com>, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
In-Reply-To: <415F3D4C.6060907@watson.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	 <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]>
	 <200408061730.06175.efocht@hpce.nec.com>
	 <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com>
	 <20041001164118.45b75e17.akpm@osdl.org>
	 <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com>
	 <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au>
	 <415F3D4C.6060907@watson.ibm.com>
Content-Type: text/plain
Message-Id: <1096946035.2673.769.camel@stark>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 04 Oct 2004 20:13:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-02 at 16:44, Hubertus Franke wrote:
<snip>
> along cpuset boundaries. If taskclasses are allowed to span disjoint
> cpumemsets, what is then the definition of setting shares ?
<snip>

	I think the clearest interpretation is the share ratios are the same
but the quantity of "real" resources and the sum of shares allocated is
different depending on cpuset.

	For example, suppose we have taskclass/A that spans cpusets Foo and Bar
-- processes foo and bar are members of taskclass/A but in cpusets Foo
and Bar respectively. Both get up to 50% share of cpu time in their
respective cpusets because they are in taskclass/A. Further suppose that
cpuset Foo has 1 CPU and cpuset Bar has 2 CPUs.

	This means process foo could consume up to half a CPU while process bar
could consume up to a whole CPU. In order to enforce cpuset
partitioning, each class would then have to track its share usage on a
per-cpuset basis. [Otherwise share allocation in one partition could
prevent share allocation in another partition. Using the example above,
suppose process foo is using 45% of CPU in cpuset Foo. If the total
share consumption is calculated across cpusets process bar would only be
able to consume up to 5% of CPU in cpuset Bar.]

Cheers,
	-Matt Helsley

