Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbREYIVj>; Fri, 25 May 2001 04:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263635AbREYIVa>; Fri, 25 May 2001 04:21:30 -0400
Received: from ns.suse.de ([213.95.15.193]:29457 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263631AbREYIVQ>;
	Fri, 25 May 2001 04:21:16 -0400
Date: Fri, 25 May 2001 10:20:15 +0200
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andreas Dilger <adilger@turbolinux.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
Message-ID: <20010525102015.C26038@gruyere.muc.suse.de>
In-Reply-To: <200105250633.f4P6Xuj2017833@webber.adilger.int> <24688.990773627@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <24688.990773627@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Fri, May 25, 2001 at 04:53:47PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 04:53:47PM +1000, Keith Owens wrote:
> The only way to avoid those problems is to move struct task out of the
> kernel stack pages and to use a task gate for the stack fault and
> double fault handlers, instead of a trap gate (all ix86 specific).
> Those methods are expensive, at a minimum they require an extra page
> for every process plus an extra stack per cpu.  I have not even
> considered the extra cost of using task gates for the interrupts nor
> how this method would complicate methods for getting the current struct
> task pointer.  It is not worth the bother, we write better kernel code
> than that.

When you don't try to handle recursive stack/double faults it only requires
a single static stack per CPU. With some tricks and minor races it is also
possible to handle multiple ones.


-Andi
