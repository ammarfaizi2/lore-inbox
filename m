Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbUDTM4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbUDTM4P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 08:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbUDTM4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 08:56:15 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:37557 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262914AbUDTM4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 08:56:13 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
Date: Tue, 20 Apr 2004 07:56:08 -0500
User-Agent: KMail/1.6.1
Cc: Tuukka Toivonen <tuukkat@ee.oulu.fi>, danlee@informatik.uni-freiburg.de,
       b-gruber@gmx.de
References: <Pine.GSO.4.58.0402271451420.11281@stekt37> <Pine.GSO.4.58.0404191124220.21825@stekt37>
In-Reply-To: <Pine.GSO.4.58.0404191124220.21825@stekt37>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404200756.08672.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 April 2004 03:35 am, Tuukka Toivonen wrote:
> psaux.c release 2004-04-19
> 
> This is psaux.c linux kernel driver for kernels 2.6.x,
> a direct PS/2 serial port (aka /dev/psaux) driver.
> 
> Available from:
> http://www.ee.oulu.fi/~tuukkat/rel/psaux-2004-04-19.tar.gz
> 
> (includes README with more information)
> 
> The driver was originally written by Lee Sau Dan
> http://www.informatik.uni-freiburg.de/~danlee/fun/psaux/
> but I fixed some bugs (most importantly SMP).
> 
> I've seen lots of discussions about different mouse behaviour (or
> completely non-functioning mouse). If you have one of those problems, this
> driver should restore the kernel 2.4.x behaviour.
> 
> Any suggestions/hopes to get it included into mainstream kernel?
> 

It seems that the driver allows non-exclusive access to the port - multiple
users may fight to set up the mode. How they will agree on which one to set?
On the other hand I do not want psaux to give me only exclusive access as
I have had emough of GPM repeater feeding X feeding Y ... etc.

It does not support active multiplexing controller (4 AUX ports) which
becomes quite common and is the only sane option when you have several
mice of different types.

Also I do not see where the code makes sure that it does not bind to
keyboard's port (so keyboard driver has to be loaded first).

I think the right way is to fix the issues with psmouse driver and use input
system to tie all hardware together.

--
Dmitry
