Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbULDVdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbULDVdk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 16:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbULDVdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 16:33:40 -0500
Received: from gw.goop.org ([64.81.55.164]:35781 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S261167AbULDVdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 16:33:37 -0500
Subject: Re: 32-bit syscalls from 64-bit process on x86-64?
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041204144002.GA15404@vana.vc.cvut.cz>
References: <1102004520.8707.10.camel@localhost>
	 <20041203061520.GG31767@wotan.suse.de>
	 <1102115789.8707.122.camel@localhost>
	 <20041204144002.GA15404@vana.vc.cvut.cz>
Content-Type: text/plain
Date: Sat, 04 Dec 2004 13:33:36 -0800
Message-Id: <1102196016.5546.3.camel@minilith.goop.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-04 at 15:40 +0100, Petr Vandrovec wrote:
> On Fri, Dec 03, 2004 at 03:16:29PM -0800, Jeremy Fitzhardinge wrote:
> > On Fri, 2004-12-03 at 07:15 +0100, Andi Kleen wrote:
> > > int 0x80 from 64bit will call 32bit syscalls.
> > 
> > Hm, that's not what I found.  If I run int 0x80 with [re]ax=1, I get
> > exit with a 32-bit process and write with a 64-bit one.
> 
> Seems to work for me.  See second example below.  If it won't work, you
> can always use reverse procedure to one I used in syscall.c - only
> problem is that you'll have to allocate some memory below 4GB to
> hold code & stack during 32bit syscall.
>  
> > >  But some things
> > > will not work properly, e.g. signals because they test the 32bit
> > > flag in the task_struct. So you would still get 64bit signal frames.
> > 
> > OK, I can deal with that, since signals are never directly delivered to
> > the client.
> > 
> > > There are some other such tests, but they probably wont affect you.
> > > 
> > > There were some plans at one point to allow to toggle the flag 
> > > using personality or prctl, but so far it hasn't been implemented.
> > > There is also no way to do 64bit calls from a 32bit executable.
> > 
> > What about my idea of using distinct ranges of syscall numbers to
> > disambiguate them?
> 
> What about this?  This does 64bit syscalls from 32bit executable.
> 
> Developed/tested on 2.6.10-rc2-mm2.  You may want to replace $0x33 with 
> some other value on 2.4.x kernels, but otherwise it should work fine for 
> you.  And well, you may want to do some additional coding so you can 
> actually pass & retrieve 64bit values to/from syscalls.
> 
> When it works correctly, program should print something and exit with code
> 111.  If it sigsegvs or exits with 222, something went wrong.

Both of these work for me on a stock FC3 kernel (2.6.9-1.681_FC3).  Not
sure what I was doing wrong...

Is 32-from-64 syscalls considered to be a documented API - something
which I can rely on?

The 64-from-32 switch is also very interesting; I hadn't realized you
could switch modes that easily within a process.

	J

