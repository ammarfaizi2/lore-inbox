Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265744AbUAKDdz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 22:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265745AbUAKDdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 22:33:55 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:15280 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265744AbUAKDdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 22:33:52 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Peter Berg Larsen <pebl@math.ku.dk>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync loss (With Patch).
Date: Sat, 10 Jan 2004 22:33:46 -0500
User-Agent: KMail/1.5.4
Cc: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.40.0401110335330.588-100000@shannon.math.ku.dk>
In-Reply-To: <Pine.LNX.4.40.0401110335330.588-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401102233.46164.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It is a good stuff but we probably want not only restore mux mode
but also do serio_reconnect on all ports to make sure all devices are
properly configured. But it gets way too big for interrupt handler.
I am thinking that if mux error is detected the only thing that should
be done in i8042_interrupt is disabling the controller and then use
schedule_work to schedule the rest.

Also, if we get SERIO_REMOVED condition we should just do serio_reconnect
right away and let it sort through the device state.

What do you think?

Dmitry
