Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbTHLKTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 06:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269628AbTHLKTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 06:19:32 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:18692 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S269621AbTHLKT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 06:19:26 -0400
Date: Tue, 12 Aug 2003 06:19:13 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <willy@debian.org>, Robert Love <rml@tech9.net>,
       CaT <cat@zip.com.au>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030812061913.G28314@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.51.0308121100200.17669@dns.toxicfilms.tv> <Pine.GSO.4.21.0308121202470.20533-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0308121202470.20533-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Aug 12, 2003 at 12:03:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 12:03:21PM +0200, Geert Uytterhoeven wrote:
> > > I sure would.  Oh, you can drop the .class, .class_mask, and
> > > .driver_data lines, and then it even looks cleaner.
> > Just a quick question. if we drop these, will they _always_
> > be initialised 0 ? I have made a test to see, and it seemed as though,
> > but I would like to be 100% sure.
> 
> For globals and static locals: yes.
> For non-static locals: no.

No, for all initializers members which are not explicitely initialized are
zero initialized.
Only if you provide no initializer at all, globals/static locals will
still be zero initializers while non-static locals may contain anything.
So, if you write:

struct A { int a; int b; int c; int d; };
void bar (void *);
void foo (void)
{
  struct A a = { .a = 21 };
  bar (&a);
}

then it is the same as:

struct A { int a; int b; int c; int d; };
void bar (void *);
void foo (void)
{
  struct A a = { .a = 21, .b = 0, .c = 0, .d = 0 };
  bar (&a);
}

	Jakub
