Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTJDDkM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 23:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbTJDDkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 23:40:12 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:47236
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261294AbTJDDkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 23:40:07 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: ebiederm@xmission.com (Eric W. Biederman),
       Andries Brouwer <aebr@win.tue.nl>
Subject: Re: [PATCH] linuxabi
Date: Fri, 3 Oct 2003 22:37:03 -0500
User-Agent: KMail/1.5
Cc: Andries.Brouwer@cwi.nl, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl> <20031002153301.GA2033@win.tue.nl> <m13ceahix8.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m13ceahix8.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310032237.03431.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 October 2003 02:36, Eric W. Biederman wrote:
> Andries Brouwer <aebr@win.tue.nl> writes:
> > On Thu, Oct 02, 2003 at 08:39:50AM -0600, Eric W. Biederman wrote:
> > > This is a 2.7 project.
> >
> > I disagree. This is unrelated to kernel development, just like working
> > on sparse is unrelated to kernel development.
>
> Granted.  The major point is that it requires a development cycle
> before it is ready.  Only if this is to be maintained as part of
> the kernel is it needed to be 2.7 work.

Um, what's the point of having linux abi exort header files that are NOT part 
of the kernel?

The theory here is that _some_ of the definitions in the kernel headers define 
interfaces with userspace.  Structures passed to fcntl or ioctl, constants, 
etc.  The kernel has to have copies of these definitions for its own use, 
just as much as userspace does. (It has to get the data from and put the data 
into these structures, doesn't it?  How can it do this without a defiition of 
these structures?  An interface has two sides, and the kernel side of that 
interface needs the abi definitions to provide the abi.)

The other 99% of the kernel headers should NOT get included in userspace 
programs.  This is the reason that, way back, #ifdef KERNEL was put in there 
in the first place, with the ABI stuff being anything that was outside the 
#ifdef.  This solution sucked eggs for fairly obvious reasons, but rather 
than separate out the ABI definitions into their own header files shared by 
kernel and user space, the advice from on high became "just cut and paste out 
the bits you need".  This solution sucked different eggs.  Any library that 
talks directly to the linux kernel needs to have access the kernel ABI, and 
manually extracting it from the kernel header files is a maintenance 
nightmare.  Even if you abstract this away into a library, the LIBRARY still 
needs to do it.  You've just moved the problem.

Some people here have argued variants of "tracking what the linux kernel 
exports to userspace is somebody else's problem".  I.E. the linux kernel 
can't be bothered to keep track of what it exports to userspace.  That just 
gives me a warm fuzzy feeling all over, that does...


> My point is that we need to cleanly handle the fact that glibc
> defines it's own abi that is not equivalent to the kernel abi.
> A linux specific namespace does that.  After libc is done with
> the definitions users will still use MS_RDONLY.

Does anything other than glibc have this problem?  (Does uclibc have this 
problem?  cdrecord?)

Rob
