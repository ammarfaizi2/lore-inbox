Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUA0OAA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 09:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUA0OAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 09:00:00 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:16592 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263618AbUA0N76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 08:59:58 -0500
Subject: Re: [PATCH] kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, george@mvista.com, amitkale@emsyssoft.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040126192840.0c1694b9.akpm@osdl.org>
References: <20040127030529.8F860C60FC@h00e098094f32.ne.client2.attbi.com>
	 <20040126192840.0c1694b9.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1075211939.1020.78.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 27 Jan 2004 08:58:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-26 at 22:28, Andrew Morton wrote:
> Jim Houston <jim.houston@comcast.net> wrote:
> >
> > The attached patch updates my kgdb-x86_64-support.patch to work
> >  with linux-2.6.2-rc1-mm3.
> 
> Thanks.  Why does it relocate the call to trap_init() in start_kernel()?

Hi Andrew,

Moving trap_init() before parse_args() makes the "gdb" command line
option work.

On the i386 George has a few lines of code in breakpoint() which do 
enough setup to allow a break point trap to enter kgdb early in the
boot.  I played with similar code on x86_64, but it didn't work.
Handling a break point trap requires some of the initialization
done in cpu_init().  I suspect the difference is the per-cpu-data
referenced using %gs.

Jim Houston - Concurrent Computer Corp.

