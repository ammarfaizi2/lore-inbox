Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUFBMdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUFBMdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUFBMda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:33:30 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:58788 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262391AbUFBMd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:33:28 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Subject: Re: [RFC/RFT] Raw access to serio ports (2/2)
Date: Wed, 2 Jun 2004 07:33:22 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <xb7d64i5lxb.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb7d64i5lxb.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Message-Id: <200406020733.22737.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 June 2004 04:49 am, Sau Dan Lee wrote:
> >>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:
> 
>     Dmitry> +static unsigned int i8042_aux_raw[4];
> 
> So,  only AUX ports  can be  directly accessed?   No direct  access to
> keyboard port?  Why?
>

Keyboards are to be handled in-kernel, at least for now. If there really
a need we can enable grabbing keyboard as well, no big deal.
 
> The  SERIO_USERDEV  patch  does  allow  direct access  to  the  PC  AT
> keyboard, and it did help me  locate the SysRq problem that I reported
> in  other postings.   i.e.  it IS  useful  to be  able  to access  the
> keyboard port directly.
> 

Vojtech has a patch for that - now raw (really raw) codes are reported via
EV_MSC/MSC_RAW event.

> 
>     Dmitry> The driver will happily co-exist with psmouse and atkbd
>     Dmitry> loaded as they ignore SERIO_8042_RAW ports, so it is
>     Dmitry> possible to have one AUX port in raw mode and other in
>     Dmitry> standard 2.6 mode.
> 
> 1) there is no RAW access to the keyboard port;
> 
> 2) I   hate  this   black  magic,   in  which   the   input  "devices"
>    (i.e. drivers)  kidnap the serio  ports they like according  to the
>    port  type SERIO_8042_RAW, etc.   That's a  kind of  hardcoding the
>    binding between ports and drivers.

We do have some hardcoding so atkbd does not try to grab a serio linked
to a serial port and sermouse does not try grabbing keyboard port, etc..
There is nothing new.

> 
> 
> Isn't it better to leave the AUX ports as SERIO_8042, and let the user
> dynamically change  this port<-->driver binding?  Then,  we don't even
> need  that ugly  "i8042.raw" boot  parameter or  i8042_aux_raw option.
> The  user can  decide  which  ports are  connected  to your  serio_raw
> driver, and which ports are  connected to psmouse.ko.  That would also
> allow multiple drivers driving the ports of the same type.  
>

Yes, that's the perfect solution, but I believe we need sysfs for that
and at least I started working on it, but it takes time. In the meantime
i8042.raw should alleviate most of the user's troubles with their input
devices no longer working.

-- 
Dmitry
