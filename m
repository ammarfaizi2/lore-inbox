Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266706AbUBEUN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbUBEUN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:13:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:61397 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266706AbUBEUNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:13:14 -0500
Date: Thu, 5 Feb 2004 12:14:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ben Collins <bcollins@debian.org>
Cc: greg@kroah.com, robert@gadsdon.giointernet.co.uk,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Message-Id: <20040205121457.50d2be05.akpm@osdl.org>
In-Reply-To: <20040205182928.GA1042@phunnypharm.org>
References: <fa.h1qu7q8.n6mopi@ifi.uio.no>
	<402240F9.3050607@gadsdon.giointernet.co.uk>
	<20040205182614.GG13075@kroah.com>
	<20040205182928.GA1042@phunnypharm.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@debian.org> wrote:
>
> On Thu, Feb 05, 2004 at 10:26:14AM -0800, Greg KH wrote:
> > On Thu, Feb 05, 2004 at 01:11:21PM +0000, Robert Gadsdon wrote:
> > > 2.6.2-mm1 tombstone "Badness in kobject_get....." when booting:
> > 
> > Oooh, not nice.  That means a kobject is being used before it has been
> > initialized.  Glad to see that check finally helps out...
> > 
> > > ieee1394: Host added: ID:BUS[0-00:1023]  GUID[090050c50000046f]
> > > Badness in kobject_get at lib/kobject.c:431
> > > Call Trace:
> > >  [<c0239966>] kobject_get+0x36/0x40
> > >  [<c027cc73>] get_device+0x13/0x20
> > >  [<c027d899>] bus_for_each_dev+0x59/0xc0
> > >  [<d0939355>] nodemgr_node_probe+0x55/0x120 [ieee1394]
> > >  [<d0939200>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
> > >  [<d0939748>] nodemgr_host_thread+0x168/0x190 [ieee1394]
> > >  [<d09395e0>] nodemgr_host_thread+0x0/0x190 [ieee1394]
> > >  [<c010ac15>] kernel_thread_helper+0x5/0x10
> > 
> > Looks like one of the ieee1394 patches causes this.  Ben?
> 
> Andrew, does 2.6.2-mm1 have that big ieee1394 patch, or is this the same
> as stock 2.6.2?

2.6.2-mm1 has no ieee1394 patch - it's the same as 2.6.2, apart from some
tweaks to eth1394.c from Jeff.

(It was _supposed_ to have the big patch, but I mucked up somewhere and
lost it)
