Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUHJAqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUHJAqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 20:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUHJAqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 20:46:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:38356 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267367AbUHJAqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:46:49 -0400
Subject: Re: [RFC] Fix Device Power Management States
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
In-Reply-To: <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
	 <20040809113829.GB9793@elf.ucw.cz>
	 <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
Content-Type: text/plain
Message-Id: <1092098630.14100.73.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 10:43:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Aha, so you are saying these do not need to be done in hardware order?
> 
> AFAICT, no.

As stated in my previous mail, I don't agree here... there are
dependencies that cannot be dealt otherwise. USB was an example
(ieee1394 is another), IDE is one, SCSI, i2c, whatever ... 

Of course, if we consider those "bus" drivers not to have class
and thus not to be stopped and only the "leaf" devices to get stopped,
that may work... I'm not sure we are not missing something there
though...

> > I believe different state is needed for "quiesce for atomic copy" and
> > for "we are really going down to S4 now".
> 
> There is nothing fundamentally different at the functional level - you
> don't want any devices fulfilling any request. Besides, by the time the
> system is actually ready to be placed in S4, the devices have long-since
> been stopped, and the class devices do not need another notification
> beyond "stop"
> 
> Thanks,
> 
> 
> 	Pat
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

