Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbUL1Kl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUL1Kl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 05:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbUL1Kl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 05:41:26 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:37906 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261190AbUL1KlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 05:41:18 -0500
Date: Tue, 28 Dec 2004 11:42:58 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Philip Pokorny <ppokorny@penguincomputing.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [RFC] I2C: Remove the i2c_client id field
Message-Id: <20041228114258.35e9b5b7.khali@linux-fr.org>
In-Reply-To: <41D0942B.8020109@penguincomputing.com>
References: <20041227230402.272fafd0.khali@linux-fr.org>
	<41D0942B.8020109@penguincomputing.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philip,

> So only the drives I wrote use the ID in a meaningful way?

True, providing we limit our consideration to the hardware monitoring
drivers. Even in your drivers, the meaningfulness is discussable.

The lm85 driver simply displays the assigned id once (at the time it
assigns it). Since the id is then never used, I would consider the lm85
driver similar to the other hardware monitoring drivers.

The adm1026 driver, OTOH, does use the id value in all debug messages,
and it also only reconfigures the GPIO pins for the first client only
(id == 0). Although this is a real use of the id, it only matters if you
use the module parameters for GPIO pins reconfiguration and actually
have more than one ADM1026 chip (a quite rare chip if you remember). You
don't necessarily know which ADM1026 will get id 0 anyway (if the chips
are on different busses it depends on the order the bus drivers were
loaded in), and I am not sure why one would want to reprogram only the
first chip. Unless someone comes with such a specific hardware setup so
that we can examine what is really needed, I think we can get rid of the
"id == 0" test and reconfigure "all" ADM1026 chips (which really is only
one for the two known boards using an ADM1026).

BTW, does anyone really use the GPIO pins reconfiguration parameters?

> What do you propose to replace the ID value in the debug messages
> with?
> Ideally it would be the things you mention that uniquely identify
> the chip in question (bus number and address)
> How hard are those values to get at?  Do we have to chase possibly
> NULL pointers?

Everything is already done. The adm1026 driver (like all other drivers
of the directory) uses dev_dbg to print its debug messages, and dev_dbg
prepends the bus number and chip address to any line it prints. This
means that the "client id" is redundant and can be removed losslessly.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
