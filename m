Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbUCTUvC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 15:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263536AbUCTUvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 15:51:02 -0500
Received: from holomorphy.com ([207.189.100.168]:24969 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263535AbUCTUvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 15:51:00 -0500
Date: Sat, 20 Mar 2004 12:50:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320205053.GJ2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320121345.2a80e6a0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320121345.2a80e6a0.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 12:13:45PM -0800, Andrew Morton wrote:
> I agree that ->nopage implementations should not be doing what that driver
> is doing.  ->nopage is defined to return a page*: it's crazy to be
> returning someting from there which isn't covered by mem_map[].
> I just don't think it's important enough to be able to cope with
> non-mem_map[] "memory" in do_no_page(), so I agree that requiring ->mmap()
> to synchronously instantiate the pte's and retaining the debug check in
> do_no_page() is a good idea.

There are other reasons for doing it, e.g. unusual TLB attributes
and/or unusual pagetable structures backing the virtual region. I don't
see anyone standing up and screaming for more functionality than cache
coherency and/or disablement now, so as far as I'm concerned,
remap_area_pages() (or rmk's stuff) kills the issue.


-- wli
