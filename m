Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132999AbRDWQXx>; Mon, 23 Apr 2001 12:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132860AbRDWQXo>; Mon, 23 Apr 2001 12:23:44 -0400
Received: from ns.suse.de ([213.95.15.193]:50957 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132999AbRDWQXe>;
	Mon, 23 Apr 2001 12:23:34 -0400
Date: Mon, 23 Apr 2001 18:23:28 +0200
From: Andi Kleen <ak@suse.de>
To: John Weber <weber@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disappearing RAM
Message-ID: <20010423182328.A16338@gruyere.muc.suse.de>
In-Reply-To: <3AE4512D.9030602@nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE4512D.9030602@nyc.rr.com>; from weber@nyc.rr.com on Mon, Apr 23, 2001 at 11:58:37AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 11:58:37AM -0400, John Weber wrote:
> 
> There appears to be quite a difference between the memory usage reported
> by top
> (immediately after boot and minus all user processes) and that reported
> by the kernel
> during boot.  Can anyone give me any hints as to why this might happen?
> 
> I am assuming that if I subtract all the memory in use by processes
> listed by top from all
> the memory in use that this equals the amount of memory used by the
> kernel.
> These numbers do not add up.

The view given by top is inaccurate because it has no way to detect shared
pages properly. This means for example that when you have glibc mapped into
all your N processes it counted N times its size, even though it only exists
once in memory. Worse it gets when you work with threaded programs; they
share their memory completely, but top/ps has no way to detect this and 
counts the single shared process space for every process (I have an 
experimental patch to fix the later problem) 

In addition there are quite a bit of internal data structures in the kernel
which never appear in top, but eat memory. Most prominent of that is the
page table itself, which eats a few percent of your ram for a management
structure for every page (in 2.2 on 32bit ~40 bytes every 4K of memory;
in 2.4 it is much worse) 

> A related question:  In the 2.2 kernels, does the kernel pre-allocate
> any amount of memory
> for modules?

No.



-Andi
