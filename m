Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUB0JGF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 04:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUB0JGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 04:06:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34569 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261742AbUB0JGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 04:06:00 -0500
Date: Fri, 27 Feb 2004 09:05:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Frank <mhf@linuxmail.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Mark Gross <mgross@linux.co.intel.com>, arjanv@redhat.com,
       Tim Bird <tim.bird@am.sony.com>, root@chaos.analogic.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Why no interrupt priorities?
Message-ID: <20040227090548.A15644@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Frank <mhf@linuxmail.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	Mark Gross <mgross@linux.co.intel.com>, arjanv@redhat.com,
	Tim Bird <tim.bird@am.sony.com>, root@chaos.analogic.com,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com> <1077859968.22213.163.camel@gaston> <opr30muhyf4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <opr30muhyf4evsfm@smtp.pacific.net.th>; from mhf@linuxmail.org on Fri, Feb 27, 2004 at 02:26:31PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 02:26:31PM +0800, Michael Frank wrote:
> Is this to imply that edge triggered shared interrupts are used anywhere?

It is (or used to be) rather common with serial ports.  Remember that
COM1 and COM3 were both defined to use IRQ4 and COM2 and COM4 to use
IRQ3.

> Never occured to me to use shared IRQ's edge triggered as this mode
> _cannot_ work reliably for HW limitations.

The serial driver takes great care with this - when we service such an
interrupt, we keep going until we have scanned all the devices until
such time that we can say "all devices are no longer signalling an
interrupt".

This is something it has always done - it's nothing new.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
