Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265850AbUFDQkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265850AbUFDQkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265857AbUFDQkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:40:15 -0400
Received: from main.gmane.org ([80.91.224.249]:19171 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265850AbUFDQkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:40:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] Memory leak in visor.c and ftdi_sio.c
Date: Fri, 04 Jun 2004 17:34:41 +0100
Message-ID: <c9q8a6$hga$1@sea.gmane.org>
References: <40C08E6D.8080606@infosciences.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mail.mev.co.uk
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
In-Reply-To: <40C08E6D.8080606@infosciences.com>
Cc: linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2004 15:59, nardelli wrote:
> Note that I have not verified any of the below on
> hardware associated with drivers/usb/serial/ftdi_sio.c,
> only with drivers/usb/serial/visor.c.  If anyone has
> hardware for this device, I would appreciate your comments.
> 
> A memory leak occurs in both drivers/usb/serial/ftdi_sio.c
> and drivers/usb/serial/visor.c when the usb device is
> unplugged while data is being written to the device.  This
> patch should clear that up.

The change to ftdi_sio.c looks correct to me.

I made the original change to ftdi_sio.c to allocate the write urbs 
and their transfer buffers dynamically (instead of using a 
preallocated pool) and I copied that technique from visor.c!

A related problem with the current implementation is that is easy to 
run out of memory by running something similar to this:

  # cat /dev/zero > /dev/ttyUSB0

That affects both the ftdi_sio and visor drivers.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-

