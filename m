Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTLKV3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 16:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTLKV3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 16:29:15 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:385
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S263776AbTLKV3M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 16:29:12 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Thu, 11 Dec 2003 22:29:04 +0100
User-Agent: KMail/1.5.4
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312111016230.1227-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312111016230.1227-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200312112229.04256.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree that it would ease things to provide entry points for set_config
> and reset_device that require the caller to hold dev->serialize already.
> The issue you and Oliver noted about holding the bus semaphore will go
> away when I finally get around to rewriting usb_reset_device().

>From what Dave says, usb_reset_device shouldn't take dev->serialize (but
accidentally does via usb_set_configuration).  That seems strange to me:
I thought the point of usbfs taking dev->serialize is to protect against the
device settings changing, but now we have usb_reset_device that doesn't
take dev->serialize at all - and surely it changes the device settings!

With much confusion,

Duncan.
