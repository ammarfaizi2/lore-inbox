Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269773AbUJAMiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269773AbUJAMiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 08:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269775AbUJAMit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 08:38:49 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:58513 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269773AbUJAMim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 08:38:42 -0400
Subject: Re: new locking in change_termios breaks USB serial drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Borchers <alborchers@steinerpoint.com>
Cc: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <415D3408.8070201@steinerpoint.com>
References: <415D3408.8070201@steinerpoint.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096630567.21871.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 01 Oct 2004 12:36:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-01 at 11:40, Al Borchers wrote:
> Unfortunately, many USB serial drivers' set_termios functions
> send an urb to change the termios settings and sleep waiting for
> it to complete.
> 
> I just looked quickly, but it seems belkin_sa.c, digi_acceleport.c,
> ftdi_sio.c, io_ti.c, kl5usb105.c, mct_u232.c, pl2303.c, and whiteheat.c
> all sleep in their set_termios functions.
> 
> If this locking in change_termios() stays, we are going to have to
> fix set_termios in all of these drivers.  I am updating io_ti.c right
> now.

How much of a problem is this, would it make more sense to make the
termios locking also include a semaphore to serialize driver side events
and not the spin lock ?

We need some kind of locking there otherwise multiple parallel termios
setters resulting in truely strange occurences because driver authors
don't think about 64 parallel executions of ->change_termios()

I can switch the lock around if you want.

Alan

