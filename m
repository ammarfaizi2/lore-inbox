Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUCQUxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUCQUxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:53:09 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:50138 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262062AbUCQUxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:53:06 -0500
Subject: Re: boot time node and memory limit options
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Robert Picco <Robert.Picco@hp.com>, Jesse Barnes <jbarnes@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Dobson <colpatch@us.ibm.com>
In-Reply-To: <2611830000.1079552673@[10.10.2.4]>
References: <4057392A.8000602@hp.com> <20040316174329.GA29992@sgi.com>
	 <34060000.1079465992@flay> <405879BC.7060904@hp.com>
	 <1745150000.1079541412@[10.10.2.4]> <4058A75A.3080409@hp.com>
	 <2611830000.1079552673@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1079556766.5789.593.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Mar 2004 12:52:47 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-17 at 11:44, Martin J. Bligh wrote:
> Yes ... that's looking very 2.7-ish to reorganise all that stuff.
> However, for now, I still think we need to restrict memory very early
> on, before anything else can allocate bootmem. Are you the absolute
> first thing that ever runs in the boot allocator?

I definitely agree with the 2.7 target for what I posted.  We can do it
cleanly in 2.7, but for now, I think the most best solution is to do it
in each architecture.  Partly because it's the way that we already do
mem=, plus I'm not sure the boot allocator code will work with all
architectures, at least ppc64.  

It's probably an oversight in the implementation (of the early ppc64
boot code), but there is some required correlation required with things
like lmb_end_of_DRAM() and how much memory is being used by the mm
structures.  I've played with it a bit, and I _think_ that you would be
required to modify the lmb structures, even with Robert's bootmem patch.

I could be wrong, so can somebody test it on a NUMA ppc64 machine?

Also, it may have been discussed before, but does the bootmem patch have
any applicability to the 32-bit NUMA platforms?  It looks like it just
deals with ZONE_DMA.

-- dave

