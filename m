Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267430AbSKQBpa>; Sat, 16 Nov 2002 20:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbSKQBpa>; Sat, 16 Nov 2002 20:45:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:16803 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267430AbSKQBpa>;
	Sat, 16 Nov 2002 20:45:30 -0500
Message-ID: <3DD6F655.4214A594@digeo.com>
Date: Sat, 16 Nov 2002 17:52:21 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Justin A <ja6447@albany.edu>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, ambx1@neo.rr.com
Subject: Re: pnpbios oops on boot w/ 2.5.47
References: <200211161700.29653.ja6447@albany.edu> <3DD6C1DC.44966373@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Nov 2002 01:52:21.0996 (UTC) FILETIME=[F81F72C0:01C28DDB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Justin A wrote:
> >
> > Hi :)
> >
> > I tried to "port" kmsgdump to 2.5.47 and for some reason, it worked.
> >
> > Attached is the full dmesg
> >
> > Alan: I ran dmidecode under 2.4.19 which said simply "PNP BIOS present"
> >
> > This is a thinkpad 760e, really old..I don't even think I need pnpbios support
> > for anything.  2.5.47/2.5.47-ac5 boot with pnpbios turned off, so I think you
> > just need to add this to your blacklist?
> >
> 
> The BUG in slab indicates that something overran the end of a kmalloced
> buffer.  That'll be either pnp_bios_get_dev_node() or node_set_resources()
> ran off the end of `node'.

err...

        node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);

max_node_size appears to never be initialised.
