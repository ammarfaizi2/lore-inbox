Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263536AbSJHT7H>; Tue, 8 Oct 2002 15:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263457AbSJHTzD>; Tue, 8 Oct 2002 15:55:03 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:14611
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263476AbSJHTyK>; Tue, 8 Oct 2002 15:54:10 -0400
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
From: Robert Love <rml@tech9.net>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
In-Reply-To: <20021008195223.GA5040@tapu.f00f.org>
References: <1034044736.29463.318.camel@phantasy>
	<20021008183824.GA4494@tapu.f00f.org>
	<1034102950.30670.1433.camel@phantasy>
	<20021008190513.GA4728@tapu.f00f.org>
	<1034104637.29468.1483.camel@phantasy> 
	<20021008195223.GA5040@tapu.f00f.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Oct 2002 15:59:50 -0400
Message-Id: <1034107190.29467.1533.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-08 at 15:52, Chris Wedgwood wrote:

> On Tue, Oct 08, 2002 at 03:17:16PM -0400, Robert Love wrote:
> 
> > Yep.  Linux treats most "hints" (e.g. madvise) as a requirement - it
> > fails if it cannot do it.  That is against the spec most of the
> > time, but oh well...
> 
> There is no spec for O_DIRECT... SGI 'invented' this in '93 or perhaps
> earlier (but the idea wasn't new) for IRIX.

I was speaking more of madvise() and in general.  I know O_DIRECT does
not have a spec.  In general, Linux returns failures on things that many
other operating systems just consider hints (i.e. madvise()).

> O_DIRECT is a very special thing, you shouldn't ask for this unless
> yoy know you want it and how to deal with it --- treating it as
> anything less that a requirement is bogus IMO.

Agreed.  Partly why O_STREAMING is needed.

Remember not everything implements O_DIRECT, especially not some odd
device you are streaming into/out of.

I think Andrew summed it up: if O_DIRECT will work in your environment,
and you can rewrite your application, it is probably preferred. 
O_STREAMING is a simple solution to solve the pagecache waste which
requires one change to the application.

I did not intend for this to be an O_DIRECT vs. O_STREAMING thread.  A
lot of people agree we need something like O_STREAMING - despite never
being implemented, you can find its name referenced often in archives
via google.  A much more interesting argument is whether we should not
have an explicit O_STREAMING but instead an intelligent drop-behind
heuristic... but that is a 2.5 issue and the patch is for 2.4.

20% increase in kernel compilation is amazingly nice, for free.

	Robert Love

