Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUJLSxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUJLSxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUJLSxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:53:34 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:15333 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S267595AbUJLSwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:52:36 -0400
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Totally broken PCI PM calls
Date: Tue, 12 Oct 2004 11:28:33 -0700
User-Agent: KMail/1.6.2
Cc: Stefan Seyfried <seife@suse.de>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       ncunningham@linuxmail.org
References: <1097455528.25489.9.camel@gaston> <200410111959.53048.david-b@pacbell.net> <20041012085440.GB2292@elf.ucw.cz>
In-Reply-To: <20041012085440.GB2292@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410121128.33861.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 October 2004 1:54 am, Pavel Machek wrote:
> > > echo disk > /sys/power/state
> > 
> > Oddly enough, neither of them work lately for me.
> > They each resume immediately after writing the
> > image to disk.
> 
> dmesg would help....

This is with /sys/power/disk set up for "shutdown";
the system didn't actually shut down, it restarted
the CPU right after snapshotting.

Stopping tasks: ===================|
Freeing 
memory: ........................................................................................................|
Freezing CPUs (at 0)...ok
PM: Attempting to suspend to disk.
PM: snapshotting memory.
Restarting CPUs...ok
Restarting tasks... done
eth0: Media Link On 10mbps half-duplex 

I've not had time to try that on other systems.  Reverting
the change to map PCI states didn't improve things.


> > p.s. I find the /sys/power/disk file mildly cryptic, maybe
> >     other folk will find the attached patch slightly more
> >     informative about what this interface can do.
> >  
> 
> Hmm, its interface change, 

To an file that was just added recently, making it more
like the other file in that same directory.

> and was not /sys expected to be "one file, 
> one value"?

It is one value -- a set!  OK, the active member
of that set is distinguished.  The power/state file
could do the same thing (but the active state
there would always be "on").


- Dave
