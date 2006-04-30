Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWD3J0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWD3J0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 05:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWD3J0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 05:26:24 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:26240 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751075AbWD3J0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 05:26:24 -0400
Subject: Re: IP1000 gigabit nic driver
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "David =?ISO-8859-1?Q?G=F3mez?=" <david@pleyades.net>
Cc: David Vrabel <dvrabel@cantab.net>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
In-Reply-To: <1146342905.11271.3.camel@localhost>
References: <20060427142939.GA31473@fargo>
	 <20060427185627.GA30871@electric-eye.fr.zoreil.com>
	 <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo>
	 <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>
	 <20060428113755.GA7419@fargo>
	 <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>
	 <1146306567.1642.3.camel@localhost>  <20060429122119.GA22160@fargo>
	 <1146342905.11271.3.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 30 Apr 2006 12:26:11 +0300
Message-Id: <1146389171.11524.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-29 at 14:21 +0200, David Gómez wrote:
> > I already had it modified, just needed to create the patch... Anyway,
> > have you submitted it to netdev?

On Sat, 2006-04-29 at 23:35 +0300, Pekka Enberg wrote:
> No, I haven't. I don't have the hardware, so I can't test the driver.
> Furthermore, there's plenty of stuff to fix before it's in any shape for
> submission. If someone wants to give this patch a spin, I would love to
> hear the results.

I killed the I/O write/read macros and switched the driver to iomap.

			Pekka

Subject: [PATCH] IP1000 Gigabit Ethernet device driver

This is a cleaned up fork of the IP1000A device driver:

  <http://www.icplus.com.tw/driver-pp-IP1000A.html>

Open issues include but are not limited to:

  - ipg_probe() looks really fishy and doesn't handle all errors
    (e.g. ioremap failing).
  - ipg_nic_do_ioctl() is playing games with user-space pointer.
    We should use ethtool ioctl instead as suggested by Arjan.
  - For multiple devices, the driver uses a global root_dev and
    ipg_remove() play some tricks which look fishy.

I don't have the hardware, so I don't know if I broke anything.
The patch is 138 KB in size, so I am not including it in this
mail. You can find the patch here:

  http://www.cs.helsinki.fi/u/penberg/linux/ip1000-driver.patch

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

