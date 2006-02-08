Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030564AbWBHQdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030564AbWBHQdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030584AbWBHQdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:33:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:19121 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030564AbWBHQdJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:33:09 -0500
Date: Wed, 8 Feb 2006 16:33:08 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH 02/17] mips: namespace pollution - mem_... -> __mem_... in io.h
Message-ID: <20060208163308.GI27946@ftp.linux.org.uk>
References: <E1F6jSx-0002TE-Ur@ZenIV.linux.org.uk> <Pine.LNX.4.64N.0602081059020.27639@blysk.ds.pg.gda.pl> <20060208161435.GH27946@ftp.linux.org.uk> <Pine.LNX.4.64N.0602081615280.27639@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0602081615280.27639@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 04:21:45PM +0000, Maciej W. Rozycki wrote:
> On Wed, 8 Feb 2006, Al Viro wrote:
> 
> > >  Then the corresponding ones with no "mem_" prefix (these for the PCI I/O 
> > > port space) should be prefixed with "__" for consistency as well.
> > 
> > Huh???
> > 
> > Things like outb(), etc. *are* public; mem_... ones are not. 
> 
>  I mean if we rename e.g. mem_ioswabb() to __mem_ioswabb(), then we should 
> rename ioswabb() to __ioswabb() as well.  Sorry for not having been clear 
> enough, but I have assumed it is obvious.

In principle that would be nice, but...  Take a look at those macros.
We can do that, but it would mean #define readb __readb, etc.  Since
really nasty clashes are in mem_inb() et.al. (let's face it, coming up
with one of those is far more likely than using ioswabb() for driver-internal
purposes) I've stopped at that.  Can do a followup switching to __ioswab...
and adding defines compensating for changes in visible symbols, but IMO
that's a separate patch...
