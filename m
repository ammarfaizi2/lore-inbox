Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTLLRiX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 12:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTLLRiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 12:38:23 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:42188 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261575AbTLLRiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 12:38:21 -0500
Date: Fri, 12 Dec 2003 18:38:02 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Roger Larsson <roger.larsson@norran.net>
Cc: "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'David Hinds'" <dahinds@users.sourceforge.net>
Subject: Re: UPD: "do_IRQ: near stack overflow" when inserting CF disk
Message-ID: <20031212173802.GK6112@wohnheim.fh-wedel.de>
References: <200312121652.23036.roger.larsson@norran.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200312121652.23036.roger.larsson@norran.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 December 2003 16:52:22 +0100, Roger Larsson wrote:
> 
> I get these three printouts when inserting a compact flash disk
> (SuSE Linux 2.4.21-144-smp) - is the stack intentionally this fit?
> or is it an unexpected code path?
> 
> I have had other interrupt related problems, it usually locks up :-(
> This time I run with "nosmp noapic"
> 
> The ide-cs is now forced to use irq 3 (When running noapic others
> seems busy... with apic and using irq 6 or 10 computer has
> locked up...)
> 
> I will try irq 3 without one of the options to see if the computer still
> survives...
> 
> - new data -
> 
> Easier said than done - they require each other!
> But I noticed that reducing 'stackwarn' and 'stackdefer'
> to under the level warned about helps (might be luck)
> 
> Summary:
>   Some routines allocate to much stack: validate_cis?
> 	several subtypes in the union cisparse_t are quite
> 	big (>250 bytes)
>   This eats stack (to much?) or only close enough to
>   trigger 'stackdefer' which might stress the drivers SMPness?

Can you send me your .config?  I'd like to run checkstack on it and
see what other functions in your trace consume too much stack.
David's patch shoundn't shave off more than 2k, so either my estimate
is wrong or there are more hungry wolves in your list.

Jörn

-- 
Beware of bugs in the above code; I have only proved it correct, but
not tried it.
-- Donald Knuth
