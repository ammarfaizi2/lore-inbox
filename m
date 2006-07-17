Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWGQP5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWGQP5x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWGQP5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:57:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:50600 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750896AbWGQP5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:57:52 -0400
Date: Mon, 17 Jul 2006 08:27:51 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: stable@kernel.org, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, rml@novell.com
Subject: Re: [stable] [patch-stable 2.6.16] pdflush: handle resume wakeups
Message-ID: <20060717152751.GD4888@kroah.com>
References: <20060708153731.GB1723@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060708153731.GB1723@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 05:37:31PM +0200, Pavel Machek wrote:
> 
> 2.6.16 needs this. It was merged into 2.6.18-rc1 in
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d616e09ab33aa4d013a93c9b393efd5cebf78521 .
> 
> pdflush is carefully designed to ensure that all wakeups have some
> corresponding work to do - if a woken-up pdflush thread discovers that
> it hasn't been given any work to do then this is considered an error.
> 
> That all broke when swsusp came along - because a timer-delivered
> wakeup to a frozen pdflush thread will just get lost.  This causes the
> pdflush thread to get lost as well: the writeback timer is supposed to
> be re-armed by pdflush in process context, but pdflush doesn't execute
> the callout which does this.
> 
> Fix that up by ignoring the return value from try_to_freeze(): jsut
> proceed, see if we have any work pending and only go back to sleep if
> that is not the case.

Queued to -stable, thanks.

greg k-h
