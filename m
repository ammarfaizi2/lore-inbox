Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVBOMQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVBOMQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 07:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVBOMOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 07:14:25 -0500
Received: from colin2.muc.de ([193.149.48.15]:44305 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261682AbVBOMOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 07:14:05 -0500
Date: 15 Feb 2005 13:14:04 +0100
Date: Tue, 15 Feb 2005 13:14:04 +0100
From: Andi Kleen <ak@muc.de>
To: Ray Bryant <raybry@sgi.com>
Cc: Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview II
Message-ID: <20050215121404.GB25815@muc.de>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42114279.5070202@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry, didn't answer to everything in your mail the first time. 
See previous mail for beginning]

On Mon, Feb 14, 2005 at 06:29:45PM -0600, Ray Bryant wrote:
> migrating, and figure out from that what portions of which pid's
> address spaces need to migrated so that we satisfy the constraints
> given above.  I admit that this may be viewed as ugly, but I really
> can't figure out a better solution than this without shuffling a
> ton of ugly code into the kernel.

I like the concept of marking stuff that shouldn't be migrated
externally (using NUMA policy) better. 

> 
> One issue that hasn't been addressed is the following:  given a
> particular entry in /proc/pid/maps, how does one figure out whether
> that entry is mapped into some other process in the system, one
> that is not in the set of processes to be migrated?   One could

[...]

Marking things externally would take care of that.

> If we did this, we still have to have the page migration system call
> to handle those cases for the tmpfs/hugetlbfs/sysv shm segments whose
> pages were placed by first touch and for which there used to not be
> a memory policy.  As discussed in a previous note, we are not in a

You can handle those with mbind(..., MPOL_F_STRICT); 
(once it is hooked up to page migration) 

Just mmap the tmpfs/shm/hugetlb file in an external program and apply
the policy. That is what numactl supports today too for shm
files like this.

It should work later.


-Andi
