Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbUKUWhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbUKUWhr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 17:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbUKUWhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 17:37:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:48356 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261825AbUKUWhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 17:37:45 -0500
Date: Sun, 21 Nov 2004 14:37:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux-os@analogic.com
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sparse segfaults
In-Reply-To: <Pine.LNX.4.61.0411211705480.16359@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0411211433540.20993@ppc970.osdl.org>
References: <20041120143755.E13550@flint.arm.linux.org.uk>
 <Pine.LNX.4.61.0411211705480.16359@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Nov 2004, linux-os wrote:
> >
> > int tickadj = 500/HZ ? : 1;             /* microsecs */
> >
> > which makes it look like sparse doesn't understand such constructions.
> 
> I don't think any 'C' compiler should understand such constructions
> either.
>  	There is no result for the TRUE condition, and the standard
> does not provide for a default. The compiler should have written
> a diagnostic.

Actually, this is documented gcc behaviour, where a missing true condition 
is substituted with the condition value.

So what the above does is set "tickadj" to 500/HZ _except_ if that 
underflows to zero, in which case tickadj gets the value 1.

IOW, it's the same as

	int tickadj = 500/HZ ? 500/HZ : 1;

except that the short syntax is not only shorter, but it's extremely
convenient in macros etc, because it only evaluates the value once, ie you
can do

	int tickadj = *ptr++ ? : 1;

and it's well-behaved in that it increments the pointer only once.

		Linus
