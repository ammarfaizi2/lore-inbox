Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbUDEFOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 01:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbUDEFOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 01:14:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20413 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263128AbUDEFOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 01:14:40 -0400
Date: Sun, 4 Apr 2004 22:14:32 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Robert White" <rwhite@casabyte.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] (linux 2.4.25) hangup on disconnect
 for usbserial module
Message-Id: <20040404221432.1a10c85a.zaitcev@redhat.com>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAt769YH9BUkiZQFHMD2kn9AEAAAAA@casabyte.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAt769YH9BUkiZQFHMD2kn9AEAAAAA@casabyte.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Apr 2004 21:46:52 -0700
"Robert White" <rwhite@casabyte.com> wrote:

> This is "reasonably well tested" on the x86 platform.
> 
> This patch fixes a problem where the usbserial code would not notify
> connected programs that the serial port was going away.

> @@ -1404,9 +1408,11 @@ static void usb_serial_disconnect(struct
>                 for (i = 0; i < serial->num_ports; ++i) {
>                         port = &serial->port[i];
>                         down (&port->sem);
> -                       if (port->tty != NULL)
> +                       if (port->tty != NULL) {
> +                               tty_hangup(port->tty);
>                                 while (port->open_count > 0)
>                                         __serial_close(port, NULL);
> +                       }

I'll think about it.

If Greg approves and takes, it's fine, too.

What is the actual symptom? Did you expect a SIGHUP?

-- Pete
