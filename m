Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWC3V2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWC3V2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWC3V2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:28:09 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:13470 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750968AbWC3V2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:28:08 -0500
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] SPI bus driver synchronous support
Date: Thu, 30 Mar 2006 09:53:00 -0800
User-Agent: KMail/1.7.1
Cc: Kumar Gala <galak@kernel.crashing.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <7C75FBEB-F962-4860-A797-AC6B454D6E6E@kernel.crashing.org>
In-Reply-To: <7C75FBEB-F962-4860-A797-AC6B454D6E6E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603300953.01583.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 March 2006 11:49 am, Kumar Gala wrote:

> The case I have is I need to talk to a microcontroller connected over  
> SPI.  I'd like to be able to issue a command to the microcontroller  
> in a MachineCheck handler before the system reboots.  

Issuing the command is trivial, but knowing it completes before the MCE
handler completes is an entirely different kettle of fish.  Remember, the
SPI controller may in general be busy with some other request, which would
need to finish first even if some other request _could_ jump to the head
of the request queue.

I suspect some system designer is thinking about the problem wrong if
you believe you need that kind of solution.  If for some reason your
board design requires that sort of access, then what you'd be needing
is a way to abort then bypass the normal SPI stack.  It could work like
any other board-specific hack.


> I need a truly   
> synchronous interface opposed to one fronting the async interface.

I think the word "synchronous" means something other than what
you're implying here.  Normally in Linux, it means that the
request handling blocks until completion, sleeping allowed.

You seem to be thinking about something behaving more like a
register access, which is safe to call when in_irq().  

- Dave
