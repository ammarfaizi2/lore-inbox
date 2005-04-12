Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVDLQwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVDLQwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVDLQu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:50:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59040 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262447AbVDLQui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:50:38 -0400
Date: Tue, 12 Apr 2005 17:50:34 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix floppy disk dependencies
Message-ID: <20050412165034.GN8859@parcelfarce.linux.theplanet.co.uk>
References: <E1DL7Bg-0003C9-Vj@raistlin.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DL7Bg-0003C9-Vj@raistlin.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 11:15:20PM +0100, Russell King wrote:
> Both the RiscPC and (optionally) EBSA285 have floppy disk
> support.  Allow this option to be selected on these ARM
> platforms again.

I think it's a wrong approach.  Instead of this collection of
dependencies we should bite the bullet and put

config HAS_GENERIC_FDC
	bool
	default y

in arch/*/Kconfig of platforms that do have it and

config BLK_DEV_FD
	tristate "Normal floppy disk support"
        depends on HAS_GENERIC_FDC

in drivers/block/Kconfig.  That way we can express such dependencies
sanely without bringing all the gory details in one pile.

I'll do that unless there are serious objections...
