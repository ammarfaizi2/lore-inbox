Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVARTuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVARTuT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 14:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVARTsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 14:48:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21208 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261417AbVARTon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 14:44:43 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1106014803.30801.22.camel@localhost.localdomain> 
References: <1106014803.30801.22.camel@localhost.localdomain>  <31453.1105979239@redhat.com> 
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Fix kallsyms/insmod/rmmod race 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Tue, 18 Jan 2005 19:44:28 +0000
Message-ID: <1561.1106077468@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rusty Russell <rusty@rustcorp.com.au> wrote:

> 	The more I looked at this, the more I warmed to it.  I've known for a
> while that people are using kallsyms not for OOPS (eg. /proc/$$/wchan),
> so we should provide a "grabs locks" version, but this solution gets
> around that nicely, while making life more certain for the oops case,
> too.


Hmmm... though it works on i386 SMP, it doesn't, however, seem to work on
ppc64 SMP:-/

My pSeries box seems to think that it can't find any symbols from previously
loaded modules, and my Power5 box is quite happy to load modules that depend
on other modules but panics because it can't mount its root fs.

This is very odd, because the patch is simple enough. Is there anything
obvious I've missed that you can see? Or maybe I'm just misunderstanding how
stop_machine_run() works... maybe it can't be called during initialisation.

David
