Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUDFSGK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263936AbUDFSFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:05:03 -0400
Received: from web40502.mail.yahoo.com ([66.218.78.119]:56746 "HELO
	web40502.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263935AbUDFSEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:04:44 -0400
Message-ID: <20040406180443.41252.qmail@web40502.mail.yahoo.com>
Date: Tue, 6 Apr 2004 11:04:43 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge 
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200404061606.i36G6YLE003375@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> > --- John Stoffel <stoffel@lucent.com> wrote:
> > > >>>>> "Sergiy" == Sergiy Lozovsky
> > > <serge_lozovsky@yahoo.com> writes:
> 
> [...]
> 
> > UNIX security policy is already implemented in the
> > Kernel,
> 
> Basic mechanism, not policy.

In case of VXE even mechanism is not stored inside the
kernel! This was the main goal - not to store(encode)
security model (mechanism) in the kernel. In VXE it is
loadable as well as particular security policy. It
loads on demand (during the start of subsystem) and
unloads when subsystem ends it work.

When susbsytem doesn't run - model and policy are
stored as a file.

VXE allow to preload model and policy if that is
desired, but it's just one of the options.


> 
> Policy has no place inside the kernel.

Root privileges (ability to send a signal to any
process, access any file and so on) are encoded in the
kernel.
 
> [...]
> 
> > > Then *WHY* does the LISP interpreter need to be
> in
> > > the kernel in the
> > > first place?  Hint, you just said you wanted to
> > > protect the kernel...
> > 
> > All LISP errors are incapsulated within LISP VM.
> 
> They aren't. A bad kprintf(), or a call to the wrong
> function inside the
> kernel, or fiddling with the wrong data structure,
> and you are toast.

No. LISP program can't call kprintf. Only VM can. LISP
program prints information into string buffer of
limited size and VM uses snprintf for that. When
buffer is full or there is \n - VM calls kprintf.

So all interaction with the kernel goes via VM.
Investing some time into carefull parameter check in
VM allows to avoid the same work for each new
application.

VM is not 100% foolproof - I don't claim that, but it
reduces problems which a new application (within the
kernel) can cause.

Serge.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
