Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVCNT7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVCNT7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVCNT7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:59:06 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:40606 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261790AbVCNT67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:58:59 -0500
Subject: Re: [PATCH] 2.6.11-mm3 patch for ext3 writeback "nobh" option
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <1110828554.6288.109.camel@laptopd505.fenrus.org>
References: <1110827903.24286.275.camel@dyn318077bld.beaverton.ibm.com>
	 <1110828554.6288.109.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: 
Message-Id: <1110830057.24286.284.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Mar 2005 11:54:17 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 11:29, Arjan van de Ven wrote:
> On Mon, 2005-03-14 at 11:18 -0800, Badari Pulavarty wrote:
> > Hi Andrew,
> > 
> > Here is the 2.6.11-mm3 version of patch for adding "nobh"
> > support for ext3 writeback mode.
> 
> can you explain why this is an option ? It's not like the on disk layout
> changes or something... is there a reason to ever not want this?

I am slowly trying to reduce the uses of "bufferhead"s in the ext3.
We can get away not attaching a bufferheads for the pages in
ext3 writeback mode easily. But for ordered mode, its doable
but tricky.

There are few cases, I didn't handle in my patch (just to reduce
the code complexity)
	
	- I still create bufferheads for filesystem 
	blocksize != PAGE_SIZE

	- In case of a truncate and the page is not uptodate
	(needs to do IO to read the page) - I attach buffers.
	I had code to eliminate this - but Andrew didn't like it :(


I want to get more run-time before making it a default.

Thanks,
Badari

