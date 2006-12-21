Return-Path: <linux-kernel-owner+w=401wt.eu-S1422677AbWLUElk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWLUElk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 23:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWLUElk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 23:41:40 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52543 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422677AbWLUElj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 23:41:39 -0500
Date: Thu, 21 Dec 2006 10:11:26 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-ID: <20061221044125.GA5921@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061220141808.e4b8c0ea.khali@linux-fr.org> <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com> <20061220214340.f6b037b1.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220214340.f6b037b1.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 09:43:40PM +0100, Jean Delvare wrote:
> Hi Eric,
> 
> On Wed, 20 Dec 2006 07:00:11 -0700, Eric W. Biederman wrote:
> > Jean Delvare writes:
> > > One of my test machines (i586, Asus P4P800-X) reboots instantly when I
> > > try to boot a 2.6.20-rc1 kernel. 2.6.19 and 2.6.19.1 boot OK. I ran a
> > > git bisect and it pointed me to this patch:
> >
> > I don't think this is a know issue.
> >
> > The most straight forward way to debug this is to put infinite
> > loops in arch/i386/boot/compressed/head.S moving progressively farther
> > in until you find where the line in head.S that the machine reboots
> > on you is.
> 
> I could try that with some guidance. What instructions should I insert
> to create an infinite loop?
> 
> > Although it is possible the problem falls in misc.c as well.
> >
> > If you have a serial console setup we can probably make this
> > process a little easier.
> 
> I can setup a serial console if needed, what are we looking for? Just
> to know where exactly the reboot happens?
> 
> > One hunch is that we did something stupid, and have an instruction
> > that only executes on an i686 in there somewhere.
> 
> This is a Pentium 4, I'm compiling for i586 for compatibility with my
> another test systems. So an i686 instruction would work fine, it has to
> be something else.
> 

Hi Jean,

What's the value of CONFIG_PHYSICAL_ALIGN? How much RAM is present in your
system? Though very unlikely, just trying to find that we are not running
short of RAM while trying to align the kernel to a large value.

Can you please provide your config file. Is it possible to provide your
bzImage? Can you upload it somewhere? Will try to boot it on my box just
to find out if it could be in some way related to compiler/linker.

Thanks
Vivek
