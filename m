Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbVKWWbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbVKWWbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVKWWbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:31:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12297 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932589AbVKWWbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:31:07 -0500
Date: Wed, 23 Nov 2005 22:30:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <galak@gate.crashing.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: overlapping resources for platform devices?
Message-ID: <20051123223057.GO15449@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <galak@gate.crashing.org>,
	Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051123115259.GA9560@flint.arm.linux.org.uk> <Pine.LNX.4.44.0511231245350.4255-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0511231245350.4255-100000@gate.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 12:48:55PM -0600, Kumar Gala wrote:
> On Wed, 23 Nov 2005, Russell King wrote:
> 
> > On Wed, Nov 23, 2005 at 12:57:40AM -0600, Kumar Gala wrote:
> > > Any update?
> > 
> > It should be okay, but I'll step back from saying "safe" because
> > I don't particularly like the insert_resource() concept.
> 
> Ok. Not sure how to take that.  Would you prefer we work around this some 
> other way? or your willing to take a patch but just hesitant about it 
> breaking something?

PCI survived this change, so I've no doubt that platform devices will
survive.  I just don't like it on a personal level because I worry
about the possibility of inappropriately inserting a resource above
some other resource.

Theoretically, if you have two platform devices which are mutually
exclusive, but use exactly the same resource range, with the existing
system only one will succeed.  My understanding of insert_resource
indicates that both will succeed, and you'll end up with one below
the other.

That's not too much of a problem as long as the drivers also request
the resources before using them.

But that's theory.  I don't know of any situation today where this
is presently true, or would be.

In the end, we can't have your behaviour without also having the
_possibility_ of this problem.  So let's have your behaviour as
it fixes a real problem you're seeing.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
