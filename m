Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUAQPSh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 10:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbUAQPSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 10:18:37 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:12754 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266049AbUAQPSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 10:18:32 -0500
Subject: Re: [PATCH] Intel Alder IOAPIC fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m13cagbgrc.fsf@ebiederm.dsl.xmission.com>
References: <1073876117.2549.65.camel@mulgrave>
	<Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
	<1073948641.4178.76.camel@mulgrave>
	<Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
	<1073954751.4178.98.camel@mulgrave>
	<Pine.LNX.4.58.0401121621220.14305@evo.osdl.org>
	<1074012755.2173.135.camel@mulgrave>
	<m1smihg56u.fsf@ebiederm.dsl.xmission.com>
	<1074185897.1868.118.camel@mulgrave>
	<m17jztau8l.fsf@ebiederm.dsl.xmission.com>
	<1074196460.1868.250.camel@mulgrave> 
	<m13cagbgrc.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 17 Jan 2004 10:18:23 -0500
Message-Id: <1074352704.2015.8.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-16 at 00:32, Eric W. Biederman wrote:
> Yes, this is the extreme case.  In normal cases I would just
> expect to push to one side and probably shrink it to 0.  I guess
> I have something against implying a hierarchal relationship that
> does not exist.

Well, it makes sense to me that the resource would be a child of the
reserved area, because the reserved area covers the APICs and this
rather annoying PCI device has one of the IO APICs tied to BAR0.

In this case, we have a PCI device claiming something we already
discovered and made use of long ago in bootup.

> Right.  To me it looks like separate cases.  What I keep envisioning
> scanning the PCI devices and then realizing they are behind
> a bridge.  Before I go to far I guess I should ask.
> 
> The splitting/pushing aside looks especially useful for those
> cases where you subdivide the resource again.
> 
> As for the bridge case I think that is something different.  

The pragmatist in me says we can handle them all as a single case. 
Simply put, it means insert_resource() says "I know this belongs in the
resource tree, just put it in where it should go, please".  As long as
we make sure we only use it for the exception cases, it should all work
fine.

All I really want is to get the alter 4 and 8 way boxes working again,
I'm happy to go with whatever people decide about resources.  What other
uses are there for the TENTATIVE regions?

James


