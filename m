Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUFBJuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUFBJuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 05:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUFBJuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 05:50:51 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:1685 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S261422AbUFBJt7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 05:49:59 -0400
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] Raw access to serio ports (2/2)
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 02 Jun 2004 11:49:52 +0200
Message-ID: <xb7d64i5lxb.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:

    Dmitry> +static unsigned int i8042_aux_raw[4];

So,  only AUX ports  can be  directly accessed?   No direct  access to
keyboard port?  Why?

The  SERIO_USERDEV  patch  does  allow  direct access  to  the  PC  AT
keyboard, and it did help me  locate the SysRq problem that I reported
in  other postings.   i.e.  it IS  useful  to be  able  to access  the
keyboard port directly.


    Dmitry> The driver will happily co-exist with psmouse and atkbd
    Dmitry> loaded as they ignore SERIO_8042_RAW ports, so it is
    Dmitry> possible to have one AUX port in raw mode and other in
    Dmitry> standard 2.6 mode.

1) there is no RAW access to the keyboard port;

2) I   hate  this   black  magic,   in  which   the   input  "devices"
   (i.e. drivers)  kidnap the serio  ports they like according  to the
   port  type SERIO_8042_RAW, etc.   That's a  kind of  hardcoding the
   binding between ports and drivers.


Isn't it better to leave the AUX ports as SERIO_8042, and let the user
dynamically change  this port<-->driver binding?  Then,  we don't even
need  that ugly  "i8042.raw" boot  parameter or  i8042_aux_raw option.
The  user can  decide  which  ports are  connected  to your  serio_raw
driver, and which ports are  connected to psmouse.ko.  That would also
allow multiple drivers driving the ports of the same type.  



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

