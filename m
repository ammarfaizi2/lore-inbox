Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267256AbUG1Pop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267256AbUG1Pop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUG1Poo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:44:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40375 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267250AbUG1Pnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:43:51 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: suparna@in.ibm.com, Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<20040728105455.GA11282@in.ibm.com>
	<1091011565.30404.0.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2004 09:42:52 -0600
In-Reply-To: <1091011565.30404.0.camel@localhost.localdomain>
Message-ID: <m1fz7c16kj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Mer, 2004-07-28 at 11:54, Suparna Bhattacharya wrote:
> > On Tue, Jul 27, 2004 at 07:53:01PM -0600, Eric W. Biederman wrote:
> > > Andrew Morton <akpm@osdl.org> writes:
> > > 
> > > > Keith Owens <kaos@sgi.com> wrote:
> > > > >
> > > > >  * How do we get a clean API to do polling mode I/O to disk?
> > > > 
> > > > We hope to not have to.  The current plan is to use kexec: at boot time,
> do
> 
> 
> If you are prepared to say "dump device is IDE" the driver ends up
> pretty tiny - maybe 4K for PIO mode.

That sounds about right. I have a read-only version of Etherboot that
pretty much does that. 

A large challenge is how do you get the IDE device into a sane state
before you use it to dump core.  How do you stop on-going DMA
transactions.  What about implementation errata etc.  Do you need to
reprogram the drive to work in a PIO mode again.  I can't quite
remember by I seem to recall that the interface to IDE drives was
fairly stateful.  All of that needs to maintained in a separate dump
driver.  

Plus there is the challenge that many high-end systems where people
want to employ this kind of thing have SCSI disks.  At least that
has been my impression.

Using kexec to switch to an independent program to do the dump
sounds sane.  If you have a simple system with just IDE you could
run a very minimal 4K IDE dumper. If you have a full sized system
you can use a kernel+initrd and do all kinds of interesting things.
Dump to disk.  Dump to network etc.  Stop and work interactively with
the user to examine the state of the machine when it crashed.

Basically you are only limited by how much of your system your 
monitor can put into a sane state.  

Plus except for a small stub the code with kernel+initrd is almost
totally user space and using the normal path for kernel drivers.
The kernel drivers that are used may need to be made a little more
robust but that is not a big deal.

What is most attractive is using kexec to put the policy in user space
seems to be the unix way.

Eric
