Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVK0UHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVK0UHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 15:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVK0UHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 15:07:09 -0500
Received: from hornet.berlios.de ([195.37.77.140]:29476 "EHLO
	hornet.berlios.de") by vger.kernel.org with ESMTP id S1751071AbVK0UHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 15:07:07 -0500
From: Michael Frank <mhf@users.berlios.de>
Reply-To: mhf@users.berlios.de
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Alternatives to serial console for oops.
Date: Sun, 27 Nov 2005 21:04:30 +0100
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <4389D63B.4000702@superbug.demon.co.uk>
In-Reply-To: <4389D63B.4000702@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20051127200758.2EED91C6B@hornet.berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 November 2005 16:52, James Courtier-Dutton 
wrote:
> Hi,
>
> I wish to view the oops that are normally output on the
> serial port of the PC. The problem I have, is that my PC
> does not have a serial port. Are there any alternatives
> for getting that vital oops from the kernel just as it
> crashes apart from the serial console. Could I get it to
> use some other interface? e.g. Network interface.
> Parallel port is also not an option.
>
> James

I use Netconsole for routine monitoring.

See Documentation/networking/netconsole.txt

Example for kernel command line
netconsole=1024@192.168.2.131/eth0,4450@192.168.2.1/00:00:0E:5F:15:64

You don't want to hassle with netcat.

Many sysloggers can log udp

I use syslog-ng. Excerpts from configuration:

source netlog { 
	udp(ip(0.0.0.0) port(4450)); 
};

destination netlog
{ 
	file("/var/log/netlog"); 
};

log 
{ 
	source(netlog); 
	destination("netlog"); 
	flags(final); 
};


