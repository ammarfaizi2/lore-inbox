Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271507AbTGQRku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271516AbTGQRkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:40:49 -0400
Received: from a.smtp-out.sonic.net ([208.201.224.38]:58509 "HELO
	a.smtp-out.sonic.net") by vger.kernel.org with SMTP id S271507AbTGQRkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:40:49 -0400
X-envelope-info: <dhinds@sonic.net>
Date: Thu, 17 Jul 2003 10:55:40 -0700
From: David Hinds <dhinds@sonic.net>
To: "Bhavesh P. Davda" <bhavesh@avaya.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fischer@norbit.de, dahinds@users.sourceforge.net,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] AHA152x driver hangs on PCMCIA card eject, kernel2.4.22-pre6
Message-ID: <20030717105540.D6720@sonic.net>
References: <1058361370.6633.6.camel@dhcp22.swansea.linux.org.uk> <003201c34c6d$e62386a0$6e260987@rnd.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003201c34c6d$e62386a0$6e260987@rnd.avaya.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 08:15:39AM -0600, Bhavesh P. Davda wrote:

> > Right - scsi_unregister should not be called on a timer event, instead
> > it needs to kick off a task queue

The removal timers need to be taken out from most *_cs drivers; they
are a holdover from when card removal events were delivered in
interrupt context, and when that was changed to an event handler
thread, drivers were not changed accordingly.  The removal routine
should now just be called in-line instead of firing up a timer.

> 2. What happens if there is no physical device hanging off an I/O port
> address? I am guessing, that on an i386 host, the inb returns 0xFF, but am
> not sure what happens on other architectures. I have a question outstanding
> to Intel for this.

On most but not all x86 systems floating ports return 0xff.  Checking
for that or other "impossible" register values should be at least
harmless on other architectures.

-- Dave
