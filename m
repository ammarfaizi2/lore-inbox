Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265458AbTLHPzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265460AbTLHPzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:55:09 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:54924 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265458AbTLHPzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:55:04 -0500
Message-ID: <3FD4A0C2.4090109@pacbell.net>
Date: Mon, 08 Dec 2003 08:03:14 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: Vince <fuzzy77@free.fr>, "Randy.Dunlap" <rddunlap@osdl.org>,
       mfedyk@matchmail.com, zwane@holomorphy.com,
       linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <3FC4E8C8.4070902@free.fr> <200312072224.32417.baldrick@free.fr> <3FD3AF9F.6010406@free.fr> <200312081110.28590.baldrick@free.fr>
In-Reply-To: <200312081110.28590.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
> Hi Vince, I'm not sure, but it looks like a bug in the USB core.
> I was kind of expecting this :)  My patch causes devio.c to hold
> a reference to the usb_device maybe long after the device has
> been disconnected.  This is supposed to be OK, but from your

... no, that's not supposed to be OK.  Returning from disconnect()
means that a device driver is no longer referencing the interface
the driver bound to, or ep0.

- Dave



> Oops it looks like some part of the hcd was finalized too early
> (before devio.c dropped its reference to the usb_device).  Maybe
> one of the USB guys can comment?
> 


