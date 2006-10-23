Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWJWRv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWJWRv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWJWRv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:51:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964971AbWJWRv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:51:28 -0400
Date: Mon, 23 Oct 2006 10:50:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@sisk.pl, ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-Id: <20061023105022.8b1dc75d.akpm@osdl.org>
In-Reply-To: <20061023171450.GA3766@elf.ucw.cz>
References: <1161576735.3466.7.camel@nigel.suspend2.net>
	<200610231236.54317.rjw@sisk.pl>
	<1161605379.3315.23.camel@nigel.suspend2.net>
	<200610231607.17525.rjw@sisk.pl>
	<20061023095522.e837ad89.akpm@osdl.org>
	<20061023171450.GA3766@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 23 Oct 2006 19:14:50 +0200 Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2006-10-23 09:55:22, Andrew Morton wrote:
> > > On Mon, 23 Oct 2006 16:07:16 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > I'm trying to prepare the patches to make swsusp into suspend2.
> > > 
> > > Oh, I see.  Please don't do that.
> > 
> > Why not?
> 
> Last time I checked, suspend2 was 15000 lines of code, including its
> own plugin system and special user-kernel protocol for drawing
> progress bar (netlink based). It also did parts of user interface from

That's different.

I don't know where these patches are leading, but thus far they look like
reasonable cleanups and generalisations.  So I suggest we just take them
one at a time.

> 
> OTOH, that was half a year ago, but given that uswsusp can now do most
> of the stuff suspend2 does (and without that 15000 lines of code), I
> do not think we want to do complete rewrite of swsusp now.

uswsusp seems like a bad idea to me.  We'd be better off concentrating on a
simple, clean in-kernel thing which *works*.  Right now the main problems
with swsusp are that it's slow and that there are driver problems. 
(Actually these are both driver problems).

Fiddling with the top-level interfaces doesn't address either of these core
problems.

Apparently uswsusp has gained support for S3 while the in-kernel driver
does not support S3.  That's disappointing.

