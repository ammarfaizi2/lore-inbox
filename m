Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265166AbTF1LHg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 07:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbTF1LHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 07:07:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63967 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265166AbTF1LHf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 07:07:35 -0400
Date: Sat, 28 Jun 2003 12:21:51 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre2 unresolved proc_get_inode
Message-ID: <20030628112151.GC27348@parcelfarce.linux.theplanet.co.uk>
References: <5.1.0.14.2.20030628123855.00aefd18@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030628123855.00aefd18@pop.t-online.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 12:40:36PM +0200, Margit Schubert-While wrote:
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.22-pre2; fi
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.22-pre2/kernel/drivers/net/wan/comx.o
> depmod:         proc_get_inode
> 
> I suppose we let Christoph and Marc fight it out.

You know what?  I'm so fed up with that crap, that today Marcelo will
get a patch killing proc_get_inode(), making proc_lookup() static and
eliminating ->proc_iops completely.

Enough is enough.  comx is the only user of that crap and all procfs
code in comx is broken by design and trivially exploitable.  It's
unsalvagable and any attempt to fix it will amount to rewrite from
scratch anyway.

It's not a new problem, it had been discussed to hell and back and
comx folks could not have been arsed to do anything about it in what,
3 years?
