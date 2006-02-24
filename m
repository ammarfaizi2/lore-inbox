Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWBXOoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWBXOoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 09:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWBXOoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 09:44:12 -0500
Received: from kanga.kvack.org ([66.96.29.28]:28320 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932099AbWBXOoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 09:44:11 -0500
Date: Fri, 24 Feb 2006 09:39:00 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andrew Morton <akpm@osdl.org>
Cc: stern@rowland.harvard.edu, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Avoid calling down_read and down_write during startup
Message-ID: <20060224143900.GA7101@kvack.org>
References: <20060223110350.49c8b869.akpm@osdl.org> <Pine.LNX.4.44L0.0602231728300.4579-100000@iolanthe.rowland.org> <20060223223729.GE30329@kvack.org> <20060223161631.6f8fa41d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223161631.6f8fa41d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 04:16:31PM -0800, Andrew Morton wrote:
> down_write() unconditionally (and reasonably) does local_irq_enable() in
> the uncontended case.  And enabling local interrupts early in boot can
> cause crashes.

Why not do a down_write_trylock() instead first?  Then the code doesn't 
have the dependancy on system_state, which seems horribly fragile.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
