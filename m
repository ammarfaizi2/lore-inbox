Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264103AbUESIIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbUESIIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 04:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264105AbUESIIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 04:08:52 -0400
Received: from holomorphy.com ([207.189.100.168]:648 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264103AbUESIIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 04:08:51 -0400
Date: Wed, 19 May 2004 01:08:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: pte_addr_t size reduction for 64 GB case?
Message-ID: <20040519080845.GF1223@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, riel@redhat.com
References: <1084941731.955.836.camel@cube> <20040519004424.72f5eb9e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519004424.72f5eb9e.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sourceforge.net> wrote:
>> When handling 64 GB on i386, pte_addr_t really only
>> needs 33 bits to find the PTE. It sure doesn't need
>> the full 64 bits it is using.

On Wed, May 19, 2004 at 12:44:24AM -0700, Andrew Morton wrote:
> yup.

Albert Cahalan <albert@users.sourceforge.net> wrote:
>> How about cheating a bit? If the pte_addr_t only had
>> the high 32 bits of the 36-bit pointer, it would point
>> to a pair of the 8-byte PTEs in a 16-byte chunk of RAM.
>> Then simply examine the PTEs to see which one is the
>> correct one.

On Wed, May 19, 2004 at 12:44:24AM -0700, Andrew Morton wrote:
> They might both map the same page.  It could overflow into page->flags.

An overflow area for the 33rd bits in pte_chains is another idea. A
CONFIG_HIGHMEM32G is another. But Hugh's and/or Andrea's code sounds
nicer than either of those. It doesn't get smaller than 0.

-- wli
