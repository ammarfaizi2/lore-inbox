Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTKPUUO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 15:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTKPUUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 15:20:14 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:7088 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262794AbTKPUUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 15:20:10 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       vojtech@ucw.cz
Subject: Re: Corrected drivermodel for i8042.c
Date: Sun, 16 Nov 2003 15:20:03 -0500
User-Agent: KMail/1.5.4
References: <20031116131134.GA301@elf.ucw.cz>
In-Reply-To: <20031116131134.GA301@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311161520.03425.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 November 2003 08:11 am, Pavel Machek wrote:

>
> +static int i8042_resume_port(struct serio *port)
> +{
> +	struct serio_dev *dev = port->dev;
> +	if (dev) {
> +		dev->disconnect(port);
> +		dev->connect(port, dev);
> +	}
> +}

You want to do that event if there was nothing attached to the port
as a mouse might get plugged in while the box is suspended. I think
serio_rescan() is more appropriate (it will do a disconnect if needed
for you).

Overall there is a problem with disconnect/connect method as it will 
cause a new input device created for the same hardware if old input
device is held open by some process. If ever serio_reconnect patches
will make in the tree then serio_reconnect() can be used instead of
serio_rescan() as it will try to keep the same input device.

Dmitry
