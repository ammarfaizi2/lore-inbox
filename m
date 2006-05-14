Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWENGhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWENGhi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 02:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWENGhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 02:37:37 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:41399 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751124AbWENGhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 02:37:37 -0400
Date: Sun, 14 May 2006 08:37:31 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       Jochen =?iso-8859-1?Q?Sch=E4uble?= <psionic@psionic.de>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mtd: fix memory leaks in phram_setup
Message-ID: <20060514063731.GA22033@wohnheim.fh-wedel.de>
References: <200605140107.18293.jesper.juhl@gmail.com> <1147562300.12379.1.camel@pmac.infradead.org> <9a8748490605131634w73b8d40ax278fac343602123b@mail.gmail.com> <1147563643.16761.1.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1147563643.16761.1.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 May 2006 00:40:42 +0100, David Woodhouse wrote:
> >
> > Want me to fix the macro and the users of it?
> 
> Well, the exclamation was intended to provoke Jörn or Jochen into fixing
> it for themselves, but if you get there first that'd be great too :)

The only question is: does it make the code better?  The code has
seven printk/return combinations.  Each of them would chew up 2 more
lines without the macro.  So phram_setup would grow from 44 to 58
lines, not nice either.

What bugs me more is the hidden allocation in parse_name.  Looks like
that should return a pointer or ERR_PTR(foo), not an int.

Jörn

-- 
There are two ways of constructing a software design: one way is to make
it so simple that there are obviously no deficiencies, and the other is
to make it so complicated that there are no obvious deficiencies.
-- C. A. R. Hoare
