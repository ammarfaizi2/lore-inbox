Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbUCZJq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 04:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUCZJq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 04:46:59 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:51211 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263985AbUCZJq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 04:46:57 -0500
Date: Fri, 26 Mar 2004 09:46:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christian Leber <christian@leber.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with remap_page_range/mmap
Message-ID: <20040326094656.A3812@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christian Leber <christian@leber.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040325234804.GA29507@core.home> <20040326071739.B2637@infradead.org> <20040326093619.GA15965@core.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040326093619.GA15965@core.home>; from christian@leber.de on Fri, Mar 26, 2004 at 10:36:19AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 10:36:19AM +0100, Christian Leber wrote:
> It also didn´t work with PG_reserved.
> What would be the good idea? I need at least 8 at least 4MB (2MB are enough for 2.4)
> big physical memory pieces for DMA, mapped to userspace.
> 
> What is the reason why it doesn´t work? There seems to be no special
> remap_page_range for ia64.

Put the page structs into an array and return them from ->nopage.  The
kernel pagefault code will set up the ptes for you.

Now actually getting 4MB of continguous memory is a different issue..

I'm surprised you actually managed to get the allocation to succeed.

