Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbTL3GmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 01:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbTL3GmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 01:42:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:60040 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264428AbTL3GmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 01:42:14 -0500
Date: Mon, 29 Dec 2003 22:42:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Murray J. Root" <murrayr@brain.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 kernel panic
In-Reply-To: <20031230033036.GA2158@Master.Wizards>
Message-ID: <Pine.LNX.4.58.0312292238390.4176@home.osdl.org>
References: <20031228020759.GA2158@Master.Wizards> <20031230033036.GA2158@Master.Wizards>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, Murray J. Root wrote:
> On Sat, Dec 27, 2003 at 09:07:59PM -0500, Murray J. Root wrote:
> > P4 2GHz
> > ASUS P4S533 mainboard
> > 1G PC2700 RAM
> > GF2 GTS video using nv driver
> > 2.6.0 compiled with gcc 3.3.2
> > 
> > At boot kernel gets:
> >    INIT: cannot execute "/etc/rc.d/rc.sysinit"
> > then panic.
> > 
> > Same configuration for 2.6.0-test11 and earlier works fine.
> > 
> 
> To answer myself, I did a diff between 2.6.0-test11 and 2.6.0. Found this:

Sounds like one of the partitions that has the executable script loader is
mounted with "noexec". 

On most systems, /etc/rc.d/rc.sysinit is a bash script, and explicitly
points to /bin/bash. Check "ldd /bin/bash", and verify that all the
libraries (and /bin itself, of course) are mounted on executable
filesystems.

That would be a bug that 2.6.0 uncovers. 

		Linus
