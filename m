Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVANVIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVANVIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVANVH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:07:56 -0500
Received: from relay.axxeo.de ([213.239.199.237]:46011 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S262132AbVANVDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:03:55 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
Date: Fri, 14 Jan 2005 22:03:44 +0100
User-Agent: KMail/1.7.1
Cc: linux@horizon.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050108082535.24141.qmail@science.horizon.com> <200501132246.37289.ioe-lkml@axxeo.de> <Pine.LNX.4.58.0501131429400.2310@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501131429400.2310@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501142203.44720.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Linus Torvalds wrote:
> On Thu, 13 Jan 2005, Ingo Oeser wrote:
> > Hmm, that's a pity, because it makes hardware support more difficult.
> > I thought you might consider an system call, which "wires up" fds.
> I think that the solution to that is to make the pipe _be_ the driver
> interface.

But we have currently no suitable interface for this.

We have socketpair(), we have pipe(), but we don't have
dev_pipe() creating a pipe with the driver sitting in the middle.

Usage: "processing devices" like crypto processors, DSPs, 
 MPEG-Encoding/-Decoding hardware, smart cards and the like.

Synopsys: int dev_pipe(const char *dev_path, int fd_vec[2]);

We also don't have wire_fds(), which would wire up two fds by 
connecting the underlying file pointers with each other and closing the fds.

That would be quite useful, because user space will not see the data anymore
anyway, if it travels just between some chips. 

Usage: Chips from a chipset, which usally know each other quite well and
 can talk to each other without CPU intervention.

Synopsys: int wire(int in_fd, int out_fd);

> But that doesn't make the pipe an "actor". The pipe just remains a
> standard way to encapsulate the notion of "set of buffers". It needs an
> external actor to do something, but that actor can be a device driver
> filling it up, or a system call that reads it or moves it to another
> destination.

I implemented this some years ago for the "Linux & DSP" project, 
but I had to impose ordering restrictions on open() and close() to user space
and this is not really elegant.

Many hardware vendors have implemented it somehow anyway.

So what about starting to do it seriously and implement infrastructure for 
both of it?

I could also do an simple example driver using both features, if you give me 
some evenings of time and are interested in the idea.

Are you interested?


Regards

Ingo Oeser, still dreaming of sys_wire() and sys_dev_pipe()

PS: Syscall names are under discussion of course ;-)

