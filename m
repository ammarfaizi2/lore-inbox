Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423035AbWJaJtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423035AbWJaJtn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423037AbWJaJtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:49:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423035AbWJaJtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:49:42 -0500
Date: Tue, 31 Oct 2006 01:49:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc3] i386/io_apic: fix compiler warning in
 create_irq
Message-Id: <20061031014914.9af0dde9.akpm@osdl.org>
In-Reply-To: <1162287457.15286.186.camel@earth>
References: <tkrat.b1c929dd899e625a@s5r6.in-berlin.de>
	<20061030090231.GA27146@elte.hu>
	<20061030170445.1dedce1e.akpm@osdl.org>
	<1162287457.15286.186.camel@earth>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 10:37:37 +0100
Ingo Molnar <mingo@redhat.com> wrote:

> On Mon, 2006-10-30 at 17:04 -0800, Andrew Morton wrote:
> > > >     irq = -ENOSPC;
> > > > +   vector = 0;
> > > 
> > > NAK - the code is fine, and this is fixed in Jeff's gcc-warnings
> > tree 
> > > via annotation.
> > 
> > err, what gcc-warnings tree?
> > 
> > git
> > +ssh://master.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git#gccbug
> > just does lots of initialise-to-zero thingies, doesn't have any
> > special
> > annotation and doesn't fix io_apic.c.
> 
> this is an initialize-to-zero annotation for a false-positive gcc
> warning. If it's not in Jeff tree yet then it should be there ...
> 

hm, I wouldn't call that "annotation".


Now, the

#define SHUT_GCC_UP(x)	= x

	...
	int foo SHUT_GCC_UP(foo);
	...

(or whatever it was) trick was "annotation".  A good way of doing it too, IMO.
