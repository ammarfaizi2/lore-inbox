Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWGIFYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWGIFYe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 01:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWGIFYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 01:24:34 -0400
Received: from xenotime.net ([66.160.160.81]:51074 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964995AbWGIFYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 01:24:34 -0400
Date: Sat, 8 Jul 2006 22:27:19 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, adaplas@gmail.com
Subject: Re: Opinions on removing /proc/tty?
Message-Id: <20060708222719.36c8fbb7.rdunlap@xenotime.net>
In-Reply-To: <9e4733910607082220v754a000ak7e75ae4042a5e595@mail.gmail.com>
References: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com>
	<20060707223043.31488bca.rdunlap@xenotime.net>
	<9e4733910607072256q65188526uc5cb706ec3ecbaee@mail.gmail.com>
	<20060708220414.c8f1476e.rdunlap@xenotime.net>
	<9e4733910607082220v754a000ak7e75ae4042a5e595@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 01:20:12 -0400 Jon Smirl wrote:

> On 7/9/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Sat, 8 Jul 2006 01:56:02 -0400 Jon Smirl wrote:
> >
> > > On 7/8/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > > > I don't know how well this is an answer to your question,
> > > > but I would like to be able to find a list of registered "consoles,"
> > > > whether they be serial, usbserial, netconsole, lp, or whatever.
> > > > /proc/tty/drivers does that partially.
> > >
> > > Console is an overloaded word. Do you want to know where it is legal
> > > to send system log output to, or do you want to know where you can log
> > > in from? There was a thread earlier that talked a little about
> > > controlling this.
> >
> > I have a working definition:
> > I want to see a list of drivers that have called register_console().
> >
> > > > I have a patch that also does it in /proc/consoles:
> > > >   http://www.xenotime.net/linux/patches/consoles-list.patch
> > > > Is somewhere in /sys the right place to find a list of all consoles?
> > >
> > > /sys is the right place for this info but a class does not exist for it yet.
> >
> > I want a list of registered consoles.  How would I express that in /sys ?
> 
> You could make the list appear as an attribute in
> /sys/class/tty/console. You will need to all a little sysfs code after
> the console tty device is created.
> 
> >
> > > Your patch isn't printing correctly. It is supposed to write the
> > > output to seq_file, not use printk.
> >
> > Pray tell where does it call printk()?
> >
> 
> +	for (con = console_drivers; con; con = con->next)
> +		printk("%d: %-8s %c:%c:%c flags:%s%s%s%s%s\n",
> +			con->index, con->name,
> +			con->read ? 'R' : 'x',

Ack, don't know how I missed that.

---
~Randy
