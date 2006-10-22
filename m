Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWJVQvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWJVQvW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 12:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWJVQvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 12:51:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:23492 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751129AbWJVQvV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 12:51:21 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
Date: Sun, 22 Oct 2006 18:51:06 +0200
User-Agent: KMail/1.9.5
Cc: Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <4537818D.4060204@qumranet.com> <200610221723.48646.arnd@arndb.de> <453B99D7.1050004@qumranet.com>
In-Reply-To: <453B99D7.1050004@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610221851.06530.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 18:18, Avi Kivity wrote:
> Arnd Bergmann wrote:

> > We ended up adding a lot more file than we initially planned,
> > but the interface is really handy, especially if you want to
> > create some procps-like tools for it.
>
> I don't really see the need.  The cell dsps are a shared resource, while
> virtual machines are just another execution mode of an existing resource
> - the main cpu, which has a sharing mechanism (the scheduler and
> priorities).

I don't think it's that different. The Cell SPU scheduler is also
implemented in kernel space. Every application using an SPU program
has its own contexts in spufs and doesn't look at the others.

While we don't have it yet, we're thinking about adding a sputop
or something similar that shows the utilization of spus. You don't
need that one, since get exactly that with the regular top, but you
might want to have a tool that prints statistics about how often
your guests drop out of the virtualisation mode, or the number
of interrupts delivered to them.

> > Have you thought about simply defining your guest to be a section
> > of the processes virtual address space? That way you could use
> > an anonymous mapping in the host as your guest address space, or
> > even use a file backed mapping in order to make the state persistant
> > over multiple runs. Or you could map the guest kernel into the
> > guest real address space with a private mapping and share the
> > text segment over multiple guests to save L2 and RAM.
> >  
>
> I've thought of it but it can't work on i386 because guest physical
> address space is larger than virtual address space on i386.  So we
> mmap("/dev/kvm") with file offsets corresponding to guest physical
> addresses.
>
> I still like that idea, since it allows using hugetlbfs and allowing
> swapping.  Perhaps we'll just accept the limitation that guests on i386
> are limited.

What is the point of 32 bit hosts anyway? Isn't this only available
on x86_64 type CPUs in the first place?

	Arnd <><
