Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbTIAWst (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTIAWst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:48:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6152 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263337AbTIAWso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:48:44 -0400
Date: Mon, 1 Sep 2003 23:48:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030901234840.H22682@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Linus Torvalds <torvalds@osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <20030831232812.GA129@elf.ucw.cz> <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org> <20030901211220.GD342@elf.ucw.cz> <20030901225243.D22682@flint.arm.linux.org.uk> <20030901221920.GE342@elf.ucw.cz> <20030901233023.F22682@flint.arm.linux.org.uk> <20030901224018.GA470@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030901224018.GA470@elf.ucw.cz>; from pavel@ucw.cz on Tue, Sep 02, 2003 at 12:40:18AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 12:40:18AM +0200, Pavel Machek wrote:
> > The main advantage from a driver writers point of view is the disposal
> > of the "level" argument.  (Doesn't really affect x86, PCI drivers never
> > had visibility of this.)
> 
> Yes, "level" is gone, instead we have very ugly
> -EAGAIN-means-call-me-with-interrupts-disabled hack.

>From a driver writers point of view, that's something I won't be using.
If I'm told to suspend, I better suspend.  If the driver model is calling
me out of sequence (because there are other children depending on me)
then it hasn't taken notice of my ordering requirements.

(Note - this bit isn't complete, but then the new model is no worse off
than the old model at present with respect to that issue.  The new model
does provide the interfaces to allow drivers to specify these dependencies
though.)

> > However, I'll let the PPC people justify the real reason for the driver
> > model change, since it was /their/ requirement that caused it, and I'm
> > not going to fight their battles for them.  (although I seem to be doing
> > exactly that while wasting my time here.)
> 
> I noticed something going on, but it seem to me one more "struct bus"
> would have solved that...

I've no idea what the PPC problem exactly was.  It's up to the PPC guys
to speak up *now*.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

