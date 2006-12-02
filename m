Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424447AbWLBV7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424447AbWLBV7q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 16:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424444AbWLBV7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 16:59:46 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53961 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1424324AbWLBV7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 16:59:45 -0500
Date: Sat, 2 Dec 2006 21:59:41 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061202215941.GN3078@ftp.linux.org.uk>
References: <20061201172149.GC3078@ftp.linux.org.uk> <1165084076.24604.56.camel@localhost.localdomain> <20061202184035.GL3078@ftp.linux.org.uk> <200612022243.58348.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612022243.58348.zippel@linux-m68k.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 10:43:58PM +0100, Roman Zippel wrote:

> You need some more magic macros to access/modify the data field.

Which is done bloody rarely.  grep and you'll see...  BTW, there are
other reasons why passing struct timer_list * is wrong:
	* direct calls of the timer callback
	* callback being the same for two timers embedded into
different structs
	* see a timer callback, decide it looks better as a tasklet.
What, need a different glue now?

Look, it's a delayed call.  The less glue we need, the better - the
rules are much simpler that way, so that alone means that we'll get
fewer fsckups.
