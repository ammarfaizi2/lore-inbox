Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263592AbUJ2VUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUJ2VUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbUJ2VTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:19:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17927 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263592AbUJ2VOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:14:17 -0400
Date: Fri, 29 Oct 2004 22:14:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tim_T_Murphy@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Message-ID: <20041029221412.K31627@flint.arm.linux.org.uk>
Mail-Followup-To: Tim_T_Murphy@Dell.com, linux-kernel@vger.kernel.org
References: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC5@ausx2kmps304.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC5@ausx2kmps304.aus.amer.dell.com>; from Tim_T_Murphy@Dell.com on Fri, Oct 29, 2004 at 04:04:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 04:04:40PM -0500, Tim_T_Murphy@Dell.com wrote:
> > Shouldn't 8250_pci setup the ports already for you?  If not, what
> > needs to be done to achieve this.  Using setserial to setup ports
> > for PCI cards isn't the preferred way of doing this.
> 
> good question, i will have to understand more to answer it though.
> our product has used this method for almost 2 years now.

Well, if you forward lspci -vvx and the "maddr" and "irqno" information
(in private mail if you prefer) then I'll fix 8250_pci to work.

> > At a guess, you've enabled "low latency" setting on this port ?
> 
> yes.  here's a snippet from the script:
> 
> 	echo -n "Starting ${racsvc}: "
> 	# set serial characteristics for RAC device
> 	setserial /dev/${ttyid} \
> 		port 0x${maddr} irq ${irqno} ^skip_test autoconfig
> 	setserial /dev/${ttyid} \
> 		uart 16550A low_latency baud_base 1382400	\
> 		close_delay 0 closing_wait infinite
> 	# now start pppd
> 	/sbin/modprobe -q ppp >/dev/null 2>&1
> 	/sbin/modprobe -q ppp_async >/dev/null 2>&1
> 	daemon pppd call ${service}
> 	RETVAL=$?

I think dropping low_latency will work around the problem for the time
being.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
