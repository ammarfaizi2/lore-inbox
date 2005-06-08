Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVFHPX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVFHPX5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 11:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVFHPX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 11:23:57 -0400
Received: from styx.suse.cz ([82.119.242.94]:3744 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261313AbVFHPXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:23:46 -0400
Date: Wed, 8 Jun 2005 17:23:45 +0200
From: Jiri Benc <jbenc@suse.cz>
To: <abonilla@linuxwireless.org>
Cc: "'Denis Vlasenko'" <vda@ilport.com.ua>, "'Pavel Machek'" <pavel@ucw.cz>,
       "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Netdev list'" <netdev@oss.sgi.com>,
       "'kernel list'" <linux-kernel@vger.kernel.org>,
       "'James P. Ketrenos'" <ipw2100-admin@linux.intel.com>
Subject: Re: ipw2100: firmware problem
Message-ID: <20050608172345.64613254@griffin.suse.cz>
In-Reply-To: <002901c56c3b$8216cdd0$600cc60a@amer.sykes.com>
References: <200506081744.20687.vda@ilport.com.ua>
	<002901c56c3b$8216cdd0$600cc60a@amer.sykes.com>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2005 09:05:27 -0600, Alejandro Bonilla wrote:
> 	I might be lost here but... How is the firmware loaded when using the
> ipw2100-1.0.0/patches Kernel patch?

It is loaded by request_firmware() during initialization of the adapter.
That doesn't work, as at that time no hotplug binary can be executed (we
are talking about ipw2100 built in the kernel, not built as a module).

> Currently, when we install the driver, it associates to any open network on
> boot. This is good, cause we don't want to be typing the commands all the
> time just to associate. It works this way now and is pretty nice.

It sounds very dangerous to me.

> So, to scan a network, I would have to do ifconfig eth1 up ; iwlist eth1
> scan?

No. Driver should request the firmware when it is told to perform a scan.

> When moving from modes with the firmwares, would I have to do ifconfig eth1
> up ; iwconfig eth1 mode monitor? or would the firmware be loaded with
> iwconfig? Does it have that function?

Firmware can be loaded automatically by the driver when there is some
request from userspace and the firmware has not been loaded yet.


-- 
Jiri Benc
SUSE Labs
