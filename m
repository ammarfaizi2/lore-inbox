Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbUKPF4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUKPF4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 00:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUKPF4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 00:56:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:47067 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261915AbUKPFze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 00:55:34 -0500
Date: Mon, 15 Nov 2004 21:54:06 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Kay Sievers <kay.sievers@vrfy.org>, tokunaga.keiich@jp.fujitsu.com,
       motoyuki@soft.fujitsu.com, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, rml@novell.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Message-ID: <20041116055406.GG29328@kroah.com>
References: <20041105001328.3ba97e08.akpm@osdl.org> <d120d5000411091548584bf8c5@mail.gmail.com> <20041110000811.GA8543@kroah.com> <200411092315.55187.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411092315.55187.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 11:15:55PM -0500, Dmitry Torokhov wrote:
> On Tuesday 09 November 2004 07:08 pm, Greg KH wrote:
> > On Tue, Nov 09, 2004 at 06:48:17PM -0500, Dmitry Torokhov wrote:
> > > On Tue, 9 Nov 2004 14:55:02 -0800, Greg KH <greg@kroah.com> wrote:
> > > > On Fri, Nov 05, 2004 at 09:18:48PM -0800, Keshavamurthy Anil S wrote:
> > > > > Also, since you have brought this, I have one another question to you.
> > > > > Now in the new kernel, I see whenever anybody calls sysdev_register(kobj),
> > > > > an "ADD" notification is sent. why is this? I would like to call
> > > > > kobject_hotplug(kobj, ADD) later.
> > > > 
> > > > This happens when kobject_add() is called.  You shouldn't ever need to
> > > > call kobject_hotplug() for an add event yourself.
> > > > 
> > > 
> > > This is not always the case. One might want to postpone ADD event
> > > until all summpelental object attributes are created. This way userspace
> > > is presented with object in consistent state.
> > 
> > No, that's a mess.  Let userspace wait for those attributes to show up
> > if they need to.  That's what the "wait_for_sysfs" program bundled with
> > udev is for.
> >
> 
> I strongly disagree:
> 
> - it makes userspace being aware of implementation details (whe exactly it
>   has to wait for, for how long, etc.) which is bad thing;
> - not all the world is udev - needless replication of the code and bugs;
> - not only making visible but announcing an object in non-working state
>   to userspace simply does not feel right.

Based on the recent additions to the /sbin/hotplug environment
variables, userspace now knows exactly what it needs to wait for, if
anything.  

Also, there's no needless replication of this code, that's why
wait_for_sysfs was split off of udev, it's for everyone to use, if they
want to.

thanks,

greg k-h
