Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161201AbWAHVLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161201AbWAHVLe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 16:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161202AbWAHVLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 16:11:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:33950 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161201AbWAHVLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 16:11:34 -0500
Subject: Re: i2c/ smbus question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20060108113013.34fe5447.khali@linux-fr.org>
References: <1136673364.30123.20.camel@localhost.localdomain>
	 <20060108113013.34fe5447.khali@linux-fr.org>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 08:10:08 +1100
Message-Id: <1136754608.30123.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-08 at 11:30 +0100, Jean Delvare wrote:

> I suspect that these drivers which do I2C block writes do so by calling
> i2c_master_send (or even i2c_transfer) directly, rather than relying on
> the SMBus compatibility layer.

Ok. Well, it's much more simple for me to implement smbus (with a few extensions
like block transfer) than the low level i2c at the host driver level.
In order to implement subaddress access with repeat start (very common in pretty
much everything nowadays), I need two messages. However, my low level hardware
can't implement everything that can be done with multiple messages. Thus
implementing the stuff using i2c_xfer needs a lot of test & validation all over
the place to coerce those 2 messages into a subaddress + data setup that my low
level hw understands. Implementing only smbus is simpler and fits most of my needs.
 
> The i2c_smbus_write_i2c_block_data wrapper function used to be defined,
> but was removed in 2.6.10-rc2 together with a couple other similar
> wrappers [1] on request by Adrian Bunk, the reason being that they had
> no user back then. I was a bit reluctant at first, but we finally agreed
> with Adrian to remove the functions, and to reintroduce them later if
> they were ever needed.

I find that weird but heh...

> So, if you need i2c_smbus_write_i2c_block_data(), we can easily
> resurrect it. See the patch below. I made the new version a bit faster
> (I hope) than the original by using memcpy, please confirm it works for
> you.

Ok, I'll test with those, I did an equivalent local to my sound drivers
but a wrapper in the i2c layer is probably better. Thanks.



