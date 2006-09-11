Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWIKQ40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWIKQ40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 12:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWIKQ40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 12:56:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36550 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932301AbWIKQ4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 12:56:25 -0400
Date: Mon, 11 Sep 2006 09:51:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brandon Philips <brandon@ifup.org>
Cc: linux-kernel@vger.kernel.org, Brice Goglin <brice@myri.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Robert Love <rml@novell.com>
Subject: Re: 2.6.18-rc6-mm1 2.6.18-rc5-mm1 Kernel Panic on X60s
Message-Id: <20060911095106.2a7d6d95.akpm@osdl.org>
In-Reply-To: <20060911021400.GA6163@plankton.ifup.org>
References: <20060908174437.GA5926@plankton.ifup.org>
	<20060908121319.11a5dbb0.akpm@osdl.org>
	<20060908194300.GA5901@plankton.ifup.org>
	<20060908125053.c31b76e9.akpm@osdl.org>
	<20060911021400.GA6163@plankton.ifup.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Sep 2006 21:14:00 -0500
Brandon Philips <brandon@ifup.org> wrote:

> On 12:50 Fri 08 Sep 2006, Andrew Morton wrote:
> > On Fri, 8 Sep 2006 14:43:00 -0500
> > Brandon Philips <brandon@ifup.org> wrote:
> > > On 12:13 Fri 08 Sep 2006, Andrew Morton wrote:
> > > > On Fri, 8 Sep 2006 12:44:37 -0500
> > > > Brandon Philips <brandon@ifup.org> wrote:
> > > > > 2.6.18-rc4-mm3 boots ok.
> > > > > 
> > > > > I will try and bisect the problem later tonight-
> > > > 
> > > > Thanks.  First, try disabling CONFIG_PCI_MSI.
> > > 
> > > With CONFIG_PCI_MSI disabled the system boots.  
> > 
> > OK, thanks.
> > 
> > So likely candidates are:
> > 
> > - The conversion of i386 to use the genirq code
> 
> genirq-convert-the-i386-architecture-to-irq-chips.patch is causing the
> Kernel panic.
> 

OK, thanks.

I don't think this necessarily tells us where the bug lies.  It could be
some pre-existing thing in MSI, or it could be added by Bryce's changes. 
Or by Eric's.  Or, of course, by
genirq-convert-the-i386-architecture-to-irq-chips.patch.

There doesn't seem to be a lot of movement on this and we want to get the
x86 genirq conversion into 2.6.19.  Could be that we end up having to merge
known-buggy stuff into mainline and crash enough computers to irritate
someone into fixing it.  Rather sad.

