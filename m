Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266131AbUA1UQD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUA1UQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:16:03 -0500
Received: from ns.suse.de ([195.135.220.2]:35979 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266106AbUA1UP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:15:58 -0500
Date: Wed, 28 Jan 2004 21:15:54 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: willy@debian.org, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
Message-Id: <20040128211554.0cc890fb.ak@suse.de>
In-Reply-To: <Pine.LNX.4.58.0401281205250.28145@home.osdl.org>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
	<Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
	<20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0401281129570.28145@home.osdl.org>
	<20040128204049.627e6312.ak@suse.de>
	<Pine.LNX.4.58.0401281205250.28145@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 12:06:12 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Wed, 28 Jan 2004, Andi Kleen wrote:
> >
> > On Wed, 28 Jan 2004 11:33:33 -0800 (PST)
> > Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > > For example, if checking for an error involves actually reading a value 
> > > from a bridge register, then that implies some _serious_ amount of 
> > > serialization and external CPU stuff.
> > 
> > Which is _extremly_ hard to do from an MCE handler ...
> 
> So don't do it in the MCE handler.
> 
> Just set a flag aka "may need checking", and let the check be done by the 
> actual "read_pcix_error()" code.

Where would you put the flag? 

Doing it global may give false errors for the wrong device with async MCEs
and on SMP.

For putting it into the pci_dev you need to take logs to walk the list.
If you delay it to a softirq for safely getting the lock it would be set too late.

Putting it into a different table indexed by pci index would be also racy 
with hotplug.

-Andi
