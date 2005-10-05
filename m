Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbVJEMxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbVJEMxx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 08:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbVJEMxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 08:53:53 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:49034 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S965156AbVJEMxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 08:53:53 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Free swap suspend from depending upon PageReserved.
Date: Wed, 5 Oct 2005 14:54:55 +0200
User-Agent: KMail/1.8.2
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1128506536.5514.13.camel@localhost> <20051005121222.GA22580@elf.ucw.cz>
In-Reply-To: <20051005121222.GA22580@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510051454.56096.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 5 of October 2005 14:12, Pavel Machek wrote:
> Hi!
> 
> > Here's the patch we've previously discussed, which removes the
> > dependancy of swap suspend on PageReserved.
> 
> This ends up in Linus' changelog, so "we've previously discussed"
> is not okay here. Missing signed-off. What is benefit of this?
> 
> swsusp part looks okay, but will Andrew like the generic part? I guess
> I'd prefer to postpone this one (unless we are last user of
> PageReserved) -- I do not see too big benefit and there's potential
> for breakage.

Basically, what it does is to make swsusp avoid saving (and restoring)
non-RAM pages (like the ISA hole, BIOS etc.).  I think it is a nice thing
to do and it does not hurt anyone (it only clears and/or sets PG_nosave
at some places).  However, if we decide to do this for i386, it should
also be done for x86-64.

Greetings,
Rafael
