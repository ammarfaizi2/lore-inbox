Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWIWFUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWIWFUF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 01:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWIWFUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 01:20:04 -0400
Received: from 1wt.eu ([62.212.114.60]:11283 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751034AbWIWFUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 01:20:03 -0400
Date: Sat, 23 Sep 2006 06:56:10 +0200
From: Willy Tarreau <w@1wt.eu>
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060923045610.GM541@1wt.eu>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922230928.GB22830@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Hi Adrian,

On Fri, Sep 22, 2006 at 04:09:28PM -0700, Greg KH wrote:

> If you want to accept new drivers and backports like this, I think you
> will find it very hard to determine what to say yes or no to in the
> future.  It's the main problem that everyone who has tried to maintain a
> stable tree has run into, that is why we set up the -stable rules to be
> what they are for that very reason.

When I started the 2.4-hotfix tree nearly two years ago, I wanted to
avoid merging drivers changes as much as possible. And particularly,
I avoided to add support for new hardware. The reason is very simple.
I want to be able to guarantee that if 2.4.X works, then any 2.4.X.Y
does too so that they can blindly upgrade. And if, for any reason,
people suspect that 2.4.X.Y might have brought a bug, then reverting
to 2.4.X.Z(Z<Y) should at most bring back older bugs but not remove
previous support for any hardware. The problem with new hardware
support is that it can break sensible setups :

  - adding a new network card support will cause existing cards to be
    renumberred (it happened to me on several production systems when
    switching from 2.2 to 2.4)

  - adding support for a new IDE controller can cause hda to become
    hdc, or worse, hda to become sda (problems encountered when adding
    libata support)

  - enabling some devices might lock up memory and/or I/O address ranges
    on a bus leading to other devices not working anymore. I had this
    problem when using dlink 580 quad port nics in some buggy machines
    already equipped with adaptec starfire nics.

  - other core devices might cause system instability without the
    admin being aware they're really used (eg: ACPI, ...)

Since hardware diversity is so high that nobody can know everything, I
think it's better to avoid playing alone with people's hardware, but I
agree it's sometimes very hard to resist.

Adrian, when you have a doubt whether such a fix should go into next
release, simply tell people about the problem and ask them to test
current driver. If nobody encounters the problem, you can safely keep
the patch in your fridge until someone complains. By that time, the
risks associated with this patch will be better known.

> > "is not really allowed under the current -stable rules" is a bit hard to 
> > answer, but considering that "Missing PCI id update for VIA IDE" was OK 
> > for 2.6.17.12 I'd say it's consistent with what you are doing.
> 
> That was a bugfix as the driver could not access that device without
> that fix.

Even this might be dangerous in late -stable releases, unless it was a
recent regression.

Just my 2 cents,
Willy

