Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbUDBANR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 19:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbUDBANR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 19:13:17 -0500
Received: from nevyn.them.org ([66.93.172.17]:3252 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S263348AbUDBANN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 19:13:13 -0500
Date: Thu, 1 Apr 2004 19:13:05 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Joe Buck <Joe.Buck@synopsys.COM>
Cc: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>,
       Andi Kleen <ak@suse.de>, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-ID: <20040402001305.GA15520@nevyn.them.org>
Mail-Followup-To: Joe Buck <Joe.Buck@synopsys.COM>,
	Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>,
	Andi Kleen <ak@suse.de>, gcc@gcc.gnu.org,
	linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
References: <20040401143908.B4619@synopsys.com> <200404012248.AAA23951@faui1d.informatik.uni-erlangen.de> <20040401155845.A8242@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401155845.A8242@synopsys.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 03:58:45PM -0800, Joe Buck wrote:
> On Fri, Apr 02, 2004 at 12:48:55AM +0200, Ulrich Weigand wrote:
> > Joe Buck wrote:
> > 
> > > Case 2: make falsely thinks that the .c is younger than the .o.  It
> > > recompiles the .c file, even though it didn't have to.  Harmless.
> > 
> > *Not* harmless, in fact this is exactly what breaks my bootstrap.
> > 
> > Think about what happens when cc1 is 'harmlessly' rebuilt just
> > while in a parallel make that very same cc1 binary is used to
> > run a compile ...
> 
> Well, then, you have a problem: how to handle ties?  Consider a system
> with no extra precision, and one-second time resolution.  You see an .o
> file and a .c file that are the same age.  Rebuild or not?  If we don't
> and are wrong, the .o file is bad.  If we do and are wrong, the target
> will be modified while some process is trying to use it.  Somehow we
> have to figure out how to do the makefile so that neither problem can
> occur.

Don't rebuild.  If you have makefiles set up that the .o and _then_ the
.c can be rebuilt by parallel threads, you've got lots more wrong
already!  And it's a reasonable assumption that the entire build, test,
notice something is wrong, fix, rebuild cycle takes longer than the
granularity of your timestamps.

> In your particular case, for example, if the command to rebuild cc1 builds
> the new version in a different place, then does an mv, the rebuild *will*
> be harmless.

No, that's not right - read what Ulrich wrote originally about the
wrong options being in scope (exported by make) at this point ->
bootstrap miscompares.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
