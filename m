Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUFCGRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUFCGRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUFCGRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:17:52 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:52915 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261793AbUFCGQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:16:55 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Subject: Re: [PATCH] serio.c: dynamically control serio ports bindings via procfs (Was: [RFC/RFT] Raw access to serio ports)
Date: Thu, 3 Jun 2004 01:16:49 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>,
       Andries Brouwer <aeb@cwi.nl>, Vojtech Pavlik <vojtech@suse.cz>
References: <20040602190927.79289.qmail@web81306.mail.yahoo.com> <xb7smdd425i.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb7smdd425i.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Message-Id: <200406030116.49431.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 12:54 am, Sau Dan Lee wrote:
> >>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:
> 
>     Dmitry> Let me start with saying that this is a very good patch
>     Dmitry> and that is exactly what I have in mind with regard to
>     Dmitry> serio port/device binding.  The only problem with the
>     Dmitry> patch is that it uses wrong foundation, namely procfs,
>     Dmitry> because:
>     ...
>  
>     Dmitry> So we have several options - if we adopt procfs based
>     Dmitry> solution now we will have to maintain it for very long
>     Dmitry> time, along with competing sysfs implementation. Dropping
>     Dmitry> one kernel parameter which will never be widely used is
>     Dmitry> much easier, IMO.
> 
> It's not just the matter of dropping one kernel parameter.  The procfs
> support, _already  implemented_, allows  one to fine-tune  the binding
> between serio  ports and  devices, which is  a new and  useful feature
> that  your kernel  parameter  doesn't provide.   

What I was trying to say is serio and input system will have sysfs support,
there is no question about that because sysfs _is_ the new driver model. So
by adopting procfs based solution we'll get ourselves 2 competing interfaces
for the same thing, just one will be very limited.

> 
> Can you unbind the keyboard port?   Can you bind/unbind any of the AUX
> ports  *dynamically*  without   reloading  the  i8042  module?   These

No, and I was not trying to. It is just a stop-gap measure to help end
users to get their PS/2 devices working until we have proper infrastructure
in place.

> functionalities are  already there in the serio-related  code.  Just a
> userland interface is missing.  My patch is to fill this gap.
> 
> 
> 
>     Dmitry> So I propose we all join our ranks and tame that sysfs
>     Dmitry> together ;) I had some patches that were converting
>     Dmitry> drivers to the sysfs adding them to serio bus, 
> 
> sysfs  looks  good  for  simple parameters:  integers,  strings.   For
> anything more  complicated (sets, graphs),  I don't see it  fit (yet).
> Unfortunately, the serio port<-->device relation is already a graph (1
> to n).
> 
> I'd like  to see  how you implement  the device<-->handler  binding in
> input.c using sysfs.

Sysfs provides all the same features as procfs (I mean you write read/write
methods and have them do whatever you please) but it also has benefits of
your stuff integrating with the rest of devices into a hierarchy.
 
-- 
Dmitry
