Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUIXCUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUIXCUD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUIXCT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 22:19:58 -0400
Received: from holomorphy.com ([207.189.100.168]:65243 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267657AbUIXCRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 22:17:39 -0400
Date: Thu, 23 Sep 2004 19:17:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Fusco <fusco_john@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 0/4] replace remap_page_range() with remap_pfn_range()
Message-ID: <20040924021735.GL9106@holomorphy.com>
References: <41535AAE.6090700@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41535AAE.6090700@yahoo.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 06:22:22PM -0500, John Fusco wrote:
> I have a problem and I would like some comments on how to fix it.
> I have a custom PCI-X device installed in an IA32 system.  The device 
> expects to see a flat contiguous address space on the host, from which 
> it reads and sends its data.  The technique I used is right out of the 
> O'Reilly Device Drivers book, which is to hide memory from the kernel 
> with the 'mem=YYY' boot parameter.  I then provide a mmap method to map 
> the contiguous (hidden) memory into user space via a call to 
> 'remap_page_range'.
> Everything worked great until we decided that we needed to install 6GB 
> in this system.  The problem is that remap_page_range() uses an unsigned 
> long as the parameter for a physical address.  On IA32, an unsigned long 
> is 32-bits, but the IA32 is capable of addressing well over 4GB of RAM.  
> So physical addresses on IA32 must be larger than 32 bits.

Do these patches work for you? Compiletested on sparc64.


-- wli
