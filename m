Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265322AbTL0Fal (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 00:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbTL0Fal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 00:30:41 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:48811 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265322AbTL0Faj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 00:30:39 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [2.6 PATCH/RFC] Firmware loader fixes - take 2
Date: Sat, 27 Dec 2003 00:29:48 -0500
User-Agent: KMail/1.5.4
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manuel Estrada Sainz <ranty@debian.org>,
       Patrick Mochel <mochel@osdl.org>
References: <200312210137.41343.dtor_core@ameritech.net> <200312222229.17991.dtor_core@ameritech.net> <1072169289.2876.57.camel@pegasus>
In-Reply-To: <1072169289.2876.57.camel@pegasus>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312270025.24160.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Tuesday 23 December 2003 03:48 am, Marcel Holtmann wrote:
> Hi Dmitry,
[..SKIP..]
> > I am sorry but I have to disagree with you. Kernel should not call
> > user space until it has all infrastructure in place and is ready.
> > Anything else is just a sloppy practice.
>
> The firmware.agent script has 3 extra lines to check for the visibility
> of the "loading" file and if it is not present it will sleep one
> second. This is a actual good practice compared to adding much more
> code to the kernel and have an own way of running hotplug.
>

OK, so if I understand you correctly you are against bloating the kernel by
duplicating hotplug handler, not against the basic idea that kernel should
not call userspace unless its ready. Your wish is my command! 

I changed the code a bit and split it into 2 patches for easier consumption.
The first patch takes care of resource deallocation issues, the second one
deals with hotplug. Firmware hotplug now uses the standard hotplug handler 
(I had to make it public) and as you can see it costs 5 extra lines of C code
(not counting one blank line) in firmware_class.c, hardly a bloat.

Dmitry
