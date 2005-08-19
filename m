Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVHSH6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVHSH6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 03:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVHSH6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 03:58:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40410 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964905AbVHSH6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 03:58:19 -0400
Date: Fri, 19 Aug 2005 09:58:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: Multi-sector writes
Message-ID: <20050819075808.GB1825@elf.ucw.cz>
References: <42FF3C05.70606@drzeus.cx> <20050817155641.12bb20fc.akpm@osdl.org> <43042114.7010503@drzeus.cx> <20050817224805.17f29cfb.akpm@osdl.org> <20050818073824.C2365@flint.arm.linux.org.uk> <4304380B.5070406@drzeus.cx> <20050818092321.B3966@flint.arm.linux.org.uk> <43044B7A.6090102@drzeus.cx> <20050818201919.GD516@openzaurus.ucw.cz> <4305676E.5080401@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4305676E.5080401@drzeus.cx>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>* Transport problem. The driver will report back a CRC error, timeout or
> >>whatnot and break. We might not know how many sectors survived so we try
> >>again, going sector-by-sector. We might get a transfer error again,
> >>possibly even before the previous one. But at this point the transport
> >>is probably so noisy that we have little chans of doing a clean umount
> >>anyway. So when the device gets fixed, either by replaying the journal
> >>    
> >>
> >
> >Well, but then you can get:
> >
> >good data #1
> >trash #2
> >good data #2
> >trash #1
> >
> >I'm not sure how much journalling filesystems will like that in their journals...
> 
> Unless the card is horribly broken it will not write sectors that cannot
> be transfered successfully. If there would be a transport error that
> goes undetected by the CRC we would just continue, believing that
> everything is peachy.
> 
> The scenario you're describing could show up in the case of a media
> error though. But that would mean that a sector went bad in an extremely
> short time, which isn't likely unless the wear leveling has gone crazy
> or the card is completely worn out. Either way the card is no longer useful.

Maybe the card is pretty close to going to crash, but... two disk
successive disk errors still should not be cause for journal
corruption.

[Also errors could be corelated. Imagine severe overheat. You'll
successive failing writes, but if you let cool it down, you'll still
have working media... only with corrupt journal :-)]
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
