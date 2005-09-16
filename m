Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbVIPCDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbVIPCDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 22:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbVIPCDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 22:03:49 -0400
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:28777 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161041AbVIPCDr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 22:03:47 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Date: Thu, 15 Sep 2005 21:03:41 -0500
User-Agent: KMail/1.8.2
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
References: <20050916002036.GA6149@suse.de> <200509152023.44003.dtor_core@ameritech.net> <20050916015418.GA13486@vrfy.org>
In-Reply-To: <20050916015418.GA13486@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509152103.42313.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 September 2005 20:54, Kay Sievers wrote:
> On Thu, Sep 15, 2005 at 08:23:43PM -0500, Dmitry Torokhov wrote:
> > On Thursday 15 September 2005 20:04, Kay Sievers wrote:
> > > I like that the child devices are actually below the parent device
> > > and represent the logical structure. I prefer that compared to the
> > > symlink-representation between the classes at the same directory
> > > level which the input patches propose.
> > 
> > Why don't we take it a step further and abandon classes altogether?
> > This way everything will grow from their respective hardware devices.
> 
> Not everything is hardware. :)
> 
> > Class represent a set of objects with similar characteristics. In
> > this regard event0 is no "lesser" than input0. Although they are
> > linked they are objects of the same importance. I do want to see
> > all input interfaces without scanning bunch of directories.
> 
> No problem, how about this:
>   /sys/class/input/
>   |-- input0
>   |   |-- event0
>   |   |   `-- dev
>   |   `-- mouse0
>   |   |   `-- dev
>   |-- input1
>   |   |-- event1
>   |   |   `-- dev
>   |   `-- ts0
>   |   |   `-- dev
>   |-- mice
>   |   `-- dev
>   `-- interfaces
>       |-- event0 ->·../input0/event0
>       |-- event1 ->·../input1/event1
>       |-- mouse0 ->·../input0/mouse0
>       |-- mice -> ../mice
>       `-- ts0 -> ../input1/ts0
> 

I am thinking... the rule would be - when adding a class device if it
has a class_device parent then it gets added to parent's directory and
symlinked into class. Otherwise it gets added into class directory.

I do not want to have a separate subclass_device structure... 

-- 
Dmitry
