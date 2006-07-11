Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWGKSzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWGKSzg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWGKSzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:55:36 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:54468 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S932089AbWGKSzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:55:35 -0400
Date: Tue, 11 Jul 2006 14:55:32 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
	transfers
In-reply-to: <874pxof0xl.fsf@javad.com>
To: Sergei Organov <osv@javad.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Message-id: <1152644133.20072.323.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<874pxof0xl.fsf@javad.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 22:31 +0400, Sergei Organov wrote:
> Andy Gay <andy@andynet.net> writes:
> > Adapted from an earlier patch by Greg KH <gregkh@suse.de>.
> > That patch added multiple read urbs and larger transfer buffers to allow
> > data transfers at full EvDO speed.
> 
> Below are two more problems with the patch, one of which existed in the
> original Greg's patch resulting in return with "Message too long"
> (EMSGSIZE) from driver's open() function.
> 
> [...]
> 
> > +		/* something happened, so free up the memory for this urb /*
> 
> There should be '*/' at the end of this line, not '/*', otherwise the
> driver even doesn't compile.

Sure. I posted an updated version including that fix -
http://lkml.org/lkml/2006/7/3/280

> 
> [...]
> > +static int airprime_open(struct usb_serial_port *port, struct file *filp)
> > +{
> [...]
> > +		usb_fill_bulk_urb(urb, serial->dev,
> > +				  usb_rcvbulkpipe(serial->dev,
> > +						  port->bulk_out_endpointAddress),
> 
> Here, it should obviously be port->bulk_in_endpointAddress, not
> port->bulk_out_endpointAddress, otherwise devices that have endpoints
> numeration like, say 0x01-out, 0x82-in (unlike more usual usual
> 0x01-out, 0x81-in), won't work returning -EMSGSIZE from open().

Sounds correct. Good catch!

> 
> After these fixes, I've been able to run the driver with my own USB
> device and achieved about 320 Kbytes/s read speed. That's still not very
> exciting as I have another driver here in development that seems to be
> able to do about 650 Kbytes/s with the same device.
> 
Nice. That's over 5Mbits/sec!

Is that on an EvDO network? I didn't know they could go that fast. The
EvDO network I'm testing on can only manage about 1Mbit/sec at best.



