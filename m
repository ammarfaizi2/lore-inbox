Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267535AbUI1Ez2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267535AbUI1Ez2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 00:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUI1Ez2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 00:55:28 -0400
Received: from digitalimplant.org ([64.62.235.95]:2773 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S267535AbUI1Ez1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 00:55:27 -0400
Date: Mon, 27 Sep 2004 21:55:18 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: "Zhu, Yi" <yi.zhu@intel.com>
cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       "" <linux-kernel@vger.kernel.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Oliver Neukum <oliver@neukum.org>
Subject: RE: suspend/resume support for driver requires an external firmware
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD579D@pdsmsx403>
Message-ID: <Pine.LNX.4.50.0409272152410.24893-100000@monsoon.he.net>
References: <3ACA40606221794F80A5670F0AF15F8403BD579D@pdsmsx403>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Sep 2004, Zhu, Yi wrote:

> Dmitry Torokhov wrote:
> > Where do you load your firmware from so that you can bring up
> > the network so you can mount everything via NFS in the first place?
>
> The firmware locates together w/ the driver in the initrd which could be
> either in the remote PXE server or the local diskettes. It should be
> also
> placed somewhere on the NFS root so that it can be picked up to
> memory during suspend.

I presume you're not talking about doing swsusp over NFS. If so, there's
a lot more work to be done to teach the driver model and power management
infrastructure about the dependencies involved to make that a possibility.
It's safe to say that we don't support that, and won't support that at
least for some time.

As far as the firmware goes, there are two choices - reload it from
userspace once we return or save it memory during suspend. I assume that
these devices provide some means for reading the firmware from them, so
you can just allocate a buffer and read it into that during the
transition.


	Pat
