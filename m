Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSFEVIk>; Wed, 5 Jun 2002 17:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSFEVIj>; Wed, 5 Jun 2002 17:08:39 -0400
Received: from air-2.osdl.org ([65.201.151.6]:49545 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315627AbSFEVIi>;
	Wed, 5 Jun 2002 17:08:38 -0400
Date: Wed, 5 Jun 2002 14:04:36 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Brian Gerst <bgerst@didntduck.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Problem with new driver model?
In-Reply-To: <3CFE7BFC.8EE5605@didntduck.org>
Message-ID: <Pine.LNX.4.33.0206051357170.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Shouldn't the calls to __remove_driver be done inside the device_lock?

No. If the driver needs to lock, it is free to use it. But, what the 
driver needs to do is up to the driver, and we don't want to force it not 
to sleep. 

But, the driver needs to be removed from the bus's list inside the lock, 
so if a device the driver supports gets inserted, we won't try and bind 
the two...Patch coming shortly.

	-pat

