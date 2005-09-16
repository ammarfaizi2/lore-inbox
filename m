Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965277AbVIPCny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965277AbVIPCny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 22:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVIPCny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 22:43:54 -0400
Received: from soundwarez.org ([217.160.171.123]:55685 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751227AbVIPCnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 22:43:53 -0400
Date: Fri, 16 Sep 2005 04:43:51 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Message-ID: <20050916024351.GC13486@vrfy.org>
References: <20050916002036.GA6149@suse.de> <200509152103.42313.dtor_core@ameritech.net> <20050916021415.GB13486@vrfy.org> <200509152136.08951.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200509152136.08951.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 09:36:08PM -0500, Dmitry Torokhov wrote:
> On Thursday 15 September 2005 21:14, Kay Sievers wrote:
> > On Thu, Sep 15, 2005 at 09:03:41PM -0500, Dmitry Torokhov wrote:
> > > On Thursday 15 September 2005 20:54, Kay Sievers wrote:
> > > > On Thu, Sep 15, 2005 at 08:23:43PM -0500, Dmitry Torokhov wrote:
> > > > > On Thursday 15 September 2005 20:04, Kay Sievers wrote:
> > > > > > I like that the child devices are actually below the parent device
> > > > > > and represent the logical structure. I prefer that compared to the
> > > > > > symlink-representation between the classes at the same directory
> > > > > > level which the input patches propose.
> > > > > 
> > > > > Why don't we take it a step further and abandon classes altogether?
> > > > > This way everything will grow from their respective hardware devices.
> > > > 
> > > > Not everything is hardware. :)
> > > > 
> > > > > Class represent a set of objects with similar characteristics. In
> > > > > this regard event0 is no "lesser" than input0. Although they are
> > > > > linked they are objects of the same importance. I do want to see
> > > > > all input interfaces without scanning bunch of directories.
> > > > 
> > > > No problem, how about this:
> > > >   /sys/class/input/
> > > >   |-- input0
> > > >   |   |-- event0
> > > >   |   |   `-- dev
> > > >   |   `-- mouse0
> > > >   |   |   `-- dev
> > > >   |-- input1
> > > >   |   |-- event1
> > > >   |   |   `-- dev
> > > >   |   `-- ts0
> > > >   |   |   `-- dev
> > > >   |-- mice
> > > >   |   `-- dev
> > > >   `-- interfaces
> > > >       |-- event0 ->·../input0/event0
> > > >       |-- event1 ->·../input1/event1
> > > >       |-- mouse0 ->·../input0/mouse0
> > > >       |-- mice -> ../mice
> > > >       `-- ts0 -> ../input1/ts0
> > > > 
> > > 
> > > I am thinking... the rule would be - when adding a class device if it
> > > has a class_device parent then it gets added to parent's directory and
> > > symlinked into class. Otherwise it gets added into class directory.
> > 
> > Like this?
> > 
> >   /sys/class/input/
> >   |-- input0
> >   |   |-- event0
> >   |   |   `-- dev
> >   |   `-- mouse0
> >   |   |   `-- dev
> >   |-- input1
> >   |   |-- event1
> >   |   |   `-- dev
> >   |   `-- ts0
> >   |   |   `-- dev
> >   |-- mice
> >   |   `-- dev
> >   |-- event0 ->·input0/event0
> >   |-- event1 ->·input1/event1
> >   |-- mouse0 ->·input0/mouse0
> >   `-- ts0 -> input1/ts0
> > 
> 
> No, like your first picture, except 'interfaces/mice' will be a directory,
> not a symlink, since it does not have class_device parent. I should have
> said "Otherwise it gets added into _its_ class directory". 

Ah, I see. But the second model would work without any changes to
existing software. :)

Kay
