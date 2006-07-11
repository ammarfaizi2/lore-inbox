Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWGKSUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWGKSUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWGKSUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:20:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44966 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932071AbWGKSUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:20:16 -0400
Date: Tue, 11 Jul 2006 14:19:05 -0400
From: Dave Jones <davej@redhat.com>
To: Joshua Hudson <joshudson@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
Message-ID: <20060711181905.GJ5362@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Joshua Hudson <joshudson@gmail.com>, Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	torvalds@osdl.org, akpm@osdl.org
References: <20060711160639.GY13938@stusta.de> <20060711170725.GD5362@redhat.com> <bda6d13a0607111015p5ab5461am4f6b4716e264e0e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda6d13a0607111015p5ab5461am4f6b4716e264e0e1@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 10:15:59AM -0700, Joshua Hudson wrote:
 > On 7/11/06, Dave Jones <davej@redhat.com> wrote:
 > >On Tue, Jul 11, 2006 at 06:06:39PM +0200, Adrian Bunk wrote:
 > > > I'd like to cleanup the mess of the in-kernel headers, based on the
 > > > following rules:
 > > > - every header should #include everything it uses
 > > > - remove unneeded #include's from headers
 > > >
 > > > This would also remove all the implicit rules "before #include'ing
 > > > header foo.h, you must #include header bar.h" you usually only see when
 > > > the compilation fails.
 > >
 > >You may want to add as a secondary goal, splitting up some of the
 > >huge 3-headed monster include files like sched.h
 > >(It's better than it used to be, but it still sucks, and that thing
 > >#include's the world).  Worst, iirc module.h pulls it in, which means
 > >everything built as a module is pulling in hundreds of includes
 > >even though most of the time, it'll never use anything from the
 > >indirect ones.
 > If you pull this off, you can shave a lot off compile time as almost
 > every component #includes module.h

I did it on at least two occasions in the past, and someone else picked
it up and retried submitting it a third time, but it never got merged.
The problem with changes of this scale is they tend to be wide-reaching,
and impact areas which other people are patching, so it's something
that needs to go in as soon as the patch is done, or it becomes stale
very quickly.

It did make a noticable difference to compiles, though I forget the
exact numbers.   Should be in the list archives somewhere.
I have vague recollection that it shaved off around 20-30s, though
my memory is fuzzy.

		Dave

-- 
http://www.codemonkey.org.uk
