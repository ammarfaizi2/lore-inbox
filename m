Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVFUXmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVFUXmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 19:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVFUXiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 19:38:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:7134 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262423AbVFUXfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 19:35:46 -0400
Date: Tue, 21 Jun 2005 16:13:41 -0700
From: Greg KH <greg@kroah.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org
Subject: Re: [PATCH] Add initial implementation of klist helpers.
Message-ID: <20050621231340.GA24612@kroah.com>
References: <1119308365601@kroah.com> <Pine.LNX.4.61.0506210740220.10499@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506210740220.10499@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 07:42:26AM -0400, Rik van Riel wrote:
> On Mon, 20 Jun 2005, Greg KH wrote:
> 
> > Internally, that routine takes the klist's lock, decrements the reference
> > count of the previous klist_node and increments the count of the next
> > klist_node. It then drops the lock and returns.
> 
> Sacrificing performance for scalability has never been
> the right thing in the past.  Why would it be right now?

This is not a performance critical piece of code at all.  It's used to
walk devices and drivers and busses at device insertion and removal
time, and at module load and unload.  All of which are not bottlenecks
in benchmarks :)

Now if people want to use this for performance critical stuff, that
would be a different story.  But the odds that they would be doing this
with kobjects would be very slim...

thanks,

greg k-h
