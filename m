Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbTEQOJe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 10:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbTEQOJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 10:09:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2476
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261544AbTEQOJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 10:09:32 -0400
Subject: Re: request_firmware() hotplug interface, third round.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Neukum <oliver@neukum.org>
Cc: ranty@debian.org, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>
In-Reply-To: <200305170022.29824.oliver@neukum.org>
References: <20030515200324.GB12949@ranty.ddts.net>
	 <200305161753.17198.oliver@neukum.org>
	 <20030516183152.GB18732@ranty.ddts.net>
	 <200305170022.29824.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053177811.7505.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 May 2003 14:23:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  If the device losses the firmware upon suspend, the driver will have to
> >  reinitialize it as if it just got plugged, which somehow makes all
> >  devices hotplugable.
> 
> So all firmware has to be permanently in RAM anyway?

Of course not you can just go back out to user space and ask for it

> > 	- In a diskless client, it is the network card

Already insoluble because of routing daemons.

> No, still no good. It means that you get a memory leak if you unload
> a driver before firmware is provided. You need the ability to explicitely
> cancel a request for firmware.

Only if you program it wrongly. Its not exactly hard.

As to an interface. The simplest is probably

	request_firmware()
and
	request_firmware_nowait(......, workqueuehandler)

The issues brought up about it failing appear bogus too, if the hotplug
run returns a non zero exit code you know about this already.

Alan

