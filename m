Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbUJ1AFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbUJ1AFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUJ1AEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:04:44 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:33172 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S262723AbUJ0Xbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 19:31:48 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [RFC] dev_acpi: support for userspace access to acpi
Date: Wed, 27 Oct 2004 17:31:39 -0600
User-Agent: KMail/1.7
Cc: "Yu, Luming" <luming.yu@intel.com>,
       "Alex Williamson" <alex.williamson@hp.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
References: <3ACA40606221794F80A5670F0AF15F84041ABFF8@pdsmsx403>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041ABFF8@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410271731.39077.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 October 2004 11:17 am, Yu, Luming wrote:
>   If don't use acpi_early_init , acpi is initialized in do_basic_setup() in kernel thread --init.
> It is very close to launch first user space process(/sbin/init ..). So, if we can invent 
> acpi_later_init, it is possible to move interpreter out of kernel.

It's true that some early init stuff is based on the static tables
and doesn't require the interpreter.  But there is a lot of stuff
that DOES require the interpreter, like finding PCI root bridges,
PRTs, PCI interrupt link devices, etc.  It's not clear to me that
it's feasible to deal with all these from userspace.

>   The difficulty for inventing userspace interpreter is to eliminate the ACPI-interpreter dependency 
> of drivers for booting. But this dependency is not mandatory. Once kernel booted to be able
> to launch /sbin/init, it is also able to launch /sbin/user_space_interpreter, then kernel can enjoy
> acpi from then on, despite the acpi interpreter is a user space daemon, we just need to invent
> or user a communication method between kernel and user space daemon.

Before the interpreter, you don't have ANY devices (legacy ones are
described via the namespace of course, and PCI devices depend on root
bridges that are also in the namespace).  So you end up at least
requiring a ramdisk, plus a bunch of encoding to communicate resource
information from the interpreter to the drivers.

Maybe not impossible, but it certainly requires a lot of work.  Moving
the interpreter to userspace has been proposed many times, but I've
never seen any indication that anybody is actually working on it.
