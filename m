Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVIROjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVIROjL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVIROjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:39:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57547 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932079AbVIROjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:39:10 -0400
Date: Sun, 18 Sep 2005 15:39:07 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050918143907.GK19626@ftp.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127041474.8932.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127041474.8932.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 12:04:34PM +0100, Alan Cox wrote:
 
> Other good practice in many cases is a single routine which allocates
> and initialises the structure and is used by all allocators of that
> object. That removes duplicate initialisers, stops people forgetting to
> update all cases, allows better debug and far more.

Indeed.  IMO, argument for sizeof(*p) is bullshit - "I've changed a pointer
type and forgot to update the allocation and initialization, but this will
magically save my arse" is missing "except that initialization will remain
bogus" part.

I've seen a lot of bugs around bogus kmalloc+initialization, but I can't
recall a single case when such bug would be prevented by using that form.
If somebody has a different experience, please post pointers to changesets
in question.
