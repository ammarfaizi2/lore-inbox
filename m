Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbUCVTSh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUCVTSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:18:37 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:19116 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262291AbUCVTSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:18:31 -0500
Date: Mon, 22 Mar 2004 11:18:10 -0800
From: Russ Weight <rweight@us.ibm.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Disassemble vmlinuz (i386)
Message-ID: <20040322191810.GB22607@us.ibm.com>
References: <20040322175807.GA22404@us.ibm.com> <200403221821.i2MILCox004241@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403221821.i2MILCox004241@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess a little background would help to explain the "desparation".
I have been helping to debug a problem that occurred at another
company. We were provided with stack-traces (generated with sysrq-t).
We also had the vmlinuz file, and sources. We were not provided with a
vmlinux file.  We made an attempt to build the same kernel, but there
was enough uncertainty about the build environment, configuration
files, etc. that we wanted to compare with the actual kernel that
was being used.

On Mon, Mar 22, 2004 at 02:21:12PM -0400, Horst von Brand wrote:
> Russ Weight <rweight@us.ibm.com> said:
> > 	Admittedly, you would have to be pretty desparate to want
> > to disassemble vmlinuz... but I was... and I did.  There may
> > be other (better?) ways to do this, but since I didn't find
> > a complete recipe for this in my web searches, I'll post what
> > I did in case it might be helpful to others.
> 
> When I needed to do stuff like this, I went back to the vmlinux
> (uncompressed) which was lying around in the build directory. Or even to
> the individual .o files.
> 
In my case, the vmlinux file, .o's, etc. were not available.

> > 	Note that this was done on a 2.4.9 kernel.
> > 
> > - Russ
> > 
> > 
> > The short version:
> > ==================
> > (1) Strip the header and decompress the kernel
> 
> Or grab the uncompressed version (if available).
> 
> > (2) Write a small C program to copy the decompressed kernel
> >     into a shared memory segment.
> 
> Placing it into a file and objdump(1) should give most of what you are
> after... and you might also start gdb(1) on the file. Dunno if the weird
> startup code/placement messes it up, but worth a try.

The decompressed file did not contain an elf header, and could not be
opened with objdump.

> > (3) Run the C program under gdb - stop at a breakpoint after the
> >     copy and then use the gdb "disassemble" command to disassemble
> > 	the kernel from shared memory.
> > (4) Clean up the addresses. If you pick a good virtual address
> >     for the shared memory segment, then the cleanup can be a fairly
> > 	simple search & replace.
> 
> May I ask what you were after?

I think I have answered your questions above. The sequence that I
described in my post is certainly a round-about solution. But it
worked quite well...
