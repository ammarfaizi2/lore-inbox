Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbUBRW1D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267020AbUBRW1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:27:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:12741 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266499AbUBRW1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:27:00 -0500
Date: Wed, 18 Feb 2004 14:26:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Raphael Rigo <raphael.rigo@inp-net.eu.org>, linux-kernel@vger.kernel.org,
       andrea@suse.de
Subject: Re: New do_mremap vulnerabitily.
In-Reply-To: <4033E3A4.80509@nortelnetworks.com>
Message-ID: <Pine.LNX.4.58.0402181424120.2686@home.osdl.org>
References: <4033841A.6020802@inp-net.eu.org> <Pine.LNX.4.58.0402180954590.2686@home.osdl.org>
 <4033E3A4.80509@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Chris Friesen wrote:
> 
> There is still a call to do_munmap() that does not check the return 
> code, called from move_vma(), which in turn is called in do_mremap().
> 
> Can that call ever fail and cause Bad Things to happen?

Yes it can fail, and no, bad things can't happen. We could return the 
error code to user space, but on the other hand, by the time the munmap 
fails we would already have done 90% of the mremap(), so it doesn't much 
help user space to know that the old area still has a vma, but no pages 
associated with it.

		Linus
