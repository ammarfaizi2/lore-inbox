Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWELRhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWELRhS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 13:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWELRhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 13:37:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932077AbWELRhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 13:37:15 -0400
Date: Fri, 12 May 2006 10:36:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Erik Mouw <erik@harddisk-recovery.com>
cc: Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       rmk@arm.linux.org.uk, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
In-Reply-To: <20060512171632.GA29077@harddisk-recovery.com>
Message-ID: <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org>
References: <20060511151456.GD3755@harddisk-recovery.com>
 <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com>
 <20060512171632.GA29077@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, Erik Mouw wrote:

> On Fri, May 12, 2006 at 06:53:27AM +0200, Or Gerlitz wrote:
> >
> > I was pointing on 2.6.17 kmem_cache related  issues while back to LKML
> > and it turns out that you can reproduce them easily with standalone
> > trivial module, see
> > http://openib.org/pipermail/openib-general/2006-April/020582.html
> > 
> > So far no one picked the issue anb i was adviced to use bisection...
> 
> I tracked it down with git bisect. The culprit is this commit:
> 
> 56cf6504fc1c0c221b82cebc16a444b684140fb7 is first bad commit

Ok, that's just _strange_. Clearly bisection picked the right commit, 
since:

> After reverting this commit in 2.6.17-rc4 I can't trigger the bug
> anymore.

but at the same time, I don't see what that two-liner patch to 
block/genhd.c has to do with that trivial module which doesn't even _use_ 
any of the functions that the patch affects.

It sounds like you used some other test-case than the trivial module above 
to test bisection?

So when you say "I tracked _it_ down with git bisect" (my emphasis), it 
sounds like "it" was really something else than the trivial stand-alone 
module. Or are you saying that the trivial stand-alone module _also_ got 
fixed?

> Might be worth fixing before 2.6.17-final.

Yes. We could just revert that commit, but it seems correct, and I'd 
really like for somebody to understand _why_ that commit matters at all. I 
certainly don't see the overlap here..

So I get the feeling that you bisected just the case below, right?

> Note: I'm going on holiday next week, so I'm not able to test any
> fixes. However, because this bug is very easy to trigger[1], anybody
> with root on NFS and fully modular SCSI or libata should be able to
> test.
> 
> [1] See http://marc.theaimsgroup.com/?l=linux-scsi&m=114736053211943&w=2

Hmm. Jens? Any ideas?

		Linus
