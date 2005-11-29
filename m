Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVK2Vy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVK2Vy2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVK2Vy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:54:28 -0500
Received: from mail.dvmed.net ([216.237.124.58]:37039 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932429AbVK2Vy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:54:27 -0500
Message-ID: <438CCE0D.7090304@pobox.com>
Date: Tue, 29 Nov 2005 16:54:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add boot option to control Intel combined mode behavior
 (to allow DMA in combined mode configs!)
References: <200511282306.38515.jbarnes@virtuousgeek.org>
In-Reply-To: <200511282306.38515.jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Jesse Barnes wrote: > Combined mode sucks. Especially
	when both libata and the legacy IDE > drivers try to drive ports on the
	same device, since that makes DMA > rather difficult. > > This patch
	addresses the problem by allowing the user to control which > driver
	binds to the ports in a combined mode configuration. In many > cases,
	they'll probably want the libata driver to control both ports > since
	it can use DMA for talking with ATAPI devices (when >
	libata.atapi_enabled=1 of course). It also allows the user to get old >
	school behavior by letting the legacy IDE driver bind to both ports. >
	But neither is forced, the patch doesn't change current behavior unless
	> one of intel_combined_mode=ide or intel_combined_mode=libata is
	passed > on the boot line. Either of those options may require you to
	access > your devices via different device nodes (/dev/hd* in the ide
	case > and /dev/sd* in the libata case), though of course if you have
	udev > installed nicely you may not notice anything. :) > > Let me know
	if the documentation is too cryptic, I'd be happy to expand > on it if
	necessary. I think most users will want to boot with >
	'intel_combined_mode=libata' and add 'options libata atapi_enabled=1' >
	to their modules.conf to get good DVD playing and disk behavior >
	(haven't tested CD or DVD writing though). > >
	Documentation/kernel-parameters.txt | 7 +++++++ > drivers/pci/quirks.c
	| 30 ++++++++++++++++++++++++++++ > > I'd much rather things behave
	sanely by default (i.e. DMA for devices on > both ports), but
	apparently that's difficult given the various chip > bugs and hardware
	configs out there (not to mention that people's > drives may suddenly
	change from /dev/hdc to /dev/sdb), so this boot > option may be the
	correct long term fix. > > Signed-off-by: Jesse Barnes
	<jbarnes@virtuousgeek.org> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> Combined mode sucks.  Especially when both libata and the legacy IDE 
> drivers try to drive ports on the same device, since that makes DMA 
> rather difficult.
> 
> This patch addresses the problem by allowing the user to control which 
> driver binds to the ports in a combined mode configuration.  In many 
> cases, they'll probably want the libata driver to control both ports 
> since it can use DMA for talking with ATAPI devices (when 
> libata.atapi_enabled=1 of course).  It also allows the user to get old 
> school behavior by letting the legacy IDE driver bind to both ports.  
> But neither is forced, the patch doesn't change current behavior unless 
> one of intel_combined_mode=ide or intel_combined_mode=libata is passed 
> on the boot line.  Either of those options may require you to access 
> your devices via different device nodes (/dev/hd* in the ide case 
> and /dev/sd* in the libata case), though of course if you have udev 
> installed nicely you may not notice anything. :)
> 
> Let me know if the documentation is too cryptic, I'd be happy to expand 
> on it if necessary.  I think most users will want to boot with 
> 'intel_combined_mode=libata' and add 'options libata atapi_enabled=1' 
> to their modules.conf to get good DVD playing and disk behavior 
> (haven't tested CD or DVD writing though).
> 
>  Documentation/kernel-parameters.txt |    7 +++++++
>  drivers/pci/quirks.c                |   30 ++++++++++++++++++++++++++++
> 
> I'd much rather things behave sanely by default (i.e. DMA for devices on 
> both ports), but apparently that's difficult given the various chip 
> bugs and hardware configs out there (not to mention that people's 
> drives may suddenly change from /dev/hdc to /dev/sdb), so this boot 
> option may be the correct long term fix.
> 
> Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

Seems like it should work.  I presume you tested this?

Remove the 'intel_' prefix from the kernel parameter, since this concept 
applies to other controllers as well.  Otherwise, seems OK.

	Jeff



