Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVEAW6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVEAW6b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 18:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVEAW6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 18:58:31 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:40370 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261357AbVEAW6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 18:58:18 -0400
Date: Sun, 1 May 2005 18:53:35 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Kyle Rose <krose+linux-kernel@krose.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI sleep states on Tyan Thunder K8W S2885
Message-ID: <20050501225335.GG3951@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Kyle Rose <krose+linux-kernel@krose.org>,
	linux-kernel@vger.kernel.org
References: <42726287.80104@krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42726287.80104@krose.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 12:36:23PM -0400, Kyle Rose wrote:
> I can't seem to get my Tyan board (AMD 81x1 chipset) to go to sleep such
> that wake-on-LAN will wake it back up.  On my other machines, when I
> shutdown -h, it (presumably) puts the machine into S5 state
> automatically, and WOL works like a charm; on this machine, shutdown -h
>   puts the machine into an actual "off" state in which WOL won't wake it
> back up.

The "off" state is always considered S5.  Adding wake devices does not make
the state S5.

> 
> Moreover, if I try to echo 5 > /proc/acpi/sleep with full debugging, I
> get absolutely nothing in dmesg.

-->snip

> Furthermore, if I shut down from Windows, it *does* go into what I
> presume is the S5 state, so this is a software problem, not hardware.
> 
> Any suggestions on debugging?
> 
> Cheers,
> Kyle

S5 wake devices can be a very fuzzy area.  In general, the ACPI spec
recommends that wake capabilities are enabled before halting the system.
Therefore, your network card driver may need to specifically handle this.

For starters, we should probably look at "lspci -vv".  I'm assuming your
network card is PCI.  This will allow us to see if it's capable of waking
from D3-cold, the state it will most likely be in during S5.

I would also check your BIOS configuration and see if it's possible to
specifically enable wake-on-lan.  Let me know if this helps.

Finally, what kernel version are you using?

Thanks,
Adam
