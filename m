Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbUJ0SNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbUJ0SNo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbUJ0SJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:09:03 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:26584 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262518AbUJ0SIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:08:01 -0400
Date: Wed, 27 Oct 2004 11:06:42 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Robin Holt <holt@sgi.com>
cc: Jesse Barnes <jbarnes@sgi.com>, William Lee Irwin III <wli@holomorphy.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
In-Reply-To: <20041026143513.GC28391@lnx-holt.americas.sgi.com>
Message-ID: <Pine.LNX.4.58.0410271103500.18165@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
 <20041026022322.GD17038@holomorphy.com> <200410251940.30574.jbarnes@sgi.com>
 <20041026143513.GC28391@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004, Robin Holt wrote:

> Sorry for being a stickler here, but the BTE is really part of the
> I/O Interface portion of the shub.  That portion has a seperate clock
> frequency from the memory controller (unfortunately slower).  The BTE
> can zero at a slightly slower speed than the processor.  It does, as
> you pointed out, not trash the CPU cache.
>
> One other feature of the BTE is it can operate asynchronously from
> the cpu.  This could be used to, during a clock interrupt, schedule
> additional huge page zero filling on multiple nodes at the same time.
> This could result in a huge speed boost on machines that have multiple
> memory only nodes.  That has not been tested thoroughly.  We have done
> considerable testing of the page zero functionality as well as the
> error handling.

If the huge patch would support some way of redirecting the clearing of a
huge page then we could:

1. set the huge pte to not present so that we get a fault on access
2. run the bte clearer.
3. On receiving a huge fault we could check for the bte being finished.

This would parallelize the clearing of huge pages. But is that really more
efficient? There may be complexity involved in allowing the clearing of
multiple pages and tracking of the clear in progress is additional
overhead.


