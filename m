Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263598AbUJ2VHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbUJ2VHP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbUJ2VFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:05:12 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:55425 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S263573AbUJ2VEq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:04:46 -0400
X-Ironport-AV: i="3.86,111,1096866000"; 
   d="scan'208"; a="118758077:sNHT23822154"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Date: Fri, 29 Oct 2004 16:04:40 -0500
Message-ID: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC5@ausx2kmps304.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Thread-Index: AcS99MHF5gacJVu6QNWIFjUtKGIsBgABLQfQ
From: <Tim_T_Murphy@Dell.com>
To: <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Oct 2004 21:04:41.0163 (UTC) FILETIME=[E86519B0:01C4BDFA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Shouldn't 8250_pci setup the ports already for you?  If not, what
needs
> to be done to achieve this.  Using setserial to setup ports for PCI
cards
> isn't the preferred way of doing this.

good question, i will have to understand more to answer it though.
our product has used this method for almost 2 years now.

> At a guess, you've enabled "low latency" setting on this port ?

yes.  here's a snippet from the script:

	echo -n "Starting ${racsvc}: "
	# set serial characteristics for RAC device
	setserial /dev/${ttyid} \
		port 0x${maddr} irq ${irqno} ^skip_test autoconfig
	setserial /dev/${ttyid} \
		uart 16550A low_latency baud_base 1382400	\
		close_delay 0 closing_wait infinite
	# now start pppd
	/sbin/modprobe -q ppp >/dev/null 2>&1
	/sbin/modprobe -q ppp_async >/dev/null 2>&1
	daemon pppd call ${service}
	RETVAL=$?

Thanks
Tim
