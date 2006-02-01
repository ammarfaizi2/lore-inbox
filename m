Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbWBAPop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWBAPop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbWBAPop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:44:45 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:63053 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161095AbWBAPoo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:44:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZuYoq22GTJLSx1e1NNh62kxvXh/OMbIcRs15kYFrHJ1y2G5SUkFeBriqfj07kgf7KNpooAvQ3ZlJPrUVmxmsQ2AxS7ZCCx//2M4aTW1o1S8+pnQY8kNkx7d2YzeeMOz4EutijTFE/8fx+QphvG6Y0Tv0R/xGHlket0AZ7z294sE=
Message-ID: <7d40d7190602010744vc2eaf3fm@mail.gmail.com>
Date: Wed, 1 Feb 2006 16:44:44 +0100
From: Aritz Bastida <aritzbastida@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Antonio Vargas <windenntw@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060201151145.GA3744@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7d40d7190601261206wdb22ccck@mail.gmail.com>
	 <20060127050109.GA23063@kroah.com>
	 <7d40d7190601270230u850604av@mail.gmail.com>
	 <69304d110601270834q5fa8a078m63a7168aa7e288d1@mail.gmail.com>
	 <7d40d7190601300323t1aca119ci@mail.gmail.com>
	 <20060130213908.GA26463@kroah.com>
	 <Pine.LNX.4.61.0602011553410.22529@yvahk01.tjqt.qr>
	 <20060201151145.GA3744@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Can't we just somewhat merge all the duplicated functionality between procfs,
> > sysfs and configfs...
>
> What "duplicated functionality"?  They all do different, unique things.
>
> Patches are always welcome...
>
> thanks,
>
> greg k-h
>

May be not "duplicated functionality", but _yes_ lots of ways to do
the same thing. I know, that's the magic with Linux, that there are
different ways to achieve the same goal, but in an effort to write
standard, generic, readable code, some ways should be preferred over
others.

As I said in previous messages, my driver is a kind of virtual network
device (imagine something like "snull" in LDD3) and my question was:
what would be the right way to configure it? I know, i know, there is
not a unique question for that, but I'm sure at least there are
suggestions. Some years ago, maybe there was no alternative other than
using system calls or ioctls, but the spectrum is a lot wider now.

I try to resume here the different ways that could be used, and their
original purpose:

* IOCTLS: as far as I know, this is deprecated for new drivers,
although it will still be there for a long time because of backward
compatibility.
* PROCFS: it has been used a lot apart from export process
information, but it seems that finally this is moving toward some new
filesystems (sysfs,configfs).
* SYSFS: this is to export system information
* CONFIGFS: this is to configure kernel modules/subsystems. This is
new to me, and don't have it (at least by default) in my Linux 2.6.15
box (guess it will be in the menuconfig somewhere :P).
* NETLINK: As far as I know this is used for configuring network
devices, routers, firewalls, ...

I guess that, with what I know now (sure more than when I started this
thread), the right ways could be either configfs or netlink. For my
purposes netlink would be more convenient (since the communication
link is bidirectional), but I still don't know if you guys think that
this method is all right.

Bye
Aritz
