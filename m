Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTFGKzI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 06:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTFGKzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 06:55:07 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:5009 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S263023AbTFGKzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 06:55:06 -0400
Message-Id: <200306071108.h57B8WsG006673@ginger.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Fri, 06 Jun 2003 21:10:05 -0300."
             <20030606211005.H3232@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Sat, 07 Jun 2003 07:06:42 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030606211005.H3232@almesberger.net>,Werner Almesberger writes:
>The data plane, yes. But the control/configuration plane is
>synchronous. And it also makes sure that the driver stops
>doing asynchronous things when removing a VCC.

i forgot to mention that this is difficult with the way most of the
atm drivers are written.  in smp kernels, you cant disable interrupts
across all processors to keep the drivers bottom halves from running.
(ok, you could but it would be very naughty).  if the bottom halves were
tasklets this would be easy, but most drivers would need converted.
