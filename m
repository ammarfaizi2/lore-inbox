Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWFRSfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWFRSfV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 14:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWFRSfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 14:35:21 -0400
Received: from xenotime.net ([66.160.160.81]:59575 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751213AbWFRSfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 14:35:20 -0400
Date: Sun, 18 Jun 2006 11:38:04 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: sturmflut@lieberbiber.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] vdso: improve print_fatal_signals support by adding
 memory maps
Message-Id: <20060618113804.ce5418dd.rdunlap@xenotime.net>
In-Reply-To: <200606182029.30247.sturmflut@lieberbiber.de>
References: <200606171614.58610.sturmflut@lieberbiber.de>
	<200606181525.42199.sturmflut@lieberbiber.de>
	<20060618104218.b07fb540.rdunlap@xenotime.net>
	<200606182029.30247.sturmflut@lieberbiber.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jun 2006 20:29:21 +0200 Simon Raffeiner wrote:

> Am Sonntag, 18. Juni 2006 19:42 schrieben Sie:
> > On Sun, 18 Jun 2006 15:25:35 +0200 Simon Raffeiner wrote:
> > > Am Sonntag, 18. Juni 2006 07:58 schrieben Sie:
> > > > On Sat, 17 Jun 2006 21:58:18 -0700
> > > >
> > > > "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> > > > > On Sat, 17 Jun 2006 16:14:52 +0200 Simon Raffeiner wrote:
> > > > > > When compiling 2.6.17-rc6-mm2 (which contains this patch) my gcc
> > > > > > 4.0.3 (Ubuntu 4.0.3-1ubuntu5) complains about "int len;" being used
> > > > > > uninitialized in print_vma(). AFAICS len is not initialized and
> > > > > > then passed to
> > > > > > pad_len_spaces(int len), which uses it for some calculations.
> > > > > >
> > > > > > I also noticed that similar code is used in fs/proc/task_mmu.c,
> > > > > > where show_map_internal() passes an uninitialised int len; to
> > > > > > pad_len_spaces(struct seq_file *m, int len).
> > > > >
> > > > > Ack both of those.  And both of them pass &len as a parameter to
> > > > > printk/seq_printf where it looks as though they want just <len>
> > > > > (after it has been initialized).
> > > >
> > > > printk("%n", &len) will initialise `len'.  gcc is being wrong again.
> > >
> > > pad_len_spaces() is called in the following way:
> > >
> > >
> > > static int print_vma(struct vm_area_struct *vma)
> > > {
> > > 	int len;
> > >
> > > 	(...)
> > >
> > > 	pad_len_spaces(len);
> > >
> > > 	(...)
> > >
> > >
> > > and is defined as:
> > >
> > >
> > > static void pad_len_spaces(int len)
> > > {
> > >        len = 25 + sizeof(void*) * 6 - len;
> > >
> > >        if (len < 1)
> > >                len = 1;
> > >
> > >        printk("%*c", len, ' ');
> > > }
> > >
> > >
> > > len is passed to pad_len_spaces() without initialization and is used for
> > > calculations BEFORE printk() is called.
> >
> > Nope, len is used after printk(..., &len) is called.
> > But I don't see how printk() inits len... ?  :(  Magic?
> 
> I finally got it: %n in the format string advises printk (have a look at 
> lib/vsprintf.c, where vsnprintf() does the real work) to store the number of 
> characters that have been written so far to a given memory location. So len 
> is actually initialised.

Carp.  I knew that.  I was just misreading it.  Sorry about
my confuzion.

---
~Randy
