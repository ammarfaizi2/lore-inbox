Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTFGDgw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 23:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTFGDgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 23:36:52 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:63884 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262543AbTFGDgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 23:36:52 -0400
Message-Id: <200306070350.h573oIsG004491@ginger.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Fri, 06 Jun 2003 22:11:00 -0300."
             <20030606221100.L3232@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 06 Jun 2003 23:48:28 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030606221100.L3232@almesberger.net>,Werner Almesberger writes:
>> how about atm_async_release()?
>That's just "tag and go away". If I understood Dave right, he
>wants the device to actually disappear at that point (well, at
>what would be the equivalent point for devices).

that's ok.  the sk list (of vcc's) will be seperate from
the atm dev so you can take the vcc w/o relying on a device
to hold the list.

btw, you might get async device 'releases' more often than
you would like.  some atm devices are usb and could be 
unplugged during operation (yes, that's really bad but it
would be wise to be prepared for this.)  i actually have
a cardbus atm interface.  i might eject it accidentally.

>In return, the stack must not make any other calls for that
>VCC after invoking "close".
>Hmm, and I should have written all this in the device driver
>interface document :-)
>Looks like trouble ...

right!
