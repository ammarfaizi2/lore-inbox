Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263501AbUCTSWn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 13:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbUCTSWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 13:22:43 -0500
Received: from holomorphy.com ([207.189.100.168]:1417 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263501AbUCTSWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 13:22:41 -0500
Date: Sat, 20 Mar 2004 10:22:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320182234.GI2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20040320133025.GH9009@dualathlon.random> <Pine.LNX.4.58.0403200937500.1106@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403200937500.1106@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2004, Andrea Arcangeli wrote:
>> The only bugreport I've got so far for the latest anon_vma code is from
>> Jens, and it's a device driver bug in my opinion, but I'd like to have a
>> definitive confirmation from you about the ->nopage API.

On Sat, Mar 20, 2004 at 09:39:51AM -0800, Linus Torvalds wrote:
> I'd say that this is definitely a driver bug.
> If a driver wants to map non-RAM pages, that's perfectly ok, but it MUST 
> NOT happen through "nopage()". The driver should map them with 
> "remap_page_range()", and thus never take a page fault for such pages at 
> all.
> There is no reason to ever lazily map non-RAM pages - clearly they aren't 
> using any "real memory", so there is no reason to not fill the page tables 
> at mmap() time.
> In other words, the driver is horribly broken.

If our official story is prefaulting, there should be very little to do.
I'll grep around for drivers doing the wrong thing and see if any rmk's
not handling are in need of conversion from fault handling to
remap_page_range().


-- wli
