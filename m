Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTJVDEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 23:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTJVDEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 23:04:32 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:24201 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263388AbTJVDEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 23:04:30 -0400
Subject: Re: [RFC] must fix lists
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: piggin@cyberone.com.au,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Albert Cahalan <albert@users.sourceforge.net>, Andi Kleen <ak@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Dominik Brodowski <linux@brodo.de>,
       "David S. Miller" <davem@redhat.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jens Axboe <axboe@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       Mike Anderson <andmike@us.ibm.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <3F94C833.8040204@cyberone.com.au>
References: <3F94C833.8040204@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1066791032.25426.59.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Oct 2003 22:50:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-21 at 01:46, Nick Piggin wrote:

> -o (Albert Cahalan) Lots of people (check Google) get this message from the
> -  kernel:
> -
> -  psmouse.c: Lost synchronization, throwing 2 bytes away.
> -
> -  (the number of bytes will be 1, 2, or 3)
> -
> -  At work, I get it when there is heavy NFS traffic.  The mouse goes crazy,
> -  jumping around and doing random cut-and-paste all over everything.  This
> -  is with a decently fast and modern PC.

I'm pretty sure this problem is NOT fixed and is NOT
related to the problems with support for some oddball
touchpad thing.

The system in question would also lose time when
under heavy load. Note that HZ is now 1000 HZ.
If interrupts are kept off for too long or an
SMI grabs the CPU...

Another infuriating symptom is that, when Linux
detects that the TSC doesn't match jiffies, the
TSC usage is turned off. There goes the only GOOD
time source, tossed aside in favor of a bad one.
Fix for that: if jiffies fall behind the TSC,
trust the TSC -- you've lost some clock ticks.


