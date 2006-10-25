Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161362AbWJYPrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161362AbWJYPrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 11:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbWJYPrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 11:47:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751725AbWJYPq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 11:46:59 -0400
Date: Wed, 25 Oct 2006 08:46:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: swsusp initialized after SATA (was Re: swsusp APIC oopsen (was
 Re: swsusp ooms))
Message-Id: <20061025084613.4776ef76.akpm@osdl.org>
In-Reply-To: <20061025104318.GA1743@elf.ucw.cz>
References: <20061009213359.7f2806b6.akpm@osdl.org>
	<200610132231.08643.rjw@sisk.pl>
	<20061013140000.329e8854.akpm@osdl.org>
	<200610132307.47162.rjw@sisk.pl>
	<20061014002504.1ab10ee9.akpm@osdl.org>
	<20061014004046.670ddd76.akpm@osdl.org>
	<20061014082237.GA3818@elf.ucw.cz>
	<20061014083227.GA3868@elf.ucw.cz>
	<20061014015109.0ff2c52f.akpm@osdl.org>
	<20061025104318.GA1743@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 25 Oct 2006 12:43:18 +0200 Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > > > (cc-ed to public list)
> > > > 
> > > > > Andrew Morton <akpm@osdl.org> wrote:
> > > > > 
> > > > > > and I'm not having much luck.  See 
> > > > > > 
> > > > > > http://userweb.kernel.org/~akpm/s5000340.jpg and
> > > > > > http://userweb.kernel.org/~akpm/s5000339.jpg
> > > > > 
> > > > > Running an UP kernel and disabling local APIC avoided the oopses and
> > > > > allowed me to confirm that it was leaking.  whoops.
> > > > 
> > > > I wonder why everyone but me sees those APIC problems?
> > > > 
> > > > Anyway, there's one more problem in -rc1: boot order changed, and (at
> > > > least with paralel boot options), swsusp gets initialized *after*
> > > > swsusp => bad, but should be easy to fix.
> > > 
> > > Sorry, I meant:
> > > 
> > > "sata is initialized *after* swsusp => bad".
> > 
> > Which patch made this change, and why?
> 
> CONFIG_PCI_MULTITHREAD_PROBE is the setting responsible, and IIRC
> that's Greg's code.
> 
> Now... what is the recommended way to wait for hard disks to become
> online?

The multithreaded probing is breaking (or at least altering) the initcall
ordering guarantees.  We should wait for all the probing kernel threads to
terminate after processing each initcall level.  

