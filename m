Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966438AbWKNW5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966438AbWKNW5U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966439AbWKNW5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:57:20 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:39558 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966438AbWKNW45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:56:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=awyeROSp7AiFviPX7HzbIB/8hixIF6xMA2lKRb1DtdK718NbqaSUJj835yszLiB7InXad2qjYJIHOmwoQ3r/G0idQ7HL/8mizZ5wNHzkx+egj7/g2JLU3cQNqO+DWWQ8MwkiHX7kJ91g7gDKfisL5ZsFVCq0u+uc1z1wg5pm6yk=  ;
X-YMail-OSG: dPTgA7QVM1nBh6p_JBrMB9Ag1D7yrpRzo4cc3jQTYHwk2GWTW9BxgFR0O8iYAYiWoQLIiCtP5ZePGfiJYiW9wB06mGP.Ov4bcwqIGi28nqQtoVbbFquCgN.4sE8hTosRMLp8LE_1vY1jikcCY_tANXutxYJ9sn2OZe4-
From: David Brownell <david-b@pacbell.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.19-rc5 regression: can't disable OHCI wakeup via sysfs
Date: Tue, 14 Nov 2006 14:56:51 -0800
User-Agent: KMail/1.7.1
Cc: arvidjaar@mail.ru, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0611141628150.6666-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0611141628150.6666-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611141456.52201.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 November 2006 1:42 pm, Alan Stern wrote:
> On Tue, 14 Nov 2006, David Brownell wrote:
> 
> > On Monday 13 November 2006 9:15 am, Alan Stern wrote:
> > > On Mon, 13 Nov 2006, David Brownell wrote:
> > > 
> > > > It's a *driver model* API, which is also accessible from sysfs ... to support
> > > > per-device policies, for example the (a) workaround.  The mechanism exists
> > > > even on kernels that don't include sysfs ... although on such systems, there
> > > > is no way for users to do things like say "ignore the fact that this mouse
> > > > claims to issue wakeup events, its descriptors lie".
> > > 
> > > Yes, it is separate from sysfs -- but it is _tied_ to the sysfs API.
> > 
> > I can't agree.  If you deconfigure sysfs, it still works.
> > Since it's independent like that, there's no way it's "tied".
> 
> We could carry on this argument indefinitely.  Yes, the device_may_wakeup
> stuff does work without sysfs.  But it doesn't do anything significant; it
> amounts to no more than device_can_wakeup().  AFAIK there's no way to
> change the setting of the may_wakeup flag other than via sysfs.  That's
> what I meant by "tied".

So "tied" means "nobody has yet needed to create a different API for
that subset of the mechanism"?  Still can't agree.  Nothing's preventing
anyone from creating such an API, if they need to.


> > So "may" is correct, and "can" is insufficient.
> 
> Things work differently in uhci-hcd. 

They shouldn't.  That's the point of having this in the driver model:
so that all wakeup-capable devices can/will act the same in terms of
the basic capability and policy.

(Of course, there are ugly PPC/OF-only enumeration issues that keep us
from kicking in the wakeup mechanisms for PCI devices.  But that's a
separate issue, specific to PCI ... although it sucks hugely, since
so few developers have non-PCI wakeup-capable devices.)


> However even when it is added and may_wakeup is off, autostop will still 
> function.  It won't rely on interrupts or other wakeup events, though -- 
> instead the root-hub status polling mechanism will be used.

Well, as was said previously:  For UHCI it's not "just" a PM mechanism.

- Dave
