Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755173AbWKVPct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbWKVPct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 10:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbWKVPct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 10:32:49 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:2276 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1755173AbWKVPct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 10:32:49 -0500
Date: Wed, 22 Nov 2006 10:32:47 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch -mm 2/2] driver core: Introduce device_move(): move a
 device
Message-ID: <Pine.LNX.4.44L0.0611221024340.3038-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cornelia Huck wrote:

> +	if (old_parent)
> +		klist_del(&dev->knode_parent);
> +	klist_add_tail(&dev->knode_parent, &new_parent->klist_children);

> +			klist_del(&dev->knode_parent);
> +			if (old_parent)
> +				klist_add_tail(&dev->knode_parent,
> 						&old_parent->klist_children);

This is wrong.  klist_del() does not wait for the knode to be removed from 
its klist.  You need to use klist_remove().

I don't see any protection against new_parent being removed while dev is
being transferred under it.  Are you relying on the caller to make sure
this never happens?

Alan Stern

