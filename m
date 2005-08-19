Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVHSIMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVHSIMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 04:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVHSIMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 04:12:09 -0400
Received: from [85.8.12.41] ([85.8.12.41]:26004 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932260AbVHSIMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 04:12:08 -0400
Message-ID: <43059455.4060505@drzeus.cx>
Date: Fri, 19 Aug 2005 10:12:05 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: Multi-sector writes
References: <42FF3C05.70606@drzeus.cx> <20050817155641.12bb20fc.akpm@osdl.org> <43042114.7010503@drzeus.cx> <20050817224805.17f29cfb.akpm@osdl.org> <20050818073824.C2365@flint.arm.linux.org.uk> <4304380B.5070406@drzeus.cx> <20050818092321.B3966@flint.arm.linux.org.uk> <43044B7A.6090102@drzeus.cx> <20050818201919.GD516@openzaurus.ucw.cz> <4305676E.5080401@drzeus.cx> <20050819075808.GB1825@elf.ucw.cz>
In-Reply-To: <20050819075808.GB1825@elf.ucw.cz>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>
>Maybe the card is pretty close to going to crash, but... two disk
>successive disk errors still should not be cause for journal
>corruption.
>
>[Also errors could be corelated. Imagine severe overheat. You'll
>successive failing writes, but if you let cool it down, you'll still
>have working media... only with corrupt journal :-)]
>								Pavel
>  
>

Hmm... So how is this handled in other systems? E.g. if you yank a USB
device whilst there is a lot of outstanding data inside the device that
hasn't been ack:d yet.

The way I see it, filesystems should assume the following at a failed write:

* 0-n sectors were written successfully.
* 0-1 sectors have corrupt data.
* 0-m sectors have old data.
* The lower layer will report back 0-k successfully written sectors,
where k <= n.

So perhaps the best course of action is to remove the sector-by-sector
failsafe? It will increase the chance of k < n, but it will not break
above assumption.

Rgds
Pierre

