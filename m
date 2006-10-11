Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161141AbWJKQw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbWJKQw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbWJKQw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:52:57 -0400
Received: from mx2.quantum.com ([146.174.252.112]:53150 "EHLO mx2.quantum.com")
	by vger.kernel.org with ESMTP id S1161141AbWJKQw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:52:56 -0400
Message-ID: <452D2086.2020204@xfs.org>
Date: Wed, 11 Oct 2006 11:49:10 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
       linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
Subject: Re: Directories > 2GB
References: <20061004165655.GD22010@schatzie.adilger.int> <452AC4BE.6090905@xfs.org> <20061010015512.GQ11034@melbourne.sgi.com> <452B0240.60203@xfs.org> <20061010091904.GA395@infradead.org> <20061010233124.GX11034@melbourne.sgi.com>
In-Reply-To: <20061010233124.GX11034@melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Oct 2006 16:49:11.0903 (UTC) FILETIME=[2D8FA6F0:01C6ED55]
X-Spam-Score: 0.00%
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner wrote:
> On Tue, Oct 10, 2006 at 10:19:04AM +0100, Christoph Hellwig wrote:
>> On Mon, Oct 09, 2006 at 09:15:28PM -0500, Steve Lord wrote:
>>> Hi Dave,
>>>
>>> My recollection is that it used to default to on, it was disabled
>>> because it needs to map the buffer into a single contiguous chunk
>>> of kernel memory. This was placing a lot of pressure on the memory
>>> remapping code, so we made it not default to on as reworking the
>>> code to deal with non contig memory was looking like a major
>>> effort.
>> Exactly.  The code works but tends to go OOM pretty fast at least
>> when the dir blocksize code is bigger than the page size.  I should
>> give the code a spin on my ppc box with 64k pages if it works better
>> there.
> 
> The pagebuf code doesn't use high-order allocations anymore; it uses
> scatter lists and remapping to allow physically discontiguous pages
> in a multi-page buffer. That is, the pages are sourced via
> find_or_create_page() from the address space of the backing device,
> and then mapped via vmap() to provide a virtually contigous mapping
> of the multi-page buffer.
> 
> So I don't think this problem exists anymore...

I was not referring to high order allocations here, but the overhead
of doing address space remapping every time a directory is accessed.

Steve

