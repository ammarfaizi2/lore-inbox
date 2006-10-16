Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422772AbWJPSRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422772AbWJPSRa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422768AbWJPSRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:17:30 -0400
Received: from cantor2.suse.de ([195.135.220.15]:31128 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422747AbWJPSR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:17:28 -0400
To: Steve Lord <lord@xfs.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
       linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
Subject: Re: Directories > 2GB
References: <20061004165655.GD22010@schatzie.adilger.int>
	<452AC4BE.6090905@xfs.org> <20061010015512.GQ11034@melbourne.sgi.com>
	<452B0240.60203@xfs.org> <20061010091904.GA395@infradead.org>
	<20061010233124.GX11034@melbourne.sgi.com>
	<452D2086.2020204__28695.6273987473$1160585745$gmane$org@xfs.org>
From: Andi Kleen <ak@suse.de>
Date: 16 Oct 2006 20:17:03 +0200
In-Reply-To: <452D2086.2020204__28695.6273987473$1160585745$gmane$org@xfs.org>
Message-ID: <p73bqoccehs.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord <lord@xfs.org> writes:

> David Chinner wrote:
> > On Tue, Oct 10, 2006 at 10:19:04AM +0100, Christoph Hellwig wrote:
> >> On Mon, Oct 09, 2006 at 09:15:28PM -0500, Steve Lord wrote:
> >>> Hi Dave,
> >>>
> >>> My recollection is that it used to default to on, it was disabled
> >>> because it needs to map the buffer into a single contiguous chunk
> >>> of kernel memory. This was placing a lot of pressure on the memory
> >>> remapping code, so we made it not default to on as reworking the
> >>> code to deal with non contig memory was looking like a major
> >>> effort.
> >> Exactly.  The code works but tends to go OOM pretty fast at least
> >> when the dir blocksize code is bigger than the page size.  I should
> >> give the code a spin on my ppc box with 64k pages if it works better
> >> there.
> > The pagebuf code doesn't use high-order allocations anymore; it uses
> > scatter lists and remapping to allow physically discontiguous pages
> > in a multi-page buffer. That is, the pages are sourced via
> > find_or_create_page() from the address space of the backing device,
> > and then mapped via vmap() to provide a virtually contigous mapping
> > of the multi-page buffer.
> > So I don't think this problem exists anymore...
> 
> I was not referring to high order allocations here, but the overhead
> of doing address space remapping every time a directory is accessed.

# grep -i vmalloc /proc/meminfo 
VmallocTotal: 34359738367 kB

At least on 64bit systems it would be reasonable to keep a large
number of directories mapped this way over a longer time. vmap() space is 
cheap there.

-Andi
