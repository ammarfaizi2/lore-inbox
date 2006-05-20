Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWETLHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWETLHl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 07:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWETLHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 07:07:41 -0400
Received: from web25811.mail.ukl.yahoo.com ([217.146.176.244]:34688 "HELO
	web25811.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932328AbWETLHk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 07:07:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Xl7RM+wXMX/laqgHPLbOzLAGLaowiaSh3Ft8ypetCw87/nSjqZMUfnqrjNWE0gmxO1PnVl7BrKfrwdITWrn94d35jugFZ1DNvTvccJ16yO3AdGRzEzHdlHzvHCYTtb88xXLqCHWMr8PjyhudIf0sBlPURAB7AGrlPg0S5nqIBsU=  ;
Message-ID: <20060520110739.93343.qmail@web25811.mail.ukl.yahoo.com>
Date: Sat, 20 May 2006 11:07:39 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : [I2C] question on adapter design
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060519102347.GM8304@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>The I²C (TM Philips) -bus runs at 100 kHz or (high-speed one) at 400 kHz.
>An eight bit byte goes thru it in 80 or 20 microseconds depending on used
>speed.  If your interrupt processing considers it as medium level
>priority and fills the Tx fifo with as much as is available (most I²C TX
>sequences do fit inside the 8 byte fifo) and collects as much data as is
>available in the Rx fifo, you should be well set.

ok so most of I2C commands shouldn't last more than 160 us when bus 
runs at 400 khz, right ? If so, I'm not sure it worth to use interrupts because
an active polling would avoid context switch that is not negligible in that case.
Interrupts can be usefull if I2C transfers would be longer than 8 bytes...

>
>Most notable detail there is, that you do have those (for I²C) huge FIFOs.
>Another thing is (I haven't verified this) that I²C master controls the
>bus clock, and can stop it temporarily, when Tx FIFO is empty, or Rx FIFO
>is full.
>

Indeed, my controller can automatically stop the bus clock when Tx fifo is
empty or Rx fifo is full.


Francis


