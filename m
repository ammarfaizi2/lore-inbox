Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266603AbSKGWHI>; Thu, 7 Nov 2002 17:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266604AbSKGWHI>; Thu, 7 Nov 2002 17:07:08 -0500
Received: from air-2.osdl.org ([65.172.181.6]:15807 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266603AbSKGWHH>;
	Thu, 7 Nov 2002 17:07:07 -0500
Subject: Re: kexec (was: [lkcd-devel] Re: What's left over.)
From: Andy Pfiffer <andyp@osdl.org>
To: Andy Pfiffer <andyp@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <1036697556.10457.254.camel@andyp>
References: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com> 
	<m14ratepbf.fsf@frodo.biederman.org>  <1036697556.10457.254.camel@andyp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Nov 2002 14:13:52 -0800
Message-Id: <1036707232.10457.275.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 11:32, Andy Pfiffer wrote:
> On Thu, 2002-11-07 at 00:50, Eric W. Biederman wrote:
> 
> > In staging the image we allocate a whole pile of pages, and keep them
> > locked in place.

> Just an idea:
> 
> Could a new, unrunnable process be created to "hold" the image?
> 
> <hand-wave>
> Use a hypothetical sys_kexec() to:
> 1. create an empty process.
> 2. copy the kernel image and parameters into the processes' address
> space.
> 3. put the process to sleep.
> </hand-wave>

A further refinement to the above:

1. make sys_kexec() a blocking call.  The caller reads the image into
their address space prior to making the call, and passes the same kind
of information (number of segments, segment pointer, etc.) to the
syscall in the same manner.  Then, it sets a well-known global variable
that means "there is a kexec image available", and then blocks.

2. add code to sys_reboot() under a CONFIG_KEXEC to check the global
variable in [1) above], and if a kexec image is available, wake the
process in [1) above].

3. the reawakened sys_kexec() then proceeds to copy-in and lay down the
new image in memory, shutdown the devices, and go.

I'm still pondering the kexec-ish reboot after panic() with this kind of
mechanism.  Ah well, it's just an idea.

Andy


