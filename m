Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265175AbSJaEEU>; Wed, 30 Oct 2002 23:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265176AbSJaEEU>; Wed, 30 Oct 2002 23:04:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25146 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265175AbSJaEET>; Wed, 30 Oct 2002 23:04:19 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>, Pavel Machek <pavel@ucw.cz>,
       "Ph. Marek" <marek@bmlv.gv.at>, Pavel Roskin <proski@gnu.org>,
       Torrey Hoffman <thoffman@arnor.net>,
       Rob Landley <landley@trommello.org>,
       Kasper Dupont <kasperd@daimi.au.dk>
Subject: Re: [CFT] [PATCH] kexec 2.5.44 (minimal)
References: <m1lm4jj7v5.fsf_-_@frodo.biederman.org>
	<1036017717.1726.7.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Oct 2002 20:59:20 -0700
In-Reply-To: <1036017717.1726.7.camel@andyp>
Message-ID: <m1r8e7gsx3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Mon, 2002-10-28 at 00:16, Eric W. Biederman wrote:
> > And is currently kept in two pieces.
> > The pure system call.
> > http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.44.x86kexec-2.diff
> > 
> > And the set of hardware fixes known to help kexec.
> >
> http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.44.x86kexec-hwfixes.diff
> 
> 
> Eric,
> 
> Hmmm... I'm having a lot more problems on my troublesome machine with
> this patchset than I did with the previous iteration.  I've
> triple-checked the application of the patches, but I can't even get
> kexec_test to start, much less run to completion.
> 
> The new behavior is that the system appears to hang immediately after
> invoking "kexec kexec_test".
> 
> What could I have done wrong?

With out some amount of output I don't have a clue.

With just the first patch it doesn't work on SMP, but I don't try it to see
what the failure mode was.

With the second patch all should be the same except the legacy pic actually
gets disabled.  I wonder if disabling the legacy pic locks your system?

There should be two printks one about shuting down devices,
and another about kexecing the image.  And knowing when which of those
printed could be useful.

In any event.  Remove the shutdown routine in arch/i386/kernel/i8259.c
That should restore the kernel to it's previous behavior if something really changed...

 static struct device_driver i8259A_driver = {
 	.name		= "pic",
 	.bus		= &system_bus_type,
 	.resume		= i8259A_resume,
- 	.shutdown	= i8259A_shutdown,
 };

Or you could try it with a uniprocessor kernel and just the first patch.

Eric

