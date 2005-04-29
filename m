Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVD2FdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVD2FdX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 01:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbVD2FdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 01:33:23 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:2589 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262345AbVD2FdR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 01:33:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bS/RNxhRwFpKOWmK/tQNrj7oFrJSW0KRgaeJRfIQMnDY7M4QG1/HUtzVDeUcp36MbaLABWNGd6ULhDUlZR6o8wEizpRtthobmVof8eIoA/An8wbHWaSpRK0QyVGgHT2vbs0lpWS+6haRQhjRsqQWGuW6n5p3aEme0kLvmDVuQu4=
Message-ID: <ba8358220504282233754de43b@mail.gmail.com>
Date: Thu, 28 Apr 2005 22:33:16 -0700
From: Gilles Pokam <gpokam@gmail.com>
Reply-To: Gilles Pokam <gpokam@gmail.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: Kernel memory
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050429030313.GA10344@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ba83582205042816522e2a7a93@mail.gmail.com>
	 <20050429030313.GA10344@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/05, Chris Wedgwood <cw@f00f.org> wrote:
> On Thu, Apr 28, 2005 at 04:52:21PM -0700, Gilles Pokam wrote:
> 
> > I have a special user application who needs to access any part of
> > the kernel memory.
> 
> why & for what?
> 
> > My question is therefore how to make the whole memory accessible for
> > that particular application ?
> 
> maybe /dev/kmem or /proc/kcore
> 
> it would help if you explain in more detail what you are trying to do
> 

Here is the big picture of the what (detailed are omitted):
I'm experimenting with system to help developers debug their programs.
The debugger is based on a replayer whose purpose is to
deterministically replay the last millions of instructions that lead
to a crash. On the user site, when the program runs, a trace of load
values along with some architectural state is continuously recorded.
Upon a crash, this trace is sent to the developer for debugging. At
the developer site, the application is replayed as follows. The
architectural state is initialized by reading the values from the
trace. The execution then proceeds as follows. If a load instruction
is encountered, the value is taken from the trace. Otherwise all other
instructions execute normally.

Issues:
Now, there are cases where a load value read from the trace (a virtual
address) raises a pagefault exception at the execution because the
address is invalid (the OS has not mapped this address) or the
accessed page doesn't have the right protection. In such cases,
instead of having the program to segfault, I want to handle this as a
valid pagefault, returning a page at the place. One other constraint
is that the application that is being debugged must not be modified.

I was thinking of making the whole memory accessible to handle this.
But I can not rely on mapping /dev/mem or /proc/kcore into the user
space since this would require modifying the binary. Are there other
ways of doing this ? May be disabling paging ? if so, how to do this ?


Thanks for any suggestions.

Gilles
