Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVAURsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVAURsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 12:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVAURsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 12:48:18 -0500
Received: from linux.us.dell.com ([143.166.224.162]:41064 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262432AbVAURsM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 12:48:12 -0500
Date: Fri, 21 Jan 2005 11:46:45 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Andi Kleen <ak@suse.de>, hpa@zytor.com
Cc: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>,
       Adrian Bunk <bunk@stusta.de>,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Chris Bruner <cryst@golden.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
Message-ID: <20050121174645.GA11386@lists.us.dell.com>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org> <20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de> <Pine.LNX.4.61.0501210857170.17260@webhosting.rdsbv.ro> <20050121071144.GB657@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121071144.GB657@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 08:11:44AM +0100, Andi Kleen wrote:
> > I really suggest to push this limit to 4k. My reason is that under UML I 
> > need to put a lot of stuff in command line and uml crash if I not extend 
> > this limit. Can we make it depend on arhitecture?
> 
> It's dependent on the architecture already. I would like to enable
> it on i386/x86-64 because the kernel command line is often used
> to pass parameters to installers, and having a small limit there
> can be awkward.
> 
> But first need to figure out what went wrong with EDD. 
> 
> Matt D., do you have thoughts on this?

It is definitely boot-loader dependent.  Simply changing
COMMAND_LINE_SIZE from 256 to 2048 in the kernel isn't enough.

There are 2 ways the command line is passed from the boot loader into
the kernel.

Boot loader version <= 0x0201  (which LILO uses)
I believe the command line is located at the end of what was known as
the 'empty zero page', now known as the boot parameters.  This part is
black magic to me.

Boot loader version >= 0x0202  (which GRUB uses)
command line can be essentially any size, located anywhere in memory,
and the boot loader tells the kernel where to find it.  The EDD real
mode code uses only this case for parsing the command line, and if an
older loader is used, EDD skips parsing the command line looking
for its options.


There's little space left in the boot parameters block, my EDD code
uses nearly all that was remaining, and could use some more if it were
available.  Having a longer command line would be nice too.  I spoke
with hpa at OLS last summer about this, and he offered to help.
Peter?


Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
