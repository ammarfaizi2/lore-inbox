Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263823AbUFBTJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUFBTJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbUFBTJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:09:29 -0400
Received: from web81306.mail.yahoo.com ([206.190.37.81]:35717 "HELO
	web81306.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263823AbUFBTJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:09:27 -0400
Message-ID: <20040602190927.79289.qmail@web81306.mail.yahoo.com>
Date: Wed, 2 Jun 2004 12:09:27 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: RE: [PATCH] serio.c: dynamically control serio ports bindings via procfs (Was: [RFC/RFT] Raw access to serio ports)
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>,
       Andries Brouwer <aeb@cwi.nl>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sau Dan Lee wrote:
> 
> I've  added procfs  support to  serio.c, so  that we  can  now control
> dynamically which serio ports connect  to which serio devices.  I call
> it "serio_switch", because it conceptually works like a patch panel or
> a switch with which you can rewire the connections.

Let me start with saying that this is a very good patch and that is
exactly what I have in mind with regard to serio port/device binding.
The only problem with the patch is that it uses wrong foundation, namely
procfs, because:
 
- procfs hierarchy is disconnected from the rest of the system. You
  cannot trace device ownership starting with root PCI bus down to your
  AUX port.
- there is no automatic hotplug notification to the userspace
- it is not flexible with regard to adding custom attributes to the
  drivers. I can see you adding rate and resolution to psmouse driver
  and repeat rate to atkbd. With sysfs drivers can themselves create
  attributes and they will be cleaned up once device disappears. With
  procfs you will have to export it form serio to be available to
  drivers and cleanup can be a nightmare.

Of course sysfs has its "problems" - it requires users to follow certain
lifetime rules which are different from what serio uses at the moment.

So we have several options - if we adopt procfs based solution now we
will have to maintain it for very long time, along with competing sysfs
implementation. Dropping one kernel parameter which will never be widely
used is much easier, IMO.

So I propose we all join our ranks and tame that sysfs together ;) I had
some patches that were converting drivers to the sysfs adding them to
serio bus, I probably should just send what I have as is for review
(I was going to rediff them as they are somewhat stale, I'll see what
shape they are later tonight).

--
Dmitry

