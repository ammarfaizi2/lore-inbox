Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135497AbRDWSpf>; Mon, 23 Apr 2001 14:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135504AbRDWSpY>; Mon, 23 Apr 2001 14:45:24 -0400
Received: from mail5.doit.wisc.edu ([144.92.9.76]:5645 "EHLO
	mail5.doit.wisc.edu") by vger.kernel.org with ESMTP
	id <S135497AbRDWSpN>; Mon, 23 Apr 2001 14:45:13 -0400
Message-Id: <200104231845.NAA13534@mail5.doit.wisc.edu>
Subject: Re: BUG: Global FPU corruption in 2.2
From: Erik Paulson <epaulson@cs.wisc.edu>
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
Cc: linux-kernel@vger.kernel.org, zandy@cs.wisc.edu
In-Reply-To: <20010423161148.6465.qmail@theseus.mathematik.uni-ulm.de>
In-Reply-To: <cpx7l0g3mfk.fsf@goat.cs.wisc.edu>  
	<20010423161148.6465.qmail@theseus.mathematik.uni-ulm.de>
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 23 Apr 2001 13:44:27 -0500
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Apr 2001 18:11:48 +0200, Christian Ehrhardt wrote:
> On Thu, Apr 19, 2001 at 11:05:03AM -0500, Victor Zandy wrote:
> > 
> > We have found that one of our programs can cause system-wide
> > corruption of the x86 FPU under 2.2.16 and 2.2.17.  That is, after we
> > run this program, the FPU gives bad results to all subsequent
> > processes.
> 
<...>
> 
> 3.) It might be interesting to know if the problem can be triggered:
> a) If pi doesn't fork, i.e. just one process calculating pi and
> another one doing the attach/detach.

Yes, we are still able to reproduce it without calling fork (the new
program just calls
do_pi() a bunch of times, and then we attach and detach to that process)

> b) If pi doesn't do FPU Operations, i.e. only the children call do_pi.
> 

You seem to need to attach and detach to a program using the fpu -
running pt on a 
process that is just busy-looping over and over some integer adds does
not seem to
while running pi on the machine at the same time, but not attaching to
it does not
seem to affect the floating point state.

-Erik

