Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUDAX6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 18:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbUDAX6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 18:58:49 -0500
Received: from us01smtp1.synopsys.com ([198.182.44.79]:34254 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S262235AbUDAX6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 18:58:48 -0500
Date: Thu, 1 Apr 2004 15:58:45 -0800
From: Joe Buck <Joe.Buck@synopsys.COM>
To: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Cc: Andi Kleen <ak@suse.de>, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-ID: <20040401155845.A8242@synopsys.com>
References: <20040401143908.B4619@synopsys.com> <200404012248.AAA23951@faui1d.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200404012248.AAA23951@faui1d.informatik.uni-erlangen.de>; from weigand@i1.informatik.uni-erlangen.de on Fri, Apr 02, 2004 at 12:48:55AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 12:48:55AM +0200, Ulrich Weigand wrote:
> Joe Buck wrote:
> 
> > Case 2: make falsely thinks that the .c is younger than the .o.  It
> > recompiles the .c file, even though it didn't have to.  Harmless.
> 
> *Not* harmless, in fact this is exactly what breaks my bootstrap.
> 
> Think about what happens when cc1 is 'harmlessly' rebuilt just
> while in a parallel make that very same cc1 binary is used to
> run a compile ...

Well, then, you have a problem: how to handle ties?  Consider a system
with no extra precision, and one-second time resolution.  You see an .o
file and a .c file that are the same age.  Rebuild or not?  If we don't
and are wrong, the .o file is bad.  If we do and are wrong, the target
will be modified while some process is trying to use it.  Somehow we
have to figure out how to do the makefile so that neither problem can
occur.

In your particular case, for example, if the command to rebuild cc1 builds
the new version in a different place, then does an mv, the rebuild *will*
be harmless.
