Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVDEPa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVDEPa0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVDEPaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:30:22 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:19946 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261783AbVDEP2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:28:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=X5nBnCP2IorgoHVmTMblPy7/TQ/fP9kSQsfnI1Z2R0Vk4AepKQRhTFGQ3pHVGxqxDf9E3JzQUqPbEInZhoK4cY75T6uCP+vM9zwGZ3n0A4ZcGWDhWcJRNJNwb8RaQokxHosSSiJ0Z0IiwS5Ua3Os1J8ZwqoLdTg990LjkGATNAI=
Message-ID: <d120d50005040508287e7523c5@mail.gmail.com>
Date: Tue, 5 Apr 2005 10:28:54 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 00/04] Load keyspan firmware with hotplug
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Greg KH <greg@kroah.com>,
       Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1112711791.12406.26.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050404100929.GA23921@pegasos> <20050404191745.GB12141@kroah.com>
	 <20050405042329.GA10171@delft.aura.cs.cmu.edu>
	 <200504042351.22099.dtor_core@ameritech.net>
	 <1112692926.8263.125.camel@pegasus>
	 <20050405114543.GG10171@delft.aura.cs.cmu.edu>
	 <1112711791.12406.26.camel@notepaq>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 5, 2005 9:36 AM, Marcel Holtmann <marcel@holtmann.org> wrote:

> People are also working on a replacement for the
> current request_firmware(), because the needs are changing. Try to keep
> it close with the usb-serial for now.
> 

Could you elaborate on what do you think is needed? I have some of
patches to firmware loader and wondering if we should coordinate out
efforts. I have

1. convert from using a timer to wait_for_comletion_timeout which
simplifies logic
2. tightening of state transition rules and removing possible memory
leak (very unlikely)
3. converting firmware_priv to fw_class_dev to simplify memory management.
4. removing request_firmware_nowait as noone seems to be using it -
and I doubt one would ever want to request firmware from an interrupt.
5. Creating firmware class in a separate thread to work around selinux
(with prism54 firmware is loaded when interface is configured and thus
firware loader runs in context of /sbin/ip which may not have access
to sysfs. Having separate thread will ensure that firmware loader runs
in kernel context).

And I was thinking about caching firmware (siomething like if you do
"echo 2 > /sys/class/firmware/blah/loading" instead of 0 it will keep
a copy of the firmware in memory. One could see all firmwares in
/sys/class/firmware/loaded/<xxx> and by erase cached firmware by
echoing 0 into it).

What do you think?

-- 
Dmitry
