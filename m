Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268400AbUI2NKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268400AbUI2NKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUI2NKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:10:52 -0400
Received: from hhlx01.visionsystems.de ([62.145.30.242]:53650 "EHLO
	hhlx01.visionsystems.de") by vger.kernel.org with ESMTP
	id S268367AbUI2NJ6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:09:58 -0400
From: Roland =?utf-8?q?Ca=C3=9Febohm?= 
	<roland.cassebohm@VisionSystems.de>
Organization: Vision Systems GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: Serial driver hangs
Date: Wed, 29 Sep 2004 15:09:38 +0200
User-Agent: KMail/1.6.2
Cc: Paul Fulghum <paulkf@microgate.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
References: <200409281734.38781.roland.cassebohm@visionsystems.de> <1096409562.14082.53.camel@localhost.localdomain> <1096420364.6003.29.camel@at2.pipehead.org>
In-Reply-To: <1096420364.6003.29.camel@at2.pipehead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409291509.39187.roland.cassebohm@visionsystems.de>
X-OriginalArrivalTime: 29 Sep 2004 13:09:40.0059 (UTC) FILETIME=[940542B0:01C4A625]
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.27.0.12; VDF 6.27.0.79
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 29. September 2004 03:12 schrieb Paul Fulghum:
> On Tue, 2004-09-28 at 17:12, Alan Cox wrote:
> > We have throttle()/unthrottle(). Drivers also know if
> > they can't push data.
>
> Yes, though these are manipulated by the ldisc
> in relation to the ldisc receive buffer.
> Coordinating the use of these functions between
> a buffering layer (like the flip buffer) and
> the ldisc would require each to have
> knowledge of the other's state to know who
> calls what and when (yuck).
>
> But much of that may go away when...
>
> > TTY_DONT_FLIP has to die.
>
> *bang*
>
> Until then, flushing the UART receive
> FIFO and dropping the bytes (and updating
> overrun stat) seems a reasonable short term
> solution to stop the machine from locking up
> while leaving the device in a recoverable state.
>
> We can even mark it with *FIXME* in a comment.
> That always seems to work :-)

I have made a little test, at which the receive interrupt is 
disabled in that state. It seems to be no improvement to the 
solution of just trow away the bytes of the FIFO. In both 
cases characters got lost.

So I think you are right, it would be the best to make the 
simple solution with flushing the UART receive FIFO till the 
flip buffer implementation will be reworked.

Roland
-- 
___________________________________________________

VS Vision Systems GmbH, Industrial Image Processing
Dipl.-Ing. Roland Caßebohm
Aspelohe 27A, D-22848 Norderstedt, Germany
Mail: roland.cassebohm@visionsystems.de
http://www.visionsystems.de
___________________________________________________
