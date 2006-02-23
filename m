Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWBWWmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWBWWmd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 17:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbWBWWmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 17:42:33 -0500
Received: from kanga.kvack.org ([66.96.29.28]:32650 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751304AbWBWWmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 17:42:33 -0500
Date: Thu, 23 Feb 2006 17:37:29 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Avoid calling down_read and down_write during startup
Message-ID: <20060223223729.GE30329@kvack.org>
References: <20060223110350.49c8b869.akpm@osdl.org> <Pine.LNX.4.44L0.0602231728300.4579-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0602231728300.4579-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 05:36:56PM -0500, Alan Stern wrote:
> This patch (as660) changes the registration and unregistration routines 
> for blocking notifier chains.  During system startup, when task switching 
> is illegal, the routines will avoid calling down_write().

Why is that necessary?  The down_write() will immediately succeed as no 
other process can possibly be holding the lock when the system is booting, 
so the special casing doesn't fix anything.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
