Return-Path: <linux-kernel-owner+w=401wt.eu-S1751318AbXAKS0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbXAKS0N (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 13:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbXAKS0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 13:26:13 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:17172 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbXAKS0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 13:26:12 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 2.6.21 0/8] ehca: remove use of do_mmap() from kernel space and minor cleanup
Date: Thu, 11 Jan 2007 19:22:27 +0100
User-Agent: KMail/1.8.2
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org,
       raisch@de.ibm.com
References: <200701111807.08593.hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200701111807.08593.hnguyen@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701111922.27474.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this. Pushed the send button to fast again.
Regards
Nam

On Thursday 11 January 2007 18:07, Hoang-Nam Nguyen wrote:
> Hello Roland and Christoph H.!
> Here is a set of patches for ehca, whose main purpose is to remove unproper use of
> do_mmap() in ehca kernel space as suggested by Christoph H. Other "small" changes
> are:
> * Remove "dead" prototype declarations (those without code implementation)
> * Use SLAB_ defines instead GFP_ ones when allocating memory from slab cache
> 
> Actually I should separate those patches for more clarity. Unfortunately that
> code cleanup above has been incorporated much earlier in our repository, and
> I had not paid attention on when I started to rework the mmap() stuff. Sorry
> for this inconvenience!
> 
> Now more detail on mmap() rework:
> - For eHCA hardware register block we use remap_pfn_range() as previously.
> - For queue pages we call pattern vm_insert_page() to register each allocated
> kernel page.
> - For each mmap-ed resource (hardware register block, send/recv and completion
> queue) we introduce a use counter that is incremented and decremented by
> the call-backs open()/close(). Destroying a completion queue or queue pair
> will succeed only if all associated counters are zero. That means those resources
> must be mmap-ed resp. munmap-ed properly by user space.
> 
> Thanks
> Nam
> 
