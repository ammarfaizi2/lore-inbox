Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266726AbUHIQrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266726AbUHIQrS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266731AbUHIQrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:47:18 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:18922 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S266726AbUHIQrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:47:16 -0400
Date: Mon, 9 Aug 2004 12:47:15 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marc Ballarin <Ballarin.Marc@gmx.de>, Greg KH <greg@kroah.com>,
       albert@users.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dynamic /dev security hole?
In-Reply-To: <1092065586.14144.31.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0408091238080.8693@vivaldi.madbase.net>
References: <20040808162115.GA7597@kroah.com>  <1091969260.5759.125.camel@cube>
  <20040808175834.59758fc0.Ballarin.Marc@gmx.de>  <20040808162115.GA7597@kroah.com>
  <20040809000727.1eaf917b.Ballarin.Marc@gmx.de> 
 <Pine.LNX.4.58.0408090025590.26834@vivaldi.madbase.net> 
 <1092062974.14153.26.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0408091203160.8353@vivaldi.madbase.net>
 <1092065586.14144.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I guess I'm missing something here...

On Mon, 9 Aug 2004, Alan Cox wrote:
> User closes device
> I have linked copy (not open)
> Device unloaded

At this point, udev (with the chown/chmod patch) would chown your
linked copy (before unlinking the original device node), right?

> I open the linked copy

So this wouldn't work.

> This makes new device load for me.
>
>
> I'm just trying to point out that the order of operations matters here
> because the old nodes must all be dead before the new device. Its even
> worse for less dynamic numbering.

The only problem I can think of is a race when a new device appears
with the same major/minor before udev gets a chance to do its stuff,
eg.

1) User closes device
2) I have linked copy (not open)
3) Device unloaded
4) New device appears
5) I open the linked copy
6) Udev chowns/chmods old device node (triggered by 3)) --> too late

Eric
