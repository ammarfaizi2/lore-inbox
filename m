Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269978AbTHFQ0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269994AbTHFQ0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:26:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41476 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269978AbTHFQ0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:26:50 -0400
Date: Wed, 6 Aug 2003 17:26:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Adam Belay <ambx1@neo.rr.com>, Linus Torvalds <torvalds@osdl.org>,
       Misha Nasledov <misha@nasledov.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5/2.6 PCMCIA Issues
Message-ID: <20030806172646.A16116@flint.arm.linux.org.uk>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Misha Nasledov <misha@nasledov.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20030804232204.GA21763@nasledov.com> <20030805144453.A8914@flint.arm.linux.org.uk> <20030806045627.GA1625@nasledov.com> <200308060559.h765xhI05860@mail.osdl.org> <20030806114225.GI13275@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030806114225.GI13275@neo.rr.com>; from ambx1@neo.rr.com on Wed, Aug 06, 2003 at 11:42:25AM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 11:42:25AM +0000, Adam Belay wrote:
> Here's a quick fix that will at least correct the i82365 probing.  It will
> be interesting to see what effect it has on these other problems.  Note
> that this driver needs some work with check_region etc.

Ok, this may allow us to detect the i82365 device.  However, yenta_socket
is already controlling it, and it has disabled the legacy port access.

Now, i82365 initialises, and PNP tells it that we have this device.  PNP
tries to activate it.  This is where we are probably going wrong.

I think we need some way for yenta to tell the PNP subsystem to ignore
the device that yenta is controlling.

As far as check_region goes - fixing it looks like it'll be fairly
disgusting.  The probing seems to be pretty complex, and I don't have
the hardware to test against.  So, until someone who cares about it
puts the work in, I'm not touching that part of it. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

