Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936837AbWLDN3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936837AbWLDN3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 08:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936834AbWLDN3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 08:29:33 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:27661 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S936837AbWLDN3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 08:29:32 -0500
Date: Mon, 4 Dec 2006 13:29:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Roman Zippel <zippel@linux-m68k.org>,
       Al Viro <viro@ftp.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061204132916.GA24634@flint.arm.linux.org.uk>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Roman Zippel <zippel@linux-m68k.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1165084076.24604.56.camel@localhost.localdomain> <20061202184035.GL3078@ftp.linux.org.uk> <200612022243.58348.zippel@linux-m68k.org> <20061202215941.GN3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022306360.1867@scrub.home> <20061202224018.GO3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022345520.1867@scrub.home> <20061203102108.GA1724@elf.ucw.cz> <26864.1165230869@redhat.com> <29346.1165237409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29346.1165237409@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 01:03:29PM +0000, David Howells wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > I assume you wanted to delete "data" ?
> 
> Yes.
> 
> > Your premise is two timer_lists which use one common handler.
> > 
> > 	struct foo {
> > 		struct timer_list timer1;
> > 		strucr timer_list timer2;
> > 	};
> 
> That's not what I was thinking of.  I was thinking of something much simpler:
> 
> 	struct foo {
> 		struct timer_list timer;
> 	};
> 
> 
> 	...
> 		struct foo *a = kmalloc(sizeof(struct foo), GFP_KERNEL);
> 		a->timer.fn = do_foo_timer;
> 	...
> 		struct foo *b = kmalloc(sizeof(struct foo), GFP_KERNEL);
> 		b->timer.fn = do_foo_timer;
> 	...
> 		struct foo *c = kmalloc(sizeof(struct foo), GFP_KERNEL);
> 		c->timer.fn = do_foo_timer;
> 	...
> 		struct foo *d = kmalloc(sizeof(struct foo), GFP_KERNEL);
> 		d->timer.fn = do_foo_timer;
> 	...
> 
> You've now got four copies of struct timer_list, but only one handler.

<re-insert last paragraph of my message until read, understood and
actioned.>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
