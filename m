Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVFPHwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVFPHwc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 03:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVFPHwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 03:52:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49067 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261173AbVFPHwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 03:52:17 -0400
Date: Thu, 16 Jun 2005 00:51:52 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       gregkh@suse.de, dbrownell@users.sourceforge.net,
       mdharm-usb@one-eyed-alien.net
Subject: Re: USB flash "drive" is not working sometimes
Message-Id: <20050616005152.15b34cfd.zaitcev@redhat.com>
In-Reply-To: <200506160933.01195.vda@ilport.com.ua>
References: <200506160933.01195.vda@ilport.com.ua>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 1.9.9 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2005 09:33:01 +0300, Denis Vlasenko <vda@ilport.com.ua> wrote:

> 2005-06-16_05:23:09.81176 kern.debug: uhci_hcd 0000:00:1f.4: port 1 portsc 0093,00
> 2005-06-16_05:23:09.81179 kern.debug: hub 2-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
> 2005-06-16_05:23:09.91495 kern.debug: hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
> 2005-06-16_05:23:09.99598 kern.info: usb 2-1: new full speed USB device using uhci_hcd and address 2
> 2005-06-16_05:23:09.99944 kern.debug: uhci_hcd 0000:00:1f.4: uhci_result_control: failed with status 440000
> 2005-06-16_05:23:09.99963 kern.debug: [ce4a7240] link (0e4a71b2) element (0ddbf040)
> 2005-06-16_05:23:09.99966 kern.debug:   0: [cddbf040] link (0ddbf080) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=0e653b80)
> 2005-06-16_05:23:09.99972 kern.debug:   1: [cddbf080] link (0ddbf0c0) e3 SPD Active Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=0e46c9a0)
> 2005-06-16_05:23:09.99976 kern.debug:   2: [cddbf0c0] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)

The 440000 is a timeout in most cases. Unsurprisingly, it ends with:

> 2005-06-16_05:23:10.24285 kern.err: usb 2-1: device descriptor read/64, error -71

At this point the device is toast, the microcontroller is not running.

> I remove flash and reinsert:

> 2005-06-16_06:11:11.24079 kern.info: usb 2-1: new full speed USB device using uhci_hcd and address 6
>[...]
> 2005-06-16_06:11:11.35987 kern.debug: usb 2-1: default language 0x0409
> 2005-06-16_06:11:11.36661 kern.debug: usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=3

Well, duh.

-- Pete
