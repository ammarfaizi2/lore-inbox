Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUJGICy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUJGICy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 04:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267338AbUJGICy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 04:02:54 -0400
Received: from gprs214-97.eurotel.cz ([160.218.214.97]:55168 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267335AbUJGICt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 04:02:49 -0400
Date: Thu, 7 Oct 2004 10:02:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: __init poisoning for i386, too
Message-ID: <20041007080237.GC15057@elf.ucw.cz>
References: <20041006221854.GA1622@elf.ucw.cz> <1097106995.9693.54.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097106995.9693.54.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Thu, 2004-10-07 at 08:18, Pavel Machek wrote:
> >  		free_page(addr);
> > +#ifdef CONFIG_INIT_DEBUG
> > +		memset((void *)(addr & ~(PAGE_SIZE-1)), 0xcc, PAGE_SIZE); 
> > +#endif
> 
> Shouldn't the memset be before the free_page? (Changing freed pages?)

Ouch, you are right. Interrupt could come and grab them. Yes, we need
first memset, then free_page().
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
