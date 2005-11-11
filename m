Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVKKQLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVKKQLm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVKKQLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:11:42 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:32491 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1750831AbVKKQLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:11:42 -0500
Date: Fri, 11 Nov 2005 11:11:29 -0500
To: Chip Salzenberg <chip@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: hostap interrupt problems, maintainers unresponsive - "wifi0: interrupt delivery does not seem to work"
Message-ID: <20051111161129.GB31850@delft.aura.cs.cmu.edu>
Mail-Followup-To: Chip Salzenberg <chip@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20051102174639.GB6816@tytlal.topaz.cx> <20051110175922.GB9632@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110175922.GB9632@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.9i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 12:59:22PM -0500, Jan Harkes wrote:
> I am seeing similar interrupt problems, but I don't have hostap (or even
> a wireless network card) on my machine. For me a clear indication is the
> serial port overrun errors even though that port only gets a handful of
> interrupts per second from an attached GPS receiver. Under X, keyboard
> and mouse are occasionally very jerky and unreponsive.
> 
> I just rebooted with 'acpi=noirq', and I'm not seeing the serial port
> overrun errors anymore, it seems to have fixed, or at least mitigated
> the problem a bit. But I'm logged into the machine remotely at the
> moment, so I can't be sure if it really fixed the unresponsive
> keyboard/mouse issues.

Interestingly, noirq didn't actually help. The main difference seems to
be that DMA is not automatically enabled for my drives with the 2.6.14
kernel, and I'm getting permission denied errors when trying to enable
it with hdparm.

Seems like piix is coming up too late and the ide device is already
claimed by a generic driver that doesn't do dma. I'm building ide/piix
into the kernel now to see if that helps.

Jan
