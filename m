Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbTE3RsL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 13:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbTE3RsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 13:48:11 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:7314 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263847AbTE3RsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 13:48:10 -0400
Date: Fri, 30 May 2003 20:01:30 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: drivers/char/sysrq.c
Message-ID: <20030530180130.GB16687@wohnheim.fh-wedel.de>
References: <5.1.0.14.2.20030530164138.00aeee40@pop.t-online.de> <20030530145851.GA15640@wohnheim.fh-wedel.de> <20030530151317.GA3973@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030530151317.GA3973@werewolf.able.es>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 17:13:17 +0200, J.A. Magallon wrote:
> On 05.30, Jörn Engel wrote:
> > On Fri, 30 May 2003 16:44:55 +0200, Margit Schubert-While wrote:
> > > 
> > > In drivers/char/sysrq.c (2.4 and 2.5) we have :
> > > 
> > >         if ((key >= '0') & (key <= '9')) {
> > >                 retval = key - '0';
> > >         } else if ((key >= 'a') & (key <= 'z')) {
> > > 
> > > Shouldn't the "&" be (pedantically) "&&" ?
> > 
> > It is semantically the same.  If you can show that gcc optimization
> > also creates the same assembler code, few people will object to a
> > patch.
> > 
> 
> I see a diff:
> - & is bitwise and you always perform the op
> - && is logical and gcc must shortcut it
> 
> I think people use & 'cause they prefer the extra argument calculation
> than the branch for the shortcut (AFAIR...)

Yes, it is an optimization, nothing more.  Either code will behave the
same, but one version might be a little faster, depending on the cpu,
unless the compiler is already clever enough to do this himself.

Just wrote a small test program with both variants and tested on i386
with gcc 3.2.3 and 2.95.4, with -O2 and -Os.  The code generated was
identical in all eight cases.  So if ever this zero optimization
reduces readability of the code, write a patch and make it better.
Beats any spelling fixes.

Jörn

-- 
Eighty percent of success is showing up.
-- Woody Allen
