Return-Path: <linux-kernel-owner+w=401wt.eu-S1161124AbXAEPlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbXAEPlR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 10:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbXAEPlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 10:41:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51783 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161124AbXAEPlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 10:41:16 -0500
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
	bad_inode_ops return values
From: Arjan van de Ven <arjan@infradead.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>, Linus Torvalds <torvalds@osdl.org>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
In-Reply-To: <20070104235226.GA17561@ftp.linux.org.uk>
References: <20070104105430.1de994a7.akpm@osdl.org>
	 <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org>
	 <20070104191451.GW17561@ftp.linux.org.uk>
	 <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org>
	 <20070104202412.GY17561@ftp.linux.org.uk>
	 <20070104215206.GZ17561@ftp.linux.org.uk>
	 <20070104223856.GA79126@gaz.sfgoth.com>
	 <Pine.LNX.4.64.0701041428510.3661@woody.osdl.org>
	 <20070104232106.GK35756@gaz.sfgoth.com>
	 <20070104235226.GA17561@ftp.linux.org.uk>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 05 Jan 2007 07:40:53 -0800
Message-Id: <1168011653.3075.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-04 at 23:52 +0000, Al Viro wrote:
> On Thu, Jan 04, 2007 at 03:21:06PM -0800, Mitchell Blank Jr wrote:
> > Linus Torvalds wrote:
> > > Well, that probably would work, but it's also true that returning a 64-bit 
> > > value on a 32-bit platform really _does_ depend on more than the size.
> > 
> > Yeah, obviously this is restricted to the signed-integer case.  My point
> > was just that you could have the compiler figure out which variant to pick
> > for loff_t automatically.
> > 
> > > "let's not play tricks with function types at all".
> > 
> > I think I agree.  The real (but harder) fix for the wasted space issue
> > would be to get the toolchain to automatically combine functions that
> > end up compiling into identical assembly.
> 
> Can't do.
> 

you could if it's static and never has it's address taken (but that's
not the case here)


> You _can_ compile g into jump to f, but that's it.  And that, AFAICS,
> is what gcc does.

I thought we actually disabled that in the kernel (it makes oopses
harder to read)....



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

