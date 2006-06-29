Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWF2Cba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWF2Cba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 22:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWF2Cb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 22:31:29 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:20163 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750982AbWF2Cb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 22:31:29 -0400
Date: Wed, 28 Jun 2006 22:31:24 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: USB driver for Sierra Wireless EM5625/MC5720 1xEVDO modules
In-reply-to: <44A31A9F.3030102@goop.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Message-id: <1151548284.3285.299.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1151537247.3285.278.camel@tahini.andynet.net>
	<44A31A9F.3030102@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 17:11 -0700, Jeremy Fitzhardinge wrote:
> Andy Gay wrote:
> > - these modules present 3 bulk EPs, the 2nd & 3rd can be used for
> > control & status monitoring while data transfer is in progress on the
> > 1st EP. This is useful (and necessary for my application) so we need to
> > increase the port count.
> >   
> Ooh, can you share the details of those EPs?
Probably not, but I'll check. The customer I'm developing for is a
Sierra OEM, so they're probably under an NDA.

The useful port is the second one, it talks a Sierra protocol called CnS
(control and status). You could google for that, I guess. Or ask Sierra
nicely :)

>   Is your application public?

> 
> > So what should I do next? I see a few possibilities, assuming anyone is
> > interested in this:
> >
> > - I could post a diff from Greg's driver. But I don't have hardware to
> > test whether my changes will break it for the other devices that it
> > supports;
> >   
> Well, it is specifically an airprime driver.  My card also presents 
> another two endpoints, but I don't know what to do with them, so I 
> haven't worried about them too much.  If they all talk the same thing, 
> then they may as well be in the same driver.
I'd think so too, but I can't test that my changes won't break things
for other cards. Just being cautious here...
> 
> Are you proposing adding some more protocol knowledge to airprime, or 
> just make those EPs appear as more serial ports?
They are just serial ports, there's nothing special the driver can or
should do with them. I just changed the driver so you can get to them.

The main change I made to Greg's driver is to fix the memory leak - it
leaks 16k per endpoint for each open(), that made it unusable on the
very limited memory embedded platform I'm developing for.
> 
> Thanks,
>     J

