Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424272AbWKKQWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424272AbWKKQWG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 11:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946017AbWKKQWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 11:22:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54800 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424396AbWKKQWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 11:22:05 -0500
Date: Sat, 11 Nov 2006 17:22:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: drivers/usb/serial/mos7720.c: inconsequent NULL checking
Message-ID: <20061111162208.GC8809@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker noted the following inconsequent NULL checking in 
drivers/usb/serial/mos7720.c:

<--  snip  -->

...
static void mos7720_close(struct usb_serial_port *port, struct file *filp)
{
...

        /* While closing port, shutdown all bulk read, write  *
         * and interrupt read if they exists                  */
        if (serial->dev) {
                dbg("Shutdown bulk write");
                usb_kill_urb(port->write_urb);
                dbg("Shutdown bulk read");
                usb_kill_urb(port->read_urb);
        }

        data = 0x00;
        send_mos_cmd(serial, MOS_WRITE, port->number - port->serial->minor,
                     0x04, &data);
...

<--  snip  -->

Note that "send_mos_cmd(serial,...)" dereferences "serial->dev".

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

