Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWAFAUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWAFAUQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWAFAUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:20:15 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:4540 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1752321AbWAFAUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:20:02 -0500
Date: Thu, 5 Jan 2006 19:19:43 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Avishay Traeger <atraeger@cs.sunysb.edu>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060106001943.GE5516@filer.fsl.cs.sunysb.edu>
References: <20060105045212.GA15789@redhat.com> <1136469533.21485.91.camel@rockstar.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136469533.21485.91.camel@rockstar.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 08:58:53AM -0500, Avishay Traeger wrote:
> Some comments:
> 1. I think this is a good idea, since serial consoles can also change
> timings.  I have seen several race conditions where the problem goes
> away once I add a serial console.

Agreed.

> 2. Should this be a separate debugging option?

Agreed.

> 3. Shouldn't you have KERN____ in your printk statements?

That's something to watch out for...If you say have:

printk(KERN_DEBUG "fooo.....");
do_foo();
printk(KERN_DEBUG "done.\n");

Then, you'll get the extra "<7>" on the screen and in the logs (assuming
you set the printk levels to display KERN_DEBUG).

Now, I'm not 100% sure about '\r', but I suspect it does the same thing.

> 4. Wouldn't printing out the message every second make the oops scroll
> off the screen, defeating the purpose of the patch?

No, read the patch carefully, it uses '\r' to go back to the begining of
the line and overwrites the message.

Jeff.
