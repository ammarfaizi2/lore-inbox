Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271279AbTHCWC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 18:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271313AbTHCWC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 18:02:28 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:13843 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271279AbTHCWCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 18:02:24 -0400
From: "Alan Shih" <alan@storlinksemi.com>
To: "David Lang" <david.lang@digitalinsight.com>
Cc: "Ben Greear" <greearb@candelatech.com>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Nivedita Singhvi" <niv@us.ibm.com>,
       "Werner Almesberger" <werner@almesberger.net>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: TOE brain dump
Date: Sun, 3 Aug 2003 15:02:09 -0700
Message-ID: <ODEIIOAOPGGCDIKEOPILGEMEDAAA.alan@storlinksemi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44.0308030120150.24695-100000@dlang.diginsite.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2727.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an embedded system, no processor will be fast enough to compete with
direct DMA xfer.  So just provide sendfile hooks that allow the kernel to
initiate data filling from source to dest then allow TSO to take place.
Kernel still needs to take care of the TCP stack.

I don't see this as building extensive customization though.

Alan

-----Original Message-----
From: David Lang [mailto:david.lang@digitalinsight.com]
Sent: Sunday, August 03, 2003 1:26 AM
To: Alan Shih
Cc: Ben Greear; Jeff Garzik; Nivedita Singhvi; Werner Almesberger;
netdev@oss.sgi.com; linux-kernel@vger.kernel.org
Subject: RE: TOE brain dump


do you really want the processor on the card to be tunning
apache/NFS/Samba/etc ?

putting enough linux on the card to act as a router (which would include
the netfilter stuff) is one thing. putting the userspace code that
interfaces with the outside world for file transfers is something else.

if you really want the disk connected to your network card you are just
talking a low-end linux box. forget all this stuff about it being on a
card and just use a full box (economys of scale will make this cheaper)

making a firewall that's a core system with a dozen slave systems attached
to it (the network cards) sounds like the type of clustering that Linux
has been used for for compute nodes. complicated to setup, but extremely
powerful and scalable once configured.

if you want more then a router on the card then Alan Cox is right, just
add another processor to the system, it's easier and cheaper.

David Lang


 On
Sat, 2 Aug 2003, Alan Shih wrote:

> Date: Sat, 2 Aug 2003 23:22:52 -0700
> From: Alan Shih <alan@storlinksemi.com>
> To: Ben Greear <greearb@candelatech.com>, Jeff Garzik <jgarzik@pobox.com>
> Cc: Nivedita Singhvi <niv@us.ibm.com>,
>      Werner Almesberger <werner@almesberger.net>, netdev@oss.sgi.com,
>      linux-kernel@vger.kernel.org
> Subject: RE: TOE brain dump
>
> A DMA xfer that fills the NIC pipe with IDE source. That's not very
hard...
> need a lot of bufferring/FIFO though.  May require large modification to
the
> file serving applications?
>
> Alan
>
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ben Greear
> Sent: Saturday, August 02, 2003 9:02 PM
> To: Jeff Garzik
> Cc: Nivedita Singhvi; Werner Almesberger; netdev@oss.sgi.com;
> linux-kernel@vger.kernel.org
> Subject: Re: TOE brain dump
>
>
> Jeff Garzik wrote:
>
> > So, fix the other end of the pipeline too, otherwise this fast network
> > stuff is flashly but pointless.  If you want to serve up data from disk,
> > then start creating PCI cards that have both Serial ATA and ethernet
> > connectors on them :)  Cut out the middleman of the host CPU and host
>
> I for one would love to see something like this, and not just Serial ATA..
> but maybe 8x Serial ATA and RAID :)
>
> Ben
>
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

