Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUBRR7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUBRR5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:57:30 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32714
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S267676AbUBRR5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:57:22 -0500
Date: Wed, 18 Feb 2004 18:57:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: module unload deadlock
Message-ID: <20040218175715.GG4478@dualathlon.random>
References: <20040217172646.GT4478@dualathlon.random> <20040218041527.052222C510@lists.samba.org> <20040218043555.GY8858@parcelfarce.linux.theplanet.co.uk> <20040218154040.GZ4478@dualathlon.random> <20040218164659.GA31035@parcelfarce.linux.theplanet.co.uk> <20040218172446.GD4478@dualathlon.random> <20040218173740.GB31035@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218173740.GB31035@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 05:37:41PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Feb 18, 2004 at 06:24:46PM +0100, Andrea Arcangeli wrote:
> > The one you propose (of parport_pc keeping track of the ports by itself)
> > is a different model, currently it's the highlevel that keeps track of
> > the ports and each lowlevel registers the lowlevel ports in the
> > highlevel list of ports. It doesn't mean the current model is wrong. You
> > may not like it and you may find it less efficient, or less clean, or
> > whatever, but the current model is definitely legitimate (the parport
> > code has the troubles you found in the sharing code locking, but this
> > registration model you're complaining about now is legitimate instead).
> 
> RTFS.  And realize that parport_enumerate() exports the damn list with no
> protection whatsoever.  It is broken and it always had been broken.

it has not always had been broken, it was was serialized by the BKL when
I worked on that code the last time ;) (so it wasn't broken in 2.2, just nobody
fixed the locking when the kernel kept evolving)

the smp safety is broken, but the model is not obviously broken as you
claim. the locking of the list could be fixed simply with a
parport_lock spinlock or semaphore or whatever like that, you may prefer
to fix it differently keeping the list local in the lowlevel and
protected it to a private lock to parport_pc instead of making it
visible and exporting hte lock too, I'm just saying that part of the
code was legitimate at least in 2.2.
