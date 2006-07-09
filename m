Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbWGIVDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbWGIVDf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWGIVDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:03:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30859 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161145AbWGIVDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:03:34 -0400
Date: Sun, 9 Jul 2006 14:03:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: gregoire.favre@gmail.com, linux-kernel@vger.kernel.org, ak@suse.de,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.18-rc1-mm1 fails on amd64 (smp_call_function_single)
Message-Id: <20060709140322.fc5afac1.akpm@osdl.org>
In-Reply-To: <200607092239.48065.rjw@sisk.pl>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<20060709114925.GA9009@gmail.com>
	<200607092239.48065.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 22:39:48 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Sunday 09 July 2006 13:49, Gregoire Favre wrote:
> > Hello,
> > 
> > can't compil it :
> > 
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > arch/x86_64/kernel/built-in.o: In function `vsyscall_set_cpu':
> > (.init.text+0x1e87): undefined reference to `smp_call_function_single'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> This is because of x86_64-mm-getcpu-vsyscall.patch which breaks
> compilation without SMP and is not obviously fixable.

Is it not as simple as adding a !SMP implementation of
smp_call_function_single(), which just calls the thing?

> I think you can safely revert it.

That works, too.
