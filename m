Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVCRXAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVCRXAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVCRXAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:00:38 -0500
Received: from mailgate1.mysql.com ([213.115.162.47]:26306 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S262089AbVCRXA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:00:27 -0500
Message-ID: <423B5D7A.1060304@mysql.com>
Date: Sat, 19 Mar 2005 00:00:10 +0100
From: Jonas Oreland <jonas.oreland@mysql.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: daniel.ritz@gmx.ch
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
Subject: Re: yenta_socket "nobody cared - Disabling IRQ #4"
References: <200503182243.24174.daniel.ritz@gmx.ch>
In-Reply-To: <200503182243.24174.daniel.ritz@gmx.ch>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Ritz wrote:
> hi

Hi 

Thanks for your effort!

> 
> it's the second time now i see this problem with an atheros chipset in
> combination with a TI bridge. last time it was the 1225...
> attached a patch that could help...
> 

Report:
1) It works somewhat better. irq doesn't get disabled.
2) however wlan card get disfunctional. I haven't been able to contact my wap
   even if i'm standing on it...
3) unplug has resulted in kernel panic (twice)
   (btw: how do I do to capture and report those)
4) when unlug don't produce kernel panic, then there is no way of power-oning that card again.
5) booting with the card inserted makes it not power on when yenta_socket is loaded (module)

comment: the card being disfunction could have something to with the driver.
but before it worked sometimes...

> --------------
> 
> for TI bridges: turn off interrupts during card power-on. this seems
> to be neccessary for some combination of TI bridges with at least CB cards
> with atheros chipset...problem is that they produce an interrupt storm
> during power-on so the kernel happens to disable the IRQ which is a bad
> thing (tm).
> adds a generic hook function so that a socket driver can hook into
> almost anywhere (by adding more hook points of course). this is the
> cleanest way i can think of. and it allows adding more workarounds
> for more problems...
> for the TI specific interrupt on-off stuff just save the MFUNC register
> and set it to 0 to disable all interrupts, restore it afterwards.
> 
> Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

Some thoughts: (not I'm neither pcmcia nor linux expert).

The "irq storm", shouldn't that be "acked" in someway.
I.e. the card produced a lot of irq's (that get ignored)
isn't the "real" solution to capture them, and "do something clever"?

Instead of just "shutting the card down".

hmmm...wonder if that made sence

Question: Why do you think that it worked sometimes before?

/Jonas

ps.
	but the hook was/is nice :-)
ds.
