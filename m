Return-Path: <linux-kernel-owner+w=401wt.eu-S1753571AbWL1QPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbWL1QPq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 11:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbWL1QPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 11:15:46 -0500
Received: from tim.rpsys.net ([194.106.48.114]:56587 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753571AbWL1QPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 11:15:45 -0500
Subject: Re: The Input Layer and the Serial Port
From: Richard Purdie <rpurdie@rpsys.net>
To: Loye Young <loyeyoung@iycc.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061227195433.872F03FC063@hamlet.sw.biz.rr.com>
References: <20061227195433.872F03FC063@hamlet.sw.biz.rr.com>
Content-Type: text/plain
Date: Thu, 28 Dec 2006 16:13:54 +0000
Message-Id: <1167322434.5596.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 13:54 -0600, Loye Young wrote:
> I, a humble pilgrim in the Land of Tux, have spent over a year seeking
> a simple answer to what seems to me a simple question: How do I expose
> my RS232 barcode scanner to the input layer so that the scanned
> information shows up in applications? Basically, I need the scanner to
> act like another keyboard. Scan a code, see the numbers. 

I can give you some hints but it will involve writing a program. It can
all be done in userspace though, saving any pain of messing with the
kernel internally/kernel recompiling.

The kernel has a driver called uinput which lets you inject input events
into the kernel from a userspace piece of code. You can write a program
to read data from /dev/ttyS0 (at 9600bps) and pass it to this uinput
driver. That should then do exactly what you need.

Working out for to use uinput caused me a few headaches but I can point
you at some example code:

http://svn.o-hand.com/view/misc/trunk/zaurusd/apps/tskeys/tskeys.c?rev=59&view=markup

This code adds support for offscreen soft "buttons" on a touchscreen. It
passes the key events to the kernel via uinput.

Cheers,

Richard

