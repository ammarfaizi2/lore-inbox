Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbUCJFHh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 00:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbUCJFHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 00:07:37 -0500
Received: from smtp9.wanadoo.fr ([193.252.22.22]:28404 "EHLO
	mwinf0901.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262000AbUCJFHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 00:07:34 -0500
Date: Wed, 10 Mar 2004 06:08:04 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
Message-ID: <20040310060804.GB2958@zaniah>
References: <200403090014.03282.thomas.schlichter@web.de> <20040308162947.4d0b831a.akpm@osdl.org> <20040309070127.GA2958@zaniah> <200403091208.20556.thomas.schlichter@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403091208.20556.thomas.schlichter@web.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2004 at 12:08 +0000, Thomas Schlichter wrote:

> As I wrote a few days ago I have problems with that ChangeSet,
>   (http://marc.theaimsgroup.com/?l=linux-kernel&m=107840458123059&w=2)
> so I did examine it closer.

errmm, http://tinyurl.com/2jbe4

Maciej, you wrote this patch, any comment ?

> so I did examine it closer.
> 
> My results are:
> 1. The semicolons behind the if()'s cannot be there intentionally.
> 2. To fix my problem, timer_ack must be set to 1 for my (integrated) APIC, and 
> as my CPU has a TSC, this cannot be correct for me:
> -	timer_ack = 1;
> +	if (nmi_watchdog == NMI_IO_APIC && !APIC_INTEGRATED(ver))
> +		timer_ack = 1;
> +	else
> +		timer_ack = !cpu_has_tsc;

I don't get the figure, this code in check_timer() is called by
setup_IO_APIC so APIC_INTEGRATED(ver) is always 0 ?


> I changed that if(...) to
> 	if (nmi_watchdog == NMI_IO_APIC || APIC_INTEGRATED(ver))
> which works fine for me here, but I am not 100% sure if this is what the 
> author of the original patch ment and if it still fixes the original 
> problem...
 

regards,
Phil


