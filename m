Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281779AbRLOCb7>; Fri, 14 Dec 2001 21:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281823AbRLOCbu>; Fri, 14 Dec 2001 21:31:50 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:32624 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281779AbRLOCbn>; Fri, 14 Dec 2001 21:31:43 -0500
Date: Fri, 14 Dec 2001 21:31:42 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: zap_page_range in a module
Message-ID: <20011214213142.A28867@redhat.com>
In-Reply-To: <C8C7DD4157F2D411AC7000A0C96B1522016C37D8@fmsmsx58.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <C8C7DD4157F2D411AC7000A0C96B1522016C37D8@fmsmsx58.fm.intel.com>; from matthew.j.sottek@intel.com on Fri, Dec 14, 2001 at 06:10:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2001 at 06:10:52PM -0800, Sottek, Matthew J wrote:
> >The vm does zap_page_range for you if you're implementing an
> >mmap operation, 
> 
> It only does zap_page_range() when the memory map is being
> removed right?

Right.

> I have a 64k sliding "window" into a 1MB region. You can only access
> 64k at a time then you have to switch the "bank" to access the next
> 64k. Address 0xa0000-0xaffff is the 64k window. The actual 1MB of
> memory is above the top of memory and not directly addressable by the
> CPU, you have to go through the banks.

Stop right there.  You can't do that.  The code will deadlock on page 
faults for certain usage patterns.  It's slow, inefficient and a waste 
of effort.

		-ben
-- 
Fish.
