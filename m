Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbUJZOf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbUJZOf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUJZOf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:35:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:13028 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262283AbUJZOfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:35:42 -0400
Date: Tue, 26 Oct 2004 09:35:13 -0500
From: Robin Holt <holt@sgi.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Lameter <clameter@sgi.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
Message-ID: <20041026143513.GC28391@lnx-holt.americas.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com> <20041026022322.GD17038@holomorphy.com> <200410251940.30574.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410251940.30574.jbarnes@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 07:40:30PM -0700, Jesse Barnes wrote:
> On Monday, October 25, 2004 7:23 pm, William Lee Irwin III wrote:
> > On Mon, Oct 25, 2004 at 06:26:42PM -0700, Christoph Lameter wrote:
> > > - Clearing hugetlb pages is time consuming using clear_highpage in
> > > alloc_huge_page. Make it possible to use hw assist via DMA or so there?
> >
> > It's possible, but it's been found not to be useful. What has been found
> > useful is assistance from much lower-level memory hardware of a kind
> > not to be had in any extant mass-manufactured machines.
> 
> Do you have examples?  SGI hardware has a so-called 'BTE' (for Block Transfer 
> Engine) that can arbitrarily zero or copy pages w/o CPU assistance.  It's 
> builtin to the memory controller.  Using it to zero the pages has the 
> advantages of being asyncrhonous and not hosing the CPU cache.
> 

Jesse,

Sorry for being a stickler here, but the BTE is really part of the
I/O Interface portion of the shub.  That portion has a seperate clock
frequency from the memory controller (unfortunately slower).  The BTE
can zero at a slightly slower speed than the processor.  It does, as
you pointed out, not trash the CPU cache.

One other feature of the BTE is it can operate asynchronously from
the cpu.  This could be used to, during a clock interrupt, schedule
additional huge page zero filling on multiple nodes at the same time.
This could result in a huge speed boost on machines that have multiple
memory only nodes.  That has not been tested thoroughly.  We have done
considerable testing of the page zero functionality as well as the
error handling.

Robin
