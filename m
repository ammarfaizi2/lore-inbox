Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263038AbVGNO7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbVGNO7B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 10:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVGNO7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 10:59:01 -0400
Received: from ns.suse.de ([195.135.220.2]:2259 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S263039AbVGNO5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 10:57:45 -0400
Message-ID: <42D67D84.2020306@suse.de>
Date: Thu, 14 Jul 2005 16:58:12 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322 Thunderbird/1.0.2 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Isaacson <adi@hexapodia.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: resuming swsusp twice
References: <20050713185955.GB12668@hexapodia.org>
In-Reply-To: <20050713185955.GB12668@hexapodia.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:
> Yesterday I booted my laptop to 2.6.13-rc2-mm1, suspended to swsusp, and
> then resumed.  It ran fine overnight, including a fair amount of IO
> (running firefox, rsyncing ~/Mail/archive from my mail server, hg pull,
> etc).  This morning I did a swsusp:
> 
> 	echo shutdown > /sys/power/disk
> 	echo disk > /sys/power/state
> 
> and got a panic along the lines of "Unable to find swap space, try

a panic? it should only be an error message, but the machine should
still be alive.

> swapon -a".  Unfortunately I was in a hurry and didn't record the error
> messages.  I powered off, then a few minutes later powered on again.

Powered off hard or "shutdown -h now"?

> At this point, it resumed *to the swsusp state from yesterday*!
> As soon as I realized what had happened, I powered off (not
> shutdown) and rebooted.

Good.

> On the next boot it did not find a swsusp signature and booted normally;
> ext3 did a normal recovery and seemed OK, but I was suspicious and did a
> fsck -f, which revealed a lot of damage; most of the damage seemed to be

this is expected in this case, unfortunately.

> in the hg repo which had been pulled from www.kernel.org/hg/.
> 
> It's extremely unfortunate that there is *any* failure mode in swsusp
> that can result in this behavior.

I of course won't say that this cannot happen, but by design, the swsusp
signature is invalidated even before reading the image, so theoretically
it should not happen.

> I will try to reproduce, but I'm curious if anyone else has seen this.

i have not seen anything like that, but i am not always running the
latest & greatest kernel.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
