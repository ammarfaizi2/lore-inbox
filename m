Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbTJWIMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 04:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbTJWIMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 04:12:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35482 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261689AbTJWIMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 04:12:38 -0400
Date: Sun, 19 Oct 2003 20:17:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Message-ID: <20031019181756.GP1659@openzaurus.ucw.cz>
References: <200310171610.36569.bjorn.helgaas@hp.com> <20031017155028.2e98b307.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017155028.2e98b307.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Old behavior:
> > 
> >     # dd if=/dev/mem of=/dev/null
> >     <unrecoverable machine check>
> 
> I recently fixed this for ia32 by changing copy_to_user() to not oops if
> the source address generated a fault.  Similarly copy_from_user() returns
> an error if the destination generates a fault.

Are you sure this is not hiding real errors? If you pass wrong
kernel ptr to copy_*_user, it should oops, not mask error with
-EFAULT.
Maybe another copy_user_unsafe should be created?
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

