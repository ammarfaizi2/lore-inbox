Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVC2Qig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVC2Qig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVC2Qig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:38:36 -0500
Received: from digitalimplant.org ([64.62.235.95]:945 "HELO digitalimplant.org")
	by vger.kernel.org with SMTP id S261210AbVC2QiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:38:21 -0500
Date: Tue, 29 Mar 2005 08:38:11 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Alan Stern <stern@rowland.harvard.edu>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.44L0.0503281417370.1185-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.50.0503290823170.9904-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503281417370.1185-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Mar 2005, Alan Stern wrote:

> On Mon, 28 Mar 2005, Patrick Mochel wrote:

> > Do you have suggestions about an alternative (with code)?
>
> Here's something a little better than pseudocode but not as good as a
> patch... :-)

> To fill the first field in correctly requires that klist creation use a
> macro; the details are unimportant.  What is important is that during
> klist_node_init you add:

In principle, you're right. Kind of. We need to tie the "usage" reference
count of the klist_node to the containing objects' "lifetime" count. But,
there is no need to confuscate the klist code to do it. At least not at
this point.

The subsystems that use the code must be sure to appropriately manage the
lifetime rules of the containing objects. That is true no matter what.
When they add a node, they should increment the reference count of the
containing object and decrement when the node is removed. If practice
shows that there is more that can be rolled into the model, then we can
revisit it later.

[ Sidebar: Perhaps we can add a callback parameter to klist_remove() to
call when the node has been removed, instead of the struct completion. ]


	Pat
