Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbUDAUkU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbUDAUkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:40:20 -0500
Received: from nevyn.them.org ([66.93.172.17]:47537 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S263152AbUDAUkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:40:15 -0500
Date: Thu, 1 Apr 2004 15:39:23 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andi Kleen <ak@suse.de>
Cc: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>, gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-ID: <20040401203923.GA32177@nevyn.them.org>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>,
	gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
	schwidefsky@de.ibm.com
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de> <20040401220957.5f4f9ad2.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401220957.5f4f9ad2.ak@suse.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 10:09:57PM +0200, Andi Kleen wrote:
> On Thu, 1 Apr 2004 21:28:20 +0200 (CEST)
> Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de> wrote:
> 
> > However, I'd say that this should probably be fixed in the kernel,
> > e.g. by not reporting high-precision time stamps in the first
> > place if the file system cannot store them ...
> 
> Interesting. We discussed the case as a theoretical possibility when
> the patch was merged, but it seemed to unlikely to make it worth
> complicating the first version.
> 
> The solution from back then I actually liked best was to just round
> up to the next second instead of rounding down when going from 1s 
> resolution to ns.
> 
> -Andi
> 
> e.g. like this for ext3 (untested). Does that fix your problem?

(I haven't tested anything but...) why should this fix it?  Ulrich's
problem happens when the .o file is flushed from the cache, and then
stat'd; it now appears to be older than the .c file.  With a change to
round up instead, if the .c file is flushed from the cache before the
.o, the .c will still suddenly appear to be newer than the .o.


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
