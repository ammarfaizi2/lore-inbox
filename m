Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbWARUXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWARUXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWARUXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:23:22 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:62162 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030413AbWARUXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:23:22 -0500
Date: Wed, 18 Jan 2006 15:23:20 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Andrew Morton <akpm@osdl.org>, Chandra Seetharaman <sekharan@us.ibm.com>,
       Keith Owens <kaos@sgi.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] Notifier chain update
In-Reply-To: <20060118181955.GF16285@kvack.org>
Message-ID: <Pine.LNX.4.44L0.0601181517060.4974-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Benjamin LaHaise wrote:

> On Wed, Jan 18, 2006 at 11:34:12AM -0500, Alan Stern wrote:
> > There are some limitations, which should not be too hard to live with.
> > For atomic/blocking chains, registration and unregistration must
> > always be done in a process context since the chain is protected by a
> > mutex/rwsem.  Also, a callout routine for a non-raw chain must not try
> > to register or unregister entries on its own chain.  (This did happen
> > in a couple of places and the code had to be changed to avoid it.)
> 
> This is bad, as rwsems are pretty much guaranteed to be a cache miss on 
> smp systems, so their addition makes these code paths scale much more 
> poorly than is needed.  Given the current approach to modules, would it 
> not make sense to simply require that any code that the notifier paths 
> touch simply remain loaded in the kernel?  In that case rcu protection 
> of the pointers would suffice for the hooks.

You can't use RCU protection around code that may sleep.  Whether the code
remains loaded in the kernel or is part of a removable module doesn't
enter into it.

Alan Stern

