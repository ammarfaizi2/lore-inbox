Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263646AbUJ3I3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUJ3I3d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 04:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbUJ3I3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 04:29:32 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:54685 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263646AbUJ3I32 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 04:29:28 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/4] Driver core: add driver_probe_device
Date: Sat, 30 Oct 2004 03:26:22 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20041029185753.53517.qmail@web81307.mail.yahoo.com> <20041029202249.GB29171@kroah.com>
In-Reply-To: <20041029202249.GB29171@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200410300326.23345.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 October 2004 03:22 pm, Greg KH wrote:
> Ok, care to redo the "driver" patch to be a symlink instead?  I think
> the last patch doesn't really need any changes, does it?
>

Coming your way.

> Hm, but how does this play with the current pci "add a new device id"
> scheme?  Can this "bind_mode" scheme work with that?
> 

They really serve different purposes as far as I can see. new_id affects
matching (and is PCI specific), bind_mode affects binding of otherwise
matching device/driver pairs. Its main use is to give preference to one
driver and "punish" another. 

For example we have atkbd, psmouse and serio_raw drivers working with
PS/2 ports. atkbd and psmouse are integrated into input subsystem and we
want to encourage their use. Still we don't support (rather detect) all
existing hardware yet so in some case raw access to PS/2 port (a-la 2.4
and earlier kernels) is desirable, so we have serio_raw. But because we
don't want it grab all free serio ports even if it loaded first it is
marked as manual bind.

Another example - you for some reason don't like touchpads and prefer an
external mouse. BUt the way serio subsystem works, even if you disconnect
serio port next time there is data it will try to find the driver again
 - so you mark your port as manual bind to prevent new input device from
appearing.

The bind_mode can also be used to control experimental/deprecated features
and still have everything compiled/loaded.

-- 
Dmitry
