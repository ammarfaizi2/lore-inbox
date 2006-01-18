Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWARWJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWARWJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWARWJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:09:14 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:29068 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932547AbWARWJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:09:13 -0500
Date: Wed, 18 Jan 2006 17:09:10 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Andrew Morton <akpm@osdl.org>, Chandra Seetharaman <sekharan@us.ibm.com>,
       Keith Owens <kaos@sgi.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] Notifier chain update
In-Reply-To: <20060118220122.GH16285@kvack.org>
Message-ID: <Pine.LNX.4.44L0.0601181706210.14089-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Benjamin LaHaise wrote:

> The notifier interface is supposed to be *light weight*.

Again, where is that documented?

>  Adding locks 
> that get taken on every call basically changes the concept entirely.  The 
> cache misses notifiers add are measurable overhead, with locks being far 
> worse.

Which is worse: overhead due to cache misses or an oops caused by code 
being called after it was unloaded?

Do you have a better proposal for a way to prevent blocking notifier 
chains from being modified while in use?  Or would you prefer to rewrite 
all the callout routines that currently block, so that all the notifier 
chains can be made atomic and we don't need the blocking notifier API?

Alan Stern

