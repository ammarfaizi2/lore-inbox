Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161347AbWHAHj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161347AbWHAHj0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161348AbWHAHj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:39:26 -0400
Received: from bill.weihenstephan.org ([82.135.35.21]:35040 "EHLO
	bill.weihenstephan.org") by vger.kernel.org with ESMTP
	id S1161347AbWHAHj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:39:26 -0400
From: Juergen Beisert <juergen127@kreuzholzen.de>
To: Chris Boot <bootc@bootc.net>, Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [RFC] Proposal: common kernel-wide GPIO interface
Date: Tue, 1 Aug 2006 09:40:24 +0200
User-Agent: KMail/1.5.4
Cc: Ben Dooks <ben@fluff.org>, kernel list <linux-kernel@vger.kernel.org>
References: <44CA7738.4050102@bootc.net> <20060731201735.GZ10495@pengutronix.de> <44CE74CA.8070504@bootc.net>
In-Reply-To: <44CE74CA.8070504@bootc.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608010940.25179.juergen127@kreuzholzen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

some ideas:

On Monday 31 July 2006 23:23, Chris Boot wrote:
> Yes I was thinking that a GPIO is a resource a little like an IRQ and
> thinking of a registration and ownership system as well. I'm glad somebody
> came up with that suggestion!
>
> The access API is, as you say, more difficult. The access methods for slow
> GPIOs is indeed very simple but I can't think of any way to provide
> (near-)direct access for faster accesses in a portable way. Does anyone
> have any suggestions?

Maybe three kind of API. One for fastest access: The driver request the GPIO 
itself from the GPIO management and has to share some kind of locking 
mechanism with the other API to avoid conflicts when accessing the registers 
to manipulate this GPIO. This could be the way an I2C driver works to be as 
fast as possible. Buts its achitecture specific.
The second API is slower and supports some functions to manipulate the GPIOs 
at higer lever. This API would be architrecture independend but for use in 
the kernel only.
The third API I like to have is for some slow GPIO. They should be accessible 
from user space in an easy way. For example through some entries in sysfs the 
user can access with simple "cat" and "echo" commands.
Alltogether share the GPIO management and the locking mechanism.

Juergen

